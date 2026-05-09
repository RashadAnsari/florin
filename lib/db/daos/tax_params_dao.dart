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

  Future<PensionEntry?> getPensionByYear(int year) => (select(
    pensionEntries,
  )..where((p) => p.fiscalYear.equals(year))).getSingleOrNull();

  Stream<PensionEntry?> watchPensionByYear(int year) => (select(
    pensionEntries,
  )..where((p) => p.fiscalYear.equals(year))).watchSingleOrNull();

  Future<void> upsertPension(PensionEntriesCompanion entry) =>
      into(pensionEntries).insertOnConflictUpdate(entry);
}
