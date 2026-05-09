import 'package:drift/drift.dart';

class HourEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  TextColumn get workType => text()();
  RealColumn get hours => real()();
  BoolColumn get billable => boolean().withDefault(const Constant(false))();
  TextColumn get clientProject => text().nullable()();
  BoolColumn get isWbso => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  IntColumn get fiscalYear => integer()();
  IntColumn get weekNumber => integer()();
}
