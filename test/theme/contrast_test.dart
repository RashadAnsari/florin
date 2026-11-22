import 'package:florin/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// WCAG 2.2 contrast ratio.
double contrast(Color a, Color b) {
  final la = a.computeLuminance(), lb = b.computeLuminance();
  final hi = la > lb ? la : lb, lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

void main() {
  final themes = {
    'light': AppTheme.light,
    'dark': AppTheme.dark,
    'high contrast light': AppTheme.highContrastLight,
    'high contrast dark': AppTheme.highContrastDark,
  };

  for (final MapEntry(key: name, value: theme) in themes.entries) {
    group(name, () {
      final s = theme.colorScheme;
      final c = theme.extension<AppColors>()!;
      final backgrounds = {
        'content': theme.scaffoldBackgroundColor,
        'surface': s.surface,
        'sidebar': c.sidebar,
      };

      // Text: at least 4.5:1 (WCAG 1.4.3).
      for (final MapEntry(key: bg, value: background) in backgrounds.entries) {
        final texts = {
          'label': s.onSurface,
          'secondary label': c.secondaryLabel,
          'accent': s.primary,
          'income': c.income,
          'danger': c.danger,
          'warning': c.warning,
          'vat': c.vat,
        };
        for (final MapEntry(key: t, value: color) in texts.entries) {
          // Light sidebar text is only labels and the accent.
          if (bg == 'sidebar' &&
              !['label', 'secondary label', 'accent'].contains(t)) {
            continue;
          }
          test('$t on $bg', () {
            expect(contrast(color, background), greaterThanOrEqualTo(4.5));
          });
        }
      }

      test('text on the accent', () {
        expect(contrast(s.onPrimary, s.primary), greaterThanOrEqualTo(4.5));
      });

      // Field borders: at least 3:1 (WCAG 1.4.11).
      test('field border on surface', () {
        expect(contrast(s.outline, s.surface), greaterThanOrEqualTo(3));
      });
    });
  }
}
