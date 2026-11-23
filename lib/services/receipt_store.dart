import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

import '../db/database.dart';

/// Why a file cannot be stored as a receipt.
enum ReceiptRejection { empty, tooLarge, unsupported }

/// A file was refused before anything was stored.
class ReceiptRejected implements Exception {
  final ReceiptRejection reason;
  final String fileName;

  const ReceiptRejected(this.reason, this.fileName);

  @override
  String toString() => 'ReceiptRejected($reason, $fileName)';
}

/// Whether a stored file is still what was added.
enum ReceiptHealth { ok, missing, changed }

/// A file checked and copied into the receipts folder, ready for its row.
class StoredFile {
  final String id;
  final ReceiptType type;
  final int sizeBytes;
  final String sha256;

  const StoredFile({
    required this.id,
    required this.type,
    required this.sizeBytes,
    required this.sha256,
  });
}

/// The receipt files in the Florin folder, next to the database:
/// `receipts/<year>/<uuid>.<extension>`, with removed files in
/// `receipts/.trash/` until the user empties it. Files are copied as they
/// are, never converted, as the Belastingdienst asks invoices to be kept in
/// the form they were received (`docs/legal.md`, Receipts).
class ReceiptStore {
  /// A size that holds any multi-page scan and keeps a synced folder light.
  static const maxBytes = 25 * 1024 * 1024;

  static const folderName = 'receipts';
  static const trashName = '.trash';

  /// The folder that holds the database and the receipts folder.
  final String root;

  const ReceiptStore(this.root);

  /// The store next to the database at [dbPath].
  factory ReceiptStore.forDatabase(String dbPath) =>
      ReceiptStore(p.dirname(dbPath));

  String get folder => p.join(root, folderName);
  String get trashFolder => p.join(folder, trashName);

  String _name(String id, ReceiptType type) => '$id.${type.extension}';

  /// Where the file of [r] lives.
  File fileOf(Receipt r) =>
      File(p.join(folder, '${r.year}', _name(r.id, r.type)));

  File _trashed(Receipt r) => File(p.join(trashFolder, _name(r.id, r.type)));

  /// The kind of file [head] starts with, or null when Florin does not keep
  /// that kind. Content decides, never the extension.
  static ReceiptType? detectType(List<int> head) {
    bool startsWith(List<int> sig, [int offset = 0]) {
      if (head.length < offset + sig.length) return false;
      for (var i = 0; i < sig.length; i++) {
        if (head[offset + i] != sig[i]) return false;
      }
      return true;
    }

    if (startsWith(ascii.encode('%PDF-'))) return ReceiptType.pdf;
    if (startsWith(const [0xFF, 0xD8, 0xFF])) return ReceiptType.jpeg;
    if (startsWith(const [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A])) {
      return ReceiptType.png;
    }
    if (startsWith(const [0x49, 0x49, 0x2A, 0x00]) ||
        startsWith(const [0x4D, 0x4D, 0x00, 0x2A])) {
      return ReceiptType.tiff;
    }
    // HEIC and HEIF: an ISO box `ftyp` with an image brand.
    if (startsWith(ascii.encode('ftyp'), 4) && head.length >= 12) {
      final brand = ascii.decode(head.sublist(8, 12), allowInvalid: true);
      const brands = {'heic', 'heix', 'hevc', 'hevx', 'mif1', 'msf1'};
      if (brands.contains(brand)) return ReceiptType.heic;
    }
    // A UBL invoice or credit note, the format of Dutch e-invoices.
    final text = utf8.decode(head, allowMalformed: true).trimLeft();
    final body = text.startsWith('﻿') ? text.substring(1) : text;
    if (body.startsWith('<') &&
        RegExp(
          r'urn:oasis:names:specification:ubl:schema:xsd:(Invoice|CreditNote)-2',
        ).hasMatch(body)) {
      return ReceiptType.xml;
    }
    return null;
  }

  /// The type of a file with [bytes], or a [ReceiptRejected] saying why it
  /// cannot be kept.
  static ReceiptType _typeOf(String name, Uint8List bytes) {
    if (bytes.isEmpty) throw ReceiptRejected(ReceiptRejection.empty, name);
    if (bytes.length > maxBytes) {
      throw ReceiptRejected(ReceiptRejection.tooLarge, name);
    }
    // An XML declaration and namespaces fit well inside the first 4 KB.
    final type = detectType(bytes.sublist(0, min(bytes.length, 4096)));
    if (type == null) throw ReceiptRejected(ReceiptRejection.unsupported, name);
    return type;
  }

  /// Checks [file] without storing it, so a choice is refused at once.
  static Future<ReceiptType> inspect(File file) async {
    final name = p.basename(file.path);
    if (await file.length() > maxBytes) {
      throw ReceiptRejected(ReceiptRejection.tooLarge, name);
    }
    return _typeOf(name, await file.readAsBytes());
  }

