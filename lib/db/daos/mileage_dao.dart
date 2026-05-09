import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/mileage_trips.dart';

part 'mileage_dao.g.dart';

@DriftAccessor(tables: [MileageTrips])
class MileageDao extends DatabaseAccessor<AppDatabase> with _$MileageDaoMixin {
  MileageDao(super.db);

  Stream<List<MileageTrip>> watchByYear(int year) =>
      (select(mileageTrips)
            ..where((m) => m.fiscalYear.equals(year))
            ..orderBy([(m) => OrderingTerm.desc(m.date)]))
          .watch();

  Future<List<MileageTrip>> getByYear(int year) =>
      (select(mileageTrips)
            ..where((m) => m.fiscalYear.equals(year))
            ..orderBy([(m) => OrderingTerm.desc(m.date)]))
          .get();

  Future<MileageTrip?> getLastTrip(int year) async {
    final results =
        await (select(mileageTrips)
              ..where((m) => m.fiscalYear.equals(year))
              ..orderBy([(m) => OrderingTerm.desc(m.date)])
              ..limit(1))
            .get();
    return results.isEmpty ? null : results.first;
  }

  Future<int> insertTrip(MileageTripsCompanion entry) =>
      into(mileageTrips).insert(entry);

  Future<bool> saveTrip(MileageTripsCompanion entry) =>
      (update(mileageTrips)).replace(entry);

  Future<int> deleteTrip(int id) =>
      (delete(mileageTrips)..where((m) => m.id.equals(id))).go();
}
