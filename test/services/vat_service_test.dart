import 'package:drift/drift.dart' show Value;
import 'package:florin/db/database.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:florin/services/domain.dart';
import 'package:florin/services/kor_service.dart';
import 'package:florin/services/vat_service.dart';
import 'package:flutter_test/flutter_test.dart';

Invoice _invoice(
  int id,
  VatTreatment treatment, {
  InvoiceType type = InvoiceType.invoice,
  InvoiceStatus status = InvoiceStatus.sent,
  int total = 100000,
}) => Invoice(
  id: id,
  invoiceNumber: 'F-2026-$id',
  invoiceType: type,
  invoiceDate: DateTime(2026, 2, 1),
  clientId: 1,
  vatTreatment: treatment,
  selfBilled: false,
  sellerName: 'S',
  sellerVatNumber: 'NL000000000B00',
  sellerKvkNumber: '00000000',
  sellerAddress: 'A',
  sellerIban: 'NL91ABNA0417164300',
  paymentTermDays: 14,
  status: status,
  totalExclVat: total,
  totalVat: 0,
  totalInclVat: total,
);

InvoiceLine _line(int invoiceId, VatRate rate, int amount) => InvoiceLine(
  id: invoiceId * 10,
  invoiceId: invoiceId,
  description: 'd',
  quantity: 1,
  unitPriceExclVat: amount,
  vatRate: rate,
  vatAmount: taxRulesFor(2026)!.vatOn(rate, amount),
  lineTotalExclVat: amount,
  sortOrder: 0,
);

Invoice _goods(int id, DateTime date, int total) => _invoice(
  id,
  VatTreatment.euGoods,
  total: total,
).copyWith(invoiceDate: date);

