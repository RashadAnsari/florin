import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'tables/tax_params.dart';
import 'tables/clients.dart';
import 'tables/invoices.dart';
import 'tables/invoice_lines.dart';
import 'tables/expenses.dart';
import 'tables/hour_entries.dart';
import 'tables/mileage_trips.dart';
import 'tables/fixed_assets.dart';
import 'tables/pension.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    TaxParams,
    Clients,
    Invoices,
    InvoiceLines,
    Expenses,
    HourEntries,
    MileageTrips,
    FixedAssets,
    PensionEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  static AppDatabase connect(String path) {
    final file = File(path);
    file.parent.createSync(recursive: true);
    return AppDatabase(NativeDatabase(file));
  }

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.alterTable(
          TableMigration(
            clients,
            columnTransformer: {
              clients.address: const CustomExpression("COALESCE(address, '')"),
            },
          ),
        );
      }
      if (from < 3) {
        await m.addColumn(invoices, invoices.refundDate);
      }
      if (from < 4) {
        await m.addColumn(invoices, invoices.sellerIban);
      }
      if (from < 5) {
        await m.alterTable(TableMigration(invoices));
      }
      if (from < 6) {
        await m.addColumn(taxParams, taxParams.kiaDecreaseRate);
        await m.addColumn(taxParams, taxParams.urencriteriumThreshold);
      }
    },
  );

  Future<void> seedIfEmpty() async {
    final existing = await (select(
      taxParams,
    )..where((t) => t.year.equals(2026))).getSingleOrNull();
    if (existing != null) return;
    await into(taxParams).insert(
      const TaxParamsCompanion(
        year: Value(2026),
        zelfstandigenaftrek: Value(-120000),
        startersaftrek: Value(-212300),
        mkbWinstvrijstellingPct: Value(0.127),
        bracket1Rate: Value(0.3575),
        bracket1Threshold: Value(3888300),
        bracket2Rate: Value(0.3756),
        bracket2Threshold: Value(7842600),
        bracket3Rate: Value(0.495),
        algHeffingskortingMax: Value(311500),
        arbeidskortingMax: Value(568500),
        zvwRate: Value(0.0485),
        zvwMax: Value(385100),
        mixedCostsThreshold: Value(570000),
        mixedCosts80Pct: Value(0.8),
        jaarruimtePct: Value(0.30),
        jaarruimteMax: Value(3558900),
        aowFranchise: Value(1917200),
        reserveringsruimteMax: Value(4275300),
        factorAMultiplier: Value(6.27),
        kiaLowerThreshold: Value(290100),
        kiaUpperThreshold: Value(7168300),
        kiaFlatThreshold: Value(13274600),
        kiaRate: Value(0.28),
        kiaFlatAmount: Value(2007200),
        kiaDecreaseRate: Value(0.0756),
        urencriteriumThreshold: Value(1225),
        mileageRatePerKm: Value(0.23),
        korThreshold: Value(2000000),
        ossThreshold: Value(1000000),
        belastingrentePct: Value(0.05),
      ),
    );
  }
}
