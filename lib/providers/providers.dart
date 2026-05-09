import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/database.dart';
import '../db/daos/client_dao.dart';
import '../db/daos/invoice_dao.dart';
import '../db/daos/expense_dao.dart';
import '../db/daos/hour_dao.dart';
import '../db/daos/mileage_dao.dart';
import '../db/daos/asset_dao.dart';
import '../db/daos/tax_params_dao.dart';

class DbPathNotifier extends ChangeNotifier {
  static const _key = 'db_path';
  final SharedPreferences _prefs;

  DbPathNotifier(this._prefs);

  String? get path => _prefs.getString(_key);

  Future<void> setPath(String newPath) async {
    await _prefs.setString(_key, newPath);
    notifyListeners();
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final dbPathNotifierProvider = ChangeNotifierProvider<DbPathNotifier>((ref) {
  return DbPathNotifier(ref.watch(sharedPreferencesProvider));
});

final databaseProvider = Provider<AppDatabase>((ref) {
  final notifier = ref.watch(dbPathNotifierProvider);
  final path = notifier.path;
  if (path == null) throw StateError('No database path configured');
  final db = AppDatabase.connect(path);
  ref.onDispose(db.close);
  return db;
});

final clientDaoProvider = Provider<ClientDao>((ref) {
  return ClientDao(ref.watch(databaseProvider));
});

final invoiceDaoProvider = Provider<InvoiceDao>((ref) {
  return InvoiceDao(ref.watch(databaseProvider));
});

final expenseDaoProvider = Provider<ExpenseDao>((ref) {
  return ExpenseDao(ref.watch(databaseProvider));
});

final hourDaoProvider = Provider<HourDao>((ref) {
  return HourDao(ref.watch(databaseProvider));
});

final mileageDaoProvider = Provider<MileageDao>((ref) {
  return MileageDao(ref.watch(databaseProvider));
});

final assetDaoProvider = Provider<AssetDao>((ref) {
  return AssetDao(ref.watch(databaseProvider));
});

final taxParamsDaoProvider = Provider<TaxParamsDao>((ref) {
  return TaxParamsDao(ref.watch(databaseProvider));
});

final fiscalYearProvider = StateProvider<int>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getInt('fiscal_year') ?? DateTime.now().year;
});

// ── Phase 2 stream providers ──────────────────────────────────────────────────

final clientsStreamProvider = StreamProvider<List<Client>>((ref) {
  return ref.watch(clientDaoProvider).watchAllActive();
});

final invoicesStreamProvider = StreamProvider.family<List<Invoice>, int>((
  ref,
  year,
) {
  return ref.watch(invoiceDaoProvider).watchByYear(year);
});

final expensesStreamProvider = StreamProvider.family<List<Expense>, int>((
  ref,
  year,
) {
  return ref.watch(expenseDaoProvider).watchByYear(year);
});

final invoiceLinesStreamProvider =
    StreamProvider.family<List<InvoiceLine>, int>((ref, invoiceId) {
      return ref.watch(invoiceDaoProvider).watchLinesForInvoice(invoiceId);
    });

final hourEntriesStreamProvider = StreamProvider.family<List<HourEntry>, int>((
  ref,
  year,
) {
  return ref.watch(hourDaoProvider).watchByYear(year);
});

final mileageTripsStreamProvider =
    StreamProvider.family<List<MileageTrip>, int>((ref, year) {
      return ref.watch(mileageDaoProvider).watchByYear(year);
    });

final assetsStreamProvider = StreamProvider.family<List<FixedAsset>, int>((
  ref,
  year,
) {
  return ref.watch(assetDaoProvider).watchByYear(year);
});

final taxParamsStreamProvider = StreamProvider.family<TaxParam?, int>((
  ref,
  year,
) {
  return ref.watch(taxParamsDaoProvider).watchByYear(year);
});

final pensionStreamProvider = StreamProvider.family<PensionEntry?, int>((
  ref,
  year,
) {
  return ref.watch(taxParamsDaoProvider).watchPensionByYear(year);
});
