import '../services/formats.dart';

/// Inline form validators. Each returns the caller's message when the value
/// fails, or null. The messages are the field's own ARB keys, which say what
/// to enter and why.
abstract final class Validate {
  /// Required text: anything but blank.
  static String? required(String? value, String message) =>
      (value ?? '').trim().isEmpty ? message : null;

  /// Required text that must also pass [valid].
  static String? requiredFormat(
    String? value, {
    required String empty,
    required bool Function(String) valid,
    required String invalid,
  }) {
    final s = (value ?? '').trim();
    if (s.isEmpty) return empty;
    return valid(s) ? null : invalid;
  }

  /// Optional text: blank is fine, anything else must pass [valid].
  static String? optional(
    String? value,
    bool Function(String) valid,
    String message,
  ) {
    final s = (value ?? '').trim();
    return s.isEmpty || valid(s) ? null : message;
  }

  /// A whole number from [min] up to [max].
  static String? wholeNumber(
    String? value,
    String message, {
    int min = 0,
    int? max,
  }) {
    final n = parseWholeNumber(value ?? '');
    if (n == null || n < min || (max != null && n > max)) return message;
    return null;
  }

  /// A decimal number above [above] and up to [max].
  static String? decimal(
    String? value,
    String message, {
    double above = 0,
    double? max,
  }) {
    final n = parseDecimal(value ?? '');
    if (n == null || n <= above || (max != null && n > max)) return message;
    return null;
  }
}
