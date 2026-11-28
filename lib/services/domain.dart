import 'package:drift/drift.dart' show Value;

import '../theme/app_format.dart';
import 'tax_rules/tax_year_rules.dart';
import '../db/database.dart';

/// Today if it falls in [year], otherwise the nearest day of that year.
DateTime todayIn(int year) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  if (today.year < year) return DateTime(year);
  if (today.year > year) return DateTime(year, 12, 31);
  return today;
}

/// Calendar quarter 1 to 4 of [date].
int quarterOf(DateTime date) => (date.month - 1) ~/ 3 + 1;

/// One BTW return period: a month, a quarter or a year, numbered from 1.
typedef VatPeriod = ({int year, VatFilingPeriod kind, int number});

/// The periods of [year] when returns are filed per [kind].
List<VatPeriod> vatPeriodsOf(int year, VatFilingPeriod kind) => [
  for (var n = 1; n <= kind.periodsPerYear; n++)
    (year: year, kind: kind, number: n),
];

/// The period of [kind] that holds [date].
VatPeriod vatPeriodOf(DateTime date, VatFilingPeriod kind) => (
  year: date.year,
  kind: kind,
  number: switch (kind) {
    VatFilingPeriod.monthly => date.month,
    VatFilingPeriod.quarterly => quarterOf(date),
    VatFilingPeriod.yearly => 1,
  },
);

extension VatFilingPeriodDomain on VatFilingPeriod {
  int get periodsPerYear => switch (this) {
    VatFilingPeriod.monthly => 12,
    VatFilingPeriod.quarterly => 4,
    VatFilingPeriod.yearly => 1,
  };

  int get monthsPerPeriod => 12 ~/ periodsPerYear;
}

extension VatPeriodDomain on VatPeriod {
  DateTime get first => DateTime(year, (number - 1) * kind.monthsPerPeriod + 1);

  DateTime get last => DateTime(year, number * kind.monthsPerPeriod + 1, 0);

  bool contains(DateTime d) =>
      !d.isBefore(first) && d.isBefore(last.add(const Duration(days: 1)));

  /// The last return of the year, which carries the yearly corrections.
  bool get isLastOfYear => number == kind.periodsPerYear;

  /// The short Dutch name of the period, as an export file names it:
  /// `M01`, `Q1` or `jaar`.
  String get code => switch (kind) {
    VatFilingPeriod.monthly => 'M${number.toString().padLeft(2, '0')}',
    VatFilingPeriod.quarterly => 'Q$number',
    VatFilingPeriod.yearly => 'jaar',
  };
}

/// One period of the ICP-opgaaf: a quarter, a month, or the months of a
/// quarter up to the month goods passed the quarterly limit, with the last
/// day its opgaaf is due (Wet OB 1968 art. 37a lid 1 and 3).
typedef IcpPeriod = ({DateTime first, DateTime last, DateTime due});

extension IcpPeriodDomain on IcpPeriod {
  bool contains(DateTime d) =>
      !d.isBefore(first) &&
      d.isBefore(DateTime(last.year, last.month, last.day + 1));

  int get months =>
      (last.year - first.year) * 12 + last.month - first.month + 1;

  /// A whole calendar quarter.
  bool get isQuarter => months == 3 && first.month % 3 == 1;

  /// The short Dutch name of the period, as an export file names it: `Q1`,
  /// `M04` or `M04-M05`.
  String get code {
    String m(DateTime d) => 'M${d.month.toString().padLeft(2, '0')}';
    if (isQuarter) return 'Q${quarterOf(first)}';
    return months == 1 ? m(first) : '${m(first)}-${m(last)}';
  }
}

/// The day an invoice dated [invoiceDate] with a term of [termDays] days is
/// due: the invoice date plus the term in calendar days, whatever the clock
/// change (BW 6:119a lid 1).
DateTime dueDateOf(DateTime invoiceDate, int termDays) =>
    DateTime(invoiceDate.year, invoiceDate.month, invoiceDate.day + termDays);

