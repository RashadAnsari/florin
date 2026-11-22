import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

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
import 'tables/tax_year_inputs.dart';
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
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
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
