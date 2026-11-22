import 'package:drift/drift.dart';
import '../enums.dart';

@TableIndex(name: 'hour_entries_date', columns: {#date})
class HourEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  TextColumn get workType => textEnum<WorkType>()();
  RealColumn get hours => real()();
  TextColumn get clientProject => text().nullable()();
  TextColumn get notes => text().nullable()();
}
