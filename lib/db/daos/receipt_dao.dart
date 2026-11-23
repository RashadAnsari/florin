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
        ..where((r) => owner._matches(r))
        ..orderBy([(r) => OrderingTerm.asc(r.addedAt)]);

  Stream<List<Receipt>> watchFor(ReceiptOwner owner) => _of(owner).watch();

  Future<List<Receipt>> forOwner(ReceiptOwner owner) => _of(owner).get();

  Future<List<Receipt>> all() =>
      (select(receipts)..orderBy([(r) => OrderingTerm.asc(r.addedAt)])).get();

  Stream<List<Receipt>> watchAll() => select(receipts).watch();

  /// A receipt already stored with the same content, if any.
  Future<Receipt?> findByHash(String sha256) =>
      (select(receipts)
            ..where((r) => r.sha256.equals(sha256))
            ..limit(1))
          .getSingleOrNull();

  Future<void> insertReceipt(ReceiptsCompanion row) =>
      into(receipts).insert(row);
}
