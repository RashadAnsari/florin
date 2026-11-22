import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/pension.dart';

part 'pension_dao.g.dart';

@DriftAccessor(tables: [PensionEntries])
class PensionDao extends DatabaseAccessor<AppDatabase>
    with _$PensionDaoMixin, Crud<$PensionEntriesTable, PensionEntry> {
  PensionDao(super.db);

  @override
  TableInfo<$PensionEntriesTable, PensionEntry> get table => pensionEntries;

  Stream<PensionEntry?> watchYear(int year) => (select(
    pensionEntries,
  )..where((p) => p.year.equals(year))).watchSingleOrNull();
}
