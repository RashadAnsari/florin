import 'dart:convert';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:florin/db/daos/expense_dao.dart';
import 'package:florin/db/daos/receipt_dao.dart';
import 'package:florin/db/database.dart';
import 'package:florin/services/receipt_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

final _pdf = ascii.encode('%PDF-1.7\n%test\n');
final _png = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0, 0, 0, 13];
const _jpeg = [0xFF, 0xD8, 0xFF, 0xE0, 0, 16];
final _heic = [0, 0, 0, 24, ...ascii.encode('ftypheic'), 0, 0, 0, 0];
const _tiff = [0x49, 0x49, 0x2A, 0x00, 8, 0];
final _ubl = utf8.encode(
  '<?xml version="1.0"?><Invoice xmlns="urn:oasis:names:specification:ubl:'
  'schema:xsd:Invoice-2"></Invoice>',
);

void main() {
  late Directory root;
  late ReceiptStore store;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('florin_receipts');
    store = ReceiptStore(root.path);
  });
  tearDown(() => root.delete(recursive: true));

  Future<File> source(String name, List<int> bytes) async {
    final f = File(p.join(root.path, 'in', name));
    await f.parent.create(recursive: true);
    return f.writeAsBytes(bytes);
  }

  test('the kind of file comes from its content, not its name', () {
    expect(ReceiptStore.detectType(_pdf), ReceiptType.pdf);
    expect(ReceiptStore.detectType(_png), ReceiptType.png);
    expect(ReceiptStore.detectType(_jpeg), ReceiptType.jpeg);
    expect(ReceiptStore.detectType(_heic), ReceiptType.heic);
    expect(ReceiptStore.detectType(_tiff), ReceiptType.tiff);
    expect(ReceiptStore.detectType(_ubl), ReceiptType.xml);
    // A ZIP (also .docx) and plain XML that is no e-invoice are refused.
    expect(ReceiptStore.detectType([0x50, 0x4B, 0x03, 0x04]), isNull);
    expect(ReceiptStore.detectType(utf8.encode('<?xml?><a/>')), isNull);
  });

  test('a file is copied as it is under a new UUID in its year folder, '
      'and the original stays', () async {
    final file = await source('bon.pdf', _pdf);
    final stored = await store.add(file, 2026);
    await store.commit(stored);
    final copy = File(
      p.join(root.path, 'receipts', '2026', '${stored.id}.pdf'),
    );
    expect(await copy.readAsBytes(), _pdf);
    expect(await file.exists(), isTrue);
    expect(stored.sizeBytes, _pdf.length);
    expect(
      RegExp(
        r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
      ).hasMatch(stored.id),
      isTrue,
    );
    // No temporary file is left behind.
    expect(copy.parent.listSync(), hasLength(1));
  });

  test(
    'empty, oversized and unknown files are refused before storing',
    () async {
      Future<ReceiptRejection?> reason(String name, List<int> bytes) async {
        try {
          await store.add(await source(name, bytes), 2026);
          return null;
        } on ReceiptRejected catch (e) {
          return e.reason;
        }
      }

      expect(await reason('leeg.pdf', const []), ReceiptRejection.empty);
      expect(
        await reason('a.docx', const [0x50, 0x4B, 3, 4]),
        ReceiptRejection.unsupported,
      );
      final big = List<int>.filled(ReceiptStore.maxBytes + 1, 0)
        ..setRange(0, _pdf.length, _pdf);
      expect(await reason('groot.pdf', big), ReceiptRejection.tooLarge);
      expect(Directory(store.folder).existsSync(), isFalse);
    },
  );

  group('with the database', () {
    late AppDatabase db;
    late ReceiptService service;
    late int expenseId;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      await db.customStatement('PRAGMA foreign_keys = ON');
      service = ReceiptService(ReceiptDao(db), store);
      expenseId = await ExpenseDao(db).save(
        ExpensesCompanion(
          date: Value(DateTime(2026, 3, 4)),
          supplier: const Value('S'),
          description: const Value('D'),
          category: const Value(ExpenseCategory.software),
          amountExclVat: const Value(1000),
          vatRate: const Value(VatRate.high),
          vatAmount: const Value(210),
          totalInclVat: const Value(1210),
          businessUsePct: const Value(1),
          deductibleAmount: const Value(1000),
          vatReclaimable: const Value(true),
          vatToReclaim: const Value(210),
        ),
      );
    });
    tearDown(() => db.close());

    test('removing keeps the row and the file, and can be undone', () async {
      final owner = ReceiptOwner.expense(expenseId);
      final r = await service.attach(
        owner,
        await source('bon.png', _png),
        2026,
      );
      expect(r.originalName, 'bon.png');
      expect(await store.check(r), ReceiptHealth.ok);
      expect(
        await service.duplicateOf(await source('zelfde.png', _png)),
        isNotNull,
      );

      final removed = await service.remove(r);
      expect(await service.dao.forOwner(owner), isEmpty);
      expect(removed.removedFromKind, ReceiptOwnerKind.expense);
      expect(removed.removedFromName, 'S');
      expect(p.dirname(store.fileOf(removed).path), store.removedFolder);
      expect(await store.check(removed), ReceiptHealth.ok);
      expect(await service.dao.all(), hasLength(1));

      await service.restore(removed);
      final back = (await service.dao.forOwner(owner)).single;
      expect(back.removedAt, isNull);
      expect(await store.check(back), ReceiptHealth.ok);
    });

    test('deleting a record keeps its receipts, listed as removed', () async {
      final owner = ReceiptOwner.expense(expenseId);
      await service.attach(owner, await source('a.pdf', _pdf), 2026);
      await service.removeAllFor(owner);
      await (db.delete(db.expenses)..where((e) => e.id.equals(expenseId))).go();
      final kept = (await service.dao.all()).single;
      expect(kept.expenseId, isNull);
      expect(kept.removedFromName, 'S');
      expect(ReceiptService.canPutBack(kept), isFalse);
      expect(await store.check(kept), ReceiptHealth.ok);
    });

    test('a receipt in use cannot lose its record', () async {
      final owner = ReceiptOwner.expense(expenseId);
      await service.attach(owner, await source('a.pdf', _pdf), 2026);
      // Deleting the expense without removing its receipts first is refused.
      expect(
        () =>
            (db.delete(db.expenses)..where((e) => e.id.equals(expenseId))).go(),
        throwsA(isA<Exception>()),
      );
    });

    test('a file whose row cannot be saved leaves nothing behind', () async {
      // An owner that does not exist breaks the foreign key.
      await expectLater(
        service.attach(
          const ReceiptOwner.expense(999),
          await source('a.pdf', _pdf),
          2026,
        ),
        throwsA(isA<Exception>()),
      );
      expect(Directory(p.join(store.folder, '2026')).listSync(), isEmpty);
    });

    test('a receipt follows its owner to another year folder', () async {
      final owner = ReceiptOwner.expense(expenseId);
      final r = await service.attach(owner, await source('a.pdf', _pdf), 2026);
      await service.relocateFor(owner, 2027);
      final moved = (await service.dao.forOwner(owner)).single;
      expect(moved.year, 2027);
      expect(await store.check(moved), ReceiptHealth.ok);
      expect(await store.fileOf(r).exists(), isFalse);
    });

    test('missing and changed files are found', () async {
      final owner = ReceiptOwner.expense(expenseId);
      final a = await service.attach(owner, await source('a.pdf', _pdf), 2026);
      final b = await service.attach(owner, await source('b.png', _png), 2026);
      await store.fileOf(a).delete();
      await store.fileOf(b).writeAsBytes([..._png, 1]);
      final found = {for (final (r, h) in await service.problems()) r.id: h};
      expect(found, {a.id: ReceiptHealth.missing, b.id: ReceiptHealth.changed});
    });

    test('a receipt belongs to exactly one owner', () async {
      expect(
        () => db.customStatement(
          "INSERT INTO receipts (id, year, type, original_name, size_bytes, "
          "sha256, added_at) VALUES ('x', 2026, 'pdf', 'a', 1, 'h', 0)",
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('the whole folder moves along with the database', () async {
      final owner = ReceiptOwner.expense(expenseId);
      final r = await service.attach(owner, await source('a.pdf', _pdf), 2026);
      final target = await Directory.systemTemp.createTemp('florin_moved');
      addTearDown(() => target.delete(recursive: true));
      await store.copyTo(target.path);
      expect(await ReceiptStore(target.path).check(r), ReceiptHealth.ok);
      expect(
        () => store.copyTo(target.path),
        throwsA(isA<FileSystemException>()),
      );
    });
  });

  test('receipts are kept until the end of the seventh year after their '
      'year (Belastingdienst, bewaarplicht)', () {
    expect(taxRulesFor(2026)!.keepUntil(2026), DateTime(2033, 12, 31));
  });
}
