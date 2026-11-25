import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/prefs_keys.dart';
import '../db/daos/asset_dao.dart';
import '../db/daos/business_profile_dao.dart';
import '../db/daos/client_dao.dart';
import '../db/daos/expense_dao.dart';
import '../db/daos/hour_dao.dart';
import '../db/daos/invoice_dao.dart';
import '../db/daos/mileage_dao.dart';
import '../db/daos/pension_dao.dart';
import '../db/daos/tax_year_inputs_dao.dart';
import '../db/daos/vat_filed_figures_dao.dart';
import '../db/daos/vat_return_dao.dart';
import '../db/database.dart';
import '../services/domain.dart';
import '../services/gift_service.dart';
import '../services/asset_service.dart';
import '../services/car_service.dart';
import '../services/pension_service.dart';
import '../services/tax_rules/tax_year_rules.dart';
import '../services/kor_service.dart';
import '../services/receipt_service.dart';
import '../db/daos/receipt_dao.dart';
import '../services/tax_service.dart';
import '../services/vat_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Overridden in main()'),
);

class DbPathNotifier extends ChangeNotifier {
  final SharedPreferences _prefs;

  DbPathNotifier(this._prefs);

  String? get path => _prefs.getString(PrefsKeys.dbPath);

  Future<void> setPath(String newPath) async {
    await _prefs.setString(PrefsKeys.dbPath, newPath);
    notifyListeners();
  }
}

final dbPathNotifierProvider = ChangeNotifierProvider<DbPathNotifier>(
  (ref) => DbPathNotifier(ref.watch(sharedPreferencesProvider)),
);

final databaseProvider = Provider<AppDatabase>((ref) {
  final path = ref.watch(dbPathNotifierProvider).path;
  if (path == null) throw StateError('No database path configured');
  final db = AppDatabase.open(path);
  ref.onDispose(db.close);
  return db;
});

final businessProfileDaoProvider = Provider(
  (ref) => BusinessProfileDao(ref.watch(databaseProvider)),
);
final clientDaoProvider = Provider(
  (ref) => ClientDao(ref.watch(databaseProvider)),
);
final invoiceDaoProvider = Provider(
  (ref) => InvoiceDao(ref.watch(databaseProvider)),
);
final expenseDaoProvider = Provider(
  (ref) => ExpenseDao(ref.watch(databaseProvider)),
);
final hourDaoProvider = Provider((ref) => HourDao(ref.watch(databaseProvider)));
final mileageDaoProvider = Provider(
  (ref) => MileageDao(ref.watch(databaseProvider)),
);
final assetDaoProvider = Provider(
  (ref) => AssetDao(ref.watch(databaseProvider)),
);
final pensionDaoProvider = Provider(
  (ref) => PensionDao(ref.watch(databaseProvider)),
);
final taxYearInputsDaoProvider = Provider(
  (ref) => TaxYearInputsDao(ref.watch(databaseProvider)),
);
final vatReturnDaoProvider = Provider(
  (ref) => VatReturnDao(ref.watch(databaseProvider)),
);
final vatFiledFiguresDaoProvider = Provider(
  (ref) => VatFiledFiguresDao(ref.watch(databaseProvider)),
);

/// Receipt files next to the open database and their rows.
final receiptServiceProvider = Provider((ref) {
  final path = ref.watch(dbPathNotifierProvider).path;
  if (path == null) throw StateError('No database path configured');
  return ReceiptService(
    ReceiptDao(ref.watch(databaseProvider)),
    ReceiptStore.forDatabase(path),
  );
});

/// The receipts of one expense, asset or invoice.
final receiptsProvider = StreamProvider.family<List<Receipt>, ReceiptOwner>(
  (ref, owner) => ref.watch(receiptServiceProvider).dao.watchFor(owner),
);

/// Every receipt in use, for the lists that mark which records have files.
final allReceiptsProvider = StreamProvider(
  (ref) => ref.watch(receiptServiceProvider).dao.watchInUse(),
);

/// The receipts the user removed from their records; Florin keeps them.
final removedReceiptsProvider = StreamProvider(
  (ref) => ref.watch(receiptServiceProvider).dao.watchRemoved(),
);

/// The selected year, always one with verified tax rules.
final fiscalYearProvider = StateProvider<int>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final stored = prefs.getInt(PrefsKeys.fiscalYear);
  return stored != null && taxYears.containsKey(stored)
      ? stored
      : nearestSupportedYear(DateTime.now().year);
});

