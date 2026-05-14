import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppColors {
  // Core palette
  static const navy = Color(0xFF1C3F6E);
  static const teal = Color(0xFF007377);
  static const green = Color(0xFF2E7032);
  static const red = Color(0xFFC83928);

  // Semantic tokens
  static const income = Color(0xFF2E7032); // positive balance, revenue
  static const expense = Color(0xFFCC8339); // costs, deductions
  static const vat = Color(0xFFB45389); // BTW deadlines, warnings
  static const action = Color(0xFF007377); // buttons, links, active states

  // Surfaces — light
  static const bgLight = Color(0xFFF1F5F9);
  static const surfaceLight = Color(0xFFFFFFFF);

  // Surfaces — dark
  static const bgDark = Color(0xFF0F172A);
  static const surfaceDark = Color(0xFF1E293B);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.navy,
        primary: AppColors.navy,
        onPrimary: Colors.white,
        secondary: AppColors.teal,
        surface: AppColors.surfaceLight,
        brightness: Brightness.light,
      ).copyWith(error: AppColors.red),
    );
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bgLight,
      appBarTheme: const AppBarTheme(centerTitle: false),
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
        seedColor: AppColors.navy,
        primary: AppColors.teal,
        onPrimary: Colors.white,
        secondary: AppColors.navy,
        surface: AppColors.surfaceDark,
        brightness: Brightness.dark,
      ).copyWith(error: AppColors.red),
    );
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bgDark,
      appBarTheme: const AppBarTheme(centerTitle: false),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      cardTheme: const CardThemeData(elevation: 1, margin: EdgeInsets.zero),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
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
