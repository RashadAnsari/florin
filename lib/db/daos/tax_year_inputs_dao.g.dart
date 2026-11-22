// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_year_inputs_dao.dart';

// ignore_for_file: type=lint
mixin _$TaxYearInputsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TaxYearInputsTable get taxYearInputs => attachedDatabase.taxYearInputs;
  TaxYearInputsDaoManager get managers => TaxYearInputsDaoManager(this);
}

class TaxYearInputsDaoManager {
  final _$TaxYearInputsDaoMixin _db;
  TaxYearInputsDaoManager(this._db);
  $$TaxYearInputsTableTableManager get taxYearInputs =>
      $$TaxYearInputsTableTableManager(_db.attachedDatabase, _db.taxYearInputs);
}
