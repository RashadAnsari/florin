import 'package:drift/drift.dart';
import 'invoices.dart';

class InvoiceLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId => integer().references(Invoices, #id)();
  TextColumn get description => text()();
  TextColumn get quantityUnit => text().withDefault(const Constant('1'))();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  IntColumn get unitPriceExclVat => integer()();
  TextColumn get vatRate => text().withDefault(const Constant('21%'))();
  IntColumn get vatAmount => integer().withDefault(const Constant(0))();
  IntColumn get lineTotalExclVat => integer().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
