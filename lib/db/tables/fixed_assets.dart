import 'package:drift/drift.dart';
import '../enums.dart';
import 'invoices.dart';

class FixedAssets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kind =>
      textEnum<AssetKind>().withDefault(Constant(AssetKind.general.name))();
  TextColumn get assetName => text()();
  IntColumn get costExclVat => integer()();

  // BTW on the purchase, counted in the return as an expense's is. The rate
  // is null when the purchase year has no rules in Florin and the amount was
  // entered.
  TextColumn get vatRate => textEnum<VatRate>().nullable()();
  TextColumn get purchaseVat => textEnum<PurchaseVat>().withDefault(
    Constant(PurchaseVat.domestic.name),
  )();
  IntColumn get vatAmount => integer().withDefault(const Constant(0))();
  BoolColumn get vatReclaimable =>
      boolean().withDefault(const Constant(true))();
  IntColumn get vatToReclaim => integer().withDefault(const Constant(0))();

  /// Depreciation stops at this value.
  IntColumn get residualValue => integer()();
  DateTimeColumn get purchaseDate => dateTime()();
  RealColumn get businessUsePct => real()();
  IntColumn get usefulLifeYears => integer()();
  BoolColumn get kiaEligible => boolean().withDefault(const Constant(false))();
  BoolColumn get eiaEligible => boolean().withDefault(const Constant(false))();
  TextColumn get miaCategory => textEnum<MiaCategory>().nullable()();

  /// Investeringsaftrek received, for a purchase year Florin has no rules
  /// for; used for the desinvesteringsbijtelling.
  IntColumn get investmentDeductionReceived => integer().nullable()();

  /// Herinvesteringsreserve booked off on this asset's cost.
  IntColumn get reinvestmentReserveApplied =>
      integer().withDefault(const Constant(0))();

  /// The gain on sale goes to the herinvesteringsreserve.
  BoolColumn get reserveGain => boolean().withDefault(const Constant(false))();

  // Cars only.
  IntColumn get catalogueValue => integer().nullable()();
  DateTimeColumn get firstRegistration => dateTime().nullable()();
  TextColumn get zeroEmission =>
      textEnum<ZeroEmission>().withDefault(Constant(ZeroEmission.none.name))();
  IntColumn get marketValue => integer().nullable()();
  BoolColumn get keepsTripLog => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get disposalDate => dateTime().nullable()();
  IntColumn get disposalProceeds => integer().nullable()();

  /// The issued invoice for the sale, which then carries its BTW.
  IntColumn get disposalInvoiceId => integer().nullable().references(
    Invoices,
    #id,
    onDelete: KeyAction.restrict,
  )();

  /// BTW on a sale or withdrawal without an invoice in Florin, over the
  /// business share of the proceeds.
  TextColumn get disposalVatRate => textEnum<VatRate>().nullable()();
  IntColumn get disposalVatAmount => integer().nullable()();
}
