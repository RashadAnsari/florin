import 'package:florin/db/database.dart';
import 'package:florin/services/invoice_pdf_service.dart';
import 'package:florin/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

Invoice _invoice(VatTreatment treatment) => Invoice(
  id: 1,
  invoiceNumber: 'F-2026-001',
  invoiceType: InvoiceType.invoice,
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

void main() {
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
}
