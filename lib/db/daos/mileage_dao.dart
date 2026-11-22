import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/mileage_trips.dart';

part 'mileage_dao.g.dart';

@DriftAccessor(tables: [MileageTrips])
class MileageDao extends DatabaseAccessor<AppDatabase>
    with _$MileageDaoMixin, Crud<$MileageTripsTable, MileageTrip> {
  MileageDao(super.db);

  @override
  TableInfo<$MileageTripsTable, MileageTrip> get table => mileageTrips;

  Stream<List<MileageTrip>> watchInYear(int year) =>
      (select(mileageTrips)
            ..where((r) => r.date.inYear(year))
            ..orderBy([(r) => OrderingTerm.desc(r.date)]))
          .watch();
}
