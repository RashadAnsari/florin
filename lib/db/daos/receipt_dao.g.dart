// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_dao.dart';

// ignore_for_file: type=lint
mixin _$ReceiptDaoMixin on DatabaseAccessor<AppDatabase> {
  $FixedAssetsTable get fixedAssets => attachedDatabase.fixedAssets;
  $ExpensesTable get expenses => attachedDatabase.expenses;
  $ClientsTable get clients => attachedDatabase.clients;
  $InvoicesTable get invoices => attachedDatabase.invoices;
  $ReceiptsTable get receipts => attachedDatabase.receipts;
  ReceiptDaoManager get managers => ReceiptDaoManager(this);
}

class ReceiptDaoManager {
  final _$ReceiptDaoMixin _db;
  ReceiptDaoManager(this._db);
  $$FixedAssetsTableTableManager get fixedAssets =>
      $$FixedAssetsTableTableManager(_db.attachedDatabase, _db.fixedAssets);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db.attachedDatabase, _db.expenses);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db.attachedDatabase, _db.clients);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db.attachedDatabase, _db.invoices);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db.attachedDatabase, _db.receipts);
}
