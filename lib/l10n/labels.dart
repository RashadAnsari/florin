import 'package:intl/intl.dart';
import '../db/enums.dart';
import '../services/domain.dart';
import '../theme/app_theme.dart';
import '../services/tax_rules/tax_year_rules.dart';
import 'app_localizations.dart';

// Localized labels for stored enum keys. Raw keys are never shown.

extension PurchaseVatLabel on PurchaseVat {
  String label(AppLocalizations l) => switch (this) {
    PurchaseVat.domestic => l.purchaseVatDomestic,
    PurchaseVat.reverseChargeNl => l.purchaseVatReverseChargeNl,
    PurchaseVat.fromEu => l.purchaseVatFromEu,
    PurchaseVat.fromOutsideEu => l.purchaseVatFromOutsideEu,
  };
}

extension AssetKindLabel on AssetKind {
  String label(AppLocalizations l) => switch (this) {
    AssetKind.general => l.assetKindGeneral,
    AssetKind.car => l.assetKindCar,
  };
}

extension MiaCategoryLabel on MiaCategory {
  String label(AppLocalizations l) => switch (this) {
    MiaCategory.one => l.miaCategoryOne,
    MiaCategory.two => l.miaCategoryTwo,
    MiaCategory.three => l.miaCategoryThree,
  };
}

extension ZeroEmissionLabel on ZeroEmission {
  String label(AppLocalizations l) => switch (this) {
    ZeroEmission.none => l.zeroEmissionNone,
    ZeroEmission.battery => l.zeroEmissionBattery,
    ZeroEmission.hydrogenOrSolar => l.zeroEmissionHydrogenOrSolar,
  };
}

extension InvoiceTypeLabel on InvoiceType {
  String label(AppLocalizations l) => switch (this) {
    InvoiceType.invoice => l.invoiceTypeInvoice,
    InvoiceType.creditNote => l.invoiceTypeCreditNote,
  };
}

extension InvoiceStatusLabel on InvoiceStatus {
  String label(AppLocalizations l) => switch (this) {
    InvoiceStatus.draft => l.invoiceStatusConcept,
    InvoiceStatus.sent => l.invoiceStatusSent,
    InvoiceStatus.paid => l.invoiceStatusPaid,
  };
}

extension VatTreatmentLabel on VatTreatment {
  String label(AppLocalizations l) => switch (this) {
    VatTreatment.standard => l.vatTreatmentStandard,
    VatTreatment.reverseChargeNl => l.vatTreatmentReverseChargeNl,
    VatTreatment.euServices => l.vatTreatmentEuServices,
    VatTreatment.euGoods => l.vatTreatmentEuGoods,
    VatTreatment.exportOutsideEu => l.vatTreatmentExportOutsideEu,
    VatTreatment.servicesOutsideEu => l.vatTreatmentServicesOutsideEu,
    VatTreatment.kor => l.vatTreatmentKor,
  };

  /// What an invoice line shows in its VAT column when the whole invoice
  /// has this treatment.
  String lineLabel(AppLocalizations l) => switch (this) {
    VatTreatment.standard => l.vatTreatmentStandard,
    VatTreatment.reverseChargeNl ||
    VatTreatment.euServices => l.vatShortReverseCharge,
    VatTreatment.euGoods || VatTreatment.exportOutsideEu => l.vatRate0,
    VatTreatment.servicesOutsideEu => l.vatShortNotTaxedNl,
    VatTreatment.kor => l.vatShortKor,
  };
}

extension ReceiptOwnerKindLabel on ReceiptOwnerKind {
  String label(AppLocalizations l) => switch (this) {
    ReceiptOwnerKind.expense => l.receiptOwnerExpense,
    ReceiptOwnerKind.asset => l.receiptOwnerAsset,
    ReceiptOwnerKind.invoice => l.receiptOwnerInvoice,
  };
}

extension ReceiptTypeLabel on ReceiptType {
  String label(AppLocalizations l) => switch (this) {
    ReceiptType.pdf => 'PDF',
    ReceiptType.jpeg => 'JPEG',
    ReceiptType.png => 'PNG',
    ReceiptType.heic => 'HEIC',
    ReceiptType.tiff => 'TIFF',
    ReceiptType.xml => l.receiptTypeEInvoice,
  };
}

