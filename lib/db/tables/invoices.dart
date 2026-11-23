import 'package:drift/drift.dart';
import '../enums.dart';
import 'clients.dart';

@TableIndex(name: 'invoices_invoice_date', columns: {#invoiceDate})
class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get invoiceNumber => text().unique()();
  TextColumn get invoiceType => textEnum<InvoiceType>()();

  /// The invoice a credit note corrects (Wet OB 1968 art. 35a lid 2 e).
  IntColumn get correctedInvoiceId => integer().nullable().references(
    Invoices,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get invoiceDate => dateTime()();
  DateTimeColumn get supplyDate => dateTime().nullable()();
  IntColumn get clientId =>
      integer().references(Clients, #id, onDelete: KeyAction.restrict)();
  TextColumn get vatTreatment => textEnum<VatTreatment>()();

  /// Issued by the customer instead of the user (Wet OB 1968 art. 35 lid 2).
  /// The number is the customer's and Florin makes no PDF.
  BoolColumn get selfBilled => boolean().withDefault(const Constant(false))();
  TextColumn get sellerName => text()();
  TextColumn get sellerVatNumber => text()();
  TextColumn get sellerKvkNumber => text()();
  TextColumn get sellerAddress => text()();
  TextColumn get sellerIban => text()();
  IntColumn get paymentTermDays => integer()();
  TextColumn get status => textEnum<InvoiceStatus>()();
  DateTimeColumn get paidDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get totalExclVat => integer()();
  IntColumn get totalVat => integer()();
  IntColumn get totalInclVat => integer()();
}
