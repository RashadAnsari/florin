// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mileage_dao.dart';

// ignore_for_file: type=lint
mixin _$MileageDaoMixin on DatabaseAccessor<AppDatabase> {
  $MileageTripsTable get mileageTrips => attachedDatabase.mileageTrips;
  MileageDaoManager get managers => MileageDaoManager(this);
}

class MileageDaoManager {
  final _$MileageDaoMixin _db;
  MileageDaoManager(this._db);
  $$MileageTripsTableTableManager get mileageTrips =>
      $$MileageTripsTableTableManager(_db.attachedDatabase, _db.mileageTrips);
}
