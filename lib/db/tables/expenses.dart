import 'package:drift/drift.dart';

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get supplier => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  BoolColumn get receiptAttached =>
      boolean().withDefault(const Constant(false))();
  IntColumn get amountExclVat => integer()();
  TextColumn get vatRate => text().withDefault(const Constant('21%'))();
  IntColumn get vatAmount => integer().withDefault(const Constant(0))();
  IntColumn get totalInclVat => integer().withDefault(const Constant(0))();
  RealColumn get businessUsePct => real().withDefault(const Constant(1.0))();
  IntColumn get deductibleAmount => integer().withDefault(const Constant(0))();
  BoolColumn get vatReclaimable =>
      boolean().withDefault(const Constant(true))();
  IntColumn get vatToReclaim => integer().withDefault(const Constant(0))();
  BoolColumn get isMixedCost => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  TextColumn get paidFrom => text().nullable()();
  TextColumn get paymentReference => text().nullable()();
  IntColumn get fiscalYear => integer()();
  TextColumn get quarter => text()();
}
