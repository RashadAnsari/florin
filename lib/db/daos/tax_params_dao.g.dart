// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_params_dao.dart';

// ignore_for_file: type=lint
mixin _$TaxParamsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TaxParamsTable get taxParams => attachedDatabase.taxParams;
  $PensionEntriesTable get pensionEntries => attachedDatabase.pensionEntries;
  TaxParamsDaoManager get managers => TaxParamsDaoManager(this);
}

class TaxParamsDaoManager {
  final _$TaxParamsDaoMixin _db;
  TaxParamsDaoManager(this._db);
  $$TaxParamsTableTableManager get taxParams =>
      $$TaxParamsTableTableManager(_db.attachedDatabase, _db.taxParams);
  $$PensionEntriesTableTableManager get pensionEntries =>
      $$PensionEntriesTableTableManager(
        _db.attachedDatabase,
        _db.pensionEntries,
      );
}