final businessProfileProvider = StreamProvider(
  (ref) => ref.watch(businessProfileDaoProvider).watch(),
);
final clientsProvider = StreamProvider(
  (ref) => ref.watch(clientDaoProvider).watchAll(),
);
final allInvoicesProvider = StreamProvider(
  (ref) => ref.watch(invoiceDaoProvider).watchAll(),
);
final invoicesProvider = StreamProvider.family<List<Invoice>, int>(
  (ref, year) => ref.watch(invoiceDaoProvider).watchInYear(year),
);
final invoiceLinesProvider = StreamProvider.family<List<InvoiceLine>, int>(
  (ref, year) => ref.watch(invoiceDaoProvider).watchLinesInYear(year),
);
final expensesProvider = StreamProvider.family<List<Expense>, int>(
  (ref, year) => ref.watch(expenseDaoProvider).watchInYear(year),
);
final hourEntriesProvider = StreamProvider.family<List<HourEntry>, int>(
  (ref, year) => ref.watch(hourDaoProvider).watchInYear(year),
);
final mileageTripsProvider = StreamProvider.family<List<MileageTrip>, int>(
  (ref, year) => ref.watch(mileageDaoProvider).watchInYear(year),
);

/// Every asset as stored, for pickers and the asset form. Figures use
/// [effectiveAssetsProvider].
final allAssetsProvider = StreamProvider(
  (ref) => ref.watch(assetDaoProvider).watchAll(),
);
final taxYearInputsProvider = StreamProvider.family<TaxYearInput?, int>(
  (ref, year) => ref.watch(taxYearInputsDaoProvider).watchYear(year),
);
final pensionProvider = StreamProvider.family<PensionEntry?, int>(
  (ref, year) => ref.watch(pensionDaoProvider).watchYear(year),
);
final vatReturnsProvider = StreamProvider.family<List<VatReturn>, int>(
  (ref, year) => ref.watch(vatReturnDaoProvider).watchYear(year),
);

/// What was filed per rubriek for each BTW return of [year] marked filed.
final vatFiledFiguresProvider =
    StreamProvider.family<Map<VatPeriod, Map<String, (int, int)>>, int>(
      (ref, year) =>
          ref.watch(vatFiledFiguresDaoProvider).watchYear(year).map((rows) {
            final byPeriod = <VatPeriod, Map<String, (int, int)>>{};
            for (final f in rows) {
              byPeriod.putIfAbsent((
                year: f.year,
                kind: f.kind,
                number: f.number,
              ), () => {})[f.rubriek] = (
                f.base,
                f.vat,
              );
            }
            return byPeriod;
          }),
    );

/// The first error or loading state among [values], or null when all have
/// data. Providers that combine several streams return this first.
AsyncValue<T>? waitForAll<T>(List<AsyncValue<Object?>> values) {
  for (final a in values) {
    if (a.hasError) return AsyncError<T>(a.error!, a.stackTrace!);
  }
  if (values.any((a) => !a.hasValue)) return AsyncLoading<T>();
  return null;
}

/// Whether and when the kleineondernemersregeling applies.
final korStatusProvider = Provider<AsyncValue<KorStatus>>((ref) {
  final profile = ref.watch(businessProfileProvider);
  final invoices = ref.watch(allInvoicesProvider);
  final assets = ref.watch(allAssetsProvider);
  return waitForAll<KorStatus>([profile, invoices, assets]) ??
      AsyncData(
        KorService.status(
          profile.requireValue,
          invoices.requireValue,
          assetSales: AssetService.saleInvoiceIds(assets.requireValue),
        ),
      );
});

/// The expenses of [year] as they count, with the KOR and the rule on gifts
/// applied.
final effectiveExpensesProvider =
    Provider.family<AsyncValue<List<Expense>>, int>((ref, year) {
      final expenses = ref.watch(expensesProvider(year));
      final kor = ref.watch(korStatusProvider);
      return waitForAll<List<Expense>>([expenses, kor]) ??
          AsyncData(
            GiftService.applyDeductionRule(
              KorService.applyToExpenses(
                expenses.requireValue,
                kor.requireValue,
              ),
              taxRulesFor,
            ),
          );
    });

/// Every asset as it counts: the proceeds of a sale invoiced in Florin from
/// that invoice, and the KOR applied.
final effectiveAssetsProvider = Provider<AsyncValue<List<FixedAsset>>>((ref) {
  final assets = ref.watch(allAssetsProvider);
  final invoices = ref.watch(allInvoicesProvider);
  final kor = ref.watch(korStatusProvider);
  return waitForAll<List<FixedAsset>>([assets, invoices, kor]) ??
      AsyncData(
        KorService.applyToAssets(
          AssetService.withSaleInvoices(
            assets.requireValue,
            invoices.requireValue,
          ),
          kor.requireValue,
        ),
      );
});

