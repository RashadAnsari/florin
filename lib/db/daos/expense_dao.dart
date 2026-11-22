import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/expenses.dart';

part 'expense_dao.g.dart';

@DriftAccessor(tables: [Expenses])
class ExpenseDao extends DatabaseAccessor<AppDatabase>
    with _$ExpenseDaoMixin, Crud<$ExpensesTable, Expense> {
  ExpenseDao(super.db);

  @override
  TableInfo<$ExpensesTable, Expense> get table => expenses;

  Stream<List<Expense>> watchInYear(int year) =>
      (select(expenses)
            ..where((r) => r.date.inYear(year))
            ..orderBy([(r) => OrderingTerm.desc(r.date)]))
          .watch();
}
