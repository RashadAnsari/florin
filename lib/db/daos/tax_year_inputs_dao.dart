import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/tax_year_inputs.dart';

part 'tax_year_inputs_dao.g.dart';

@DriftAccessor(tables: [TaxYearInputs])
class TaxYearInputsDao extends DatabaseAccessor<AppDatabase>
    with _$TaxYearInputsDaoMixin, Crud<$TaxYearInputsTable, TaxYearInput> {
  TaxYearInputsDao(super.db);

  @override
  TableInfo<$TaxYearInputsTable, TaxYearInput> get table => taxYearInputs;

  Stream<TaxYearInput?> watchYear(int year) => (select(
    taxYearInputs,
  )..where((t) => t.year.equals(year))).watchSingleOrNull();
}
