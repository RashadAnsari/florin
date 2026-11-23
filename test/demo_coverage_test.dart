import 'package:drift/native.dart';
import 'package:florin/db/database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tool/create_demo_database.dart';

/// The demo database holds every kind of record and every option, so every
/// screen and rule can be tried with it.
void main() {
  late AppDatabase db;

  setUpAll(() async {
    db = AppDatabase(NativeDatabase.memory());
    await fillDemo(db);
  });

  tearDownAll(() => db.close());

  test('every table has rows', () async {
    for (final table in db.allTables) {
      final count = await db
          .customSelect('SELECT COUNT(*) AS c FROM ${table.actualTableName}')
          .getSingle();
      expect(
        count.read<int>('c'),
        greaterThan(0),
        reason: table.actualTableName,
      );
    }
  });

  test('every enum value is used', () async {
    final invoices = await db.select(db.invoices).get();
    final lines = await db.select(db.invoiceLines).get();
    final expenses = await db.select(db.expenses).get();
    final assets = await db.select(db.fixedAssets).get();
    final hours = await db.select(db.hourEntries).get();
    final trips = await db.select(db.mileageTrips).get();
    final clients = await db.select(db.clients).get();

    expect(
      invoices.map((i) => i.invoiceType).toSet(),
      InvoiceType.values.toSet(),
    );
    expect(invoices.map((i) => i.status).toSet(), InvoiceStatus.values.toSet());
    expect(
      invoices.map((i) => i.vatTreatment).toSet(),
      VatTreatment.values.toSet(),
    );
    expect(lines.map((l) => l.vatRate).toSet(), VatRate.values.toSet());
    expect(expenses.map((e) => e.vatRate).toSet(), VatRate.values.toSet());
    expect(
      expenses.map((e) => e.category).toSet(),
      ExpenseCategory.values.toSet(),
    );
    expect(
      expenses.map((e) => e.purchaseVat).toSet(),
      PurchaseVat.values.toSet(),
    );
    expect(assets.map((a) => a.kind).toSet(), AssetKind.values.toSet());
    expect(
      assets.map((a) => a.zeroEmission).toSet(),
      ZeroEmission.values.toSet(),
    );
    expect(
      assets.map((a) => a.miaCategory).whereType<MiaCategory>().isNotEmpty,
      isTrue,
    );
    expect(hours.map((h) => h.workType).toSet(), WorkType.values.toSet());
    expect(trips.map((t) => t.tripType).toSet(), TripType.values.toSet());
    expect(clients.map((c) => c.wetDbaRisk).toSet(), WetDbaRisk.values.toSet());
    expect(clients.any((c) => !c.isActive), isTrue);
    expect(clients.any((c) => c.isMerchantOfRecord), isTrue);
    expect(invoices.any((i) => i.selfBilled), isTrue);
    final profile = await db.select(db.businessProfiles).getSingle();
    expect(profile.korStart, isNotNull);
    expect(assets.any((a) => a.reserveGain), isTrue);
    expect(assets.any((a) => a.reinvestmentReserveApplied > 0), isTrue);
    expect(assets.any((a) => a.investmentDeductionReceived != null), isTrue);
  });
}
