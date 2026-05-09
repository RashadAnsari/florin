// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_dao.dart';

// ignore_for_file: type=lint
mixin _$InvoiceDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientsTable get clients => attachedDatabase.clients;
  $InvoicesTable get invoices => attachedDatabase.invoices;
  $InvoiceLinesTable get invoiceLines => attachedDatabase.invoiceLines;
  InvoiceDaoManager get managers => InvoiceDaoManager(this);
}

class InvoiceDaoManager {
  final _$InvoiceDaoMixin _db;
  InvoiceDaoManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db.attachedDatabase, _db.clients);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db.attachedDatabase, _db.invoices);
  $$InvoiceLinesTableTableManager get invoiceLines =>
      $$InvoiceLinesTableTableManager(_db.attachedDatabase, _db.invoiceLines);
}
