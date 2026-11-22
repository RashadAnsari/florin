import 'package:drift_dev/api/migrations_native.dart';
import 'package:florin/db/database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';

void main() {
  late SchemaVerifier verifier;

  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  test('the tables in code match the latest exported snapshot', () async {
    // The database is created from the snapshot, then checked against what
    // the code expects. A table change without `make migration` fails here.
    final db = AppDatabase(await verifier.startAt(1));
    addTearDown(db.close);
    await db.customSelect('SELECT 1').get();
    await db.validateDatabaseSchema();
  });

  test('foreign keys are enforced', () async {
    final db = AppDatabase(await verifier.startAt(1));
    addTearDown(db.close);
    await db.customSelect('SELECT 1').get();
    final fk = await db.customSelect('PRAGMA foreign_keys').getSingle();
    expect(fk.data.values.first, 1);
  });
}
