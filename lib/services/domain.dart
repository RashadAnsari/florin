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

extension InvoiceDomain on Invoice {
  /// Issued invoices count for revenue and BTW; drafts do not.
  bool get isIssued => status != InvoiceStatus.draft;

  DateTime get dueDate => invoiceDate.add(Duration(days: paymentTermDays));

  bool get isCreditNote => invoiceType == InvoiceType.creditNote;

  /// +1 for an invoice, -1 for a credit note, which reduces every total.
  int get sign => isCreditNote ? -1 : 1;

  /// The amount excl. VAT as it counts in totals: negative for a credit note.
  int get signedExclVat => sign * totalExclVat;

  int get signedInclVat => sign * totalInclVat;

  bool get isOverdue =>
      status == InvoiceStatus.sent && dueDate.isBefore(DateTime.now());
}

/// The last day to issue the invoice for a supply on [supply]: the 15th of
/// the next month (Wet OB 1968 art. 34g).
DateTime latestInvoiceDate(DateTime supply) =>
    DateTime(supply.year, supply.month + 1, 15);

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
  /// The rate as Dutch documents print it: invoice PDFs and CSV exports.
  String get dutchLabel => switch (this) {
    VatRate.high => '21%',
    VatRate.low => '9%',
    VatRate.zero => '0%',
    VatRate.exempt => 'Vrijgesteld',
  };
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
  /// The treatment a new invoice to this client starts with: Dutch BTW in
  /// the Netherlands, or the KOR exemption while that applies; services with
  /// BTW verlegd in another member state and services outside the EU
  /// elsewhere. The user can pick another that fits.
  VatTreatment suggestedVatTreatment({required bool korApplies}) {
    if (country == 'NL') {
      return korApplies ? VatTreatment.kor : VatTreatment.standard;
    }
    return isEuCountry(country)
        ? VatTreatment.euServices
        : VatTreatment.servicesOutsideEu;
  }
}

/// How an expense counts, shared by the expense form and the calculations.
abstract final class ExpenseMath {
  /// The cost for income tax: BTW that is not reclaimed is part of it.
  static int deductible({
    required int amountExclVat,
    required int vatAmount,
    required double businessUsePct,
    required bool vatReclaimable,
  }) => ((amountExclVat + (vatReclaimable ? 0 : vatAmount)) * businessUsePct)
      .round();

  static int vatToReclaim({
    required int vatAmount,
    required double businessUsePct,
    required bool vatReclaimable,
  }) => vatReclaimable ? (vatAmount * businessUsePct).round() : 0;
}

extension ExpenseDomain on Expense {
  /// This expense with its BTW not reclaimed, as the KOR requires.
  Expense withoutVatReclaim() => copyWith(
    vatReclaimable: false,
    vatToReclaim: 0,
    deductibleAmount: ExpenseMath.deductible(
      amountExclVat: amountExclVat,
      vatAmount: vatAmount,
      businessUsePct: businessUsePct,
      vatReclaimable: false,
    ),
  );
}

extension MileageTripDomain on MileageTrip {
  int get distanceKm => odometerEnd - odometerStart;
}

extension HourEntryDomain on HourEntry {
  bool get billable => workType == WorkType.billable;
}
