// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_dao.dart';

// ignore_for_file: type=lint
mixin _$ClientDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientsTable get clients => attachedDatabase.clients;
  $InvoicesTable get invoices => attachedDatabase.invoices;
  $HourEntriesTable get hourEntries => attachedDatabase.hourEntries;
  ClientDaoManager get managers => ClientDaoManager(this);
}

class ClientDaoManager {
  final _$ClientDaoMixin _db;
  ClientDaoManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db.attachedDatabase, _db.clients);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db.attachedDatabase, _db.invoices);
  $$HourEntriesTableTableManager get hourEntries =>
      $$HourEntriesTableTableManager(_db.attachedDatabase, _db.hourEntries);
}
