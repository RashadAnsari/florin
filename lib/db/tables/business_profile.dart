import 'package:drift/drift.dart';

/// The seller details printed on invoices. Holds a single row with id 1.
class BusinessProfiles extends Table {
  // ignore: recursive_getters
  IntColumn get id => integer().check(id.equals(1))();
  TextColumn get name => text()();
  TextColumn get vatNumber => text()();
  TextColumn get kvkNumber => text()();
  TextColumn get address => text()();
  TextColumn get iban => text()();
  BoolColumn get isStarter => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
