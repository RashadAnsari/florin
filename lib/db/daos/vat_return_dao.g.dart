// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vat_return_dao.dart';

// ignore_for_file: type=lint
mixin _$VatReturnDaoMixin on DatabaseAccessor<AppDatabase> {
  $VatReturnsTable get vatReturns => attachedDatabase.vatReturns;
  VatReturnDaoManager get managers => VatReturnDaoManager(this);
}

class VatReturnDaoManager {
  final _$VatReturnDaoMixin _db;
  VatReturnDaoManager(this._db);
  $$VatReturnsTableTableManager get vatReturns =>
      $$VatReturnsTableTableManager(_db.attachedDatabase, _db.vatReturns);
}
