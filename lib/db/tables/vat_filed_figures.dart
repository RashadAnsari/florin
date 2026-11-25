import 'package:drift/drift.dart';

import '../enums.dart';

/// What the user filed for one rubriek of one BTW return, kept when the
/// return is marked filed, so a later change to the records shows as a
/// correction (`docs/legal.md`, Correcting a filed return).
class VatFiledFigures extends Table {
  IntColumn get year => integer()();
  TextColumn get kind => textEnum<VatFilingPeriod>()();
  IntColumn get number => integer()();

  /// The rubriek's code on the form, such as `1a` or `5b`.
  TextColumn get rubriek => text()();

  /// The amount the BTW is calculated over, in cents; 0 where the rubriek
  /// has none.
  IntColumn get base => integer()();
  IntColumn get vat => integer()();

  @override
  Set<Column> get primaryKey => {year, kind, number, rubriek};
}
