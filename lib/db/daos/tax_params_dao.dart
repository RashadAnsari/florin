import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/tax_params.dart';
import '../tables/pension.dart';

part 'tax_params_dao.g.dart';

@DriftAccessor(tables: [TaxParams, PensionEntries])
class TaxParamsDao extends DatabaseAccessor<AppDatabase>
    with _$TaxParamsDaoMixin {
  TaxParamsDao(super.db);

  Future<TaxParam?> getByYear(int year) =>
      (select(taxParams)..where((t) => t.year.equals(year))).getSingleOrNull();

  Stream<TaxParam?> watchByYear(int year) => (select(
    taxParams,
  )..where((t) => t.year.equals(year))).watchSingleOrNull();

  Future<List<TaxParam>> getAll() =>
      (select(taxParams)..orderBy([(t) => OrderingTerm.asc(t.year)])).get();

  Future<void> upsert(TaxParamsCompanion entry) =>
      into(taxParams).insertOnConflictUpdate(entry);

  /// Copies the nearest year's row to [year] if no row exists yet.
  Future<void> ensureExistsForYear(int year) async {
    final existing = await getByYear(year);
    if (existing != null) return;

    final all = await getAll();
    if (all.isEmpty) return;

    final source = all.reduce(
      (a, b) => (a.year - year).abs() <= (b.year - year).abs() ? a : b,
    );

    await upsert(
      TaxParamsCompanion(
        year: Value(year),
        zelfstandigenaftrek: Value(source.zelfstandigenaftrek),
        startersaftrek: Value(source.startersaftrek),
        mkbWinstvrijstellingPct: Value(source.mkbWinstvrijstellingPct),
        bracket1Rate: Value(source.bracket1Rate),
        bracket1Threshold: Value(source.bracket1Threshold),
        bracket2Rate: Value(source.bracket2Rate),
        bracket2Threshold: Value(source.bracket2Threshold),
        bracket3Rate: Value(source.bracket3Rate),
        algHeffingskortingMax: Value(source.algHeffingskortingMax),
        arbeidskortingMax: Value(source.arbeidskortingMax),
        zvwRate: Value(source.zvwRate),
        zvwMax: Value(source.zvwMax),
        mixedCostsThreshold: Value(source.mixedCostsThreshold),
        mixedCosts80Pct: Value(source.mixedCosts80Pct),
        jaarruimtePct: Value(source.jaarruimtePct),
        jaarruimteMax: Value(source.jaarruimteMax),
        aowFranchise: Value(source.aowFranchise),
        reserveringsruimteMax: Value(source.reserveringsruimteMax),
        factorAMultiplier: Value(source.factorAMultiplier),
        kiaLowerThreshold: Value(source.kiaLowerThreshold),
        kiaUpperThreshold: Value(source.kiaUpperThreshold),
        kiaFlatThreshold: Value(source.kiaFlatThreshold),
        kiaRate: Value(source.kiaRate),
        kiaFlatAmount: Value(source.kiaFlatAmount),
        kiaDecreaseRate: Value(source.kiaDecreaseRate),
        urencriteriumThreshold: Value(source.urencriteriumThreshold),
        mileageRatePerKm: Value(source.mileageRatePerKm),
        korThreshold: Value(source.korThreshold),
        ossThreshold: Value(source.ossThreshold),
        belastingrentePct: Value(source.belastingrentePct),
      ),
    );
  }

  Future<PensionEntry?> getPensionByYear(int year) => (select(
    pensionEntries,
  )..where((p) => p.fiscalYear.equals(year))).getSingleOrNull();

  Stream<PensionEntry?> watchPensionByYear(int year) => (select(
    pensionEntries,
  )..where((p) => p.fiscalYear.equals(year))).watchSingleOrNull();

  Future<void> upsertPension(PensionEntriesCompanion entry) =>
      into(pensionEntries).insertOnConflictUpdate(entry);
}
