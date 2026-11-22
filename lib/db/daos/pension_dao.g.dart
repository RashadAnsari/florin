// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pension_dao.dart';

// ignore_for_file: type=lint
mixin _$PensionDaoMixin on DatabaseAccessor<AppDatabase> {
  $PensionEntriesTable get pensionEntries => attachedDatabase.pensionEntries;
  PensionDaoManager get managers => PensionDaoManager(this);
}

class PensionDaoManager {
  final _$PensionDaoMixin _db;
  PensionDaoManager(this._db);
  $$PensionEntriesTableTableManager get pensionEntries =>
      $$PensionEntriesTableTableManager(
        _db.attachedDatabase,
        _db.pensionEntries,
      );
}
