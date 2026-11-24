import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:florin/db/daos/client_dao.dart';
import 'package:florin/db/daos/invoice_dao.dart';
import 'package:florin/db/database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late InvoiceDao invoices;
  late Client client;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    invoices = InvoiceDao(db);
    final clients = ClientDao(db);
    final id = await clients.save(
      const ClientsCompanion(
        name: Value('Klant'),
        address: Value('Straat 1'),
        wetDbaRisk: Value(WetDbaRisk.low),
      ),
    );
    client = (await clients.getById(id))!;
  });

  tearDown(() => db.close());

  InvoicesCompanion invoice(String number) => InvoicesCompanion(
    invoiceNumber: Value(number),
    invoiceType: const Value(InvoiceType.invoice),
    invoiceDate: Value(DateTime(2026, 3, 1)),
    clientId: Value(client.id),
    vatTreatment: const Value(VatTreatment.standard),
    sellerName: const Value('S'),
    sellerVatNumber: const Value('NL000000000B00'),
    sellerKvkNumber: const Value('00000000'),
    sellerAddress: const Value('A'),
    sellerIban: const Value('NL91ABNA0417164300'),
    paymentTermDays: const Value(14),
    status: const Value(InvoiceStatus.draft),
    totalExclVat: const Value(1000),
    totalVat: const Value(210),
    totalInclVat: const Value(1210),
  );

  InvoiceLinesCompanion line(String text) => InvoiceLinesCompanion(
    invoiceId: const Value(0),
    description: Value(text),
    quantity: const Value(1),
    unitPriceExclVat: const Value(1000),
    vatRate: const Value(VatRate.high),
    vatAmount: const Value(210),
    lineTotalExclVat: const Value(1000),
    sortOrder: const Value(0),
  );

  test('saveWithLines inserts, then replaces the lines on update', () async {
    final id = await invoices.saveWithLines(invoice('F-2026-001'), [
      line('a'),
      line('b'),
    ]);
    expect((await invoices.getLines(id)).length, 2);
    await invoices.saveWithLines(
      invoice('F-2026-001').copyWith(id: Value(id)),
      [line('c')],
    );
    expect((await invoices.getLines(id)).map((l) => l.description), ['c']);
  });

  group('issued numbers follow on (Wet OB 1968 art. 35a lid 1 b; '
      'Belastingdienst, Factuureisen)', () {
    Future<int> add(String number, InvoiceStatus status) =>
        invoices.saveWithLines(
          invoice(number).copyWith(status: Value(status)),
          [line('a')],
        );

    test('the next number follows the last issued one in its series, and a '
        'series with nothing issued keeps the given number', () async {
      expect(await invoices.nextIssuedNumber(2026, 'F'), isNull);
      await add('F-2026-001', InvoiceStatus.sent);
      await add('F-2026-003', InvoiceStatus.draft);
      await add('2026-77', InvoiceStatus.paid);
      expect(await invoices.nextIssuedNumber(2026, 'F'), 'F-2026-002');
    });

    test('renumbering a draft swaps numbers with the draft that holds the '
        'number', () async {
      await add('F-2026-001', InvoiceStatus.sent);
      final second = await add('F-2026-002', InvoiceStatus.draft);
      final third = await add('F-2026-003', InvoiceStatus.draft);
      await invoices.renumberDraft(third, 'F-2026-002');
      expect((await invoices.getById(third))!.invoiceNumber, 'F-2026-002');
      expect((await invoices.getById(second))!.invoiceNumber, 'F-2026-003');
    });
  });

  test('deleting an invoice deletes its lines', () async {
    final id = await invoices.saveWithLines(invoice('F-2026-001'), [line('a')]);
    await invoices.remove((await invoices.getById(id))!);
    expect(await db.select(db.invoiceLines).get(), isEmpty);
  });

  test('a client with invoices cannot be deleted', () async {
    await invoices.saveWithLines(invoice('F-2026-001'), [line('a')]);
    expect(ClientDao(db).remove(client), throwsA(isA<SqliteException>()));
  });

  test('invoice numbers are unique and sequenced per year', () async {
    await invoices.saveWithLines(invoice('F-2026-001'), [line('a')]);
    await invoices.saveWithLines(invoice('F-2026-007'), [line('a')]);
    expect(await invoices.nextSequenceNumber(2026, 'F'), 8);
    expect(await invoices.nextSequenceNumber(2027, 'F'), 1);
    expect(
      invoices.saveWithLines(invoice('F-2026-001'), [line('a')]),
      throwsA(isA<SqliteException>()),
    );
  });
}
