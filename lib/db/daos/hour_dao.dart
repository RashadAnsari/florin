import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/hour_entries.dart';

part 'hour_dao.g.dart';

@DriftAccessor(tables: [HourEntries])
class HourDao extends DatabaseAccessor<AppDatabase> with _$HourDaoMixin {
  HourDao(super.db);

  Stream<List<HourEntry>> watchByYear(int year) =>
      (select(hourEntries)
            ..where((h) => h.fiscalYear.equals(year))
            ..orderBy([(h) => OrderingTerm.desc(h.date)]))
          .watch();

  Future<List<HourEntry>> getByYear(int year) =>
      (select(hourEntries)
            ..where((h) => h.fiscalYear.equals(year))
            ..orderBy([(h) => OrderingTerm.desc(h.date)]))
          .get();

  Future<double> totalHoursForYear(int year) async {
    final entries = await getByYear(year);
    return entries.fold<double>(0.0, (sum, e) => sum + e.hours);
  }

  Future<int> insertEntry(HourEntriesCompanion entry) =>
      into(hourEntries).insert(entry);

  Future<bool> saveEntry(HourEntriesCompanion entry) =>
      (update(hourEntries)).replace(entry);

  Future<int> deleteEntry(int id) =>
      (delete(hourEntries)..where((h) => h.id.equals(id))).go();
}
