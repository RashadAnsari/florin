import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/invoice_lines.dart';
import '../tables/invoices.dart';

part 'invoice_dao.g.dart';

@DriftAccessor(tables: [Invoices, InvoiceLines])
class InvoiceDao extends DatabaseAccessor<AppDatabase>
    with _$InvoiceDaoMixin, Crud<$InvoicesTable, Invoice> {
  InvoiceDao(super.db);

  @override
  TableInfo<$InvoicesTable, Invoice> get table => invoices;

  Stream<List<Invoice>> watchInYear(int year) =>
      (select(invoices)
            ..where((i) => i.invoiceDate.inYear(year))
            ..orderBy([(i) => OrderingTerm.desc(i.invoiceDate)]))
          .watch();

  Stream<List<Invoice>> watchAll() => (select(
    invoices,
  )..orderBy([(i) => OrderingTerm.desc(i.invoiceDate)])).watch();

  Future<Invoice?> getById(int id) =>
      (select(invoices)..where((i) => i.id.equals(id))).getSingleOrNull();

  Future<List<InvoiceLine>> getLines(int invoiceId) =>
      (select(invoiceLines)
            ..where((l) => l.invoiceId.equals(invoiceId))
            ..orderBy([(l) => OrderingTerm.asc(l.sortOrder)]))
          .get();

  Stream<List<InvoiceLine>> watchLinesInYear(int year) {
    final query = select(invoiceLines).join([
      innerJoin(invoices, invoices.id.equalsExp(invoiceLines.invoiceId)),
    ])..where(invoices.invoiceDate.inYear(year));
    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(invoiceLines)).toList(),
    );
  }

  /// Saves [invoice] and replaces its lines in one transaction.
  Future<int> saveWithLines(
    InvoicesCompanion invoice,
    List<InvoiceLinesCompanion> lines,
  ) => transaction(() async {
    final id = await save(invoice);
    final invoiceId = invoice.id.present ? invoice.id.value : id;
    await (delete(
      invoiceLines,
    )..where((l) => l.invoiceId.equals(invoiceId))).go();
    for (final line in lines) {
      await into(
        invoiceLines,
      ).insert(line.copyWith(invoiceId: Value(invoiceId)));
    }
    return invoiceId;
  });

  /// The amount excl. VAT already credited on [invoiceId] by other credit
  /// notes, drafts included, leaving out [excludingId].
  Future<int> creditedExclVat(int invoiceId, {int? excludingId}) async {
    final notes =
        await (select(invoices)..where(
              (i) =>
                  i.correctedInvoiceId.equals(invoiceId) &
                  i.invoiceType.equalsValue(InvoiceType.creditNote),
            ))
            .get();
    return notes
        .where((n) => n.id != excludingId)
        .fold<int>(0, (s, n) => s + n.totalExclVat);
  }

  Future<void> setStatus(int id, InvoiceStatus status, {DateTime? paidDate}) =>
      (update(invoices)..where((i) => i.id.equals(id))).write(
        InvoicesCompanion(status: Value(status), paidDate: Value(paidDate)),
      );

  /// Highest sequence number used in `<prefix>-<year>-<n>`, plus one.
  Future<int> nextSequenceNumber(int year, String prefix) async {
    final numbers =
        await (selectOnly(invoices)
              ..addColumns([invoices.invoiceNumber])
              ..where(invoices.invoiceNumber.like('$prefix-$year-%')))
            .map((r) => r.read(invoices.invoiceNumber)!)
            .get();
    var max = 0;
    for (final n in numbers) {
      final seq = int.tryParse(n.split('-').last) ?? 0;
      if (seq > max) max = seq;
    }
    return max + 1;
  }
}
