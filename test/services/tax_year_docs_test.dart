import 'dart:convert';
import 'dart:io';

import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:flutter_test/flutter_test.dart';

/// The fields of `TaxYearRules`, read from its source.
List<String> _ruleFields() {
  final source = File(
    'lib/services/tax_rules/tax_year_rules.dart',
  ).readAsStringSync();
  final start = source.indexOf('class TaxYearRules {');
  final end = source.indexOf('const TaxYearRules({', start);
  return RegExp(
    r'final [^;]*?\s(\w+);',
  ).allMatches(source.substring(start, end)).map((m) => m.group(1)!).toList();
}

void main() {
  final fields = _ruleFields();

  test('the rules have fields to check', () {
    expect(fields, contains('korThreshold'));
    expect(fields, contains('vatRates'));
  });

  test('docs/tax-years/README.md explains every field of the rules', () {
    final readme = File('docs/tax-years/README.md').readAsStringSync();
    final missing = [
      for (final f in fields)
        if (!readme.contains('`$f`')) f,
    ];
    expect(missing, isEmpty, reason: 'Explain these in the README');
  });

  test('every year sources every field of its rules', () {
    for (final year in taxYears.keys) {
      final doc = File('docs/tax-years/$year.md').readAsStringSync();
      final missing = [
        for (final f in fields)
          if (!doc.contains('`$f`')) f,
      ];
      expect(missing, isEmpty, reason: 'Source these in $year.md');
    }
  });

  test('texts take amounts and rates from the rules, not from the text', () {
    // A euro amount or a percentage in a text would stay the same when a
    // year's rules change; 0% is the nil rate by definition.
    final figure = RegExp(r'€\s?\d|(?<![\d,])(?!0%)\d+(,\d+)?%');
    for (final path in ['lib/l10n/app_en.arb', 'lib/l10n/app_nl.arb']) {
      final arb = jsonDecode(File(path).readAsStringSync()) as Map;
      final fixed = [
        for (final MapEntry(:key, :value) in arb.entries)
          if (!(key as String).startsWith('@') &&
              value is String &&
              figure.hasMatch(value))
            key,
      ];
      expect(fixed, isEmpty, reason: 'Use a placeholder in $path');
    }
  });
}
