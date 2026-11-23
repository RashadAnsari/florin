import 'package:drift/drift.dart';
import '../enums.dart';

class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get country => text().withDefault(const Constant('NL'))();
  TextColumn get vatNumber => text().nullable()();
  TextColumn get kvkNumber => text().nullable()();
  TextColumn get address => text()();
  TextColumn get contactPerson => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get wetDbaRisk => textEnum<WetDbaRisk>()();
  BoolColumn get contractSigned =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get contractExpiry => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// A reseller that sells the user's product to end customers in its own
  /// name and pays the user, such as a merchant of record or an app store.
  BoolColumn get isMerchantOfRecord =>
      boolean().withDefault(const Constant(false))();
}
