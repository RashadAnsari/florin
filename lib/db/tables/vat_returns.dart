import 'package:drift/drift.dart';

class VatReturns extends Table {
  IntColumn get year => integer()();
  // ignore: recursive_getters
  IntColumn get quarter => integer().check(quarter.isBetweenValues(1, 4))();
  BoolColumn get filed => boolean().withDefault(const Constant(false))();
  BoolColumn get paid => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {year, quarter};
}
