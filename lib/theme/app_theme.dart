import 'package:flutter/material.dart';

import 'app_spacing.dart';
import 'package:intl/intl.dart';

/// Semantic colours. Values follow Apple's system colours (Human Interface
/// Guidelines, Color, updated June 2025) in their increased-contrast form,
/// which is what keeps text at 4.5:1 or more on the surfaces they sit on.
/// The accent is the logo teal; its dark variant keeps the hue and raises
/// the lightness. Every pair is measured in `test/theme/contrast_test.dart`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  /// Money in, profit, done.
  final Color income;

  /// Money out, errors, overdue.
  final Color danger;

  /// Needs attention soon.
  final Color warning;

  /// BTW deadlines.
  final Color vat;

  /// Text of lesser importance.
  final Color secondaryLabel;

  /// Background of the sidebar.
  final Color sidebar;

  /// Thin lines between content.
  final Color separator;

  const AppColors({
    required this.income,
    required this.danger,
    required this.warning,
    required this.vat,
    required this.secondaryLabel,
    required this.sidebar,
    required this.separator,
  });

  static const light = AppColors(
    income: Color(0xFF008932),
    danger: Color(0xFFE9152D),
    warning: Color(0xFFC55300),
    vat: Color(0xFFB02FC2),
    secondaryLabel: Color(0xFF6C6C70),
    sidebar: Color(0xFFF2F2F7),
    separator: Color(0xFFD1D1D6),
  );

  static const dark = AppColors(
    income: Color(0xFF4AD968),
    danger: Color(0xFFFF6165),
    warning: Color(0xFFFFA056),
    vat: Color(0xFFEA8DFF),
    secondaryLabel: Color(0xFFAEAEB2),
    sidebar: Color(0xFF000000),
    separator: Color(0xFF3A3A3C),
  );

  static const highContrastLight = AppColors(
    income: Color(0xFF006E28),
    danger: Color(0xFFB80F24),
    warning: Color(0xFF9C4200),
    vat: Color(0xFF8A2599),
    secondaryLabel: Color(0xFF3A3A3C),
    sidebar: Color(0xFFE5E5EA),
    separator: Color(0xFF8E8E93),
  );

  static const highContrastDark = AppColors(
    income: Color(0xFF7BE891),
    danger: Color(0xFFFF8F92),
    warning: Color(0xFFFFBE8A),
    vat: Color(0xFFF2B6FF),
    secondaryLabel: Color(0xFFD1D1D6),
    sidebar: Color(0xFF000000),
    separator: Color(0xFF8E8E93),
  );

  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>()!;

  @override
  AppColors copyWith({
    Color? income,
    Color? danger,
    Color? warning,
    Color? vat,
    Color? secondaryLabel,
    Color? sidebar,
    Color? separator,
  }) => AppColors(
    income: income ?? this.income,
    danger: danger ?? this.danger,
    warning: warning ?? this.warning,
    vat: vat ?? this.vat,
    secondaryLabel: secondaryLabel ?? this.secondaryLabel,
    sidebar: sidebar ?? this.sidebar,
    separator: separator ?? this.separator,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      income: Color.lerp(income, other.income, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      vat: Color.lerp(vat, other.vat, t)!,
      secondaryLabel: Color.lerp(secondaryLabel, other.secondaryLabel, t)!,
      sidebar: Color.lerp(sidebar, other.sidebar, t)!,
      separator: Color.lerp(separator, other.separator, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get colors => AppColors.of(this);
}

/// Light and dark themes in the manner of macOS: the system font, white or
/// near-black content, a quiet sidebar, thin separators instead of shadows,
/// and the accent reserved for interactive elements and primary actions.
abstract final class AppTheme {
  static const _accentLight = Color(0xFF0E716F);
  static const _accentDark = Color(0xFF18C3C0);
  static const _accentHighContrastLight = Color(0xFF0A5654);
  static const _accentHighContrastDark = Color(0xFF5CEBE8);

  /// Corner radius of fields and buttons.
  static const controlRadius = 8.0;

  /// Corner radius of cards and panels.
  static const cardRadius = 12.0;

  static ThemeData get light => _build(
    brightness: Brightness.light,
    accent: _accentLight,
    onAccent: Colors.white,
    content: Colors.white,
    surface: Colors.white,
    label: Colors.black,
    outline: const Color(0xFF8E8E93),
    colors: AppColors.light,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    accent: _accentDark,
    onAccent: Colors.black,
    content: const Color(0xFF1C1C1E),
    surface: const Color(0xFF2C2C2E),
    label: Colors.white,
    outline: const Color(0xFF8E8E93),
    colors: AppColors.dark,
  );

  static ThemeData get highContrastLight => _build(
    brightness: Brightness.light,
    accent: _accentHighContrastLight,
    onAccent: Colors.white,
    content: Colors.white,
    surface: Colors.white,
    label: Colors.black,
    outline: const Color(0xFF3A3A3C),
    colors: AppColors.highContrastLight,
  );

  static ThemeData get highContrastDark => _build(
    brightness: Brightness.dark,
    accent: _accentHighContrastDark,
    onAccent: Colors.black,
    content: Colors.black,
    surface: const Color(0xFF1C1C1E),
    label: Colors.white,
    outline: const Color(0xFFD1D1D6),
    colors: AppColors.highContrastDark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color accent,
    required Color onAccent,
    required Color content,
    required Color surface,
    required Color label,
    required Color outline,
    required AppColors colors,
  }) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: accent,
          brightness: brightness,
        ).copyWith(
          primary: accent,
          onPrimary: onAccent,
          primaryContainer: accent,
          onPrimaryContainer: onAccent,
          secondary: accent,
          onSecondary: onAccent,
          error: colors.danger,
          surface: surface,
          onSurface: label,
          onSurfaceVariant: colors.secondaryLabel,
          surfaceContainerHighest: colors.sidebar,
          outline: outline,
          outlineVariant: colors.separator,
        );
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      // No fontFamily: the platform's own font, San Francisco on macOS and
      // Segoe UI on Windows. Nothing is downloaded.
    );
    // ThemeData's text theme has no sizes until MaterialApp localizes it, so
    // styles set here take theirs from the same geometry.
    final sizes = Typography.englishLike2021;
    final controlShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(controlRadius),
    );
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(controlRadius),
      borderSide: BorderSide(color: c, width: w),
    );
    return base.copyWith(
      scaffoldBackgroundColor: content,
      canvasColor: content,
      extensions: [colors],
      textTheme: _tracked(base.textTheme),
      dividerTheme: DividerThemeData(color: colors.separator, space: 1),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: content,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleSpacing: AppSpacing.section,
        titleTextStyle: sizes.titleMedium?.copyWith(
          color: label,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: BorderSide(color: colors.separator),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        // Errors and helper text wrap instead of being cut off.
        errorMaxLines: 6,
        helperMaxLines: 6,
        border: border(outline),
        enabledBorder: border(outline),
        focusedBorder: border(accent, 2),
        errorBorder: border(colors.danger),
        focusedErrorBorder: border(colors.danger, 2),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(shape: controlShape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: controlShape,
          side: BorderSide(color: outline),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: controlShape),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: StadiumBorder(side: BorderSide(color: colors.separator)),
      ),
      // One style for every list row: the name, its details, and a figure
      // in tabular digits so amounts line up.
      listTileTheme: ListTileThemeData(
        shape: controlShape,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.section,
        ),
        iconColor: colors.secondaryLabel,
        titleTextStyle: sizes.bodyLarge?.copyWith(
          color: label,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: sizes.bodyMedium?.copyWith(
          color: colors.secondaryLabel,
        ),
        leadingAndTrailingTextStyle: sizes.bodyMedium?.copyWith(
          color: label,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 400),
        constraints: const BoxConstraints(maxWidth: 360),
        textStyle: base.textTheme.bodySmall?.copyWith(
          color: brightness == Brightness.light ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  /// Size-specific tracking: large text tighter, small text slightly looser.
  static TextTheme _tracked(TextTheme t) => t.copyWith(
    displayLarge: t.displayLarge?.copyWith(letterSpacing: -0.8),
    displayMedium: t.displayMedium?.copyWith(letterSpacing: -0.6),
    headlineLarge: t.headlineLarge?.copyWith(letterSpacing: -0.5),
    headlineMedium: t.headlineMedium?.copyWith(
      letterSpacing: -0.4,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: t.headlineSmall?.copyWith(
      letterSpacing: -0.3,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: t.titleLarge?.copyWith(
      letterSpacing: -0.3,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: t.titleMedium?.copyWith(
      letterSpacing: -0.2,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
    bodySmall: t.bodySmall?.copyWith(letterSpacing: 0.1),
    labelSmall: t.labelSmall?.copyWith(letterSpacing: 0.2),
  );
}

abstract final class AppFormat {
  static final _currency = NumberFormat.currency(locale: 'nl_NL', symbol: '€');
  static final _date = DateFormat('dd-MM-yyyy', 'nl_NL');
  static final _decimal = NumberFormat.decimalPattern('nl_NL');

  static String cents(int cents) => _currency.format(cents / 100);

  static String date(DateTime d) => _date.format(d);

  /// A quantity such as 1 or 1,5 without trailing zeros.
  static String number(double n) => _decimal.format(n);

  /// A rate as a percentage without the sign, e.g. 0.3575 as `35,75`. Copy
  /// adds the `%`.
  static String percent(double rate, [int digits = 2]) =>
      (rate * 100).toStringAsFixed(digits).replaceAll('.', ',');

  /// A file size such as `840 kB` or `1,2 MB`.
  static String fileSize(int bytes) {
    if (bytes < 1000 * 1000) {
      return '${(bytes / 1000).ceil()} kB';
    }
    return '${(bytes / 1000 / 1000).toStringAsFixed(1).replaceAll('.', ',')} MB';
  }

  /// Hours with one decimal, e.g. `7,5`.
  static String hours(double h) => h.toStringAsFixed(1).replaceAll('.', ',');

  /// Cents as an editable amount, e.g. `1234,50`.
  static String centsInput(int cents) =>
      (cents / 100).toStringAsFixed(2).replaceAll('.', ',');

  // `1.234,50`, `1234,5`, `-12` or `12.50`: dots group thousands in threes,
  // except one dot followed by one or two digits, which is read as decimals.
  static final _dutchAmount = RegExp(r'^-?(\d{1,3}(\.\d{3})+|\d+)(,\d{1,2})?$');
  static final _dotDecimal = RegExp(r'^-?\d+\.\d{1,2}$');

  /// Parses an amount such as `€ 1.234,50` to cents. Returns null for text
  /// that is not an amount, including more than two decimals, so `12.5`
  /// and `12,50` both mean twelve and a half and `1.2345` is rejected.
  static int? parseCents(String text) {
    final s = text.replaceAll('€', '').replaceAll(RegExp(r'\s'), '');
    final String normalized;
    if (_dotDecimal.hasMatch(s)) {
      normalized = s;
    } else if (_dutchAmount.hasMatch(s)) {
      normalized = s.replaceAll('.', '').replaceAll(',', '.');
    } else {
      return null;
    }
    final v = double.tryParse(normalized);
    return v == null ? null : (v * 100).round();
  }
}
