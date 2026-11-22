import 'package:drift/drift.dart';
import '../enums.dart';
import 'invoices.dart';

class InvoiceLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId =>
      integer().references(Invoices, #id, onDelete: KeyAction.cascade)();
  TextColumn get description => text()();
  RealColumn get quantity => real()();
  TextColumn get unit => text().nullable()();
  IntColumn get unitPriceExclVat => integer()();
  TextColumn get vatRate => textEnum<VatRate>()();
  IntColumn get vatAmount => integer()();
  IntColumn get lineTotalExclVat => integer()();
  IntColumn get sortOrder => integer()();
}
