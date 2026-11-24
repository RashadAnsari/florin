import 'package:florin/services/domain.dart';
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

  test('todayIn keeps new records inside the selected year', () {
    final now = DateTime.now();
    expect(todayIn(now.year - 1), DateTime(now.year - 1, 12, 31));
    expect(todayIn(now.year + 1), DateTime(now.year + 1));
    expect(todayIn(now.year), DateTime(now.year, now.month, now.day));
  });
}
