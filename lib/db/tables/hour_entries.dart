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

  /// Worked by the fiscal partner in the business, for the meewerkaftrek
  /// (Wet IB 2001 art. 3.78). Not part of the user's own hours.
  BoolColumn get byPartner => boolean().withDefault(const Constant(false))();
}