extension VatRateLabel on VatRate {
  /// The rate with the percentage of [rules], the rules of the record's year.
  String label(AppLocalizations l, TaxYearRules rules) => switch (this) {
    VatRate.high ||
    VatRate.low => AppFormat.percentLabel(rules.vatRates[this]!),
    VatRate.zero => l.vatRate0,
    VatRate.exempt => l.vatRateExempt,
  };
}

extension ExpenseCategoryLabel on ExpenseCategory {
  String label(AppLocalizations l) => switch (this) {
    ExpenseCategory.office => l.expenseCatOffice,
    ExpenseCategory.travel => l.expenseCatTravel,
    ExpenseCategory.foodAndRepresentation => l.expenseCatMeals,
    ExpenseCategory.software => l.expenseCatSoftware,
    ExpenseCategory.hardware => l.expenseCatHardware,
    ExpenseCategory.marketing => l.expenseCatMarketing,
    ExpenseCategory.gifts => l.expenseCatGifts,
    ExpenseCategory.professionalServices => l.expenseCatProfessional,
    ExpenseCategory.phoneAndInternet => l.expenseCatPhone,
    ExpenseCategory.insurance => l.expenseCatInsurance,
    ExpenseCategory.training => l.expenseCatTraining,
    ExpenseCategory.courseTravel => l.expenseCatCourseTravel,
    ExpenseCategory.clothingAndCare => l.expenseCatClothingAndCare,
    ExpenseCategory.homePhoneLine => l.expenseCatHomePhoneLine,
    ExpenseCategory.generalLiterature => l.expenseCatGeneralLiterature,
    ExpenseCategory.fines => l.expenseCatFines,
    ExpenseCategory.other => l.expenseCatOther,
  };
}

extension TripTypeLabel on TripType {
  String label(AppLocalizations l) => switch (this) {
    TripType.business => l.tripTypeBusiness,
    TripType.commute => l.tripTypeCommute,
    TripType.private => l.tripTypePrivate,
  };
}

extension WorkTypeLabel on WorkType {
  String label(AppLocalizations l) => switch (this) {
    WorkType.billable => l.workTypeBillable,
    WorkType.nonBillable => l.workTypeNonBillable,
    WorkType.administrative => l.workTypeAdministrative,
    WorkType.wbso => l.workTypeWbso,
    WorkType.other => l.workTypeOther,
  };
}

extension WetDbaRiskLabel on WetDbaRisk {
  String label(AppLocalizations l) => switch (this) {
    WetDbaRisk.low => l.clientsRiskLow,
    WetDbaRisk.medium => l.clientsRiskMedium,
    WetDbaRisk.high => l.clientsRiskHigh,
  };
}

extension VatFilingPeriodLabel on VatFilingPeriod {
  String label(AppLocalizations l) => switch (this) {
    VatFilingPeriod.quarterly => l.vatFilingQuarterly,
    VatFilingPeriod.monthly => l.vatFilingMonthly,
    VatFilingPeriod.yearly => l.vatFilingYearly,
  };
}

extension VatPeriodLabel on VatPeriod {
  /// The name of the period on screen: a month, `Q1`, or the year.
  String label(AppLocalizations l) => switch (kind) {
    VatFilingPeriod.monthly => DateFormat.MMM(l.localeName).format(first),
    VatFilingPeriod.quarterly => 'Q$number',
    VatFilingPeriod.yearly => '$year',
  };
}

extension IcpPeriodLabel on IcpPeriod {
  /// The name of an ICP-opgaaf period on screen: `Q1 2026`, a month, or the
  /// months it covers.
  String label(AppLocalizations l) {
    if (isQuarter) return 'Q${quarterOf(first)} ${first.year}';
    final month = DateFormat.yMMMM(l.localeName);
    return months == 1
        ? month.format(first)
        : l.icpPeriodMonths(
            DateFormat.MMMM(l.localeName).format(first),
            month.format(last),
          );
  }
}
