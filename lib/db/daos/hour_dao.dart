import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/hour_entries.dart';

part 'hour_dao.g.dart';

@DriftAccessor(tables: [HourEntries])
class HourDao extends DatabaseAccessor<AppDatabase>
    with _$HourDaoMixin, Crud<$HourEntriesTable, HourEntry> {
  HourDao(super.db);

  @override
  TableInfo<$HourEntriesTable, HourEntry> get table => hourEntries;

  Stream<List<HourEntry>> watchInYear(int year) =>
      (select(hourEntries)
            ..where((r) => r.date.inYear(year))
            ..orderBy([(r) => OrderingTerm.desc(r.date)]))
          .watch();
}
