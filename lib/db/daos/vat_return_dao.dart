import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/vat_returns.dart';

part 'vat_return_dao.g.dart';

@DriftAccessor(tables: [VatReturns])
class VatReturnDao extends DatabaseAccessor<AppDatabase>
    with _$VatReturnDaoMixin, Crud<$VatReturnsTable, VatReturn> {
  VatReturnDao(super.db);

  @override
  TableInfo<$VatReturnsTable, VatReturn> get table => vatReturns;

  Stream<List<VatReturn>> watchYear(int year) =>
      (select(vatReturns)..where((v) => v.year.equals(year))).watch();
}
