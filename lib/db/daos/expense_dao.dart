import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/expenses.dart';

part 'expense_dao.g.dart';

@DriftAccessor(tables: [Expenses])
class ExpenseDao extends DatabaseAccessor<AppDatabase> with _$ExpenseDaoMixin {
  ExpenseDao(super.db);

  Stream<List<Expense>> watchByYear(int year) =>
      (select(expenses)
            ..where((e) => e.fiscalYear.equals(year))
            ..orderBy([(e) => OrderingTerm.desc(e.date)]))
          .watch();

  Future<List<Expense>> getByYear(int year) =>
      (select(expenses)
            ..where((e) => e.fiscalYear.equals(year))
            ..orderBy([(e) => OrderingTerm.desc(e.date)]))
          .get();

  Future<List<Expense>> getByYearAndQuarter(int year, String quarter) =>
      (select(expenses)
            ..where((e) => e.fiscalYear.equals(year))
            ..where((e) => e.quarter.equals(quarter))
            ..orderBy([(e) => OrderingTerm.desc(e.date)]))
          .get();

  Future<Expense?> getById(int id) =>
      (select(expenses)..where((e) => e.id.equals(id))).getSingleOrNull();

  Future<int> insertExpense(ExpensesCompanion entry) =>
      into(expenses).insert(entry);

  Future<bool> saveExpense(ExpensesCompanion entry) =>
      (update(expenses)).replace(entry);

  Future<int> deleteExpense(int id) =>
      (delete(expenses)..where((e) => e.id.equals(id))).go();
}
