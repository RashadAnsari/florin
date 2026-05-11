import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/clients.dart';
import '../tables/invoices.dart';
import '../tables/invoice_lines.dart';

part 'invoice_dao.g.dart';

@DriftAccessor(tables: [Invoices, InvoiceLines, Clients])
class InvoiceDao extends DatabaseAccessor<AppDatabase> with _$InvoiceDaoMixin {
  InvoiceDao(super.db);

  Stream<List<Invoice>> watchByYear(int year) =>
      (select(invoices)
            ..where((i) => i.fiscalYear.equals(year))
            ..orderBy([(i) => OrderingTerm.desc(i.invoiceDate)]))
          .watch();

  Future<List<Invoice>> getByYear(int year) =>
      (select(invoices)
            ..where((i) => i.fiscalYear.equals(year))
            ..orderBy([(i) => OrderingTerm.desc(i.invoiceDate)]))
          .get();

  Future<Invoice?> getById(int id) =>
      (select(invoices)..where((i) => i.id.equals(id))).getSingleOrNull();

  Future<List<InvoiceLine>> getLinesForInvoice(int invoiceId) =>
      (select(invoiceLines)
            ..where((l) => l.invoiceId.equals(invoiceId))
            ..orderBy([(l) => OrderingTerm.asc(l.sortOrder)]))
          .get();

  Stream<List<InvoiceLine>> watchLinesForInvoice(int invoiceId) =>
      (select(invoiceLines)
            ..where((l) => l.invoiceId.equals(invoiceId))
            ..orderBy([(l) => OrderingTerm.asc(l.sortOrder)]))
          .watch();

  Future<int> insertInvoice(InvoicesCompanion entry) =>
      into(invoices).insert(entry);

  Future<bool> saveInvoice(InvoicesCompanion entry) =>
      (update(invoices)).replace(entry);

  Future<int> insertLine(InvoiceLinesCompanion entry) =>
      into(invoiceLines).insert(entry);

  Future<bool> saveLine(InvoiceLinesCompanion entry) =>
      (update(invoiceLines)).replace(entry);

  Future<int> deleteLine(int id) =>
      (delete(invoiceLines)..where((l) => l.id.equals(id))).go();

  Future<void> deleteInvoice(int id) async {
    await (delete(invoiceLines)..where((l) => l.invoiceId.equals(id))).go();
    await (delete(invoices)..where((i) => i.id.equals(id))).go();
  }

  Future<int> nextSequenceNumber(int year, String prefix) async {
    final all =
        await (select(invoices)
              ..where((i) => i.fiscalYear.equals(year))
              ..where((i) => i.invoiceNumber.like('$prefix-$year-%')))
            .get();
    if (all.isEmpty) return 1;
    final nums = all.map((i) {
      final parts = i.invoiceNumber.split('-');
      return parts.length >= 3 ? (int.tryParse(parts.last) ?? 0) : 0;
    });
    return nums.reduce((a, b) => a > b ? a : b) + 1;
  }

  Future<bool> clientHasInvoices(int clientId) async {
    final result =
        await (select(invoices)
              ..where((i) => i.clientId.equals(clientId))
              ..limit(1))
            .get();
    return result.isNotEmpty;
  }

  Future<void> recalculateTotals(int invoiceId) async {
    final lines = await getLinesForInvoice(invoiceId);
    var exclVat = 0;
    var vat = 0;
    for (final l in lines) {
      exclVat += l.lineTotalExclVat;
      vat += l.vatAmount;
    }
    await (update(invoices)..where((i) => i.id.equals(invoiceId))).write(
      InvoicesCompanion(
        totalExclVat: Value(exclVat),
        totalVat: Value(vat),
        totalInclVat: Value(exclVat + vat),
      ),
    );
  }
}
