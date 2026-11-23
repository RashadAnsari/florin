import 'package:drift/drift.dart';
import '../enums.dart';
import 'expenses.dart';
import 'fixed_assets.dart';
import 'invoices.dart';

/// A receipt, invoice or other proof stored as a file in the Florin folder,
/// at `receipts/<year>/<id>.<extension>`. It belongs to exactly one expense,
/// asset or invoice.
class Receipts extends Table {
  /// A random UUID, which is also the file name.
  TextColumn get id => text()();

  IntColumn get expenseId => integer().nullable().references(
    Expenses,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get assetId => integer().nullable().references(
    FixedAssets,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get invoiceId => integer().nullable().references(
    Invoices,
    #id,
    onDelete: KeyAction.restrict,
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

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK ((expense_id IS NOT NULL) + (asset_id IS NOT NULL) + '
        '(invoice_id IS NOT NULL) = 1)',
  ];
}
