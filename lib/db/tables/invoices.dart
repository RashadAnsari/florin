import 'package:drift/drift.dart';
import 'clients.dart';

class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get invoiceNumber => text().unique()();
  DateTimeColumn get invoiceDate => dateTime()();
  DateTimeColumn get supplyDate => dateTime().nullable()();
  IntColumn get clientId => integer().references(Clients, #id)();
  TextColumn get invoiceType => text().withDefault(const Constant('Invoice'))();
  TextColumn get sellerName => text()();
  TextColumn get sellerVatNumber => text()();
  TextColumn get sellerKvkNumber => text()();
  TextColumn get sellerAddress => text()();
  TextColumn get sellerIban => text().nullable()();
  IntColumn get paymentTermDays => integer().withDefault(const Constant(14))();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get status => text().withDefault(const Constant('Draft'))();
  DateTimeColumn get paidDate => dateTime().nullable()();
  TextColumn get paymentMethod => text().nullable()();
  DateTimeColumn get refundDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isReverseCharge =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isIcp => boolean().withDefault(const Constant(false))();
  TextColumn get reverseChargeNote => text().nullable()();
  IntColumn get totalExclVat => integer().withDefault(const Constant(0))();
  IntColumn get totalVat => integer().withDefault(const Constant(0))();
  IntColumn get totalInclVat => integer().withDefault(const Constant(0))();
  IntColumn get fiscalYear => integer()();
  TextColumn get quarter => text()();
}