/// The earliest day the records give for a supply invoiced on
/// [invoiceDate]: [supplyDate] when it precedes the invoice, else the invoice
/// date.
DateTime suppliedOnOf(DateTime invoiceDate, DateTime? supplyDate) =>
    supplyDate != null && supplyDate.isBefore(invoiceDate)
    ? supplyDate
    : invoiceDate;

extension InvoiceDomain on Invoice {
  /// Issued invoices count for revenue and BTW; drafts do not.
  bool get isIssued => status != InvoiceStatus.draft;

  DateTime get dueDate => dueDateOf(invoiceDate, paymentTermDays);

  bool get isCreditNote => invoiceType == InvoiceType.creditNote;

  /// The date that puts the invoice in a BTW return and an ICP-opgaaf. A
  /// service to an EU business counts in the period it was supplied, the
  /// invoice date when no supply date is given; everything else, and a
  /// correction, which goes in the next opgaaf, by invoice date
  /// (`docs/legal.md`, ICP-opgaaf).
  DateTime get vatDate =>
      vatTreatment == VatTreatment.euServices && !isCreditNote
      ? supplyDate ?? invoiceDate
      : invoiceDate;

  /// The earliest day the records give for the supply ([suppliedOnOf]).
  DateTime get suppliedOn => suppliedOnOf(invoiceDate, supplyDate);

  /// +1 for an invoice, -1 for a credit note, which reduces every total.
  int get sign => isCreditNote ? -1 : 1;

  /// The amount excl. VAT as it counts in totals: negative for a credit note.
  int get signedExclVat => sign * totalExclVat;

  int get signedInclVat => sign * totalInclVat;

  /// Sent, unpaid and past its due date on [day]: interest and collection
  /// costs run from the day after the due date (BW 6:119a lid 1, 6:96 lid 4).
  bool isOverdueOn(DateTime day) =>
      status == InvoiceStatus.sent &&
      DateTime(day.year, day.month, day.day).isAfter(dueDate);

  bool get isOverdue => isOverdueOn(DateTime.now());

  /// Issued on or before [day] and not paid by the end of it: a receivable
  /// on that day, or for a credit note an amount owed back.
  bool isOpenOn(DateTime day) {
    final end = DateTime(day.year, day.month, day.day + 1);
    return isIssued &&
        invoiceDate.isBefore(end) &&
        (paidDate == null || !paidDate!.isBefore(end));
  }

  /// The last day the claim can be brought to court: the limitation term
  /// runs from the day after the claim fell due (BW 3:307 lid 1). The records
  /// do not show whether the term on the invoice was agreed, and without one
  /// payment can be claimed at once (BW 6:38), so Florin counts from the
  /// earliest day it knows: the supply date or the invoice date.
  DateTime claimLapsesOn(TaxYearRules rules) {
    final from = suppliedOn;
    final year = from.year + rules.claimLimitationYears;
    // 29 February becomes 28 February, the earlier day.
    final lastOfMonth = DateTime(year, from.month + 1, 0).day;
    return DateTime(
      year,
      from.month,
      from.day > lastOfMonth ? lastOfMonth : from.day,
    );
  }
}

/// What clients owe on [day], incl. BTW: issued invoices not yet paid, less
/// credit notes not yet refunded.
int openReceivables(Iterable<Invoice> invoices, DateTime day) => invoices
    .where((i) => i.isOpenOn(day))
    .fold(0, (s, i) => s + i.signedInclVat);

/// The 27 EU member states by ISO 3166 code, as listed by the EU
/// (`docs/legal.md`, EU member states). Greece's BTW prefix EL counts too.
const euCountries = {
  'AT', 'BE', 'BG', 'HR', 'CY', 'CZ', 'DK', 'EE', 'FI', 'FR', 'DE', //
  'GR', 'EL', 'HU', 'IE', 'IT', 'LV', 'LT', 'LU', 'MT', 'NL', 'PL', //
  'PT', 'RO', 'SK', 'SI', 'ES', 'SE',
};

bool isEuCountry(String country) =>
    euCountries.contains(country.trim().toUpperCase());

extension VatRateDomain on VatRate {
  /// The rate as Dutch documents print it, invoice PDFs and CSV exports,
  /// with the percentages of [rules], the rules of the record's year.
  String dutchLabel(TaxYearRules rules) => this == VatRate.exempt
      ? 'Vrijgesteld'
      : AppFormat.percentLabel(rules.vatRates[this]!);
}

