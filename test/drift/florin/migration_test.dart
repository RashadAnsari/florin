// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:florin/db/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;
import 'generated/schema_v4.dart' as v4;
import 'generated/schema_v5.dart' as v5;
import 'generated/schema_v6.dart' as v6;
import 'generated/schema_v7.dart' as v7;
import 'generated/schema_v8.dart' as v8;
import 'generated/schema_v9.dart' as v9;

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

  test('migration from v1 to v2 keeps the profile, clients, invoices and '
      'expenses', () async {
    const oldExpense = v1.ExpensesData(
      id: 1,
      date: 1767225600,
      supplier: 'Leverancier',
      description: 'Software',
      category: 'software',
      receiptAttached: 1,
      amountExclVat: 10000,
      vatRate: 'high',
      purchaseVat: 'domestic',
      vatAmount: 2100,
      totalInclVat: 12100,
      businessUsePct: 1,
      deductibleAmount: 10000,
      vatReclaimable: 1,
      vatToReclaim: 2100,
    );
    // The paper flag keeps its value under its new name.
    const newExpense = v2.ExpensesData(
      id: 1,
      date: 1767225600,
      supplier: 'Leverancier',
      description: 'Software',
      category: 'software',
      paperOriginalKept: 1,
      amountExclVat: 10000,
      vatRate: 'high',
      purchaseVat: 'domestic',
      vatAmount: 2100,
      totalInclVat: 12100,
      businessUsePct: 1,
      deductibleAmount: 10000,
      vatReclaimable: 1,
      vatToReclaim: 2100,
    );
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
        batch.insertAll(oldDb.expenses, [oldExpense]);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.businessProfiles).get(), [newProfile]);
        expect(await newDb.select(newDb.clients).get(), [newClient]);
        expect(await newDb.select(newDb.invoices).get(), [newInvoice]);
        expect(await newDb.select(newDb.expenses).get(), [newExpense]);
        expect(await newDb.select(newDb.receipts).get(), isEmpty);
      },
    );
  });

  test('migration from v2 to v3 moves a car\'s purchase BTW and counts a car '
      'and its costs in full', () async {
    const oldCar = v2.FixedAssetsData(
      id: 1,
      kind: 'car',
      assetName: 'Auto',
      costExclVat: 2000000,
      residualValue: 200000,
      purchaseDate: 1767225600,
      businessUsePct: 0.7,
      usefulLifeYears: 5,
      kiaEligible: 0,
      eiaEligible: 0,
      reinvestmentReserveApplied: 0,
      reserveGain: 0,
      catalogueValue: 3000000,
      zeroEmission: 'none',
      keepsTripLog: 0,
      vatDeductedOnPurchase: 420000,
    );
    const oldLaptop = v2.FixedAssetsData(
      id: 2,
      kind: 'general',
      assetName: 'Laptop',
      costExclVat: 200000,
      residualValue: 0,
      purchaseDate: 1767225600,
      businessUsePct: 0.8,
      usefulLifeYears: 5,
      kiaEligible: 1,
      eiaEligible: 0,
      reinvestmentReserveApplied: 0,
      reserveGain: 0,
      zeroEmission: 'none',
      keepsTripLog: 0,
      vatDeductedOnPurchase: 0,
    );
    // The purchase BTW was not recorded on a general asset, so none is
    // reclaimed until the user enters it: the cautious reading.
    const newCar = v3.FixedAssetsData(
      id: 1,
      kind: 'car',
      assetName: 'Auto',
      costExclVat: 2000000,
      purchaseVat: 'domestic',
      vatAmount: 420000,
      vatReclaimable: 1,
      vatToReclaim: 420000,
      residualValue: 200000,
      purchaseDate: 1767225600,
      businessUsePct: 1,
      usefulLifeYears: 5,
      kiaEligible: 0,
      eiaEligible: 0,
      reinvestmentReserveApplied: 0,
      reserveGain: 0,
      catalogueValue: 3000000,
      zeroEmission: 'none',
      keepsTripLog: 0,
    );
    const newLaptop = v3.FixedAssetsData(
      id: 2,
      kind: 'general',
      assetName: 'Laptop',
      costExclVat: 200000,
      purchaseVat: 'domestic',
      vatAmount: 0,
      vatReclaimable: 1,
      vatToReclaim: 0,
      residualValue: 0,
      purchaseDate: 1767225600,
      businessUsePct: 0.8,
      usefulLifeYears: 5,
      kiaEligible: 1,
      eiaEligible: 0,
      reinvestmentReserveApplied: 0,
      reserveGain: 0,
      zeroEmission: 'none',
      keepsTripLog: 0,
    );
    v2.ExpensesData oldExpense(int id, int? car, int reclaimable) =>
        v2.ExpensesData(
          id: id,
          date: 1767225600,
          supplier: 'Tankstation',
          description: 'Brandstof',
          category: 'travel',
          paperOriginalKept: 0,
          amountExclVat: 10000,
          vatRate: 'high',
          purchaseVat: 'domestic',
          vatAmount: 2100,
          totalInclVat: 12100,
          businessUsePct: 0.6,
          deductibleAmount: reclaimable == 1 ? 6000 : 7260,
          vatReclaimable: reclaimable,
          vatToReclaim: reclaimable == 1 ? 1260 : 0,
          carAssetId: car,
        );
    v3.ExpensesData newExpense(
      int id,
      int? car,
      int reclaimable, {
      required double share,
      required int deductible,
      required int vatBack,
    }) => v3.ExpensesData(
      id: id,
      date: 1767225600,
      supplier: 'Tankstation',
      description: 'Brandstof',
      category: 'travel',
      paperOriginalKept: 0,
      amountExclVat: 10000,
      vatRate: 'high',
      purchaseVat: 'domestic',
      vatAmount: 2100,
      totalInclVat: 12100,
      businessUsePct: share,
      deductibleAmount: deductible,
      vatReclaimable: reclaimable,
      vatToReclaim: vatBack,
      carAssetId: car,
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 3,
      createOld: v2.DatabaseAtV2.new,
      createNew: v3.DatabaseAtV3.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.fixedAssets, [oldCar, oldLaptop]);
        batch.insertAll(oldDb.expenses, [
          oldExpense(1, 1, 1),
          oldExpense(2, 1, 0),
          oldExpense(3, null, 1),
        ]);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.fixedAssets).get(), [
          newCar,
          newLaptop,
        ]);
        expect(await newDb.select(newDb.expenses).get(), [
          newExpense(1, 1, 1, share: 1, deductible: 10000, vatBack: 2100),
          newExpense(2, 1, 0, share: 1, deductible: 12100, vatBack: 0),
          // An expense without a car keeps its share and amounts.
          newExpense(3, null, 1, share: 0.6, deductible: 6000, vatBack: 1260),
        ]);
      },
    );
  });

  test('migration from v3 to v4 keeps the year inputs and starts without a '
      'job', () async {
    const oldInputs = v3.TaxYearInputsData(
      year: 2026,
      partnerHours: 900,
      hasSoVerklaring: 1,
      soStarter: 0,
      businessCeased: 0,
      stakingsaftrekUsedBefore: 0,
      disabilityBenefit: 0,
      disabilityStartersUsed: 0,
      unrealisedZelfstandigenaftrek: 50000,
      lossCarryForward: 100000,
    );
    const newInputs = v4.TaxYearInputsData(
      year: 2026,
      partnerHours: 900,
      hasSoVerklaring: 1,
      soStarter: 0,
      businessCeased: 0,
      stakingsaftrekUsedBefore: 0,
      disabilityBenefit: 0,
      disabilityStartersUsed: 0,
      unrealisedZelfstandigenaftrek: 50000,
      lossCarryForward: 100000,
      employed: 0,
      wages: 0,
      wageTaxWithheld: 0,
      zvwWages: 0,
      employmentHours: 0,
      notOndernemerBefore: 0,
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 3,
      newVersion: 4,
      createOld: v3.DatabaseAtV3.new,
      createNew: v4.DatabaseAtV4.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(oldDb.taxYearInputs, oldInputs);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.taxYearInputs).get(), [newInputs]);
      },
    );
  });

  test('migration from v4 to v5 makes a starter profile a starter in every '
      'year with records, and keeps the profile', () async {
    const oldProfile = v4.BusinessProfilesData(
      id: 1,
      name: 'Studio',
      vatNumber: 'NL000099998B57',
      kvkNumber: '12345678',
      address: 'Straat 2',
      iban: 'NL91ABNA0417164300',
      isStarter: 1,
    );
    const newProfile = v5.BusinessProfilesData(
      id: 1,
      name: 'Studio',
      vatNumber: 'NL000099998B57',
      kvkNumber: '12345678',
      address: 'Straat 2',
      iban: 'NL91ABNA0417164300',
    );
    const client = v4.ClientsData(
      id: 1,
      name: 'Voorbeeld BV',
      country: 'NL',
      address: 'Straat 1',
      wetDbaRisk: 'low',
      contractSigned: 1,
      isActive: 1,
      isMerchantOfRecord: 0,
    );
    // 15 June 2026, 12:00 UTC: in 2026 in every time zone.
    const invoice = v4.InvoicesData(
      id: 1,
      invoiceNumber: 'F-2026-001',
      invoiceType: 'invoice',
      invoiceDate: 1781524800,
      clientId: 1,
      vatTreatment: 'standard',
      selfBilled: 0,
      sellerName: 'Studio',
      sellerVatNumber: 'NL000099998B57',
      sellerKvkNumber: '12345678',
      sellerAddress: 'Straat 2',
      sellerIban: 'NL91ABNA0417164300',
      paymentTermDays: 14,
      status: 'sent',
      totalExclVat: 10000,
      totalVat: 2100,
      totalInclVat: 12100,
    );
    const newInputs = v5.TaxYearInputsData(
      year: 2026,
      partnerHours: 0,
      hasSoVerklaring: 0,
      soStarter: 0,
      businessCeased: 0,
      stakingsaftrekUsedBefore: 0,
      disabilityBenefit: 0,
      disabilityStartersUsed: 0,
      unrealisedZelfstandigenaftrek: 0,
      lossCarryForward: 0,
      employed: 0,
      wages: 0,
      wageTaxWithheld: 0,
      zvwWages: 0,
      employmentHours: 0,
      notOndernemerBefore: 1,
      isStarter: 1,
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 4,
      newVersion: 5,
      createOld: v4.DatabaseAtV4.new,
      createNew: v5.DatabaseAtV5.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(oldDb.businessProfiles, oldProfile);
        batch.insert(oldDb.clients, client);
        batch.insert(oldDb.invoices, invoice);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.businessProfiles).get(), [newProfile]);
        expect(await newDb.select(newDb.taxYearInputs).get(), [newInputs]);
      },
    );
  });

  test('migration from v5 to v6 keeps every client a business', () async {
    const oldClient = v5.ClientsData(
      id: 1,
      name: 'Voorbeeld BV',
      country: 'DE',
      vatNumber: 'DE123456789',
      address: 'Strasse 1',
      wetDbaRisk: 'low',
      contractSigned: 0,
      isActive: 1,
      isMerchantOfRecord: 0,
    );
    const newClient = v6.ClientsData(
      id: 1,
      name: 'Voorbeeld BV',
      country: 'DE',
      vatNumber: 'DE123456789',
      address: 'Strasse 1',
      wetDbaRisk: 'low',
      contractSigned: 0,
      isActive: 1,
      isMerchantOfRecord: 0,
      isConsumer: 0,
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 5,
      newVersion: 6,
      createOld: v5.DatabaseAtV5.new,
      createNew: v6.DatabaseAtV6.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(oldDb.clients, oldClient);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.clients).get(), [newClient]);
      },
    );
  });

  test(
    'migration from v6 to v7 keeps expenses, without a gift recipient',
    () async {
      // 15 June 2026, 12:00 UTC, in seconds.
      const date = 1781524800;
      const oldExpense = v6.ExpensesData(
        id: 1,
        date: date,
        supplier: 'S',
        description: 'D',
        category: 'marketing',
        paperOriginalKept: 0,
        amountExclVat: 10000,
        vatRate: 'high',
        purchaseVat: 'domestic',
        vatAmount: 2100,
        totalInclVat: 12100,
        businessUsePct: 1,
        deductibleAmount: 10000,
        vatReclaimable: 1,
        vatToReclaim: 2100,
      );
      const newExpense = v7.ExpensesData(
        id: 1,
        date: date,
        supplier: 'S',
        description: 'D',
        category: 'marketing',
        paperOriginalKept: 0,
        amountExclVat: 10000,
        vatRate: 'high',
        purchaseVat: 'domestic',
        vatAmount: 2100,
        totalInclVat: 12100,
        businessUsePct: 1,
        deductibleAmount: 10000,
        vatReclaimable: 1,
        vatToReclaim: 2100,
      );

      await verifier.testWithDataIntegrity(
        oldVersion: 6,
        newVersion: 7,
        createOld: v6.DatabaseAtV6.new,
        createNew: v7.DatabaseAtV7.new,
        openTestedDatabase: AppDatabase.new,
        createItems: (batch, oldDb) {
          batch.insert(oldDb.expenses, oldExpense);
        },
        validateItems: (newDb) async {
          expect(await newDb.select(newDb.expenses).get(), [newExpense]);
        },
      );
    },
  );

  test('migration from v7 to v8 keeps hours as the user\'s own and the '
      'partner unpaid', () async {
    // 15 June 2026, 12:00 UTC, in seconds.
    const date = 1781524800;
    const oldHours = v7.HourEntriesData(
      id: 1,
      date: date,
      description: 'Ontwerp',
      workType: 'billable',
      hours: 6,
    );
    const newHours = v8.HourEntriesData(
      id: 1,
      date: date,
      description: 'Ontwerp',
      workType: 'billable',
      hours: 6,
      byPartner: 0,
    );
    const oldInputs = v7.TaxYearInputsData(
      year: 2026,
      partnerHours: 600,
      hasSoVerklaring: 0,
      soStarter: 0,
      businessCeased: 0,
      stakingsaftrekUsedBefore: 0,
      disabilityBenefit: 0,
      disabilityStartersUsed: 0,
      unrealisedZelfstandigenaftrek: 0,
      lossCarryForward: 0,
      employed: 0,
      wages: 0,
      wageTaxWithheld: 0,
      zvwWages: 0,
      employmentHours: 0,
      notOndernemerBefore: 0,
      isStarter: 0,
    );
    const newInputs = v8.TaxYearInputsData(
      year: 2026,
      partnerHours: 600,
      partnerPay: 0,
      hasSoVerklaring: 0,
      soStarter: 0,
      businessCeased: 0,
      stakingsaftrekUsedBefore: 0,
      disabilityBenefit: 0,
      disabilityStartersUsed: 0,
      unrealisedZelfstandigenaftrek: 0,
      lossCarryForward: 0,
      employed: 0,
      wages: 0,
      wageTaxWithheld: 0,
      zvwWages: 0,
      employmentHours: 0,
      notOndernemerBefore: 0,
      isStarter: 0,
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 7,
      newVersion: 8,
      createOld: v7.DatabaseAtV7.new,
      createNew: v8.DatabaseAtV8.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(oldDb.hourEntries, oldHours);
        batch.insert(oldDb.taxYearInputs, oldInputs);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.hourEntries).get(), [newHours]);
        expect(await newDb.select(newDb.taxYearInputs).get(), [newInputs]);
      },
    );
  });

  test('migration from v8 to v9 links hours to the one client named in '
      'their client / project', () async {
    const date = 1781524800;
    const clients = [
      v8.ClientsData(
        id: 1,
        name: 'Voorbeeld BV',
        country: 'NL',
        address: 'A',
        wetDbaRisk: 'low',
        contractSigned: 0,
        isActive: 1,
        isMerchantOfRecord: 0,
        isConsumer: 0,
      ),
      v8.ClientsData(
        id: 2,
        name: 'Dubbel',
        country: 'NL',
        address: 'A',
        wetDbaRisk: 'low',
        contractSigned: 0,
        isActive: 1,
        isMerchantOfRecord: 0,
        isConsumer: 0,
      ),
      v8.ClientsData(
        id: 3,
        name: 'dubbel ',
        country: 'NL',
        address: 'A',
        wetDbaRisk: 'low',
        contractSigned: 0,
        isActive: 1,
        isMerchantOfRecord: 0,
        isConsumer: 0,
      ),
    ];
    v8.HourEntriesData hour(int id, String? project) => v8.HourEntriesData(
      id: id,
      date: date,
      description: 'Werk',
      workType: 'billable',
      hours: 2,
      clientProject: project,
      byPartner: 0,
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 8,
      newVersion: 9,
      createOld: v8.DatabaseAtV8.new,
      createNew: v9.DatabaseAtV9.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.clients, clients);
        batch.insertAll(oldDb.hourEntries, [
          hour(1, ' voorbeeld bv'),
          hour(2, 'Dubbel'),
          hour(3, 'Iets anders'),
          hour(4, null),
        ]);
      },
      validateItems: (newDb) async {
        final rows = await newDb.select(newDb.hourEntries).get();
        expect(rows.map((h) => h.clientId).toList(), [1, null, null, null]);
      },
    );
  });
}
