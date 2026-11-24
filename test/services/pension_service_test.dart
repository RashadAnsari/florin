import 'package:florin/db/database.dart';
import 'package:florin/services/pension_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final rules = taxRulesFor(2026)!;

  PensionEntry entry({int income = 0, int factorA = 0}) => PensionEntry(
    year: 2026,
    priorYearIncome: income,
    factorA: factorA,
    reserveringsruimte: 0,
    plannedContribution: 0,
    aovInsured: false,
    monthlyAovPremium: 0,
  );

  group('jaarruimte (Wet IB 2001 art. 3.127)', () {
    test('30% of the income above the franchise, less 6,27 x factor A', () {
      final r = PensionService.calculate(
        rules,
        entry(income: 5000000, factorA: 100000),
      );
      expect(r.premiegrondslag, 5000000 - 1917200);
      expect(r.jaarruimte, ((5000000 - 1917200) * 0.30 - 627000).round());
    });

    test('income counts up to € 137.800 before the franchise is subtracted '
        '(lid 3)', () {
      final r = PensionService.calculate(rules, entry(income: 20000000));
      expect(r.premiegrondslag, 13780000 - 1917200);
      expect(r.jaarruimte, ((13780000 - 1917200) * 0.30).round());
      expect(r.jaarruimte, rules.jaarruimteMax);
    });

    test('nothing below the franchise', () {
      final r = PensionService.calculate(rules, entry(income: 1500000));
      expect(r.premiegrondslag, 0);
      expect(r.jaarruimte, 0);
    });
  });
}
