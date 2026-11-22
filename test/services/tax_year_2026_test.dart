import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:flutter_test/flutter_test.dart';

// Expected values are worked by hand from the tables in docs/tax-years/2026.md.
void main() {
  final rules = taxRulesFor(2026)!;

  test('years without verified rules are not filled in', () {
    expect(taxRulesFor(2025), isNull);
    expect(taxRulesFor(2027), isNull);
  });

  test('box 1 brackets', () {
    // 38,883 × 35.75% + 11,117 × 37.56%
    expect(rules.box1TaxPerBracket(5000000), [1390067, 417555, 0]);
    // above schijf 2: 1,000 × 49.50%
    expect(rules.box1TaxPerBracket(7942600).last, 49500);
    expect(rules.box1Tax(0), 0);
  });

  test('algemene heffingskorting', () {
    expect(rules.algemeneHeffingskorting.valueFor(2000000), 311500);
    // 3,115 − 6.398% × (50,000 − 29,736)
    expect(rules.algemeneHeffingskorting.valueFor(5000000), 181851);
    expect(rules.algemeneHeffingskorting.valueFor(7842700), 0);
  });

  test('arbeidskorting', () {
    expect(rules.arbeidskorting.valueFor(1196500), 99597);
    // 5,300 + 1.950% × (30,000 − 25,845)
    expect(rules.arbeidskorting.valueFor(3000000), 538102);
    // Wet IB 2001 art. 8.11 lid 2: a capped at € 996, a+b at € 5.300,
    // a+b+c at € 5.685.
    expect(rules.arbeidskorting.valueFor(4559200), 568500);
    expect(rules.arbeidskorting.valueFor(2584500), 530000);
    expect(rules.arbeidskorting.valueFor(13292000), 0);
    expect(rules.arbeidskorting.valueFor(20000000), 0);
  });

  test('kleinschaligheidsinvesteringsaftrek', () {
    expect(rules.kia.valueFor(290000), 0);
    expect(rules.kia.valueFor(1000000), 280000);
    expect(rules.kia.valueFor(10000000), 2007200);
    // 20,072 − 7.56% × (200,000 − 132,746)
    expect(rules.kia.valueFor(20000000), 1498760);
    expect(rules.kia.valueFor(39823700), 0);
  });

  test('only verified years are selectable', () {
    expect(supportedYears, [2026]);
    expect(nearestSupportedYear(2030), 2026);
    expect(nearestSupportedYear(2020), 2026);
  });
}
