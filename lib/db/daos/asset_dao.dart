import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/fixed_assets.dart';

part 'asset_dao.g.dart';

@DriftAccessor(tables: [FixedAssets])
class AssetDao extends DatabaseAccessor<AppDatabase>
    with _$AssetDaoMixin, Crud<$FixedAssetsTable, FixedAsset> {
  AssetDao(super.db);

  @override
  TableInfo<$FixedAssetsTable, FixedAsset> get table => fixedAssets;

  Stream<List<FixedAsset>> watchAll() => (select(
    fixedAssets,
  )..orderBy([(a) => OrderingTerm.asc(a.purchaseDate)])).watch();

  /// Assets bought before the end of [year] and not disposed before it.
  Stream<List<FixedAsset>> watchInUse(int year) =>
      (select(fixedAssets)
            ..where(
              (a) =>
                  a.purchaseDate.isSmallerThanValue(DateTime(year + 1)) &
                  (a.disposalDate.isNull() |
                      a.disposalDate.isBiggerOrEqualValue(DateTime(year))),
            )
            ..orderBy([(a) => OrderingTerm.asc(a.assetName)]))
          .watch();
}
