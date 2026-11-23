import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/receipts.dart';

part 'receipt_dao.g.dart';

/// What a receipt belongs to: exactly one expense, asset or invoice.
class ReceiptOwner {
  final int? expenseId;
  final int? assetId;
  final int? invoiceId;

  const ReceiptOwner.expense(int id)
    : expenseId = id,
      assetId = null,
      invoiceId = null;

  const ReceiptOwner.asset(int id)
    : expenseId = null,
      assetId = id,
      invoiceId = null;

  const ReceiptOwner.invoice(int id)
    : expenseId = null,
      assetId = null,
      invoiceId = id;

  Expression<bool> _matches($ReceiptsTable t) => expenseId != null
      ? t.expenseId.equals(expenseId!)
      : assetId != null
      ? t.assetId.equals(assetId!)
      : t.invoiceId.equals(invoiceId!);

  @override
  bool operator ==(Object other) =>
      other is ReceiptOwner &&
      other.expenseId == expenseId &&
      other.assetId == assetId &&
      other.invoiceId == invoiceId;

  @override
  int get hashCode => Object.hash(expenseId, assetId, invoiceId);
}

@DriftAccessor(tables: [Receipts])
class ReceiptDao extends DatabaseAccessor<AppDatabase>
    with _$ReceiptDaoMixin, Crud<$ReceiptsTable, Receipt> {
  ReceiptDao(super.db);

  @override
  TableInfo<$ReceiptsTable, Receipt> get table => receipts;

  SimpleSelectStatement<$ReceiptsTable, Receipt> _of(ReceiptOwner owner) =>
      select(receipts)
        // In use only; removed receipts are listed apart.
        ..where((r) => owner._matches(r) & r.removedAt.isNull())
        ..orderBy([(r) => OrderingTerm.asc(r.addedAt)]);

  Stream<List<Receipt>> watchFor(ReceiptOwner owner) => _of(owner).watch();

  Future<List<Receipt>> forOwner(ReceiptOwner owner) => _of(owner).get();

  /// Every receipt, removed ones included.
  Future<List<Receipt>> all() =>
      (select(receipts)..orderBy([(r) => OrderingTerm.asc(r.addedAt)])).get();

  /// The receipts in use, for the lists that mark records with files.
  Stream<List<Receipt>> watchInUse() =>
      (select(receipts)..where((r) => r.removedAt.isNull())).watch();

  /// The removed receipts, newest removal first.
  Stream<List<Receipt>> watchRemoved() =>
      (select(receipts)
            ..where((r) => r.removedAt.isNotNull())
            ..orderBy([(r) => OrderingTerm.desc(r.removedAt)]))
          .watch();

  /// What [r] belongs to, to remember when it is removed: the kind, the date
  /// and the name a person knows it by.
  Future<(ReceiptOwnerKind, DateTime, String)> describeOwner(Receipt r) async {
    final db = attachedDatabase;
    if (r.expenseId != null) {
      final e = await (db.select(
        db.expenses,
      )..where((x) => x.id.equals(r.expenseId!))).getSingle();
      return (ReceiptOwnerKind.expense, e.date, e.supplier);
    }
    if (r.assetId != null) {
      final a = await (db.select(
        db.fixedAssets,
      )..where((x) => x.id.equals(r.assetId!))).getSingle();
      return (ReceiptOwnerKind.asset, a.purchaseDate, a.assetName);
    }
    final i = await (db.select(
      db.invoices,
    )..where((x) => x.id.equals(r.invoiceId!))).getSingle();
    return (ReceiptOwnerKind.invoice, i.invoiceDate, i.invoiceNumber);
  }

  /// A receipt already stored with the same content, if any.
  Future<Receipt?> findByHash(String sha256) =>
      (select(receipts)
            ..where((r) => r.sha256.equals(sha256))
            ..limit(1))
          .getSingleOrNull();

  Future<void> insertReceipt(ReceiptsCompanion row) =>
      into(receipts).insert(row);
}
