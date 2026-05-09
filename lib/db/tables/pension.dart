import 'package:drift/drift.dart';

class PensionEntries extends Table {
  IntColumn get fiscalYear => integer()();
  RealColumn get factorA => real().withDefault(const Constant(0.0))();
  IntColumn get unusedPriorYearsSpace =>
      integer().withDefault(const Constant(0))();
  IntColumn get plannedContribution =>
      integer().withDefault(const Constant(0))();
  BoolColumn get aovInsured => boolean().withDefault(const Constant(false))();
  IntColumn get monthlyAovPremium => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {fiscalYear};
}