extension VatTreatmentDomain on VatTreatment {
  /// Whether the invoice must show the customer's BTW number: Wet OB 1968
  /// art. 35a lid 1 d for reverse charge, and the Belastingdienst's extra
  /// invoice requirements for EU goods and services (`docs/legal.md`).
  bool get needsCustomerVatNumber =>
      this == VatTreatment.reverseChargeNl ||
      this == VatTreatment.euServices ||
      this == VatTreatment.euGoods;

  /// Whether this treatment can apply to a customer in [country]: domestic
  /// reverse charge only in the Netherlands, the EU treatments only in
  /// another member state, the non-EU treatments only outside the EU.
  /// Dutch BTW fits every country, for supplies taxed in the Netherlands.
  bool fitsCountry(String country) {
    final c = country.trim().toUpperCase();
    return switch (this) {
      VatTreatment.standard || VatTreatment.kor => true,
      VatTreatment.reverseChargeNl => c == 'NL',
      VatTreatment.euServices ||
      VatTreatment.euGoods => c != 'NL' && isEuCountry(c),
      VatTreatment.exportOutsideEu ||
      VatTreatment.servicesOutsideEu => !isEuCountry(c),
    };
  }

  /// A consumer: Dutch BTW, the KOR or export of goods, and outside the EU
  /// services taxed there (Wet OB 1968 art. 6e, 6h, 6i); reverse charge and
  /// the EU zero rates need a business customer.
  bool get fitsConsumer => switch (this) {
    VatTreatment.standard ||
    VatTreatment.kor ||
    VatTreatment.exportOutsideEu ||
    VatTreatment.servicesOutsideEu => true,
    _ => false,
  };

  /// Whether this treatment can apply to [client]: its country and whether
  /// it is a consumer.
  bool fitsClient(Client client) =>
      fitsCountry(client.country) && (!client.isConsumer || fitsConsumer);

  /// The rates a line can state under this treatment: any rate with Dutch
  /// BTW; with domestic reverse charge the rate that would apply without it,
  /// as the invoice must show (`docs/legal.md`, Invoice contents); none for
  /// the other treatments.
  List<VatRate> get lineRates => switch (this) {
    VatTreatment.standard => VatRate.values,
    VatTreatment.reverseChargeNl => const [VatRate.high, VatRate.low],
    _ => const [],
  };

  /// Supplies left out of the Dutch BTW return, per the Belastingdienst
  /// (`docs/legal.md`, Services to businesses outside the EU).
  bool get outsideReturn => this == VatTreatment.servicesOutsideEu;
}

extension ClientDomain on Client {
  /// Whether a service to this client may be taxed in its country instead
  /// of the Netherlands: a consumer in another member state (Wet OB 1968
  /// art. 6h, 6k).
  bool get isEuConsumerAbroad =>
      isConsumer && country != 'NL' && isEuCountry(country);

  /// The treatment a new invoice to this client starts with: Dutch BTW in
  /// the Netherlands or to a consumer, the cautious choice since most
  /// services to a consumer are taxed where the supplier is (Wet OB 1968
  /// art. 6 lid 2), or the KOR exemption while that applies; services with
  /// BTW verlegd in another member state and services outside the EU
  /// elsewhere. The user can pick another that fits.
  VatTreatment suggestedVatTreatment({required bool korApplies}) {
    if (country == 'NL' || isConsumer) {
      return korApplies ? VatTreatment.kor : VatTreatment.standard;
    }
    return isEuCountry(country)
        ? VatTreatment.euServices
        : VatTreatment.servicesOutsideEu;
  }
}

/// How a purchase counts, an expense or an asset, shared by the forms and
/// the calculations.
abstract final class PurchaseMath {
  /// The business share of [amount].
  static int share(int amount, double businessUsePct) =>
      (amount * businessUsePct).round();

