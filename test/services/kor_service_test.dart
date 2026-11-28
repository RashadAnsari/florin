import 'package:drift/drift.dart' show Value;
import 'package:florin/db/database.dart';
import 'package:florin/services/domain.dart';
import 'package:florin/services/kor_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:florin/services/vat_service.dart';
import 'package:flutter_test/flutter_test.dart';

Invoice _invoice(
  int id,
  DateTime date,
  int total, {
  VatTreatment treatment = VatTreatment.kor,
  InvoiceStatus status = InvoiceStatus.sent,
  InvoiceType type = InvoiceType.invoice,
}) => Invoice(
  id: id,
  invoiceNumber: 'F-$id',
  invoiceType: type,
  invoiceDate: date,
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

BusinessProfile _profile({DateTime? start, DateTime? end}) => BusinessProfile(
  id: 1,
  name: 'S',
  vatNumber: 'NL000000000B00',
  kvkNumber: '00000000',
  address: 'A',
  iban: 'NL91ABNA0417164300',
  korStart: start,
  korEnd: end,
);

void main() {
  test('turnover counts supplies taxed in NL, not services taxed abroad '
      '(Belastingdienst, Omzet die meetelt voor KOR)', () {
    for (final t in [
      VatTreatment.standard,
      VatTreatment.reverseChargeNl,
      VatTreatment.euGoods,
      VatTreatment.exportOutsideEu,
      VatTreatment.kor,
    ]) {
      expect(KorService.counts(t), isTrue, reason: t.name);
    }
    expect(KorService.counts(VatTreatment.euServices), isFalse);
    expect(KorService.counts(VatTreatment.servicesOutsideEu), isFalse);

    final invoices = [
      _invoice(1, DateTime(2026, 1, 10), 500000),
      _invoice(
        2,
        DateTime(2026, 2, 10),
        300000,
        treatment: VatTreatment.servicesOutsideEu,
      ),
      _invoice(3, DateTime(2026, 3, 10), 100000, type: InvoiceType.creditNote),
      _invoice(4, DateTime(2026, 3, 11), 999999, status: InvoiceStatus.draft),
    ];
    expect(KorService.turnover(invoices, 2026), 400000);
    expect(
      KorService.turnover(invoices, 2026, through: DateTime(2026, 1, 31)),
      500000,
    );
  });

  test('the KOR ends with the supply that passes the limit, for the rest of '
      'that year and the next (art. 25a lid 9)', () {
    final invoices = [
      _invoice(1, DateTime(2026, 1, 28), 1530000),
      _invoice(
        2,
        DateTime(2026, 4, 28),
        510000,
        treatment: VatTreatment.standard,
      ),
    ];
    final status = KorService.status(
      _profile(start: DateTime(2026, 1, 1)),
      invoices,
    );
    expect(status.exceededOn[2026], DateTime(2026, 4, 28));
    expect(status.appliesOn(DateTime(2026, 4, 27)), isTrue);
    expect(status.appliesOn(DateTime(2026, 4, 28)), isFalse);
    expect(status.appliesOn(DateTime(2026, 12, 31)), isFalse);
    expect(status.appliesOn(DateTime(2027, 6, 1)), isFalse);
    expect(status.covers(DateTime(2026), DateTime(2026, 3, 31)), isTrue);
    expect(status.covers(DateTime(2026, 4), DateTime(2026, 6, 30)), isFalse);
    expect(status.touches(DateTime(2026, 4), DateTime(2026, 6, 30)), isTrue);
    expect(status.touches(DateTime(2026, 7), DateTime(2026, 9, 30)), isFalse);
  });

  test('passing the limit ends the KOR until a new registration (Wet OB 1968 '
      'art. 25a lid 5 and 9)', () {
    final invoices = [
      _invoice(1, DateTime(2026, 1, 28), 1530000),
      _invoice(
        2,
        DateTime(2026, 4, 28),
        510000,
        treatment: VatTreatment.standard,
      ),
    ];
    final status = KorService.status(
      _profile(start: DateTime(2026, 1, 1)),
      invoices,
    );
    expect(status.appliesOn(DateTime(2028, 6, 1)), isFalse);
    // A new registration from 2028 starts the scheme again.
    final again = KorService.status(
      _profile(start: DateTime(2028, 7, 1)),
      invoices,
    );
    expect(again.appliesOn(DateTime(2028, 6, 30)), isFalse);
    expect(again.appliesOn(DateTime(2028, 7, 1)), isTrue);
  });

  test('a new KOR start in the rest of the year the limit was passed or the '
      'year after is refused (Wet OB 1968 art. 25a lid 9)', () {
    final status = KorService.status(_profile(start: DateTime(2026, 1, 1)), [
      _invoice(1, DateTime(2026, 4, 28), 2100000),
    ]);
    expect(status.startBlockedUntil(DateTime(2026, 1, 1)), isNull);
    expect(status.startBlockedUntil(DateTime(2026, 7, 1)), DateTime(2028));
    expect(status.startBlockedUntil(DateTime(2027, 12, 1)), DateTime(2028));
    expect(status.startBlockedUntil(DateTime(2028, 1, 1)), isNull);
  });

  test('turnover counts a supply in the year and on the day it was performed '
      '(Wet OB 1968 art. 25 lid 1 a)', () {
    final january = _invoice(
      1,
      DateTime(2027, 1, 5),
      500000,
    ).copyWith(supplyDate: Value(DateTime(2026, 12, 20)));
    expect(KorService.turnover([january], 2026), 500000);
    expect(KorService.turnover([january], 2027), 0);
    final september = _invoice(
      2,
      DateTime(2026, 9, 30),
      2100000,
      treatment: VatTreatment.standard,
    ).copyWith(supplyDate: Value(DateTime(2026, 9, 10)));
    final status = KorService.status(_profile(start: DateTime(2026, 1, 1)), [
      september,
    ]);
    expect(status.exceededOn[2026], DateTime(2026, 9, 10));
    expect(status.appliesOn(DateTime(2026, 9, 20)), isFalse);
  });

  test('the KOR applies from its start and until a voluntary end '
      '(art. 25a lid 5 and 7)', () {
    final status = KorService.status(
      _profile(start: DateTime(2026, 4, 1), end: DateTime(2026, 10, 1)),
      const [],
    );
    expect(status.appliesOn(DateTime(2026, 3, 31)), isFalse);
    expect(status.appliesOn(DateTime(2026, 4, 1)), isTrue);
    expect(status.appliesOn(DateTime(2026, 9, 30)), isTrue);
    expect(status.appliesOn(DateTime(2026, 10, 1)), isFalse);
    expect(KorService.status(_profile(), const []).participates, isFalse);
  });

  test('an invoice that would pass the limit is found before it is saved', () {
    final invoices = [_invoice(1, DateTime(2026, 3, 1), 1900000)];
    bool exceeds(int amount, VatTreatment t) => KorService.wouldExceed(
      invoices: invoices,
      date: DateTime(2026, 3, 5),
      treatment: t,
      amount: amount,
      limit: 2000000,
    );
    expect(exceeds(100000, VatTreatment.kor), isFalse);
    expect(exceeds(100001, VatTreatment.kor), isTrue);
    // A service taxed abroad does not count.
    expect(exceeds(500000, VatTreatment.euServices), isFalse);
  });

  test('under the KOR no BTW on purchases is reclaimed; it becomes cost '
      '(art. 25a lid 4)', () {
    final expense = Expense(
      id: 1,
      date: DateTime(2026, 2, 1),
      supplier: 's',
      description: 'd',
      category: ExpenseCategory.software,
      paperOriginalKept: true,
      amountExclVat: 10000,
      vatRate: VatRate.high,
      purchaseVat: PurchaseVat.domestic,
      vatAmount: 2100,
      totalInclVat: 12100,
      businessUsePct: 1,
      deductibleAmount: 10000,
      vatReclaimable: true,
      vatToReclaim: 2100,
    );
    final status = KorService.status(
      _profile(start: DateTime(2026, 1, 1)),
      const [],
    );
    final [applied] = KorService.applyToExpenses([expense], status);
    expect(applied.vatToReclaim, 0);
    expect(applied.deductibleAmount, 12100);
    final outside = KorService.applyToExpenses([
      expense.copyWith(date: DateTime(2025, 12, 31)),
    ], status).single;
    expect(outside.vatToReclaim, 2100);
  });

  test('KOR-exempt invoices are in no rubriek and the treatment fits a client '
      'anywhere', () {
    final r = VatService.calculateQuarter(
      invoices: [_invoice(1, DateTime(2026, 2, 1), 50000)],
      lines: const [],
      expenses: const [],
      year: 2026,
      quarter: 1,
    );
    expect(r.revenueKorExempt, 50000);
    expect(r.revenue1a + r.revenue1e + r.revenue3a + r.revenue3b, 0);
    expect(r.outputVat5a, 0);
    expect(VatTreatment.kor.fitsCountry('US'), isTrue);
  });

  group('which return a quarter needs (Wet OB 1968 art. 14 lid 1; '
      'Belastingdienst, Moet ik altijd btw-aangifte doen?)', () {
    final fromEu = Expense(
      id: 1,
      date: DateTime(2026, 2, 3),
      supplier: 's',
      description: 'd',
      category: ExpenseCategory.software,
      paperOriginalKept: false,
      amountExclVat: 5500,
      vatRate: VatRate.high,
      purchaseVat: PurchaseVat.fromEu,
      vatAmount: 1155,
      totalInclVat: 5500,
      businessUsePct: 1,
      deductibleAmount: 5500,
      vatReclaimable: true,
      vatToReclaim: 1155,
    );
    final kor = KorService.status(_profile(start: DateTime(2026, 1, 1)), []);

    VatReturnResult quarter({
      List<Expense> expenses = const [],
      List<Invoice> invoices = const [],
      KorStatus status = KorStatus.none,
    }) => VatService.calculateQuarter(
      invoices: invoices,
      lines: const [],
      expenses: KorService.applyToExpenses(expenses, status),
      year: 2026,
      quarter: 1,
      kor: status,
    );

    test('outside the KOR every quarter needs a return, also an empty one', () {
      final r = quarter();
      expect(r.duty, ReturnDuty.regular);
      expect(r.isEmpty, isTrue);
    });

    test('a KOR quarter without BTW owed needs none', () {
      expect(quarter(status: kor).duty, ReturnDuty.none);
    });

    test('BTW shifted to a KOR participant is owed, not deducted, and needs '
        'an incidental return', () {
      final r = quarter(expenses: [fromEu], status: kor);
      expect(r.duty, ReturnDuty.incidental);
      expect(r.vat4b, 1155);
      expect(r.inputVat5b, 0);
      expect(r.netVat, 1155);
    });

    test('services to EU businesses while the KOR applies are not on the '
        'ICP list (art. 37a lid 1)', () {
      final services = _invoice(
        2,
        DateTime(2026, 2, 1),
        30000,
        treatment: VatTreatment.euServices,
      );
      expect(quarter(invoices: [services], status: kor).icpInvoices, isEmpty);
      expect(quarter(invoices: [services]).icpInvoices, [services]);
    });
  });

  group('herziening because of the KOR (Belastingdienst examples)', () {
    final rules = taxRulesFor(2026)!;
    FixedAsset car(DateTime bought, int vat, {DateTime? sold}) => FixedAsset(
      id: 1,
      kind: AssetKind.car,
      assetName: 'Auto',
      costExclVat: 2000000,
      purchaseVat: PurchaseVat.domestic,
      vatAmount: vat,
      vatReclaimable: true,
      vatToReclaim: vat,
      residualValue: 0,
      purchaseDate: bought,
      businessUsePct: 1,
      usefulLifeYears: 5,
      kiaEligible: false,
      eiaEligible: false,
      reinvestmentReserveApplied: 0,
      reserveGain: false,
      zeroEmission: ZeroEmission.none,
      keepsTripLog: false,
      disposalDate: sold,
    );
    KorStatus from(DateTime start) => KorStatus(
      start: start,
      end: null,
      exceededOn: const {},
      turnover: const {},
    );

    test('a later year under the KOR repays one fifth', () {
      final r = KorService.revision(
        status: from(DateTime(2025)),
        assets: [car(DateTime(2024), 450000)],
        invoices: [_invoice(1, DateTime(2026, 3, 1), 100000)],
        year: 2026,
        rules: rules,
      );
      expect(r.yearEnd.values.single, 90000);
      expect(r.sales, isEmpty);
    });

    test('joining in the year of purchase revises the whole deduction by '
        'the taxed share; later years below EUR 500 are not revised', () {
      final kor = from(DateTime(2025, 7));
      final invoices = [
        _invoice(
          1,
          DateTime(2025, 3, 1),
          100000,
          treatment: VatTreatment.standard,
        ),
        _invoice(2, DateTime(2025, 9, 1), 100000),
        _invoice(3, DateTime(2026, 3, 1), 100000),
      ];
      final asset = car(DateTime(2025), 450000);
      expect(
        KorService.revision(
          status: kor,
          assets: [asset],
          invoices: invoices,
          year: 2025,
          rules: rules,
        ).yearEnd.values.single,
        225000,
      );
      final later = KorService.revision(
        status: kor,
        assets: [asset],
        invoices: invoices,
        year: 2026,
        rules: rules,
      );
      expect(later.yearEnd, isEmpty);
      expect(later.sales, isEmpty);
    });

    test('the year of purchase is revised on the whole year without the 10% '
        'margin (Uitvoeringsbeschikking OB 1968 art. 12 lid 3)', () {
      final r = KorService.revision(
        status: from(DateTime(2026, 10)),
        assets: [car(DateTime(2026), 450000)],
        invoices: [
          _invoice(
            1,
            DateTime(2026, 3, 1),
            92000,
            treatment: VatTreatment.standard,
          ),
          _invoice(2, DateTime(2026, 11, 1), 8000),
        ],
        year: 2026,
        rules: rules,
      );
      // 92% taxed: a shift of 8%, within the margin a later year has.
      expect(r.yearEnd.values.single, 36000);
    });

    test('the share of the year of purchase is the whole boekjaar\'s '
        '(Uitvoeringsbeschikking OB 1968 art. 12 lid 3)', () {
      final kor = from(DateTime(2025, 7));
      final invoices = [
        _invoice(
          1,
          DateTime(2025, 1, 15),
          100000,
          treatment: VatTreatment.standard,
        ),
        _invoice(
          2,
          DateTime(2025, 9, 15),
          50000,
          treatment: VatTreatment.euServices,
        ),
        _invoice(3, DateTime(2025, 10, 15), 150000),
      ];
      int revised(DateTime bought) => KorService.revision(
        status: kor,
        assets: [car(bought, 450000)],
        invoices: invoices,
        year: 2025,
        rules: rules,
      ).yearEnd.values.single;
      expect(revised(DateTime(2025, 3, 1)), revised(DateTime(2025)));
      expect(revised(DateTime(2025, 3, 1)), 225000);
    });

    test('an asset bought after the KOR ended that year served only taxed '
        'supplies and is not revised (Uitvoeringsbeschikking OB 1968 '
        'art. 11 lid 1 a)', () {
      final kor = KorStatus(
        start: DateTime(2025),
        end: null,
        exceededOn: {2026: DateTime(2026, 4, 28)},
        turnover: const {},
      );
      final r = KorService.revision(
        status: kor,
        assets: [car(DateTime(2026, 5, 4), 450000)],
        invoices: [
          _invoice(1, DateTime(2026, 2, 1), 1500000),
          _invoice(
            2,
            DateTime(2026, 4, 28),
            600000,
            treatment: VatTreatment.standard,
          ),
        ],
        year: 2026,
        rules: rules,
      );
      expect(r.yearEnd, isEmpty);
    });

    test('a sale under the KOR settles the remaining years at once', () {
      final r = KorService.revision(
        status: from(DateTime(2025)),
        assets: [car(DateTime(2024), 450000, sold: DateTime(2026, 6, 1))],
        invoices: const [],
        year: 2026,
        rules: rules,
      );
      // 2026, 2027 and 2028 remain of the five years.
      expect(r.sales.values.single, 270000);
      expect(r.yearEnd, isEmpty);
    });

    test('a sale under the KOR settles the herziening in the return of the '
        'sale\'s period (Uitvoeringsbeschikking OB 1968 art. 13a lid 2)', () {
      final kor = from(DateTime(2025));
      final sold = car(DateTime(2024), 450000, sold: DateTime(2026, 6, 1));
      VatReturnResult quarter(int q) => VatService.fromRecords(
        invoices: const [],
        lines: const [],
        expenses: const [],
        assets: [sold],
        trips: const [],
        period: (year: 2026, kind: VatFilingPeriod.quarterly, number: q),
        kor: kor,
        rules: rules,
      );
      expect(quarter(2).vat1a, 270000);
      expect(quarter(2).duty, ReturnDuty.incidental);
      expect(quarter(4).vat1a, 0);
      expect(quarter(4).duty, ReturnDuty.none);
    });

    test(
      'a KOR year shows both the herziening and the BTW on private use, '
      'the cautious reading (Wet OB 1968 art. 4 lid 2 a, art. 25a lid 1)',
      () {
        final kept = car(
          DateTime(2025),
          630000,
        ).copyWith(catalogueValue: const Value(4000000));
        final q4 = VatService.fromRecords(
          invoices: const [],
          lines: const [],
          expenses: const [],
          assets: [kept],
          trips: const [],
          period: (year: 2026, kind: VatFilingPeriod.quarterly, number: 4),
          kor: from(DateTime(2026)),
          rules: rules,
        );
        expect(q4.vatRevisionTotal, 126000);
        expect(q4.vat1d, 108000);
        expect(q4.privateUseUnderKor, isTrue);
        expect(q4.duty, ReturnDuty.incidental);
      },
    );

    test('the revision goes into the BTW of rubriek 1a and makes the KOR '
        'quarter need a return', () {
      final asset = car(DateTime(2024), 450000);
      final q4 = VatService.calculateQuarter(
        invoices: const [],
        lines: const [],
        expenses: const [],
        year: 2026,
        quarter: 4,
        kor: from(DateTime(2025)),
        vatRevision: {asset: 90000},
      );
      expect(q4.vat1a, 90000);
      expect(q4.netVat, 90000);
      expect(q4.duty, ReturnDuty.incidental);
    });
  });
}
