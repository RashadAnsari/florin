import 'package:florin/db/database.dart';
import 'package:florin/services/asset_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:florin/services/tax_service.dart';
import 'package:flutter_test/flutter_test.dart';

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
    double hours = 0,
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
    totalHours: hours,
    soHours: soHours,
    assumeUrencriterium: uren,
    isStarter: starter,
    inputs: inputs,
    lijfrentePremium: lijfrente,
    aovPremium: aov,
  );

  TaxYearInput inputs({
    int partnerHours = 0,
    bool so = false,
    bool soStarter = false,
    bool ceased = false,
    int stakingsUsed = 0,
    bool disability = false,
    int disabilityUsed = 0,
    int unrealised = 0,
    int losses = 0,
  }) => TaxYearInput(
    year: 2026,
    partnerHours: partnerHours,
    hasSoVerklaring: so,
    soStarter: soStarter,
    businessCeased: ceased,
    stakingsaftrekUsedBefore: stakingsUsed,
    disabilityBenefit: disability,
    disabilityStartersUsed: disabilityUsed,
    unrealisedZelfstandigenaftrek: unrealised,
    lossCarryForward: losses,
  );

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
          vatDeductedOnPurchase: 0,
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
