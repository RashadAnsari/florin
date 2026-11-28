import 'package:florin/db/database.dart';
import 'package:florin/services/invoice_pdf_service.dart';
import 'package:florin/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

Invoice _invoice(
  VatTreatment treatment, {
  InvoiceType type = InvoiceType.invoice,
  String number = 'F-2026-001',
}) => Invoice(
  id: 1,
  invoiceNumber: number,
  invoiceType: type,
  invoiceDate: DateTime(2026, 3, 2),
  clientId: 1,
  vatTreatment: treatment,
  selfBilled: false,
  sellerName: 'S',
  sellerVatNumber: 'NL000099998B57',
  sellerKvkNumber: '12345678',
  sellerAddress: 'A',
  sellerIban: 'NL91ABNA0417164300',
  paymentTermDays: 14,
  status: InvoiceStatus.sent,
  totalExclVat: 150000,
  totalVat: 0,
  totalInclVat: 150000,
);

InvoiceLine _line(int id, VatRate rate, int total) => InvoiceLine(
  id: id,
  invoiceId: 1,
  description: 'Montage',
  quantity: 1,
  unitPriceExclVat: total,
  vatRate: rate,
  vatAmount: 0,
  lineTotalExclVat: total,
  sortOrder: id,
);

Client _client(String country, {bool consumer = false, String? vatNumber}) =>
    Client(
      id: 1,
      name: 'K',
      country: country,
      vatNumber: vatNumber,
      address: 'B',
      wetDbaRisk: WetDbaRisk.low,
      contractSigned: false,
      isActive: true,
      isMerchantOfRecord: false,
      isConsumer: consumer,
    );

void main() {
  setUpAll(() => initializeDateFormatting('nl_NL'));

  test('domestic reverse charge states the rate and the amount per rate as '
      'without reverse charge (Wet OB 1968 art. 35a lid 1 h and i; '
      'Belastingdienst, Hoe werkt btw verleggen?)', () {
    final invoice = _invoice(VatTreatment.reverseChargeNl);
    final lines = [
      _line(1, VatRate.high, 100000),
      _line(2, VatRate.low, 50000),
    ];
    expect(InvoicePdfService.rateCell(invoice, lines[0]), '21%');
    expect(InvoicePdfService.vatRows(invoice, lines), [
      ('Btw 21% over ${AppFormat.cents(100000)}', 'verlegd'),
      ('Btw 9% over ${AppFormat.cents(50000)}', 'verlegd'),
    ]);
  });

  test('services taxed abroad state no rate', () {
    final invoice = _invoice(VatTreatment.euServices);
    final lines = [_line(1, VatRate.zero, 100000)];
    expect(InvoicePdfService.rateCell(invoice, lines[0]), '-');
    expect(InvoicePdfService.vatRows(invoice, lines), [
      ('Btw', AppFormat.cents(0)),
    ]);
  });

  test('a KOR invoice mentions no BTW and states the exemption (Wet OB 1968 '
      'art. 25a lid 4)', () {
    final invoice = _invoice(VatTreatment.kor);
    final client = _client('NL', vatNumber: 'NL000099997B65');
    final lines = [_line(1, VatRate.high, 150000)];
    final printed = [
      ...InvoicePdfService.sellerRows(invoice),
      ...InvoicePdfService.clientRows(invoice, client),
      ...InvoicePdfService.columnHeads(invoice),
      for (final (label, value) in InvoicePdfService.totalRows(invoice, lines))
        '$label $value',
      InvoicePdfService.paymentText(invoice),
    ];
    expect(printed.where((t) => t.toLowerCase().contains('btw')), isEmpty);
    expect(InvoicePdfService.columnHeads(invoice), hasLength(4));
    expect(
      InvoicePdfService.treatmentNote(invoice, client),
      'Vrijgesteld op grond van de kleineondernemersregeling',
    );
    // Without the KOR both BTW numbers are printed.
    final standard = _invoice(VatTreatment.standard);
    expect(
      InvoicePdfService.sellerRows(standard),
      contains('Btw-id: NL000099998B57'),
    );
    expect(
      InvoicePdfService.clientRows(standard, client),
      contains('Btw-id: NL000099997B65'),
    );
  });

  test(
    'a credit note names the invoice it corrects (Wet OB 1968 art. 34f)',
    () {
      final original = _invoice(VatTreatment.standard);
      expect(
        InvoicePdfService.creditReference(original),
        'Creditnota bij factuur F-2026-001 van '
        '${AppFormat.date(DateTime(2026, 3, 2))}',
      );
    },
  );

  test('an intra-Community supply states artikel 138, lid 1, Richtlijn '
      '2006/112 (art. 35a lid 1 l)', () {
    expect(
      InvoicePdfService.treatmentNote(
        _invoice(VatTreatment.euGoods),
        _client('BE', vatNumber: 'BE0999999999'),
      ),
      contains('artikel 138, lid 1, Richtlijn 2006/112'),
    );
  });

  test('an exempt line states the exemption and no BTW (art. 35a lid 1 l)', () {
    final invoice = _invoice(VatTreatment.standard);
    final lines = [_line(1, VatRate.exempt, 15000)];
    expect(InvoicePdfService.rateCell(invoice, lines[0]), 'Vrijgesteld');
    expect(InvoicePdfService.vatRows(invoice, lines), [
      ('Vrijgesteld van btw over ${AppFormat.cents(15000)}', '-'),
    ]);
  });

  test('a service outside the EU names the article that places it there: '
      'art. 6 lid 1 for a business, art. 6e, 6h or 6i for a private person '
      '(Wet OB 1968)', () {
    final invoice = _invoice(VatTreatment.servicesOutsideEu);
    expect(
      InvoicePdfService.treatmentNote(invoice, _client('US')),
      contains('artikel 6, lid 1'),
    );
    expect(
      InvoicePdfService.treatmentNote(invoice, _client('US', consumer: true)),
      'Niet in Nederland belast: dienst aan een afnemer buiten de EU '
      '(artikel 6e, 6h of 6i, Wet OB 1968)',
    );
  });
}