/// The assets that belong to the business in [year], as they count, by name.
final assetsInUseProvider = Provider.family<AsyncValue<List<FixedAsset>>, int>(
  (ref, year) => ref
      .watch(effectiveAssetsProvider)
      .whenData(
        (all) =>
            all.where((a) => AssetService.inUse(a, year)).toList()
              ..sort((a, b) => a.assetName.compareTo(b.assetName)),
      ),
);

/// Verified statutory figures for a supported year.
final taxRulesProvider = Provider.family<TaxYearRules, int>(
  (ref, year) => taxYears[year]!,
);

/// The income tax estimate for [year], built from all bookkeeping of that
/// year.
final taxEstimateProvider = Provider.family<AsyncValue<TaxEstimate>, int>((
  ref,
  year,
) {
  final rules = ref.watch(taxRulesProvider(year));
  final invoices = ref.watch(invoicesProvider(year));
  final expenses = ref.watch(effectiveExpensesProvider(year));
  final hours = ref.watch(hourEntriesProvider(year));
  final trips = ref.watch(mileageTripsProvider(year));
  final assets = ref.watch(assetsInUseProvider(year));
  final allAssets = ref.watch(effectiveAssetsProvider);
  final pension = ref.watch(pensionProvider(year));
  final inputs = ref.watch(taxYearInputsProvider(year));
  final all = [
    invoices,
    expenses,
    hours,
    trips,
    assets,
    allAssets,
    pension,
    inputs,
  ];
  final pending = waitForAll<TaxEstimate>(all);
  if (pending != null) return pending;

  final totalHours = ownHours(hours.requireValue);
  final yearOver = year < DateTime.now().year;
  final km = TaxService.businessKm(trips.requireValue);
  final assetList = assets.requireValue;
  final every = allAssets.requireValue;
  final assetSales = AssetService.saleInvoiceIds(every);
  final yearInputs = inputs.requireValue;
  final ceased = yearInputs?.businessCeased ?? false;
  final reserve = AssetService.reserveLedger(
    every,
    year,
    ceasedYear: ceased ? year : null,
  )[year];
  final soHours = ownHours(
    hours.requireValue.where((h) => h.workType == WorkType.wbso),
  );
  final result = TaxService.calculate(
    rules: rules,
    grossRevenue: TaxService.grossRevenue(
      invoices.requireValue,
      assetSales: assetSales,
    ),
    creditNotes: TaxService.creditNotes(
      invoices.requireValue,
      assetSales: assetSales,
    ),
    deductibleExpenses: TaxService.deductibleExpenses(
      expenses.requireValue,
      rules,
    ),
    depreciation: AssetService.totalDepreciation(assetList, year),
    disposalResult: AssetService.disposalResult(every, year),
    mileageAllowance: TaxService.mileageAllowance(km, rules),
    investmentDeduction: AssetService.investmentDeduction(every, year, rules),
    desinvesteringsbijtelling: AssetService.desinvesteringsbijtelling(
      every,
      year,
      rules,
    ),
    carPrivateUse: CarService.privateUseAddition(
      assets: every,
      trips: trips.requireValue,
      expenses: expenses.requireValue,
      year: year,
      rules: rules,
    ),
    reserveReleased: reserve?.released ?? 0,
    stakingswinst: ceased
        ? AssetService.saleGains(every, year) + (reserve?.released ?? 0)
        : 0,
    totalHours: totalHours,
    soHours: soHours,
    partnerHours:
        partnerLoggedHours(hours.requireValue) +
        (yearInputs?.partnerHours ?? 0),
    hoursFinal: yearOver,
    inputs: yearInputs,
    lijfrentePremium: PensionService.deductiblePremium(
      rules,
      pension.requireValue,
    ),
    aovPremium: (pension.requireValue?.aovInsured ?? false)
        ? pension.requireValue!.monthlyAovPremium * 12
        : 0,
  );
  return AsyncData(
    TaxEstimate(
      rules: rules,
      result: result,
      totalHours: totalHours,
      meetsUrencriterium: TaxService.meetsUrencriterium(
        rules: rules,
        totalHours: totalHours,
        inputs: yearInputs,
      ),
      timeTestHours: TaxService.timeTestHours(yearInputs),
      yearOver: yearOver,
      businessKm: km,
    ),
  );
});

/// The period of [year]'s BTW returns, a quarter unless the user chose
/// another.
final vatFilingPeriodProvider =
    Provider.family<AsyncValue<VatFilingPeriod>, int>(
      (ref, year) => ref
          .watch(taxYearInputsProvider(year))
          .whenData((i) => i?.vatFilingPeriod ?? VatFilingPeriod.quarterly),
    );

