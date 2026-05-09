import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/fixed_assets.dart';

part 'asset_dao.g.dart';

@DriftAccessor(tables: [FixedAssets])
class AssetDao extends DatabaseAccessor<AppDatabase> with _$AssetDaoMixin {
  AssetDao(super.db);

  Stream<List<FixedAsset>> watchByYear(int year) =>
      (select(fixedAssets)
            ..where((a) => a.fiscalYear.equals(year))
            ..orderBy([(a) => OrderingTerm.asc(a.assetName)]))
          .watch();

  Future<List<FixedAsset>> getByYear(int year) =>
      (select(fixedAssets)
            ..where((a) => a.fiscalYear.equals(year))
            ..orderBy([(a) => OrderingTerm.asc(a.assetName)]))
          .get();

  Future<FixedAsset?> getById(int id) =>
      (select(fixedAssets)..where((a) => a.id.equals(id))).getSingleOrNull();

  Future<int> insertAsset(FixedAssetsCompanion entry) =>
      into(fixedAssets).insert(entry);

  Future<bool> saveAsset(FixedAssetsCompanion entry) =>
      (update(fixedAssets)).replace(entry);

  Future<int> deleteAsset(int id) =>
      (delete(fixedAssets)..where((a) => a.id.equals(id))).go();
}
