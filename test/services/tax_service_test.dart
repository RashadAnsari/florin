import 'package:flutter_test/flutter_test.dart';
import 'package:florin/services/tax_service.dart';
import 'package:florin/db/database.dart';

TaxParam _params() => const TaxParam(
      year: 2026,
      zelfstandigenaftrek: -120000,
      startersaftrek: -212300,
      mkbWinstvrijstellingPct: 0.127,
      bracket1Rate: 0.3575,
      bracket1Threshold: 3888300,
      bracket2Rate: 0.3756,
      bracket2Threshold: 7842600,
      bracket3Rate: 0.495,
      algHeffingskortingMax: 311500,
      arbeidskortingMax: 568500,
      zvwRate: 0.0485,
      zvwMax: 385100,
      mixedCostsThreshold: 570000,
      mixedCosts80Pct: 0.8,
      jaarruimtePct: 0.30,
      jaarruimteMax: 3558900,
      aowFranchise: 1917200,
      reserveringsruimteMax: 4275300,
      factorAMultiplier: 6.27,
      kiaLowerThreshold: 290100,
      kiaUpperThreshold: 7168300,
      kiaFlatThreshold: 13274600,
      kiaRate: 0.28,
      kiaFlatAmount: 2007200,
      mileageRatePerKm: 0.23,
      korThreshold: 2000000,
      ossThreshold: 1000000,
      belastingrentePct: 0.05,
    );

void main() {
  const service = TaxService();
  final params = _params();

  group('TaxService.calculate', () {
    test('zero revenue yields zero tax', () {
      final r = service.calculate(
        params: params,
        grossRevenue: 0,
        creditNotes: 0,
        totalDeductibleExpenses: 0,
        totalDepreciation: 0,
        carMileageAllowance: 0,
        kiaDeduction: 0,
        claimZelfstandigenaftrek: false,
        claimStartersaftrek: false,
        wbsoDeduction: 0,
        algHeffingskorting: 0,
        arbeidskorting: 0,
        lijrenteDeduction: 0,
      );
      expect(r.totalTax, 0);
      expect(r.netProfitAfterTax, 0);
    });

    test('gross profit flows through correctly', () {
      final r = service.calculate(
        params: params,
        grossRevenue: 10000000, // €100,000
        creditNotes: 0,
        totalDeductibleExpenses: 2000000, // €20,000
        totalDepreciation: 0,
        carMileageAllowance: 0,
        kiaDeduction: 0,
        claimZelfstandigenaftrek: false,
        claimStartersaftrek: false,
        wbsoDeduction: 0,
        algHeffingskorting: 0,
        arbeidskorting: 0,
        lijrenteDeduction: 0,
      );
      expect(r.grossRevenue, 10000000);
      expect(r.totalExpenses, 2000000);
      expect(r.grossProfit, 8000000);
    });

    test('zelfstandigenaftrek reduces taxable profit', () {
      final withZelfs = service.calculate(
        params: params,
        grossRevenue: 6000000,
        creditNotes: 0,
        totalDeductibleExpenses: 0,
        totalDepreciation: 0,
        carMileageAllowance: 0,
        kiaDeduction: 0,
        claimZelfstandigenaftrek: true,
        claimStartersaftrek: false,
        wbsoDeduction: 0,
        algHeffingskorting: 0,
        arbeidskorting: 0,
        lijrenteDeduction: 0,
      );
      final withoutZelfs = service.calculate(
        params: params,
        grossRevenue: 6000000,
        creditNotes: 0,
        totalDeductibleExpenses: 0,
        totalDepreciation: 0,
        carMileageAllowance: 0,
        kiaDeduction: 0,
        claimZelfstandigenaftrek: false,
        claimStartersaftrek: false,
        wbsoDeduction: 0,
        algHeffingskorting: 0,
        arbeidskorting: 0,
        lijrenteDeduction: 0,
      );
      expect(withZelfs.taxableProfit, lessThan(withoutZelfs.taxableProfit));
    });

    test('kortingen capped at zero (no negative tax)', () {
      final r = service.calculate(
        params: params,
        grossRevenue: 100000, // €1,000 — very low income
        creditNotes: 0,
        totalDeductibleExpenses: 0,
        totalDepreciation: 0,
        carMileageAllowance: 0,
        kiaDeduction: 0,
        claimZelfstandigenaftrek: false,
        claimStartersaftrek: false,
        wbsoDeduction: 0,
        algHeffingskorting: params.algHeffingskortingMax,
        arbeidskorting: params.arbeidskortingMax,
        lijrenteDeduction: 0,
      );
      expect(r.box1Tax, greaterThanOrEqualTo(0));
    });

    test('bracket3 kicks in above second threshold', () {
      final r = service.calculate(
        params: params,
        grossRevenue: 100000000, // €1M
        creditNotes: 0,
        totalDeductibleExpenses: 0,
        totalDepreciation: 0,
        carMileageAllowance: 0,
        kiaDeduction: 0,
        claimZelfstandigenaftrek: false,
        claimStartersaftrek: false,
        wbsoDeduction: 0,
        algHeffingskorting: 0,
        arbeidskorting: 0,
        lijrenteDeduction: 0,
      );
      expect(r.bracket3Tax, greaterThan(0));
    });
  });

  group('TaxService.computeKia', () {
    test('below lower threshold: 0', () {
      expect(service.computeKia(params, 0), 0);
      expect(service.computeKia(params, params.kiaLowerThreshold - 1), 0);
    });

    test('in 28% band', () {
      final kia = service.computeKia(params, 1000000); // €10k
      expect(kia, (1000000 * 0.28).round());
    });

    test('in flat band', () {
      final midpoint = (params.kiaUpperThreshold + params.kiaFlatThreshold) ~/ 2;
      expect(service.computeKia(params, midpoint), params.kiaFlatAmount);
    });

    test('above flat threshold: degressive, non-negative', () {
      final kia = service.computeKia(
          params, params.kiaFlatThreshold + 5000000);
      expect(kia, greaterThanOrEqualTo(0));
      expect(kia, lessThan(params.kiaFlatAmount));
    });
  });

  group('TaxService.computeBookValue', () {
    test('full depreciation: book value 0', () {
      final bv = service.computeBookValue(
        costExclVat: 500000,
        usefulLifeYears: 5,
        businessUsePct: 1.0,
        yearsElapsed: 5,
      );
      expect(bv, 0);
    });

    test('partial depreciation', () {
      final bv = service.computeBookValue(
        costExclVat: 500000,
        usefulLifeYears: 5,
        businessUsePct: 1.0,
        yearsElapsed: 2,
      );
      // annual = 100000; 2 years = 200000 depreciated
      expect(bv, 300000);
    });
  });
}
