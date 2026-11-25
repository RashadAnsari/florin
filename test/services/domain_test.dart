import 'package:florin/db/database.dart';
import 'package:florin/services/domain.dart';
import 'package:florin/services/vat_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an invoice is due by the 15th of the month after the supply '
      '(Wet OB 1968 art. 34g)', () {
    final rules = taxRulesFor(2026)!;
    expect(
      rules.latestInvoiceDate(DateTime(2026, 1, 31)),
      DateTime(2026, 2, 15),
    );
    expect(
      rules.latestInvoiceDate(DateTime(2026, 12, 3)),
      DateTime(2027, 1, 15),
    );
  });

  test('a voorlopige aanslag can be asked for or changed until 1 May of the '
      'next year (Belastingdienst)', () {
    expect(
      taxRulesFor(2026)!.provisionalAssessmentDeadline,
      DateTime(2027, 5, 1),
    );
  });

  test('todayIn keeps new records inside the selected year', () {
    final now = DateTime.now();
    expect(todayIn(now.year - 1), DateTime(now.year - 1, 12, 31));
    expect(todayIn(now.year + 1), DateTime(now.year + 1));
    expect(todayIn(now.year), DateTime(now.year, now.month, now.day));
  });

  Client client(String country, {bool consumer = false}) => Client(
    id: country.hashCode,
    name: country,
    country: country,
    address: 'A',
    wetDbaRisk: WetDbaRisk.low,
    contractSigned: false,
    isActive: true,
    isMerchantOfRecord: false,
    isConsumer: consumer,
  );

  test('a private person gets Dutch BTW, the KOR or export of goods, never '
      'reverse charge (Wet OB 1968 art. 6 lid 2)', () {
    final de = client('DE', consumer: true);
    expect(VatTreatment.values.where((t) => t.fitsClient(de)).toSet(), {
      VatTreatment.standard,
      VatTreatment.kor,
    });
    final us = client('US', consumer: true);
    expect(VatTreatment.values.where((t) => t.fitsClient(us)).toSet(), {
      VatTreatment.standard,
      VatTreatment.kor,
      VatTreatment.exportOutsideEu,
    });
    expect(VatTreatment.euServices.fitsClient(client('DE')), isTrue);
    expect(de.suggestedVatTreatment(korApplies: false), VatTreatment.standard);
  });

  test('supplies to private persons in other member states count towards the '
      'threshold of art. 6k; others do not', () {
    final clients = {
      1: client('DE', consumer: true),
      2: client('NL', consumer: true),
      3: client('DE'),
    };
    Invoice inv(int id, int clientId, int total, {DateTime? date}) => Invoice(
      id: id,
      invoiceNumber: '$id',
      invoiceType: InvoiceType.invoice,
      invoiceDate: date ?? DateTime(2026, 3, 1),
      clientId: clientId,
      vatTreatment: VatTreatment.standard,
      selfBilled: false,
      sellerName: 'S',
      sellerVatNumber: 'V',
      sellerKvkNumber: 'K',
      sellerAddress: 'A',
      sellerIban: 'I',
      paymentTermDays: 14,
      status: InvoiceStatus.sent,
      totalExclVat: total,
      totalVat: 0,
      totalInclVat: total,
    );
    final invoices = [
      inv(1, 1, 400000),
      inv(2, 2, 900000),
      inv(3, 3, 900000),
      inv(4, 1, 700000, date: DateTime(2025, 6, 1)),
    ];
    expect(VatService.euConsumerSales(invoices, clients, 2026), 400000);
    expect(VatService.euConsumerSales(invoices, clients, 2025), 700000);
    expect(taxRulesFor(2026)!.euConsumerSalesThreshold, 1000000);
  });
}
