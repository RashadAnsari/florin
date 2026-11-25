// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vat_filed_figures_dao.dart';

// ignore_for_file: type=lint
mixin _$VatFiledFiguresDaoMixin on DatabaseAccessor<AppDatabase> {
  $VatFiledFiguresTable get vatFiledFigures => attachedDatabase.vatFiledFigures;
  $VatReturnsTable get vatReturns => attachedDatabase.vatReturns;
  VatFiledFiguresDaoManager get managers => VatFiledFiguresDaoManager(this);
}

class VatFiledFiguresDaoManager {
  final _$VatFiledFiguresDaoMixin _db;
  VatFiledFiguresDaoManager(this._db);
  $$VatFiledFiguresTableTableManager get vatFiledFigures =>
      $$VatFiledFiguresTableTableManager(
        _db.attachedDatabase,
        _db.vatFiledFigures,
      );
  $$VatReturnsTableTableManager get vatReturns =>
      $$VatReturnsTableTableManager(_db.attachedDatabase, _db.vatReturns);
}
