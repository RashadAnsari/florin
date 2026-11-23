// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:florin/db/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  test(
    'migration from v1 to v2 keeps the profile, clients and invoices',
    () async {
      const oldProfile = v1.BusinessProfilesData(
        id: 1,
        name: 'Studio',
        vatNumber: 'NL000099998B57',
        kvkNumber: '12345678',
        address: 'Straat 2',
        iban: 'NL91ABNA0417164300',
        isStarter: 0,
      );
      const newProfile = v2.BusinessProfilesData(
        id: 1,
        name: 'Studio',
        vatNumber: 'NL000099998B57',
        kvkNumber: '12345678',
        address: 'Straat 2',
        iban: 'NL91ABNA0417164300',
        isStarter: 0,
      );
      const oldClient = v1.ClientsData(
        id: 1,
        name: 'Voorbeeld BV',
        country: 'NL',
        address: 'Straat 1',
        wetDbaRisk: 'low',
        contractSigned: 1,
        isActive: 1,
      );
      const newClient = v2.ClientsData(
        id: 1,
        name: 'Voorbeeld BV',
        country: 'NL',
        address: 'Straat 1',
        wetDbaRisk: 'low',
        contractSigned: 1,
        isActive: 1,
        isMerchantOfRecord: 0,
      );
      const oldInvoice = v1.InvoicesData(
        id: 1,
        invoiceNumber: 'F-2026-001',
        invoiceType: 'invoice',
        invoiceDate: 1767225600,
        clientId: 1,
        vatTreatment: 'standard',
        sellerName: 'Studio',
        sellerVatNumber: 'NL000099998B57',
        sellerKvkNumber: '12345678',
        sellerAddress: 'Straat 2',
        sellerIban: 'NL91ABNA0417164300',
        paymentTermDays: 14,
        status: 'paid',
        totalExclVat: 10000,
        totalVat: 2100,
        totalInclVat: 12100,
      );
      const newInvoice = v2.InvoicesData(
        id: 1,
        invoiceNumber: 'F-2026-001',
        invoiceType: 'invoice',
        invoiceDate: 1767225600,
        clientId: 1,
        vatTreatment: 'standard',
        selfBilled: 0,
        sellerName: 'Studio',
        sellerVatNumber: 'NL000099998B57',
        sellerKvkNumber: '12345678',
        sellerAddress: 'Straat 2',
        sellerIban: 'NL91ABNA0417164300',
        paymentTermDays: 14,
        status: 'paid',
        totalExclVat: 10000,
        totalVat: 2100,
        totalInclVat: 12100,
      );

      await verifier.testWithDataIntegrity(
        oldVersion: 1,
        newVersion: 2,
        createOld: v1.DatabaseAtV1.new,
        createNew: v2.DatabaseAtV2.new,
        openTestedDatabase: AppDatabase.new,
        createItems: (batch, oldDb) {
          batch.insertAll(oldDb.businessProfiles, [oldProfile]);
          batch.insertAll(oldDb.clients, [oldClient]);
          batch.insertAll(oldDb.invoices, [oldInvoice]);
        },
        validateItems: (newDb) async {
          expect(await newDb.select(newDb.businessProfiles).get(), [
            newProfile,
          ]);
          expect(await newDb.select(newDb.clients).get(), [newClient]);
          expect(await newDb.select(newDb.invoices).get(), [newInvoice]);
        },
      );
    },
  );
}
