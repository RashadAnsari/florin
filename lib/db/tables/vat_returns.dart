import 'package:drift/drift.dart';

import '../enums.dart';

/// Whether the user filed and paid the BTW return of one period.
class VatReturns extends Table {
  IntColumn get year => integer()();

  /// The kind of period: a month, a quarter or the year.
  TextColumn get kind => textEnum<VatFilingPeriod>().withDefault(
    Constant(VatFilingPeriod.quarterly.name),
  )();

  /// The month (1 to 12) or quarter (1 to 4), or 1 for the year.
  // ignore: recursive_getters
  IntColumn get number => integer().check(number.isBetweenValues(1, 12))();
  BoolColumn get filed => boolean().withDefault(const Constant(false))();
  BoolColumn get paid => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {year, kind, number};
}