  /// Checks [source] and copies it into the folder of [year] under a new
  /// UUID. The copy is written next to its place and then renamed, so a
  /// failure never leaves half a file. [source] itself is not touched.
  Future<StoredFile> add(File source, int year) async {
    final bytes = await source.readAsBytes();
    final type = _typeOf(p.basename(source.path), bytes);
    final id = newUuid();
    final dir = Directory(p.join(folder, '$year'));
    await dir.create(recursive: true);
    final target = File(p.join(dir.path, _name(id, type)));
    final temp = File(p.join(dir.path, '.$id.part'));
    await temp.writeAsBytes(bytes, flush: true);
    await temp.rename(target.path);
    return StoredFile(
      id: id,
      type: type,
      sizeBytes: bytes.length,
      sha256: sha256.convert(bytes).toString(),
    );
  }

  /// Stores generated [bytes], such as an issued invoice PDF, the same way.
  Future<StoredFile> addBytes(
    Uint8List bytes,
    String fileName,
    int year,
  ) async {
    final dir = await Directory.systemTemp.createTemp('florin_receipt');
    try {
      final file = File(p.join(dir.path, fileName));
      await file.writeAsBytes(bytes, flush: true);
      return await add(file, year);
    } finally {
      await dir.delete(recursive: true);
    }
  }

  /// The SHA-256 of [file], as stored for each receipt.
  static Future<String> fingerprint(File file) async =>
      sha256.convert(await file.readAsBytes()).toString();

  /// Deletes a file [add] stored, when its row could not be saved.
  Future<void> deleteStored(StoredFile stored, int year) async {
    final file = File(p.join(folder, '$year', _name(stored.id, stored.type)));
    if (await file.exists()) await file.delete();
  }

  /// Moves the file of [r] to the trash. A missing file is already gone.
  Future<void> moveToTrash(Receipt r) async {
    final file = fileOf(r);
    if (!await file.exists()) return;
    await Directory(trashFolder).create(recursive: true);
    await file.rename(_trashed(r).path);
  }

  /// Brings the file of [r] back from the trash, for an undo.
  Future<void> restoreFromTrash(Receipt r) async {
    final file = _trashed(r);
    if (!await file.exists()) return;
    await fileOf(r).parent.create(recursive: true);
    await file.rename(fileOf(r).path);
  }

  /// Moves the file of [r] to the folder of [year], when its owner moved to
  /// another bookkeeping year.
  Future<void> relocate(Receipt r, int year) async {
    if (r.year == year) return;
    final target = File(p.join(folder, '$year', _name(r.id, r.type)));
    await target.parent.create(recursive: true);
    await fileOf(r).rename(target.path);
  }

  /// Whether the file of [r] is there and unchanged.
  Future<ReceiptHealth> check(Receipt r) async {
    final file = fileOf(r);
    if (!await file.exists()) return ReceiptHealth.missing;
    final hash = sha256.convert(await file.readAsBytes()).toString();
    return hash == r.sha256 ? ReceiptHealth.ok : ReceiptHealth.changed;
  }

  /// The files in the trash.
  Future<List<File>> trashed() async {
    final dir = Directory(trashFolder);
    if (!await dir.exists()) return const [];
    return dir.list().where((e) => e is File).cast<File>().toList();
  }

  /// Deletes the files in the trash for good.
  Future<void> emptyTrash() async {
    for (final f in await trashed()) {
      await f.delete();
    }
  }

  /// Copies every receipt file, the trash included, into the store at
  /// [targetRoot], for when the database moves there. Refuses to merge into
  /// an existing receipts folder.
  Future<void> copyTo(String targetRoot) async {
    final source = Directory(folder);
    if (!await source.exists()) return;
    final target = Directory(p.join(targetRoot, folderName));
    if (await target.exists()) {
      throw FileSystemException(
        'A receipts folder already exists here',
        target.path,
      );
    }
    await for (final entity in source.list(recursive: true)) {
      if (entity is! File) continue;
      final relative = p.relative(entity.path, from: source.path);
      final copy = File(p.join(target.path, relative));
      await copy.parent.create(recursive: true);
      await entity.copy(copy.path);
    }
  }
}

final _random = Random.secure();

/// A random version 4 UUID (RFC 9562), such as
/// `3f2c9a1e-6b0d-4e8a-9c1f-2a7b5d4e3c10`.
String newUuid() {
  final b = List<int>.generate(16, (_) => _random.nextInt(256));
  b[6] = (b[6] & 0x0F) | 0x40;
  b[8] = (b[8] & 0x3F) | 0x80;
  final h = b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
  return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-'
      '${h.substring(16, 20)}-${h.substring(20)}';
}
