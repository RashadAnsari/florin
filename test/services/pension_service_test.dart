import 'package:flutter_test/flutter_test.dart';
import 'package:florin/services/pension_service.dart';
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
  const service = PensionService();
  final params = _params();

  group('PensionService.calculate', () {
    test('negative grondslag yields zero jaarruimte', () {
      final r = service.calculate(
        params: params,
        taxableProfit: params.aowFranchise - 1, // below franchise
        factorA: 0,
        unusedPriorYears: 0,
        marginalRate: 0.3575,
      );
      expect(r.jaarruimte, 0);
      expect(r.totalBudget, 0);
      expect(r.estimatedTaxSaving, 0);
    });

    test('jaarruimte computed as 30% × grondslag − 6.27 × factorA', () {
      const taxableProfit = 5000000; // €50k
      const factorA = 0.0;
      final grondslag = taxableProfit - params.aowFranchise;
      final expected = (grondslag * params.jaarruimtePct).round();

      final r = service.calculate(
        params: params,
        taxableProfit: taxableProfit,
        factorA: factorA,
        unusedPriorYears: 0,
        marginalRate: 0.3575,
      );
      expect(r.jaarruimte, expected);
    });

    test('jaarruimte capped at jaarruimteMax', () {
      final r = service.calculate(
        params: params,
        taxableProfit: 200000000, // €2M — huge
        factorA: 0,
        unusedPriorYears: 0,
        marginalRate: 0.495,
      );
      expect(r.jaarruimteCapped, params.jaarruimteMax);
    });

    test('reserveringsruimte capped at reserveringsruimteMax', () {
      final r = service.calculate(
        params: params,
        taxableProfit: 5000000,
        factorA: 0,
        unusedPriorYears: params.reserveringsruimteMax + 9999999,
        marginalRate: 0.3575,
      );
      expect(r.reserveringsruimte, params.reserveringsruimteMax);
    });

    test('totalBudget = jaarruimteCapped + reserveringsruimte', () {
      final r = service.calculate(
        params: params,
        taxableProfit: 5000000,
        factorA: 0,
        unusedPriorYears: 500000,
        marginalRate: 0.3575,
      );
      expect(r.totalBudget, r.jaarruimteCapped + r.reserveringsruimte);
    });

    test('tax saving = totalBudget × marginalRate', () {
      const rate = 0.3575;
      final r = service.calculate(
        params: params,
        taxableProfit: 5000000,
        factorA: 0,
        unusedPriorYears: 0,
        marginalRate: rate,
      );
      expect(r.estimatedTaxSaving, (r.totalBudget * rate).round());
    });

    test('factorA reduces jaarruimte', () {
      final withoutA = service.calculate(
        params: params,
        taxableProfit: 5000000,
        factorA: 0,
        unusedPriorYears: 0,
        marginalRate: 0.3575,
      );
      final withA = service.calculate(
        params: params,
        taxableProfit: 5000000,
        factorA: 1000.0, // €1000 factor A
        unusedPriorYears: 0,
        marginalRate: 0.3575,
      );
      expect(withA.jaarruimte, lessThan(withoutA.jaarruimte));
    });
  });
}
