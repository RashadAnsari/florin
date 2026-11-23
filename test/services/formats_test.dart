import 'package:florin/services/formats.dart';
import 'package:florin/theme/app_theme.dart';
import 'package:florin/widgets/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('IBAN check digits are verified', () {
    expect(isValidIban('NL91 ABNA 0417 1643 00'), isTrue);
    expect(isValidIban('NL92ABNA0417164300'), isFalse);
  });

  test('identifiers are checked after removing spaces and case', () {
    expect(isValidDutchVatNumber('nl 000099998 b57'), isTrue);
    expect(isValidDutchVatNumber('NL00009999B57'), isFalse);
    expect(isValidVatId('DE999999999'), isTrue);
    expect(isValidVatId('9E999'), isFalse);
    expect(isValidKvkNumber('1234 5678'), isTrue);
    expect(isValidCountryCode('NL'), isTrue);
    expect(isValidCountryCode('NLD'), isFalse);
    expect(normalizeId(' nl91 abna '), 'NL91ABNA');
  });

  test('amounts accept Dutch notation and reject anything ambiguous', () {
    expect(AppFormat.parseCents('€ 1.234,50'), 123450);
    expect(AppFormat.parseCents('1234,5'), 123450);
    expect(AppFormat.parseCents('12,50'), 1250);
    // One dot with one or two digits is a decimal point, not thousands.
    expect(AppFormat.parseCents('12.50'), 1250);
    expect(AppFormat.parseCents('1.234'), 123400);
    expect(AppFormat.parseCents('-12'), -1200);
    expect(AppFormat.parseCents('12,505'), isNull);
    expect(AppFormat.parseCents('1.23.4'), isNull);
    expect(AppFormat.parseCents('abc'), isNull);
    expect(AppFormat.parseCents(''), isNull);
  });

  test('numbers and optional text parse the way forms store them', () {
    expect(parseDecimal('1,5'), 1.5);
    expect(parseDecimal('2.25'), 2.25);
    expect(parseWholeNumber(' 14 '), 14);
    expect(parseWholeNumber('1,5'), isNull);
    expect(optionalText('  '), isNull);
    expect(optionalText(' a '), 'a');
  });

  test('validators return the message only when the value fails', () {
    expect(Validate.required(' ', 'm'), 'm');
    expect(Validate.required('x', 'm'), isNull);
    expect(Validate.optional('', isValidEmail, 'm'), isNull);
    expect(Validate.optional('a@b', isValidEmail, 'm'), 'm');
    expect(Validate.wholeNumber('4', 'm', min: 5), 'm');
    expect(Validate.wholeNumber('5', 'm', min: 5), isNull);
    expect(Validate.decimal('0', 'm'), 'm');
    expect(Validate.decimal('24,5', 'm', max: 24), 'm');
    expect(Validate.decimal('8', 'm', max: 24), isNull);
  });
}