void main() {
  test('rubrieken follow the Belastingdienst guidance', () {
    final invoices = [
      _invoice(1, VatTreatment.standard),
      _invoice(2, VatTreatment.reverseChargeNl),
      _invoice(3, VatTreatment.euServices),
      _invoice(8, VatTreatment.euGoods),
      _invoice(4, VatTreatment.exportOutsideEu),
      _invoice(5, VatTreatment.standard, type: InvoiceType.creditNote),
      _invoice(6, VatTreatment.standard, status: InvoiceStatus.draft),
      _invoice(7, VatTreatment.standard),
      _invoice(9, VatTreatment.servicesOutsideEu),
      _invoice(
        10,
        VatTreatment.servicesOutsideEu,
        total: 30000,
        type: InvoiceType.creditNote,
      ),
    ];
    final lines = [
      _line(1, VatRate.high, 100000),
      _line(5, VatRate.high, 10000),
      _line(6, VatRate.high, 99999),
      _line(7, VatRate.exempt, 50000),
    ];
    final r = VatService.calculateQuarter(
      invoices: invoices,
      lines: lines,
      expenses: const [],
      year: 2026,
      quarter: 1,
    );
    expect(r.revenue1a, 90000);
    expect(r.vat1a, 21000 - 2100);
    expect(r.revenue1e, 100000);
    expect(r.revenue3b, 200000);
    expect(r.revenue3a, 100000);
    expect(r.icpInvoices.map((i) => i.id), [3, 8]);
    // Services to businesses outside the EU stay out of every rubriek.
    expect(r.revenueOutsideReturn, 70000);
    expect(r.outputVat5a, 21000 - 2100);
  });

  test(
    'a service to an EU business counts in the quarter it was supplied, '
    'goods and corrections by invoice date (Belastingdienst, Opgaaf ICP)',
    () {
      final december = DateTime(2026, 3, 20);
      final service = _invoice(1, VatTreatment.euServices).copyWith(
        invoiceDate: DateTime(2026, 4, 5),
        supplyDate: Value(december),
      );
      final goods = _invoice(2, VatTreatment.euGoods).copyWith(
        invoiceDate: DateTime(2026, 4, 5),
        supplyDate: Value(december),
      );
      final credit =
          _invoice(
            3,
            VatTreatment.euServices,
            type: InvoiceType.creditNote,
            total: 20000,
          ).copyWith(
            invoiceDate: DateTime(2026, 4, 6),
            supplyDate: Value(december),
          );
      VatReturnResult q(int quarter) => VatService.calculateQuarter(
        invoices: [service, goods, credit],
        lines: const [],
        expenses: const [],
        year: 2026,
        quarter: quarter,
      );
      expect(q(1).revenue3b, 100000);
      expect(q(1).icpInvoices.map((i) => i.id), [1]);
      expect(q(2).revenue3b, 100000 - 20000);
      expect(q(2).icpInvoices.map((i) => i.id), [2, 3]);
    },
  );

  test('without goods above the limit the ICP-opgaaf is per quarter, due '
      'the last day of the next month (Wet OB 1968 art. 37a lid 1 and 3)', () {
    final periods = VatService.icpPeriods(
      const [],
      KorStatus.none,
      2026,
      taxRulesFor(2026)!,
    );
    expect(periods.map((p) => p.code), ['Q1', 'Q2', 'Q3', 'Q4']);
    expect(periods.first.due, DateTime(2026, 4, 30));
    expect(periods.last.due, DateTime(2027, 1, 31));
  });

  test('with a yearly BTW period, a goods invoice of 10 February belongs to '
      'ICP period Q1, due 30 April (Wet OB 1968 art. 37a lid 1 and 3)', () {
    final yearly = (year: 2026, kind: VatFilingPeriod.yearly, number: 1);
    final february = _goods(1, DateTime(2026, 2, 10), 100000);
    final periods = VatService.icpPeriodsIn(
      VatService.icpPeriods(
        [february],
        KorStatus.none,
        2026,
        taxRulesFor(2026)!,
      ),
      yearly,
    );
    expect(periods, hasLength(4));
    final holding = periods.firstWhere((p) => p.contains(february.vatDate));
    expect(holding.code, 'Q1');
    expect(holding.due, DateTime(2026, 4, 30));
  });

  VatPeriod period(VatFilingPeriod kind, int n) =>
      (year: 2026, kind: kind, number: n);

  test('filing deadline is the last day of the next month, and three months '
      'after a yearly period (Belastingdienst)', () {
    const q = VatFilingPeriod.quarterly;
    expect(VatService.filingDeadline(period(q, 1)), DateTime(2026, 4, 30));
    expect(VatService.filingDeadline(period(q, 3)), DateTime(2026, 10, 31));
    expect(VatService.filingDeadline(period(q, 4)), DateTime(2027, 1, 31));
    const m = VatFilingPeriod.monthly;
    expect(VatService.filingDeadline(period(m, 1)), DateTime(2026, 2, 28));
    expect(VatService.filingDeadline(period(m, 12)), DateTime(2027, 1, 31));
    expect(
      VatService.filingDeadline(period(VatFilingPeriod.yearly, 1)),
      DateTime(2027, 3, 31),
    );
  });

  test('a period holds its days and the last one carries the year', () {
    final march = period(VatFilingPeriod.monthly, 3);
    expect(march.contains(DateTime(2026, 3, 31, 23)), isTrue);
    expect(march.contains(DateTime(2026, 4, 1)), isFalse);
    expect(march.isLastOfYear, isFalse);
    expect(period(VatFilingPeriod.yearly, 1).isLastOfYear, isTrue);
    expect(vatPeriodsOf(2026, VatFilingPeriod.monthly), hasLength(12));
    expect(period(VatFilingPeriod.monthly, 3).code, 'M03');
  });

  test('a year breaks the yearly return conditions at the limits', () {
    final rules = taxRulesFor(2026)!;
    VatReturnResult year({int vat1a = 0, int r3b = 0}) => VatReturnResult(
      revenue1a: 0,
      vat1a: vat1a,
      revenue1b: 0,
      vat1b: 0,
      revenue1e: 0,
      vat1d: 0,
      revenue3a: 0,
      revenue3b: r3b,
      base2a: 0,
      vat2a: 0,
      base4a: 0,
      vat4a: 0,
      base4b: 0,
      vat4b: 0,
      inputVat5b: 0,
      icpInvoices: const [],
    );
    expect(VatService.yearlyFilingIssue(year(vat1a: 188299), rules), isFalse);
    expect(VatService.yearlyFilingIssue(year(vat1a: 188300), rules), isTrue);
    expect(VatService.yearlyFilingIssue(year(r3b: 1000000), rules), isTrue);
  });

  test('BTW shifted to you goes in 2a, 4a or 4b and 5b (Belastingdienst)', () {
    Expense purchase(int id, PurchaseVat p) => Expense(
      id: id,
      date: DateTime(2026, 2, 1),
      supplier: 's',
      description: 'd',
      category: ExpenseCategory.software,
      paperOriginalKept: true,
      amountExclVat: 10000,
      vatRate: VatRate.high,
      purchaseVat: p,
      vatAmount: 2100,
      totalInclVat: 10000,
      businessUsePct: 1,
      deductibleAmount: 10000,
      vatReclaimable: true,
      vatToReclaim: 2100,
    );
    final r = VatService.calculateQuarter(
      invoices: const [],
      lines: const [],
      expenses: [
        purchase(1, PurchaseVat.fromEu),
        purchase(2, PurchaseVat.fromOutsideEu),
        purchase(3, PurchaseVat.reverseChargeNl),
      ],
      year: 2026,
      quarter: 1,
    );
    expect(r.vat4b, 2100);
    expect(r.vat4a, 2100);
    expect(r.vat2a, 2100);
    expect(r.outputVat5a, 6300);
    expect(r.netVat, 0);
  });

  test('a VAT treatment fits only the countries it is for', () {
    expect(VatTreatment.standard.fitsCountry('US'), isTrue);
    expect(VatTreatment.reverseChargeNl.fitsCountry('NL'), isTrue);
    expect(VatTreatment.reverseChargeNl.fitsCountry('DE'), isFalse);
    expect(VatTreatment.euServices.fitsCountry('DE'), isTrue);
    expect(VatTreatment.euServices.fitsCountry('NL'), isFalse);
    expect(VatTreatment.euServices.fitsCountry('GB'), isFalse);
    expect(VatTreatment.euGoods.fitsCountry('EL'), isTrue);
    expect(VatTreatment.servicesOutsideEu.fitsCountry('GB'), isTrue);
    expect(VatTreatment.servicesOutsideEu.fitsCountry('IE'), isFalse);
    expect(VatTreatment.exportOutsideEu.fitsCountry('CH'), isTrue);
    expect(euCountries.where((c) => c != 'EL'), hasLength(27));
  });

  List<(String, DateTime)> icp(List<Invoice> invoices) => [
    for (final p in VatService.icpPeriods(
      invoices,
      KorStatus.none,
      2026,
      taxRulesFor(2026)!,
    ))
      (p.code, p.due),
  ];

  test('goods passing the limit in the second month of a quarter give one '
      'opgaaf over both months, due the month after, then months (Wet OB '
      '1968 art. 37a lid 3)', () {
    final periods = icp([
      _goods(1, DateTime(2026, 4, 10), 3000000),
      _goods(2, DateTime(2026, 5, 12), 3000000),
    ]);
    expect(periods.take(4), [
      ('Q1', DateTime(2026, 4, 30)),
      ('M04-M05', DateTime(2026, 6, 30)),
      ('M06', DateTime(2026, 7, 31)),
      ('M07', DateTime(2026, 8, 31)),
    ]);
    expect(periods.last, ('M12', DateTime(2027, 1, 31)));
    expect(periods, hasLength(9));
  });

  test('goods passing the limit in the last month of a quarter give one '
      'opgaaf over the quarter, then months (Wet OB 1968 art. 37a lid 3)', () {
    final periods = icp([
      _goods(1, DateTime(2026, 6, 1), 3000000),
      _goods(2, DateTime(2026, 6, 20), 3000000),
    ]);
    expect(periods.take(3), [
      ('Q1', DateTime(2026, 4, 30)),
      ('Q2', DateTime(2026, 7, 31)),
      ('M07', DateTime(2026, 8, 31)),
    ]);
    expect(periods, hasLength(8));
  });

  test('goods passing the limit in the first month of a quarter make each '
      'month its own opgaaf (Wet OB 1968 art. 37a lid 3)', () {
    final periods = icp([_goods(1, DateTime(2026, 4, 2), 6000000)]);
    expect(periods.take(4), [
      ('Q1', DateTime(2026, 4, 30)),
      ('M04', DateTime(2026, 5, 31)),
      ('M05', DateTime(2026, 6, 30)),
      ('M06', DateTime(2026, 7, 31)),
    ]);
  });

  test('goods above the limit in one of the four quarters before make the '
      'whole quarter monthly, and exactly the limit does not (Wet OB 1968 '
      'art. 37a lid 3)', () {
    final rules = taxRulesFor(2026)!;
    // Q2 2025 is within the four quarters before Q1 and Q2 2026, not before
    // Q3 2026.
    expect(icp([_goods(1, DateTime(2025, 5, 1), 6000000)]).map((p) => p.$1), [
      'M01',
      'M02',
      'M03',
      'M04',
      'M05',
      'M06',
      'Q3',
      'Q4',
    ]);
    expect(
      VatService.icpMonthlyByLookback(
        [_goods(1, DateTime(2025, 5, 1), 6000000)],
        KorStatus.none,
        2026,
        3,
        rules,
      ),
      isFalse,
    );
    expect(icp([_goods(2, DateTime(2026, 2, 1), 5000000)]).map((p) => p.$1), [
      'Q1',
      'Q2',
      'Q3',
      'Q4',
    ]);
  });

  test('the ICP lookback names the year before the records Florin holds '
      '(Wet OB 1968 art. 37a lid 3)', () {
    final rules = taxRulesFor(2026)!;
    expect(VatService.icpLookbackWithoutRecords(2026, 4, rules), 2025);
  });

  test(
    'a change to a filed Q4 of at most EUR 1.000 asks the user to add it to '
    'next year\'s first return (Belastingdienst, Toelichting Suppletie btw)',
    () {
      final rules = taxRulesFor(2026)!;
      const change = {'5b': (0, 5000)};
      VatPeriod q(int n) =>
          (year: 2026, kind: VatFilingPeriod.quarterly, number: n);
      expect(
        VatService.correctionRoute(q(4), change, rules),
        CorrectionRoute.nextYearReturn,
      );
      expect(
        VatService.correctionRoute(q(3), change, rules),
        CorrectionRoute.nextReturn,
      );
      expect(
        VatService.correctionRoute(q(4), const {'1a': (0, 100001)}, rules),
        CorrectionRoute.suppletie,
      );
    },
  );
}
