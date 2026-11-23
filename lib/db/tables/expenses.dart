import 'package:drift/drift.dart';
import '../enums.dart';
import 'fixed_assets.dart';

@TableIndex(name: 'expenses_date', columns: {#date})
class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get supplier => text()();
  TextColumn get description => text()();
  TextColumn get category => textEnum<ExpenseCategory>()();

  /// The user keeps the paper receipt; files are in the receipts table.
  BoolColumn get paperOriginalKept =>
      boolean().withDefault(const Constant(false))();
  IntColumn get amountExclVat => integer()();
  TextColumn get vatRate => textEnum<VatRate>()();
  TextColumn get purchaseVat => textEnum<PurchaseVat>().withDefault(
    Constant(PurchaseVat.domestic.name),
  )();
  IntColumn get vatAmount => integer()();
  IntColumn get totalInclVat => integer()();
  RealColumn get businessUsePct => real()();
  IntColumn get deductibleAmount => integer()();
  BoolColumn get vatReclaimable => boolean()();
  IntColumn get vatToReclaim => integer()();
  TextColumn get notes => text().nullable()();
  TextColumn get paidFrom => text().nullable()();
  TextColumn get paymentReference => text().nullable()();

  /// The business car this cost belongs to.
  IntColumn get carAssetId => integer().nullable().references(
    FixedAssets,
    #id,
    onDelete: KeyAction.restrict,
  )();
}
