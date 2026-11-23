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

  /// The first day the kleineondernemersregeling applies, as the
  /// Belastingdienst confirmed it (Wet OB 1968 art. 25a lid 5).
  DateTimeColumn get korStart => dateTime().nullable()();

  /// The first day it no longer applies after a voluntary deregistration
  /// (art. 25a lid 7). Passing the turnover limit ends it without this.
  DateTimeColumn get korEnd => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
