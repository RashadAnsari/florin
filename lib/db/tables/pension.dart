import 'package:drift/drift.dart';

class PensionEntries extends Table {
  IntColumn get year => integer()();

  /// Income from work in the previous year, the basis of the premiegrondslag
  /// (Wet IB 2001 art. 3.127).
  IntColumn get priorYearIncome => integer().withDefault(const Constant(0))();
  IntColumn get factorA => integer().withDefault(const Constant(0))();
  IntColumn get reserveringsruimte =>
      integer().withDefault(const Constant(0))();
  IntColumn get plannedContribution =>
      integer().withDefault(const Constant(0))();
  BoolColumn get aovInsured => boolean().withDefault(const Constant(false))();
  IntColumn get monthlyAovPremium => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {year};
}
