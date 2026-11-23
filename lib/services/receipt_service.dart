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
/// its row, and a removed receipt goes to the trash until the user empties
/// it.
class ReceiptService {
  /// The Belastingdienst's bewaarplicht for invoices and receipts
  /// (`docs/legal.md`, Receipts).
  static const retentionYears = 7;

  final ReceiptDao dao;
  final ReceiptStore store;

  const ReceiptService(this.dao, this.store);

  /// The last day a receipt of the bookkeeping year [year] must be kept:
  /// the end of the seventh year after it, the cautious reading of when the
  /// term starts.
  static DateTime keepUntil(int year) =>
      DateTime(year + retentionYears, 12, 31);

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
      await dao.insertReceipt(row);
    } catch (_) {
      // Without its row the file is unreachable, so it goes too.
      await store.deleteStored(stored, year);
      rethrow;
    }
    return (await dao.forOwner(owner)).firstWhere((r) => r.id == stored.id);
  }

  /// Moves [r]'s file to the trash and deletes its row. Returns it, so the
  /// caller can offer to undo.
  Future<Receipt> remove(Receipt r) async {
    await store.moveToTrash(r);
    await dao.remove(r);
    return r;
  }

  /// Undoes [remove].
  Future<void> restore(Receipt r) async {
    await store.restoreFromTrash(r);
    await dao.save(r);
  }

  /// Moves every receipt of [owner] to the trash, before the owner itself is
  /// deleted.
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

  /// Every receipt whose file is missing or changed.
  Future<List<(Receipt, ReceiptHealth)>> problems() async {
    final found = <(Receipt, ReceiptHealth)>[];
    for (final r in await dao.all()) {
      final health = await store.check(r);
      if (health != ReceiptHealth.ok) found.add((r, health));
    }
    return found;
  }
}
