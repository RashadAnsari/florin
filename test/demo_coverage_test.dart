import 'dart:io';

import 'package:drift/native.dart';
import 'package:florin/db/database.dart';
import 'package:florin/services/car_service.dart';
import 'package:florin/services/domain.dart';
import 'package:florin/services/gift_service.dart';
import 'package:florin/services/kor_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:florin/services/vat_service.dart';
import 'package:florin/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tool/create_demo_database.dart';

/// The demo database holds every kind of record and every option, so every
/// screen and rule can be tried with it.
void main() {
  late AppDatabase db;
  late Directory folder;

  setUpAll(() async {
    db = AppDatabase(NativeDatabase.memory());
    folder = await Directory.systemTemp.createTemp('florin_demo');
    await fillDemo(db, folder: folder.path);
  });

  tearDownAll(() async {
    await db.close();
    await folder.delete(recursive: true);
  });

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
    // A domestic reverse charge invoice states the rate of its lines.
    final reverse = invoices
        .where((i) => i.vatTreatment == VatTreatment.reverseChargeNl)
        .map((i) => i.id)
        .toSet();
    expect(
      lines.any(
        (l) =>
            reverse.contains(l.invoiceId) &&
            VatTreatment.reverseChargeNl.lineRates.contains(l.vatRate),
      ),
      isTrue,
    );
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
    expect(clients.any((c) => c.isEuConsumerAbroad), isTrue);
    // Services taxed outside the EU for a private person there (Wet OB 1968
    // art. 6i).
    final consumersOutsideEu = {
      for (final c in clients)
        if (c.isConsumer && !isEuCountry(c.country)) c.id,
    };
    expect(
      invoices.any(
        (i) =>
            consumersOutsideEu.contains(i.clientId) &&
            i.vatTreatment == VatTreatment.servicesOutsideEu,
      ),
      isTrue,
    );
    expect(invoices.any((i) => i.selfBilled), isTrue);
    final profile = await db.select(db.businessProfiles).getSingle();
    expect(profile.korStart, isNotNull);
    final receipts = await db.select(db.receipts).get();
    expect(
      receipts.map((r) => r.type).toSet(),
      containsAll([ReceiptType.pdf, ReceiptType.png, ReceiptType.xml]),
    );
    expect(receipts.any((r) => r.assetId != null), isTrue);
    expect(receipts.any((r) => r.invoiceId != null), isTrue);
    expect(receipts.any((r) => r.removedAt != null), isTrue);
    expect(assets.any((a) => a.reserveGain), isTrue);
    expect(assets.any((a) => a.reinvestmentReserveApplied > 0), isTrue);
    expect(assets.any((a) => a.investmentDeductionReceived != null), isTrue);
    // Purchase BTW reclaimed, kept as cost under the KOR, and entered for a
    // year without rules; a sale with BTW, one the KOR exempts, and one
    // invoiced in Florin.
    expect(assets.any((a) => a.vatToReclaim > 0), isTrue);
    expect(assets.any((a) => !a.vatReclaimable && a.vatAmount > 0), isTrue);
    expect(assets.any((a) => a.vatRate == null && a.vatAmount > 0), isTrue);
    expect(assets.any((a) => a.disposalVatAmount != null), isTrue);
    expect(
      assets.any(
        (a) =>
            a.disposalDate != null &&
            a.disposalInvoiceId == null &&
            a.disposalVatRate == null,
      ),
      isTrue,
    );
    expect(assets.any((a) => a.disposalInvoiceId != null), isTrue);
  });

  test('an EU service is reported in the quarter it was supplied, before '
      'the quarter of its invoice', () async {
    final invoices = await db.select(db.invoices).get();
    expect(
      invoices.where(
        (i) =>
            i.vatTreatment == VatTreatment.euServices &&
            quarterOf(i.vatDate) < quarterOf(i.invoiceDate),
      ),
      isNotEmpty,
    );
  });

  test('a demo car with a trip log has a complete one', () async {
    final assets = await db.select(db.fixedAssets).get();
    final trips = await db.select(db.mileageTrips).get();
    final logged = assets.where((a) => a.keepsTripLog).toList();
    expect(logged, isNotEmpty);
    for (final car in logged) {
      final year = trips.firstWhere((t) => t.carAssetId == car.id).date.year;
      expect(CarService.hasCompleteTripLog(car, trips, year), isTrue);
    }
  });

  /// The demo's 2026 BTW returns as the app computes them.
  Future<List<(VatPeriod, VatReturnResult)>> returns2026() async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
        databaseProvider.overrideWithValue(db),
      ],
    );
    addTearDown(container.dispose);
    final year = container.listen(vatYearProvider(2026), (_, _) {});
    for (var i = 0; i < 300 && !year.read().hasValue; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
    return year.read().requireValue;
  }

  test(
    'a sale under the KOR settles its herziening in the return of the '
    'sale\'s period (Uitvoeringsbeschikking OB 1968 art. 13a lid 2)',
    () async {
      final periods = await returns2026();
      final q1 = periods.firstWhere((p) => p.$1.number == 1).$2;
      expect(q1.vatRevisionTotal, greaterThan(0));
      expect(q1.duty, ReturnDuty.incidental);
      final sold = q1.vatRevision.keys.single;
      expect(quarterOf(sold.disposalDate!), 1);
      expect(periods.last.$2.vatRevision.keys, isNot(contains(sold)));
    },
  );

  test('the demo charges BTW on a car\'s private use in a KOR year and says '
      'so, with the base of 1d from the trip log (Wet OB 1968 art. 4 lid 2 a, '
      'art. 25a lid 1)', () async {
    final q4 = (await returns2026()).last.$2;
    expect(q4.vat1d, greaterThan(0));
    expect(q4.privateUseUnderKor, isTrue);
    expect(q4.base1d, greaterThan(0));
  });

  test('a gift without BTW stays out of the threshold (Belastingdienst, '
      'drempelbedrag giften)', () async {
    final gifts = (await db.select(db.expenses).get())
        .where((e) => e.category == ExpenseCategory.gifts)
        .toList();
    final threshold = taxRulesFor(2026)!.buaGiftThreshold;
    final withoutVat = gifts.firstWhere((e) => e.vatAmount == 0);
    final key = GiftService.recipientKey(withoutVat.giftRecipient!);
    final all = gifts
        .where((e) => GiftService.recipientKey(e.giftRecipient!) == key)
        .fold(0, (s, e) => s + e.amountExclVat);
    expect(all, greaterThan(threshold));
    expect(
      GiftService.totalsByRecipient(gifts, 2026)[key],
      lessThanOrEqualTo(threshold),
    );
  });

  test('the demo\'s goods to EU businesses pass the limit in the second month '
      'of Q3, so the ICP-opgaaf covers July and August, then months (Wet OB '
      '1968 art. 37a lid 3)', () async {
    final invoices = await db.select(db.invoices).get();
    final kor = KorService.status(
      await db.select(db.businessProfiles).getSingle(),
      invoices,
    );
    final periods = VatService.icpPeriods(
      invoices,
      kor,
      2026,
      taxRulesFor(2026)!,
    );
    expect(periods.map((p) => p.code), [
      'Q1',
      'Q2',
      'M07-M08',
      'M09',
      'M10',
      'M11',
      'M12',
    ]);
    expect(periods[2].due, DateTime(2026, 9, 30));
  });

  test('the demo logs the partner\'s hours per day', () async {
    final hours = await db.select(db.hourEntries).get();
    expect(hours.any((h) => h.byPartner), isTrue);
  });

  test(
    'the demo\'s equity comparison closes on its estimated profit',
    () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
          databaseProvider.overrideWithValue(db),
        ],
      );
      addTearDown(container.dispose);
      final balance = container.listen(balanceSheetProvider(2026), (_, _) {});
      final estimate = container.listen(taxEstimateProvider(2026), (_, _) {});
      for (
        var i = 0;
        i < 300 && !(balance.read().hasValue && estimate.read().hasValue);
        i++
      ) {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }
      expect(
        balance.read().requireValue.equityProfit,
        estimate.read().requireValue.comparableProfit,
      );
    },
  );
}
