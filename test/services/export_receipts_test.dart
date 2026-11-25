import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';
import 'package:drift/native.dart';
import 'package:florin/db/database.dart';
import 'package:florin/services/csv_export_service.dart';
import 'package:florin/services/receipt_store.dart';
import 'package:florin/services/vat_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path/path.dart' as p;

import '../../tool/create_demo_database.dart';

void main() {
  test(
    'an export copies the receipts of the year unchanged and lists them',
    () async {
      await initializeDateFormatting('nl_NL');
      final folder = await Directory.systemTemp.createTemp('florin_export_db');
      final parent = await Directory.systemTemp.createTemp('florin_export_out');
      addTearDown(() async {
        await folder.delete(recursive: true);
        await parent.delete(recursive: true);
      });
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await fillDemo(db, folder: folder.path);

      final empty = VatService.calculateQuarter(
        invoices: const [],
        lines: const [],
        expenses: const [],
        year: 2026,
        quarter: 1,
      );
      final dir = await CsvExportService(db).writeYear(
        2026,
        parent: parent.path,
        periods: [
          for (var q = 1; q <= 4; q++)
            ((year: 2026, kind: VatFilingPeriod.quarterly, number: q), empty),
        ],
        quarters: [empty, empty, empty, empty],
        incomeTax: null,
        receipts: ReceiptStore(folder.path),
      );

      final rows = const CsvToListConverter(eol: '\r\n').convert(
        await File(p.join(dir, 'florin_2026_bonnen.csv')).readAsString(),
      );
      final stored = await db.select(db.receipts).get();
      expect(rows.length - 1, stored.length);
      for (final row in rows.skip(1)) {
        final copy = File(p.join(dir, row[0] as String));
        expect(await copy.exists(), isTrue, reason: row[0] as String);
        // Copied as stored: the fingerprint still matches.
        expect(sha256.convert(await copy.readAsBytes()).toString(), row[8]);
        expect(row[9], 'Ja');
      }
      expect(
        rows.skip(1).map((r) => (r[0] as String).split('/').first).toSet(),
        {'bonnen', 'facturen', 'verwijderd'},
      );
      // A removed receipt is exported too, with the date it was removed.
      final removed = rows
          .skip(1)
          .where((r) => (r[0] as String).startsWith('verwijderd/'));
      expect(removed, hasLength(1));
      expect(removed.single[4], 'verkeerde-bon.pdf');
      expect(removed.single[10], isNotEmpty);
      final expensesCsv = await File(
        p.join(dir, 'florin_2026_uitgaven.csv'),
      ).readAsString();
      expect(expensesCsv, contains('Papieren origineel bewaard'));
      expect(expensesCsv, contains('bonnen/2026-03-04_Hardware Voorbeeld_'));

      // Everything the estimate and the invoices rest on is in the export.
      for (final name in [
        'bedrijfsgegevens',
        'pensioen',
        'fiscale_gegevens',
        'btw_aangiften',
      ]) {
        expect(
          await File(p.join(dir, 'florin_2026_$name.csv')).exists(),
          isTrue,
          reason: name,
        );
      }
      final profile = await db.select(db.businessProfiles).getSingle();
      expect(
        await File(
          p.join(dir, 'florin_2026_bedrijfsgegevens.csv'),
        ).readAsString(),
        contains(profile.kvkNumber),
      );
      final status = const CsvToListConverter(eol: '\r\n').convert(
        await File(p.join(dir, 'florin_2026_btw_aangiften.csv')).readAsString(),
      );
      expect(status.skip(1).map((r) => r.first), ['Q1', 'Q2', 'Q3', 'Q4']);
    },
  );
}
