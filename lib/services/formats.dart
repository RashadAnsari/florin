/// Format checks and parsers for what users type. Every form uses these;
/// screens never hold their own pattern or parser.
library;

final _dutchVat = RegExp(r'^NL\d{9}B\d{2}$');
final _vatId = RegExp(r'^[A-Z]{2}[A-Z0-9]{2,13}$');
final _kvk = RegExp(r'^\d{8}$');
final _iban = RegExp(r'^[A-Z]{2}\d{2}[A-Z0-9]{11,30}$');
final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
final _phone = RegExp(r'^[+\d][\d\s\-().]{4,}$');
final _country = RegExp(r'^[A-Z]{2}$');

/// An identifier without spaces, in capitals: BTW numbers, IBANs, codes.
String normalizeId(String value) => value.replaceAll(' ', '').toUpperCase();

/// Dutch btw-identificatienummer: NL, 9 digits, B, 2 digits.
bool isValidDutchVatNumber(String value) =>
    _dutchVat.hasMatch(normalizeId(value));

/// Any EU-style VAT number: a two-letter prefix and 2 to 13 characters.
bool isValidVatId(String value) => _vatId.hasMatch(normalizeId(value));

bool isValidKvkNumber(String value) => _kvk.hasMatch(normalizeId(value));

/// IBAN structure plus the ISO 13616 mod-97 check.
bool isValidIban(String value) {
  final iban = normalizeId(value);
  if (!_iban.hasMatch(iban)) return false;
  final rearranged = iban.substring(4) + iban.substring(0, 4);
  var remainder = 0;
  for (final c in rearranged.codeUnits) {
    final digits = c >= 65 ? '${c - 55}' : String.fromCharCode(c);
    for (final d in digits.codeUnits) {
      remainder = (remainder * 10 + d - 48) % 97;
    }
  }
  return remainder == 1;
}

bool isValidEmail(String value) => _email.hasMatch(value.trim());

bool isValidPhone(String value) => _phone.hasMatch(value.trim());

/// A two-letter country code such as NL or DE.
bool isValidCountryCode(String value) => _country.hasMatch(value.trim());

/// A whole number such as 14, or null.
int? parseWholeNumber(String text) => int.tryParse(text.trim());

/// A number with a comma or a dot as decimal separator, such as 1,5.
double? parseDecimal(String text) =>
    double.tryParse(text.trim().replaceAll(',', '.'));

/// Optional text as stored: trimmed, or null when blank.
String? optionalText(String text) {
  final s = text.trim();
  return s.isEmpty ? null : s;
}
