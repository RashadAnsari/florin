import 'package:intl/intl.dart';

abstract final class AppFormat {
  static final _currency = NumberFormat.currency(locale: 'nl_NL', symbol: '€');
  static final _wholeEuros = NumberFormat.currency(
    locale: 'nl_NL',
    symbol: '€',
    decimalDigits: 0,
  );
  static final _date = DateFormat('dd-MM-yyyy', 'nl_NL');
  static final _decimal = NumberFormat.decimalPattern('nl_NL');

  static String cents(int cents) => _currency.format(cents / 100);

  /// An amount in whole euros, as a rule in a sentence reads it: `€ 3.630`.
  static String euros(int cents) => _wholeEuros.format(cents / 100);

  static String date(DateTime d) => _date.format(d);

  /// A quantity such as 1 or 1,5 without trailing zeros.
  static String number(double n) => _decimal.format(n);

  /// A rate as a percentage without the sign, e.g. 0.3575 as `35,75`. Copy
  /// adds the `%`.
  static String percent(double rate, [int digits = 2]) =>
      (rate * 100).toStringAsFixed(digits).replaceAll('.', ',');

  /// A rate as text reads it, with no trailing zeros: `21%`, `2,7%`,
  /// `11,94%`.
  static String percentLabel(double rate) {
    final text = (rate * 100)
        .toStringAsFixed(2)
        .replaceAll(RegExp(r'\.?0+$'), '');
    return '${text.replaceAll('.', ',')}%';
  }

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
