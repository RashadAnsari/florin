// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_profile_dao.dart';

// ignore_for_file: type=lint
mixin _$BusinessProfileDaoMixin on DatabaseAccessor<AppDatabase> {
  $BusinessProfilesTable get businessProfiles =>
      attachedDatabase.businessProfiles;
  BusinessProfileDaoManager get managers => BusinessProfileDaoManager(this);
}

class BusinessProfileDaoManager {
  final _$BusinessProfileDaoMixin _db;
  BusinessProfileDaoManager(this._db);
  $$BusinessProfilesTableTableManager get businessProfiles =>
      $$BusinessProfilesTableTableManager(
        _db.attachedDatabase,
        _db.businessProfiles,
      );
}
