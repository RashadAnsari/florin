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
}
