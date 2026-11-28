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

  test('a private person gets Dutch BTW, the KOR or export of goods, and '
      'outside the EU services taxed there (Wet OB 1968 art. 6 lid 2, 6h, '
      '6i)', () {
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
      VatTreatment.servicesOutsideEu,
    });
    expect(VatTreatment.euServices.fitsClient(client('DE')), isTrue);
    expect(de.suggestedVatTreatment(korApplies: false), VatTreatment.standard);
    expect(us.suggestedVatTreatment(korApplies: false), VatTreatment.standard);
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

  Invoice sale(
    int id,
    DateTime date, {
    DateTime? paid,
    InvoiceType type = InvoiceType.invoice,
    InvoiceStatus status = InvoiceStatus.sent,
    DateTime? supplyDate,
    int termDays = 30,
  }) => Invoice(
    id: id,
    invoiceNumber: '$id',
    invoiceType: type,
    invoiceDate: date,
    supplyDate: supplyDate,
    clientId: 1,
    vatTreatment: VatTreatment.standard,
    selfBilled: false,
    sellerName: 'S',
    sellerVatNumber: 'V',
    sellerKvkNumber: 'K',
    sellerAddress: 'A',
    sellerIban: 'I',
    paymentTermDays: termDays,
    status: paid == null ? status : InvoiceStatus.paid,
    paidDate: paid,
    totalExclVat: 10000,
    totalVat: 2100,
    totalInclVat: 12100,
  );

  test('receivables on a day: issued by then and not paid by its end', () {
    final day = DateTime(2026, 12, 31);
    final invoices = [
      sale(1, DateTime(2026, 11, 1)),
      sale(2, DateTime(2026, 11, 1), paid: DateTime(2026, 12, 31, 15)),
      sale(3, DateTime(2026, 11, 1), paid: DateTime(2027, 1, 5)),
      sale(4, DateTime(2027, 1, 2)),
      sale(5, DateTime(2026, 12, 1), status: InvoiceStatus.draft),
      sale(6, DateTime(2026, 12, 10), type: InvoiceType.creditNote),
    ];
    expect(openReceivables(invoices, day), 12100 + 12100 - 12100);
  });

  test('the due date is the invoice date plus the term in calendar days, '
      'also across the end of summer time (BW 6:119a lid 1)', () {
    final inv = sale(1, DateTime(2026, 10, 20), termDays: 14);
    expect(inv.dueDate, DateTime(2026, 11, 3));
    expect(dueDateOf(DateTime(2026, 3, 20), 14), DateTime(2026, 4, 3));
  });

  test('an invoice is overdue from the day after its due date, not on it '
      '(BW 6:119a lid 1, 6:96 lid 4)', () {
    final inv = sale(1, DateTime(2026, 10, 1), termDays: 30);
    expect(inv.dueDate, DateTime(2026, 10, 31));
    expect(inv.isOverdueOn(DateTime(2026, 10, 31, 23, 59)), isFalse);
    expect(inv.isOverdueOn(DateTime(2026, 11, 1)), isTrue);
    final paid = sale(
      2,
      DateTime(2026, 10, 1),
      paid: DateTime(2026, 11, 5),
      termDays: 30,
    );
    expect(paid.isOverdueOn(DateTime(2026, 11, 2)), isFalse);
  });

  test('a claim lapses five years after the invoice date at the latest, or '
      'after the supply date when that is earlier (BW 3:307 lid 1, 6:38)', () {
    final rules = taxRulesFor(2026)!;
    expect(
      sale(1, DateTime(2026, 3, 1)).claimLapsesOn(rules),
      DateTime(2031, 3, 1),
    );
    expect(
      sale(
        2,
        DateTime(2026, 3, 1),
        supplyDate: DateTime(2026, 2, 20),
      ).claimLapsesOn(rules),
      DateTime(2031, 2, 20),
    );
    expect(
      sale(
        3,
        DateTime(2026, 3, 1),
        supplyDate: DateTime(2026, 3, 10),
      ).claimLapsesOn(rules),
      DateTime(2031, 3, 1),
    );
    // 29 February has no counterpart five years on; the earlier day holds.
    expect(
      sale(4, DateTime(2028, 2, 29)).claimLapsesOn(rules),
      DateTime(2033, 2, 28),
    );
  });
}
