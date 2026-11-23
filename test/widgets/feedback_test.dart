import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:florin/db/daos/client_dao.dart';
import 'package:florin/db/database.dart';
import 'package:florin/l10n/app_localizations.dart';
import 'package:florin/widgets/feedback.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l = lookupAppLocalizations(const Locale('en'));

  test('database constraint failures read as what to do, also from the '
      'background isolate the app uses', () async {
    final dir = await Directory.systemTemp.createTemp('florin_feedback');
    final db = AppDatabase(
      NativeDatabase.createInBackground(File('${dir.path}/f.db')),
    );
    await db.customStatement('PRAGMA foreign_keys = ON');
    addTearDown(() async {
      await db.close();
      await dir.delete(recursive: true);
    });

    final clients = ClientDao(db);
    final id = await clients.save(
      const ClientsCompanion(
        name: Value('K'),
        address: Value('A'),
        wetDbaRisk: Value(WetDbaRisk.low),
      ),
    );
    Object? duplicate;
    try {
      await db.customStatement(
        "INSERT INTO clients (id, name, address, wet_dba_risk) "
        "VALUES ($id, 'K', 'A', 'low')",
      );
    } catch (e) {
      duplicate = e;
    }
    expect(describeError(duplicate!, l), l.errorDuplicate);

    Object? missingClient;
    try {
      await db.customStatement(
        "INSERT INTO invoices (invoice_number, invoice_type, invoice_date, "
        "client_id, vat_treatment, seller_name, seller_vat_number, "
        "seller_kvk_number, seller_address, seller_iban, payment_term_days, "
        "status, total_excl_vat, total_vat, total_incl_vat) VALUES ('F-1', "
        "'invoice', 0, 999, 'standard', 'S', 'NL', 'K', 'A', 'I', 14, "
        "'draft', 0, 0, 0)",
      );
    } catch (e) {
      missingClient = e;
    }
    expect(describeError(missingClient!, l), l.errorInUse);
  });

  test('other errors keep their own text', () {
    expect(describeError(StateError('x'), l), 'Bad state: x');
    expect(
      describeError(const FileSystemException('denied', '/a/b'), l),
      l.errorFile('/a/b', 'denied'),
    );
  });
}
