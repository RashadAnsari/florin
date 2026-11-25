// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hour_dao.dart';

// ignore_for_file: type=lint
mixin _$HourDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientsTable get clients => attachedDatabase.clients;
  $HourEntriesTable get hourEntries => attachedDatabase.hourEntries;
  HourDaoManager get managers => HourDaoManager(this);
}

class HourDaoManager {
  final _$HourDaoMixin _db;
  HourDaoManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db.attachedDatabase, _db.clients);
  $$HourEntriesTableTableManager get hourEntries =>
      $$HourEntriesTableTableManager(_db.attachedDatabase, _db.hourEntries);
}
