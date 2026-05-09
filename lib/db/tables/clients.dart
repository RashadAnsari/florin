import 'package:drift/drift.dart';

class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get country => text().withDefault(const Constant('NL'))();
  TextColumn get vatNumber => text().nullable()();
  TextColumn get kvkNumber => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get contactPerson => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get wetDbaRiskLevel => text().withDefault(const Constant('Low'))();
  BoolColumn get contractSigned =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get contractExpiry => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
