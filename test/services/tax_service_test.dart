import 'package:florin/db/database.dart';
import 'package:florin/services/asset_service.dart';
import 'package:florin/services/csv_export_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:florin/services/tax_service.dart';
import 'package:flutter_test/flutter_test.dart';

const _noInputs = TaxYearInput(
  year: 2026,
  partnerHours: 0,
  partnerPay: 0,
  hasSoVerklaring: false,
  soStarter: false,
  businessCeased: false,
  stakingsaftrekUsedBefore: 0,
  disabilityBenefit: false,
  disabilityStartersUsed: 0,
  unrealisedZelfstandigenaftrek: 0,
  lossCarryForward: 0,
  employed: false,
  wages: 0,
  wageTaxWithheld: 0,
  zvwWages: 0,
  employmentHours: 0,
  notOndernemerBefore: false,
  isStarter: false,
  equityStart: 0,
  bankBalance: 0,
  cashBalance: 0,
  unpaidPurchases: 0,
  longTermLoans: 0,
  privateWithdrawals: 0,
  privateDeposits: 0,
  vatFilingPeriod: VatFilingPeriod.quarterly,
);

void main() {
  final rules = taxRulesFor(2026)!;

  TaxResult calc({
    int revenue = 0,
    bool uren = true,
    bool starter = false,
    int lijfrente = 0,
    int aov = 0,
    int disposalResult = 0,
    int stakingswinst = 0,
    double? hours,
    bool yearOver = true,
    double soHours = 0,
    TaxYearInput? inputs,
  }) => TaxService.calculate(
    rules: rules,
    grossRevenue: revenue,
    creditNotes: 0,
    deductibleExpenses: 0,
    depreciation: 0,
    disposalResult: disposalResult,
    mileageAllowance: 0,
    investmentDeduction: const InvestmentDeduction(),
    desinvesteringsbijtelling: 0,
    carPrivateUse: 0,
    reserveReleased: 0,
    stakingswinst: stakingswinst,
    // With the urencriterium, the hours that meet it unless given.
    totalHours: hours ?? (uren ? rules.urencriterium.toDouble() : 0),
    soHours: soHours,
    partnerHours: (inputs?.partnerHours ?? 0).toDouble(),
    hoursFinal: yearOver,
    // A startersaftrek starter was not an ondernemer in a previous year.
    inputs: starter
        ? (inputs ?? _noInputs).copyWith(
            isStarter: true,
            notOndernemerBefore: true,
          )
        : inputs,
    lijfrentePremium: lijfrente,
    aovPremium: aov,
  );

  TaxYearInput inputs({
    int partnerHours = 0,
    int partnerPay = 0,
    bool so = false,
    bool soStarter = false,
    bool ceased = false,
    int stakingsUsed = 0,
    bool disability = false,
    int disabilityUsed = 0,
    int unrealised = 0,
    int losses = 0,
    bool employed = false,
    int wages = 0,
    int withheld = 0,
    int zvwWages = 0,
    int jobHours = 0,
    bool notOndernemerBefore = false,
  }) => TaxYearInput(
    year: 2026,
    partnerHours: partnerHours,
    partnerPay: partnerPay,
    hasSoVerklaring: so,
    soStarter: soStarter,
    businessCeased: ceased,
    stakingsaftrekUsedBefore: stakingsUsed,
    disabilityBenefit: disability,
    disabilityStartersUsed: disabilityUsed,
    unrealisedZelfstandigenaftrek: unrealised,
    lossCarryForward: losses,
    employed: employed,
    wages: wages,
    wageTaxWithheld: withheld,
    zvwWages: zvwWages,
    employmentHours: jobHours,
    notOndernemerBefore: notOndernemerBefore,
    vatFilingPeriod: VatFilingPeriod.quarterly,
    isStarter: false,
    equityStart: 0,
    bankBalance: 0,
    cashBalance: 0,
    unpaidPurchases: 0,
    longTermLoans: 0,
    privateWithdrawals: 0,
    privateDeposits: 0,
  );

  TaxYearInput job({
    int wages = 4000000,
    int withheld = 0,
    int? zvwWages,
    int hours = 0,
    bool notOndernemerBefore = false,
  }) => inputs(
    employed: true,
    wages: wages,
    withheld: withheld,
    zvwWages: zvwWages ?? wages,
    jobHours: hours,
    notOndernemerBefore: notOndernemerBefore,
  );

  group('a job next to the business', () {
    test('wages and profit are taxed together in box 1 (art. 3.1 lid 2)', () {
      final r = calc(revenue: 3000000, inputs: job());
      final alone = calc(revenue: 3000000);
      expect(r.taxableIncome, alone.taxableIncome + 4000000);
      expect(r.bracketTax, rules.box1TaxPerBracket(r.taxableIncome));
    });

    test('arbeidskorting on profit and loon together (art. 8.1 lid 1 e)', () {
      final r = calc(revenue: 1000000, inputs: job(wages: 1500000));
      expect(r.arbeidskorting, rules.arbeidskorting.valueFor(2500000));
    });

    test('algemene heffingskorting on the combined income (art. 2.18)', () {
      final r = calc(revenue: 3000000, inputs: job());
      expect(
        r.algemeneHeffingskorting,
        rules.algemeneHeffingskorting.valueFor(r.taxableIncome),
      );
    });

    test('the tariefaanpassing counts the wages towards the top bracket '
        '(art. 2.10 lid 2)', () {
      // € 40.000 profit stays below the top bracket alone, not with
      // € 60.000 wages.
      expect(calc(revenue: 4000000).tariefaanpassing, 0);
      expect(
        calc(revenue: 4000000, inputs: job(wages: 6000000)).tariefaanpassing,
        greaterThan(0),
      );
    });

    test('loon Zvw lowers the maximum for the Zvw on the profit '
        '(Zvw art. 43 lid 5)', () {
      // The Belastingdienst example: € 40.000 loon Zvw leaves € 39.409 of
      // the maximum for the profit.
      final r = calc(revenue: 5000000, uren: false, inputs: job());
      expect(r.belastbareWinst, greaterThan(3940900));
      expect(r.zvwContribution, (3940900 * rules.zvwRate).round());
      // Loon above the maximum leaves nothing.
      expect(
        calc(
          revenue: 1500000,
          inputs: job(wages: 8000000, zvwWages: 8000000),
        ).zvwContribution,
        0,
      );
    });

    test(
      'loonheffing withheld is settled against the tax (art. 9.2 lid 1)',
      () {
        final r = calc(revenue: 3000000, inputs: job(withheld: 900000));
        expect(r.wageTaxWithheld, 900000);
        expect(r.taxToPay, r.totalTax - 900000);
        final refund = calc(inputs: job(withheld: 2000000));
        expect(refund.taxToPay, lessThan(0));
      },
    );

    test('net profit after tax counts only the tax the business adds', () {
      final r = calc(revenue: 3000000, inputs: job());
      expect(r.wageOnlyTax, TaxService.wageOnlyTax(4000000, rules));
      expect(r.netProfitAfterTax, r.grossProfit - (r.totalTax - r.wageOnlyTax));
      expect(calc(inputs: job()).businessTax, 0);
    });

    test('a job turned off counts nothing', () {
      final off = inputs(wages: 4000000, withheld: 900000, zvwWages: 4000000);
      expect(
        calc(revenue: 3000000, inputs: off).taxableIncome,
        calc(revenue: 3000000).taxableIncome,
      );
      expect(calc(revenue: 3000000, inputs: off).wageTaxWithheld, 0);
    });
  });

  group('urencriterium with a job (art. 3.6 lid 1)', () {
    test('needs more hours in the business than in the job', () {
      expect(
        calc(
          revenue: 5000000,
          hours: 1300,
          inputs: job(hours: 1300),
        ).zelfstandigenaftrek,
        0,
      );
      expect(
        calc(
          revenue: 5000000,
          hours: 1301,
          inputs: job(hours: 1300),
        ).zelfstandigenaftrek,
        rules.zelfstandigenaftrek,
      );
    });

    test('not when the user was not an ondernemer in a previous year '
        '(lid 1 b)', () {
      expect(
        calc(
          revenue: 5000000,
          hours: 1300,
          inputs: job(hours: 1800, notOndernemerBefore: true),
        ).zelfstandigenaftrek,
        rules.zelfstandigenaftrek,
      );
      expect(
        calc(
          revenue: 5000000,
          hours: 1300,
          starter: true,
          inputs: job(hours: 1800),
        ).startersaftrek,
        rules.startersaftrek,
      );
    });

    test('the job hours apply only to someone employed', () {
      expect(TaxService.timeTestHours(job(hours: 500)), 500);
      expect(TaxService.timeTestHours(inputs()), null);
      expect(
        TaxService.timeTestHours(job(hours: 500).copyWith(isStarter: true)),
        null,
      );
    });
  });

  group('ondernemersaftrek', () {
    test('meewerkaftrek by partner hours (art. 3.78)', () {
      expect(
        calc(revenue: 5000000, inputs: inputs(partnerHours: 900)).meewerkaftrek,
        100000,
      );
      expect(
        calc(revenue: 5000000, inputs: inputs(partnerHours: 524)).meewerkaftrek,
        0,
      );
      expect(
        calc(
          revenue: 5000000,
          uren: false,
          inputs: inputs(partnerHours: 2000),
        ).meewerkaftrek,
        0,
      );
    });

    test('pay to the partner: below € 5.000 not deductible and still '
        'meewerkaftrek; from it a cost and no meewerkaftrek '
        '(art. 3.16 lid 4, art. 3.78 lid 1)', () {
      final low = calc(
        revenue: 5000000,
        inputs: inputs(partnerHours: 900, partnerPay: 499999),
      );
      expect(low.totalCosts, 0);
      expect(low.meewerkaftrek, 100000);
      final paid = calc(
        revenue: 5000000,
        inputs: inputs(partnerHours: 900, partnerPay: 500000),
      );
      expect(paid.totalCosts, 500000);
      expect(paid.meewerkaftrek, 0);
    });

    test('S&O-aftrek needs the verklaring and 500 hours (art. 3.77)', () {
      expect(
        calc(revenue: 5000000, soHours: 500, inputs: inputs(so: true)).soAftrek,
        1597900,
      );
      expect(
        calc(
          revenue: 5000000,
          soHours: 500,
          inputs: inputs(so: true, soStarter: true),
        ).soAftrek,
        1597900 + 799600,
      );
      expect(
        calc(revenue: 5000000, soHours: 499, inputs: inputs(so: true)).soAftrek,
        0,
      );
    });

    test('stakingsaftrek up to € 3.630 minus earlier use (art. 3.79)', () {
      expect(
        calc(
          revenue: 1000000,
          stakingswinst: 1000000,
          inputs: inputs(ceased: true),
        ).stakingsaftrek,
        363000,
      );
      expect(
        calc(
          revenue: 1000000,
          stakingswinst: 1000000,
          inputs: inputs(ceased: true, stakingsUsed: 300000),
        ).stakingsaftrek,
        63000,
      );
    });

    test('startersaftrek bij arbeidsongeschiktheid (art. 3.78a)', () {
      final r = calc(
        revenue: 2000000,
        uren: false,
        starter: true,
        hours: 800,
        inputs: inputs(disability: true, disabilityUsed: 1),
      );
      expect(r.disabilityStartersaftrek, 800000);
      expect(r.zelfstandigenaftrek, 0);
    });

    test('startersaftrek bij arbeidsongeschiktheid needs only that the user '
        'was not an ondernemer in a previous year, not the startersaftrek '
        '(art. 3.78a lid 1)', () {
      TaxResult r({required bool notBefore}) => calc(
        revenue: 2000000,
        uren: false,
        hours: 800,
        inputs: inputs(
          disability: true,
        ).copyWith(notOndernemerBefore: notBefore),
      );
      expect(r(notBefore: true).disabilityStartersaftrek, 1200000);
      expect(r(notBefore: false).disabilityStartersaftrek, 0);
    });

    test('unrealised zelfstandigenaftrek is used up to the profit', () {
      final r = calc(revenue: 150000, inputs: inputs(unrealised: 100000));
      expect(r.zelfstandigenaftrek, 120000);
      expect(r.unrealisedZelfstandigenaftrek, 30000);
    });
  });

  test('earlier losses reduce taxable income down to zero', () {
    final base = calc(revenue: 5000000);
    final r = calc(revenue: 5000000, inputs: inputs(losses: 100000));
    expect(r.taxableIncome, base.taxableIncome - 100000);
    expect(
      calc(revenue: 100000, inputs: inputs(losses: 99999999)).taxableIncome,
      0,
    );
  });

  test('gemengde kosten: the better of 80% and above € 5.700 (art. 3.15)', () {
    expect(TaxService.gemengdeKostenDeductible(100000, rules), 80000);
    expect(TaxService.gemengdeKostenDeductible(5000000, rules), 4430000);
  });

  Expense cost(ExpenseCategory category, int amount) => Expense(
    id: amount,
    date: DateTime(2026, 5, 1),
    supplier: 's',
    description: 'd',
    category: category,
    paperOriginalKept: false,
    amountExclVat: amount,
    vatRate: VatRate.zero,
    purchaseVat: PurchaseVat.domestic,
    vatAmount: 0,
    totalInclVat: amount,
    businessUsePct: 1,
    deductibleAmount: amount,
    vatReclaimable: false,
    vatToReclaim: 0,
  );

  test('fines, clothing, a home phone line and general literature are not '
      'deducted (Wet IB 2001 art. 3.14 lid 1 c, art. 3.16 lid 2 a to d)', () {
    final expenses = [
      cost(ExpenseCategory.software, 10000),
      cost(ExpenseCategory.fines, 20000),
      cost(ExpenseCategory.clothingAndCare, 30000),
      cost(ExpenseCategory.homePhoneLine, 4000),
      cost(ExpenseCategory.generalLiterature, 5000),
    ];
    expect(TaxService.barredCosts(expenses), 59000);
    expect(TaxService.deductibleExpenses(expenses, rules), 10000);
  });

  test('course and congress travel is deducted up to € 1.500 '
      '(art. 3.16 lid 2 f)', () {
    expect(
      TaxService.deductibleExpenses([
        cost(ExpenseCategory.courseTravel, 100000),
      ], rules),
      100000,
    );
    expect(
      TaxService.deductibleExpenses([
        cost(ExpenseCategory.courseTravel, 120000),
        cost(ExpenseCategory.courseTravel, 60000),
        cost(ExpenseCategory.office, 1000),
      ], rules),
      150000 + 1000,
    );
  });

  test('zelfstandigenaftrek is capped at profit for non-starters', () {
    expect(calc(revenue: 50000).zelfstandigenaftrek, 50000);
    expect(calc(revenue: 50000, starter: true).zelfstandigenaftrek, 120000);
    expect(calc(revenue: 50000, starter: true).startersaftrek, 212300);
  });

  test('no ondernemersaftrek without the urencriterium', () {
    final r = calc(revenue: 5000000, uren: false);
    expect(r.zelfstandigenaftrek, 0);
    expect(r.mkbWinstvrijstelling, (5000000 * 0.127).round());
  });

  group('urencriterium counts the logged hours only (AGENTS.md rule 5)', () {
    test('this year, no zelfstandigenaftrek before 1.225 hours are logged', () {
      final r = calc(revenue: 5000000, hours: 600, yearOver: false);
      expect(r.zelfstandigenaftrek, 0);
      expect(
        calc(
          revenue: 5000000,
          hours: 1225,
          yearOver: false,
        ).zelfstandigenaftrek,
        120000,
      );
    });

    test('the startersaftrek bij arbeidsongeschiktheid waits for the year '
        'to end, as it needs the urencriterium not to be met (art. 3.78a)', () {
      TaxResult r(bool over) => calc(
        revenue: 2000000,
        starter: true,
        hours: 900,
        yearOver: over,
        inputs: inputs(disability: true),
      );
      expect(r(false).disabilityStartersaftrek, 0);
      expect(r(true).disabilityStartersaftrek, 1200000);
    });
  });

  group('tariefaanpassing (Wet IB 2001 art. 2.10 lid 2 and 3)', () {
    test('ondernemersaftrek and mkb-winstvrijstelling above the top bracket '
        'cost 11,94% back', () {
      // € 100.000 profit: all € 13.747,60 of deductions lie above € 78.426.
      final r = calc(revenue: 10000000);
      final deducted = r.zelfstandigenaftrek + r.mkbWinstvrijstelling;
      expect(deducted, 1374760);
      expect(r.tariefaanpassing, (1374760 * 0.1194).round());
    });

    test('only the part of the deductions above € 78.426 counts', () {
      // € 85.000 profit: taxable income plus deductions exceeds the top
      // bracket by € 6.574, less than the deductions.
      final r = calc(revenue: 8500000);
      expect(r.tariefaanpassing, (657400 * 0.1194).round());
    });

    test('the income tax export lists it before the heffingskortingen', () {
      final rows = CsvExportService.incomeTaxRows(calc(revenue: 10000000));
      final labels = [for (final r in rows) r.first];
      expect(
        labels.indexOf('Tariefaanpassing'),
        labels.indexOf('Belasting box 1 vóór heffingskortingen') + 1,
      );
      expect(
        rows.firstWhere((r) => r.first == 'Tariefaanpassing').last,
        (1374760 * 0.1194).round() / 100,
      );
    });

    test('the income tax export adds up from the profit to box 1 income, '
        'with the unrealised zelfstandigenaftrek (art. 3.76 lid 7)', () {
      final r = calc(
        revenue: 5000000,
        inputs: inputs(unrealised: 50000, employed: true, wages: 1000000),
      );
      expect(r.unrealisedZelfstandigenaftrek, 50000);
      final rows = CsvExportService.incomeTaxRows(r);
      final labels = [for (final row in rows) row.first as String];
      double at(String label) => rows[labels.indexOf(label)].last as double;
      final from = labels.indexOf('Winst uit onderneming');
      final to = labels.indexOf('Belastbaar inkomen box 1');
      var sum = 0.0;
      for (var k = from; k < to; k++) {
        if (labels[k] == 'Belastbare winst uit onderneming') continue;
        sum += rows[k].last as double;
      }
      expect(sum, closeTo(at('Belastbaar inkomen box 1'), 0.001));
    });

    test('nothing below the top bracket, and it raises box 1 tax', () {
      expect(calc(revenue: 5000000).tariefaanpassing, 0);
      final r = calc(revenue: 10000000);
      expect(
        r.box1Tax,
        r.grossBox1Tax +
            r.tariefaanpassing -
            r.algemeneHeffingskorting -
            r.arbeidskorting,
      );
    });
  });

  test('mkb-winstvrijstelling applies after ondernemersaftrek', () {
    final r = calc(revenue: 5000000);
    expect(r.mkbWinstvrijstelling, ((5000000 - 120000) * 0.127).round());
    expect(r.belastbareWinst, 5000000 - 120000 - r.mkbWinstvrijstelling);
  });

  test('Zvw is levied on belastbare winst, not reduced by lijfrente', () {
    final without = calc(revenue: 5000000);
    final with_ = calc(revenue: 5000000, lijfrente: 500000);
    expect(with_.zvwContribution, without.zvwContribution);
    expect(with_.taxableIncome, without.taxableIncome - 500000);
  });

  test('Zvw stops at the maximum bijdrage-inkomen', () {
    expect(
      calc(revenue: 50000000).zvwContribution,
      (rules.zvwMaxIncome * rules.zvwRate).round(),
    );
  });

  test('arbeidskorting uses profit before ondernemersaftrek and mkb '
      '(Belastingdienst, Arbeidsinkomen)', () {
    final r = calc(revenue: 5000000);
    expect(r.arbeidskorting, rules.arbeidskorting.valueFor(5000000));
  });

  test('AOV premiums reduce taxable income but not the Zvw base '
      '(Wet IB 2001 art. 3.124; Zvw art. 43)', () {
    final without = calc(revenue: 5000000);
    final with_ = calc(revenue: 5000000, aov: 300000);
    expect(with_.taxableIncome, without.taxableIncome - 300000);
    expect(with_.zvwContribution, without.zvwContribution);
  });

  test('a gain on a sold asset is part of the profit', () {
    expect(calc(revenue: 100000, disposalResult: 20000).profit, 120000);
  });

  test('heffingskortingen never make box 1 tax negative', () {
    expect(calc(revenue: 1000000).box1Tax, 0);
  });

  test('commuting counts as business kilometres '
      '(Belastingdienst, Zakelijk gebruik privévervoermiddel 2026)', () {
    MileageTrip trip(TripType type) => MileageTrip(
      id: 1,
      date: DateTime(2026, 5, 1),
      vehicleMakeModel: 'Car',
      vehicleLicensePlate: 'AB-123-C',
      departureAddress: 'A',
      arrivalAddress: 'B',
      odometerStart: 100,
      odometerEnd: 150,
      tripType: type,
      purpose: 'p',
      routeDeviation: false,
    );
    expect(
      TaxService.businessKm([
        trip(TripType.business),
        trip(TripType.commute),
        trip(TripType.private),
      ]),
      100,
    );
  });

  group('depreciation', () {
    FixedAsset asset({DateTime? disposal, int residual = 0, int? proceeds}) =>
        FixedAsset(
          id: 1,
          assetName: 'Laptop',
          costExclVat: 500000,
          purchaseVat: PurchaseVat.domestic,
          vatAmount: 0,
          vatReclaimable: true,
          vatToReclaim: 0,
          residualValue: residual,
          disposalProceeds: proceeds,
          purchaseDate: DateTime(2026, 7, 2),
          businessUsePct: 1,
          usefulLifeYears: 5,
          kiaEligible: false,
          disposalDate: disposal,
          kind: AssetKind.general,
          eiaEligible: false,
          reinvestmentReserveApplied: 0,
          reserveGain: false,
          zeroEmission: ZeroEmission.none,
          keepsTripLog: false,
        );

    test('is time-proportional in the year of purchase', () {
      // 5,000 × 183 of 1,826 days in service
      expect(AssetService.depreciation(asset(), 2026), 50110);
      // 5,000 × 365 of 1,826 days
      expect(AssetService.depreciation(asset(), 2027), 99945);
    });

    test('writes off exactly the cost over the useful life', () {
      final a = asset();
      final total = [
        for (var y = 2026; y <= 2032; y++) AssetService.depreciation(a, y),
      ].fold(0, (s, d) => s + d);
      expect(total, 500000);
      expect(AssetService.bookValue(a, 2031), 0);
    });

    test('stops at disposal', () {
      final a = asset(disposal: DateTime(2027, 12, 31));
      expect(AssetService.depreciation(a, 2027), 99945);
      expect(AssetService.depreciation(a, 2028), 0);
    });

    test('stops at the residual value (Fiscale informatie 2026, 7)', () {
      final a = asset(residual: 50000);
      final total = [
        for (var y = 2026; y <= 2032; y++) AssetService.depreciation(a, y),
      ].fold(0, (s, d) => s + d);
      expect(total, 450000);
      expect(AssetService.bookValue(a, 2032), 50000);
    });

    test('a sale yields proceeds minus book value in that year', () {
      final a = asset(disposal: DateTime(2027, 12, 31), proceeds: 400000);
      final book = AssetService.bookValue(a, 2027);
      expect(AssetService.disposalResult([a], 2027), 400000 - book);
      expect(AssetService.disposalResult([a], 2026), 0);
    });
  });
}