/// The BTW return of one period, with the corrections of earlier filed
/// periods it carries and, once filed, how its records changed since
/// (`docs/legal.md`, Correcting a filed return).
final vatPeriodProvider =
    Provider.family<AsyncValue<VatReturnResult>, VatPeriod>((ref, key) {
      final own = ref.watch(vatOwnPeriodProvider(key));
      final returns = ref.watch(vatReturnsProvider(key.year));
      final filedFigures = ref.watch(vatFiledFiguresProvider(key.year));
      final pending = waitForAll<VatReturnResult>([own, returns, filedFigures]);
      if (pending != null) return pending;
      final rules = ref.watch(taxRulesProvider(key.year));
      final filed = {
        for (final v in returns.requireValue)
          if (v.filed && v.kind == key.kind) v.number,
      };
      final figures = filedFigures.requireValue;
      Map<String, (int, int)>? changeOf(VatPeriod p, VatReturnResult r) {
        final kept = figures[p];
        return kept == null ? null : VatService.difference(r.rubrieken, kept);
      }

      if (filed.contains(key.number)) {
        return AsyncData(
          own.requireValue.withCorrections(
            changed: changeOf(key, own.requireValue) ?? const {},
          ),
        );
      }
      // Earlier filed periods right before this one, back to the last one
      // not filed: their small corrections come into this return.
      final corrections = <String, (int, int)>{};
      final from = <VatPeriod, Map<String, (int, int)>>{};
      for (var n = key.number - 1; n >= 1 && filed.contains(n); n--) {
        final p = (year: key.year, kind: key.kind, number: n);
        final earlier = ref.watch(vatOwnPeriodProvider(p));
        if (!earlier.hasValue) {
          return waitForAll<VatReturnResult>([earlier])!;
        }
        final change = changeOf(p, earlier.requireValue);
        if (change == null ||
            change.isEmpty ||
            !VatService.fitsNextReturn(change, rules)) {
          continue;
        }
        from[p] = earlier.requireValue.rubrieken;
        for (final MapEntry(key: r, value: (b, v)) in change.entries) {
          final (cb, cv) = corrections[r] ?? (0, 0);
          corrections[r] = (cb + b, cv + v);
        }
      }
      return AsyncData(
        own.requireValue.withCorrections(corrections: corrections, from: from),
      );
    });

/// The BTW return figures for one period from its own records alone.
final vatOwnPeriodProvider =
    Provider.family<AsyncValue<VatReturnResult>, VatPeriod>((ref, key) {
      // Every year's invoices: a service is reported in the quarter it was
      // supplied, which can precede the year of its invoice.
      final invoices = ref.watch(allInvoicesProvider);
      final lines = ref.watch(invoiceLinesProvider(key.year));
      final expenses = ref.watch(effectiveExpensesProvider(key.year));
      final trips = ref.watch(mileageTripsProvider(key.year));
      final assets = ref.watch(effectiveAssetsProvider);
      final kor = ref.watch(korStatusProvider);
      final pending = waitForAll<VatReturnResult>([
        invoices,
        lines,
        expenses,
        trips,
        assets,
        kor,
      ]);
      if (pending != null) return pending;
      return AsyncData(
        VatService.fromRecords(
          invoices: invoices.requireValue,
          lines: lines.requireValue,
          expenses: expenses.requireValue,
          assets: assets.requireValue,
          trips: trips.requireValue,
          period: key,
          kor: kor.requireValue,
          rules: ref.watch(taxRulesProvider(key.year)),
        ),
      );
    });

/// Every BTW period of [year] for its filing period, with its figures.
final vatYearProvider =
    Provider.family<AsyncValue<List<(VatPeriod, VatReturnResult)>>, int>((
      ref,
      year,
    ) {
      final kind = ref.watch(vatFilingPeriodProvider(year));
      final pending = waitForAll<List<(VatPeriod, VatReturnResult)>>([kind]);
      if (pending != null) return pending;
      final periods = vatPeriodsOf(year, kind.requireValue);
      final results = [
        for (final p in periods) ref.watch(vatPeriodProvider(p)),
      ];
      return waitForAll<List<(VatPeriod, VatReturnResult)>>(results) ??
          AsyncData([
            for (var i = 0; i < periods.length; i++)
              (periods[i], results[i].requireValue),
          ]);
    });

class TaxEstimate {
  final TaxYearRules rules;
  final TaxResult result;
  final double totalHours;
  final bool meetsUrencriterium;

  /// The hours in employment the business hours must exceed for the
  /// urencriterium, or null when that condition does not apply.
  final int? timeTestHours;
  final bool yearOver;
  final int businessKm;

  const TaxEstimate({
    required this.rules,
    required this.result,
    required this.totalHours,
    required this.meetsUrencriterium,
    required this.timeTestHours,
    required this.yearOver,
    required this.businessKm,
  });
}
