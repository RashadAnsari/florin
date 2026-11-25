import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'database.steps.dart';
import 'enums.dart';
import 'tables/business_profile.dart';
import 'tables/clients.dart';
import 'tables/expenses.dart';
import 'tables/fixed_assets.dart';
import 'tables/hour_entries.dart';
import 'tables/invoice_lines.dart';
import 'tables/invoices.dart';
import 'tables/mileage_trips.dart';
import 'tables/pension.dart';
import 'tables/receipts.dart';
import 'tables/tax_year_inputs.dart';
import 'tables/vat_filed_figures.dart';
import 'tables/vat_returns.dart';

export 'enums.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    BusinessProfiles,
    Clients,
    Invoices,
    InvoiceLines,
    Expenses,
    HourEntries,
    MileageTrips,
    FixedAssets,
    PensionEntries,
    VatReturns,
    TaxYearInputs,
    Receipts,
    VatFiledFigures,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  factory AppDatabase.open(String path) {
    final file = File(path);
    file.parent.createSync(recursive: true);
    return AppDatabase(NativeDatabase.createInBackground(file));
  }

  /// Bump with every schema change and run `make migration`; see AGENTS.md.
  @override
  int get schemaVersion => 12;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      await customStatement('PRAGMA foreign_keys = OFF');
      await transaction(
        () => stepByStep(
          from1To2: (m, schema) async {
            await m.addColumn(
              schema.clients,
              schema.clients.isMerchantOfRecord,
            );
            await m.addColumn(schema.invoices, schema.invoices.selfBilled);
            await m.addColumn(
              schema.businessProfiles,
              schema.businessProfiles.korStart,
            );
            await m.addColumn(
              schema.businessProfiles,
              schema.businessProfiles.korEnd,
            );
            await m.renameColumn(
              schema.expenses,
              'receipt_attached',
              schema.expenses.paperOriginalKept,
            );
            await m.createTable(schema.receipts);
          },
          from2To3: (m, schema) async {
            final assets = schema.fixedAssets;
            // A car's deducted purchase BTW becomes its purchase BTW. A car
            // counts in full: the bijtelling and the BTW on private use
            // correct its private use (docs/legal.md).
            await m.alterTable(
              TableMigration(
                assets,
                columnTransformer: {
                  assets.vatAmount: const CustomExpression<int>(
                    'vat_deducted_on_purchase',
                  ),
                  assets.vatToReclaim: const CustomExpression<int>(
                    'vat_deducted_on_purchase',
                  ),
                  assets.businessUsePct: const CustomExpression<double>(
                    "CASE WHEN kind = 'car' THEN 1.0 ELSE business_use_pct END",
                  ),
                },
                newColumns: [
                  assets.vatRate,
                  assets.purchaseVat,
                  assets.vatAmount,
                  assets.vatReclaimable,
                  assets.vatToReclaim,
                  assets.disposalInvoiceId,
                  assets.disposalVatRate,
                  assets.disposalVatAmount,
                ],
              ),
            );
            // Costs linked to a business car count in full for the same
            // reason; the amounts follow PurchaseMath with a share of 1.
            await customStatement(
              'UPDATE expenses SET business_use_pct = 1.0, '
              'deductible_amount = amount_excl_vat + '
              'CASE WHEN vat_reclaimable = 1 THEN 0 ELSE vat_amount END, '
              'vat_to_reclaim = '
              'CASE WHEN vat_reclaimable = 1 THEN vat_amount ELSE 0 END '
              'WHERE car_asset_id IS NOT NULL',
            );
          },
          from3To4: (m, schema) async {
            final inputs = schema.taxYearInputs;
            await m.addColumn(inputs, inputs.employed);
            await m.addColumn(inputs, inputs.wages);
            await m.addColumn(inputs, inputs.wageTaxWithheld);
            await m.addColumn(inputs, inputs.zvwWages);
            await m.addColumn(inputs, inputs.employmentHours);
            await m.addColumn(inputs, inputs.notOndernemerBefore);
          },
          from4To5: (m, schema) async {
            final inputs = schema.taxYearInputs;
            await m.addColumn(inputs, inputs.isStarter);
            // The startersaftrek is decided per year (Wet IB 2001 art. 3.76
            // lid 3). A profile marked as a starter marks every year with
            // records; eligibility includes not having been an ondernemer.
            await customStatement('''
              INSERT INTO tax_year_inputs (year, not_ondernemer_before, is_starter)
              SELECT y, 1, 1 FROM (
                SELECT CAST(strftime('%Y', invoice_date, 'unixepoch', 'localtime') AS INTEGER) AS y FROM invoices
                UNION SELECT CAST(strftime('%Y', date, 'unixepoch', 'localtime') AS INTEGER) FROM expenses
                UNION SELECT CAST(strftime('%Y', date, 'unixepoch', 'localtime') AS INTEGER) FROM hour_entries
                UNION SELECT year FROM tax_year_inputs
              )
              WHERE EXISTS (SELECT 1 FROM business_profiles WHERE is_starter = 1)
              ON CONFLICT (year) DO UPDATE SET not_ondernemer_before = 1, is_starter = 1
            ''');
            await m.alterTable(TableMigration(schema.businessProfiles));
          },
          from5To6: (m, schema) async {
            await m.addColumn(schema.clients, schema.clients.isConsumer);
          },
          from6To7: (m, schema) async {
            await m.addColumn(schema.expenses, schema.expenses.giftRecipient);
          },
          from7To8: (m, schema) async {
            await m.addColumn(schema.hourEntries, schema.hourEntries.byPartner);
            await m.addColumn(
              schema.taxYearInputs,
              schema.taxYearInputs.partnerPay,
            );
          },
          from8To9: (m, schema) async {
            await m.addColumn(schema.hourEntries, schema.hourEntries.clientId);
            // Hours whose client / project text is exactly one client's name
            // are linked to that client.
            await customStatement('''
              UPDATE hour_entries SET client_id = (
                SELECT c.id FROM clients c
                WHERE lower(trim(c.name)) = lower(trim(hour_entries.client_project))
              )
              WHERE client_project IS NOT NULL AND (
                SELECT COUNT(*) FROM clients c
                WHERE lower(trim(c.name)) = lower(trim(hour_entries.client_project))
              ) = 1
            ''');
          },
          from9To10: (m, schema) async {
            await m.addColumn(
              schema.taxYearInputs,
              schema.taxYearInputs.vatFilingPeriod,
            );
            // Every stored return was a quarter's.
            final returns = schema.vatReturns;
            await m.alterTable(
              TableMigration(
                returns,
                columnTransformer: {
                  returns.number: const CustomExpression<int>('quarter'),
                },
                newColumns: [returns.kind, returns.number],
              ),
            );
          },
          from10To11: (m, schema) async {
            await m.createTable(schema.vatFiledFigures);
          },
          from11To12: (m, schema) async {
            final inputs = schema.taxYearInputs;
            await m.addColumn(inputs, inputs.equityStart);
            await m.addColumn(inputs, inputs.bankBalance);
            await m.addColumn(inputs, inputs.cashBalance);
            await m.addColumn(inputs, inputs.unpaidPurchases);
            await m.addColumn(inputs, inputs.longTermLoans);
            await m.addColumn(inputs, inputs.privateWithdrawals);
            await m.addColumn(inputs, inputs.privateDeposits);
          },
        )(m, from, to),
      );
      final broken = await customSelect('PRAGMA foreign_key_check').get();
      if (broken.isNotEmpty) {
        throw StateError('Foreign key check failed after migrating to $to');
      }
    },
    beforeOpen: (details) => customStatement('PRAGMA foreign_keys = ON'),
  );
}

extension DateColumnRange on Expression<DateTime> {
  Expression<bool> inYear(int year) =>
      isBiggerOrEqualValue(DateTime(year)) &
      isSmallerThanValue(DateTime(year + 1));
}

/// Insert-or-update and delete for any table, keyed by primary key.
mixin Crud<T extends Table, D extends DataClass>
    on DatabaseAccessor<AppDatabase> {
  TableInfo<T, D> get table;

  Future<int> save(Insertable<D> row) =>
      into(table).insertOnConflictUpdate(row);

  Future<int> remove(Insertable<D> row) => delete(table).delete(row);
}
