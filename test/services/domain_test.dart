import 'package:florin/services/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('todayIn keeps new records inside the selected year', () {
    final now = DateTime.now();
    expect(todayIn(now.year - 1), DateTime(now.year - 1, 12, 31));
    expect(todayIn(now.year + 1), DateTime(now.year + 1));
    expect(todayIn(now.year), DateTime(now.year, now.month, now.day));
  });
}
