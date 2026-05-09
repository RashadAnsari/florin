import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppTheme {
  static const _primary = Color(0xFF1A5276);
  static const _primaryDark = Color(0xFF0D2137);
  static const _accent = Color(0xFFF39C12);
  static const _background = Color(0xFFF8F9FA);

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primary,
        primary: _primary,
        secondary: _accent,
        surface: _background,
        brightness: Brightness.light,
      ),
    );
    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      cardTheme: const CardThemeData(elevation: 1, margin: EdgeInsets.zero),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryDark,
        primary: _primaryDark,
        secondary: _accent,
        brightness: Brightness.dark,
      ),
    );
    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      cardTheme: const CardThemeData(elevation: 1, margin: EdgeInsets.zero),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  static TextStyle get wordmark => GoogleFonts.sourceSerif4(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
}

class AppFormat {
  static final _currency = NumberFormat.currency(locale: 'nl_NL', symbol: '€');
  static final _date = DateFormat('dd-MM-yyyy', 'nl_NL');

  static String cents(int cents) => _currency.format(cents / 100);

  static String date(DateTime d) => _date.format(d);

  static String quarter(DateTime d) {
    final q = ((d.month - 1) ~/ 3) + 1;
    return 'Q$q';
  }

  static int currentFiscalYear() => DateTime.now().year;
}
