import 'package:florin/db/database.dart';
import 'package:florin/services/csv_export_service.dart';
import 'package:florin/services/vat_service.dart';
import 'package:flutter_test/flutter_test.dart';

Invoice _invoice(
  int id,
  VatTreatment treatment,
  int total, {
  bool credit = false,
}) => Invoice(
  id: id,
  invoiceNumber: 'F-2026-$id',
  invoiceType: credit ? InvoiceType.creditNote : InvoiceType.invoice,
  invoiceDate: DateTime(2026, 2, 1),
  clientId: 1,
  vatTreatment: treatment,
  sellerName: 'S',
  sellerVatNumber: 'NL000000000B00',
  sellerKvkNumber: '00000000',
  sellerAddress: 'A',
  sellerIban: 'NL91ABNA0417164300',
  paymentTermDays: 14,
  status: InvoiceStatus.sent,
  totalExclVat: total,
  totalVat: 0,
  totalInclVat: total,
);

VatQuarterResult _quarter({
  int revenue1a = 0,
  int vat1a = 0,
  int vat2a = 0,
  int input5b = 0,
  List<Invoice> icp = const [],
}) => VatQuarterResult(
  revenue1a: revenue1a,
  vat1a: vat1a,
  revenue1b: 0,
  vat1b: 0,
  revenue1e: 0,
  vat1d: 0,
  revenue3a: 0,
  revenue3b: 0,
  base2a: 0,
  vat2a: vat2a,
  base4a: 0,
  vat4a: 0,
  base4b: 0,
  vat4b: 0,
  inputVat5b: input5b,
  icpInvoices: icp,
);

List<Object> _row(List<List<Object>> rows, String rubriek) =>
    rows.firstWhere((r) => r.first == rubriek);

void main() {
  group('BTW return export, rounding per docs/legal.md', () {
    test('lists every rubriek of the form in order', () {
      final codes = CsvExportService.btwReturnRows(
        _quarter(),
      ).skip(1).map((r) => r.first).toList();
      expect(codes, [
        '1a', '1b', '1c', '1d', '1e', '2a', '3a', '3b', '3c', '4a', '4b', //
        '5a', '5b', '',
      ]);
    });

    test('owed amounts round down, voorbelasting rounds up', () {
      final rows = CsvExportService.btwReturnRows(
        _quarter(revenue1a: 123499, vat1a: 25934, vat2a: 1099, input5b: 10001),
      );
      expect(_row(rows, '1a').sublist(2), [1234, 259]);
      expect(_row(rows, '2a').last, 10);
      expect(_row(rows, '5a').last, 269);
      expect(_row(rows, '5b').last, 101);
      expect(_row(rows, '').last, 168);
    });

    test(
      'negative amounts keep their sign and round in the filer\'s favour',
      () {
        final rows = CsvExportService.btwReturnRows(
          _quarter(revenue1a: -10050, vat1a: -2110),
        );
        expect(_row(rows, '1a').sublist(2), [-101, -22]);
        expect(_row(rows, '').last, -22);
      },
    );
  });

  test('ICP list totals per customer with goods and services apart', () {
    final client = Client(
      id: 1,
      name: 'K',
      country: 'BE',
      vatNumber: 'BE0123456789',
      address: 'A',
      wetDbaRisk: WetDbaRisk.low,
      contractSigned: false,
      isActive: true,
    );
    final rows = CsvExportService.icpRows(
      _quarter(
        icp: [
          _invoice(1, VatTreatment.euGoods, 50000),
          _invoice(2, VatTreatment.euServices, 20000),
          _invoice(3, VatTreatment.euServices, 5000, credit: true),
        ],
      ),
      {1: client},
    );
    expect(rows, hasLength(2));
    expect(rows[1], ['BE', 'BE0123456789', 500.0, 150.0]);
  });
}