  /// The cost before the business share: BTW that is not reclaimed is part
  /// of it (Wet IB 2001 art. 3.43 lid 1, `docs/legal.md`).
  static int cost({
    required int amountExclVat,
    required int vatAmount,
    required bool vatReclaimable,
  }) => amountExclVat + (vatReclaimable ? 0 : vatAmount);

  /// The cost for income tax: the business share of [cost].
  static int deductible({
    required int amountExclVat,
    required int vatAmount,
    required double businessUsePct,
    required bool vatReclaimable,
  }) => share(
    cost(
      amountExclVat: amountExclVat,
      vatAmount: vatAmount,
      vatReclaimable: vatReclaimable,
    ),
    businessUsePct,
  );

  static int vatToReclaim({
    required int vatAmount,
    required double businessUsePct,
    required bool vatReclaimable,
  }) => vatReclaimable ? share(vatAmount, businessUsePct) : 0;
}

/// A purchase as the BTW return counts it: the base and BTW of shifted
/// purchases (2a, 4a, 4b) and the BTW reclaimed (5b).
typedef Purchase = ({
  DateTime date,
  int base,
  PurchaseVat purchaseVat,
  int vat,
  int vatToReclaim,
});

extension ExpenseDomain on Expense {
  Purchase get asPurchase => (
    date: date,
    base: amountExclVat,
    purchaseVat: purchaseVat,
    vat: vatAmount,
    vatToReclaim: vatToReclaim,
  );

  /// This expense with its BTW not reclaimed, as the KOR requires.
  Expense withoutVatReclaim() => copyWith(
    vatReclaimable: false,
    vatToReclaim: 0,
    deductibleAmount: PurchaseMath.deductible(
      amountExclVat: amountExclVat,
      vatAmount: vatAmount,
      businessUsePct: businessUsePct,
      vatReclaimable: false,
    ),
  );
}

extension FixedAssetDomain on FixedAsset {
  Purchase get asPurchase => (
    date: purchaseDate,
    base: costExclVat,
    purchaseVat: purchaseVat,
    vat: vatAmount,
    vatToReclaim: vatToReclaim,
  );

  /// The investment for income tax: the price and any BTW not reclaimed.
  int get cost => PurchaseMath.cost(
    amountExclVat: costExclVat,
    vatAmount: vatAmount,
    vatReclaimable: vatReclaimable,
  );

  /// The business share of the proceeds, the base of the BTW on a sale.
  int get businessProceeds =>
      PurchaseMath.share(disposalProceeds ?? 0, businessUsePct);

  /// This asset with its purchase BTW not reclaimed, as the KOR requires.
  FixedAsset withoutVatReclaim() =>
      copyWith(vatReclaimable: false, vatToReclaim: 0);

  /// This asset with no BTW on its sale, which the KOR exempts.
  FixedAsset withoutSaleVat() => copyWith(
    disposalVatRate: const Value(null),
    disposalVatAmount: const Value(null),
  );
}

extension ExpenseCategoryDomain on ExpenseCategory {
  /// Costs the law keeps out of the profit whatever their amount: fines
  /// (Wet IB 2001 art. 3.14 lid 1 c), and clothing other than werkkleding,
  /// personal care, a phone line at home and general literature (art. 3.16
  /// lid 2 a to d). `docs/legal.md`, Costs that are not deductible.
  bool get barredForIncomeTax => switch (this) {
    ExpenseCategory.fines ||
    ExpenseCategory.clothingAndCare ||
    ExpenseCategory.homePhoneLine ||
    ExpenseCategory.generalLiterature => true,
    _ => false,
  };
}

extension MileageTripDomain on MileageTrip {
  int get distanceKm => odometerEnd - odometerStart;
}

extension HourEntryDomain on HourEntry {
  bool get billable => workType == WorkType.billable;
}

/// The user's own hours in [entries], for the urencriterium: the fiscal
/// partner's hours are not the user's.
double ownHours(Iterable<HourEntry> entries) =>
    entries.where((e) => !e.byPartner).fold(0.0, (s, e) => s + e.hours);

/// The fiscal partner's logged hours in [entries], for the meewerkaftrek.
double partnerLoggedHours(Iterable<HourEntry> entries) =>
    entries.where((e) => e.byPartner).fold(0.0, (s, e) => s + e.hours);
