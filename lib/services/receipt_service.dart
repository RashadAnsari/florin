import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:path/path.dart' as p;

import '../db/daos/receipt_dao.dart';
import '../db/database.dart';
import 'receipt_store.dart';

export '../db/daos/receipt_dao.dart' show ReceiptOwner;
export 'receipt_store.dart'
    show ReceiptHealth, ReceiptRejected, ReceiptRejection, ReceiptStore;

/// Receipt files and their rows, kept in step: a file is only stored with
/// its row, and nothing is ever deleted. A removed receipt keeps its row and
/// its file, in the removed folder.
class ReceiptService {
  final ReceiptDao dao;
  final ReceiptStore store;

  const ReceiptService(this.dao, this.store);

  /// A receipt with the same content as [file], to warn before a duplicate.
  Future<Receipt?> duplicateOf(File file) async =>
      dao.findByHash(await ReceiptStore.fingerprint(file));

  /// Copies [file] into the store for [owner] in the bookkeeping [year].
  Future<Receipt> attach(ReceiptOwner owner, File file, int year) async =>
      _record(owner, await store.add(file, year), p.basename(file.path), year);

  /// Stores generated [bytes], such as the PDF of an issued invoice.
  Future<Receipt> attachBytes(
    ReceiptOwner owner,
    Uint8List bytes,
    String fileName,
    int year,
  ) async => _record(
    owner,
    await store.addBytes(bytes, fileName, year),
    fileName,
    year,
  );

  Future<Receipt> _record(
    ReceiptOwner owner,
    StoredFile stored,
    String originalName,
    int year,
  ) async {
    final row = ReceiptsCompanion(
      id: Value(stored.id),
      expenseId: Value(owner.expenseId),
      assetId: Value(owner.assetId),
      invoiceId: Value(owner.invoiceId),
      year: Value(year),
      type: Value(stored.type),
      originalName: Value(originalName),
      sizeBytes: Value(stored.sizeBytes),
      sha256: Value(stored.sha256),
      addedAt: Value(DateTime.now()),
    );
    try {
      // The row and the file's final name land together or not at all.
      await dao.transaction(() async {
        await dao.insertReceipt(row);
        await store.commit(stored);
      });
    } catch (_) {
      await store.discard(stored);
      rethrow;
    }
    return (await dao.forOwner(owner)).firstWhere((r) => r.id == stored.id);
  }

  /// Takes [r] off its record. Nothing is deleted: the row stays, marked
  /// removed with what it belonged to, and the file moves to the removed
  /// folder. Returns the removed receipt, so the caller can offer to undo.
  Future<Receipt> remove(Receipt r) async {
    final (kind, date, name) = await dao.describeOwner(r);
    final removed = r.copyWith(
      removedAt: Value(DateTime.now()),
      removedFromKind: Value(kind),
      removedFromDate: Value(date),
      removedFromName: Value(name),
    );
    await dao.transaction(() async {
      await dao.save(removed);
      await store.moveToRemoved(r);
    });
    return removed;
  }

  /// Whether [r] can go back to its record, which still exists.
  static bool canPutBack(Receipt r) =>
      r.expenseId != null || r.assetId != null || r.invoiceId != null;

  /// Puts a removed receipt back on its record, as an undo or later from the
  /// list of removed receipts.
  Future<void> restore(Receipt r) async {
    if (!canPutBack(r)) return;
    await dao.transaction(() async {
      // A companion that keeps the nulls, so the removal is cleared.
      await dao.save(
        r
            .copyWith(
              removedAt: const Value(null),
              removedFromKind: const Value(null),
              removedFromDate: const Value(null),
              removedFromName: const Value(null),
            )
            .toCompanion(false),
      );
      await store.moveBack(r);
    });
  }

  /// Removes every receipt of [owner] before the owner itself is deleted.
  /// The receipts stay, listed as removed, with what they belonged to.
  Future<void> removeAllFor(ReceiptOwner owner) async {
    for (final r in await dao.forOwner(owner)) {
      await remove(r);
    }
  }

  /// Moves the files of [owner] to the folder of [year] after its date moved
  /// to another bookkeeping year.
  Future<void> relocateFor(ReceiptOwner owner, int year) async {
    for (final r in await dao.forOwner(owner)) {
      if (r.year == year) continue;
      await store.relocate(r, year);
      await dao.save(r.copyWith(year: year));
    }
  }

  /// Every receipt whose file is missing or changed, removed ones included.
  Future<List<(Receipt, ReceiptHealth)>> problems() async {
    final found = <(Receipt, ReceiptHealth)>[];
    for (final r in await dao.all()) {
      final health = await store.check(r);
      if (health != ReceiptHealth.ok) found.add((r, health));
    }
    return found;
  }
}
