// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mileage_dao.dart';

// ignore_for_file: type=lint
mixin _$MileageDaoMixin on DatabaseAccessor<AppDatabase> {
  $FixedAssetsTable get fixedAssets => attachedDatabase.fixedAssets;
  $MileageTripsTable get mileageTrips => attachedDatabase.mileageTrips;
  MileageDaoManager get managers => MileageDaoManager(this);
}

class MileageDaoManager {
  final _$MileageDaoMixin _db;
  MileageDaoManager(this._db);
  $$FixedAssetsTableTableManager get fixedAssets =>
      $$FixedAssetsTableTableManager(_db.attachedDatabase, _db.fixedAssets);
  $$MileageTripsTableTableManager get mileageTrips =>
      $$MileageTripsTableTableManager(_db.attachedDatabase, _db.mileageTrips);
}
