import 'package:drift/drift.dart';
import '../enums.dart';
import 'expenses.dart';
import 'fixed_assets.dart';
import 'invoices.dart';

/// A receipt, invoice or other proof stored as a file in the Florin folder,
/// at `receipts/<year>/<id>.<extension>`. While in use it belongs to exactly
/// one expense, asset or invoice. Florin never deletes one: a removed receipt
/// keeps its row, marked removed with what it belonged to, and its file moves
/// to `receipts/removed/`.
class Receipts extends Table {
  /// A random UUID, which is also the file name.
  TextColumn get id => text()();

  IntColumn get expenseId => integer().nullable().references(
    Expenses,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get assetId => integer().nullable().references(
    FixedAssets,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get invoiceId => integer().nullable().references(
    Invoices,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// The year folder the file is in: the bookkeeping year of its owner.
  IntColumn get year => integer()();
  TextColumn get type => textEnum<ReceiptType>()();

  /// The name of the file the user added, shown and used in exports.
  TextColumn get originalName => text()();
  IntColumn get sizeBytes => integer()();

  /// SHA-256 of the stored file, to find duplicates and changed files.
  TextColumn get sha256 => text()();
  DateTimeColumn get addedAt => dateTime()();

  /// When the user removed it from its record, or null while in use.
  DateTimeColumn get removedAt => dateTime().nullable()();

  /// What it belonged to when removed, kept for when that record is gone.
  TextColumn get removedFromKind => textEnum<ReceiptOwnerKind>().nullable()();
  DateTimeColumn get removedFromDate => dateTime().nullable()();
  TextColumn get removedFromName => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK ((expense_id IS NOT NULL) + (asset_id IS NOT NULL) + '
        '(invoice_id IS NOT NULL) <= 1)',
    'CHECK (removed_at IS NOT NULL OR (expense_id IS NOT NULL) + '
        '(asset_id IS NOT NULL) + (invoice_id IS NOT NULL) = 1)',
    'CHECK (removed_at IS NULL OR (removed_from_kind IS NOT NULL AND '
        'removed_from_date IS NOT NULL AND removed_from_name IS NOT NULL))',
  ];
}
