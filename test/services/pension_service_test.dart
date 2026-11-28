import 'package:florin/db/database.dart';
import 'package:florin/services/pension_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final rules = taxRulesFor(2026)!;

  PensionEntry entry({
    int income = 0,
    int factorA = 0,
    int? premiums,
    int reservering = 0,
    int planned = 0,
    bool aov = false,
    int monthlyAov = 0,
  }) => PensionEntry(
    year: 2026,
    priorYearIncome: income,
    factorA: factorA,
    pensionPremiumsPriorYear: premiums,
    reserveringsruimte: reservering,
    plannedContribution: planned,
    aovInsured: aov,
    monthlyAovPremium: monthlyAov,
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

    test('Wtp premiums lower the jaarruimte 1:1 (art. 3.127 lid 4)', () {
      final r = PensionService.calculate(
        rules,
        entry(income: 5000000, premiums: 300000),
      );
      expect(r.jaarruimte, ((5000000 - 1917200) * 0.30 - 300000).round());
    });

    test('factor A cannot make the jaarruimte negative (art. 3.127 lid 1)', () {
      final r = PensionService.calculate(
        rules,
        entry(income: 3000000, factorA: 1000000, premiums: 500000),
      );
      expect(r.jaarruimte, 0);
    });

    test('reserveringsruimte is at most € 42.753 (art. 3.127 lid 2)', () {
      final r = PensionService.calculate(rules, entry(reservering: 5000000));
      expect(r.reserveringsruimte, 4275300);
    });

    test('deductible premium is at most jaarruimte plus reserveringsruimte '
        '(art. 3.127 lid 1 and 2)', () {
      final e = entry(income: 5000000, reservering: 100000, planned: 9999999);
      final room = PensionService.calculate(rules, e).totalRoom;
      expect(room, ((5000000 - 1917200) * 0.30).round() + 100000);
      expect(PensionService.deductiblePremium(rules, e), room);
      expect(
        PensionService.deductiblePremium(
          rules,
          entry(income: 5000000, planned: 1000),
        ),
        1000,
      );
    });
  });

  test('AOV premiums count for the months paid so far '
      '(Wet IB 2001 art. 3.147)', () {
    final e = entry(aov: true, monthlyAov: 18000);
    expect(PensionService.aovPremiumPaid(e, 12), 18000 * 12);
    expect(PensionService.aovPremiumPaid(e, 10), 18000 * 10);
    expect(PensionService.aovPremiumPaid(entry(monthlyAov: 18000), 12), 0);
    expect(PensionService.aovPremiumPaid(null, 12), 0);
    // Only months that have ended: the day of payment is not recorded.
    expect(PensionService.aovMonthsPaid(2026, DateTime(2026, 11, 28)), 10);
    expect(PensionService.aovMonthsPaid(2026, DateTime(2027, 1, 2)), 12);
    expect(PensionService.aovMonthsPaid(2026, DateTime(2025, 12, 31)), 0);
  });
}
