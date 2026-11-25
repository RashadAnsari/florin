import '../db/database.dart';
import 'car_service.dart';
import 'domain.dart';
import 'kor_service.dart';
import 'tax_rules/tax_year_rules.dart';

/// Which return a quarter needs (`docs/legal.md`, Filing a return).
enum ReturnDuty {
  /// The regular return, also when there is nothing to report.
  regular,

  /// The KOR covers the quarter but BTW is owed in it, such as BTW shifted
  /// to the user. The user asks the Belastingdienst for this return.
  incidental,

  /// The KOR covers the quarter and no BTW is owed in it.
  none,
}

/// One period of the BTW return, by rubriek. Amounts are in cents, signed
/// so that credit notes reduce them.
class VatReturnResult {
  final int revenue1a;
  final int vat1a;
  final int revenue1b;
  final int vat1b;
  final int revenue1e;

  /// BTW on private use (rubriek 1d).
  final int vat1d;
  final int revenue3a;
  final int revenue3b;

  /// Purchases with BTW shifted to you: domestic (2a), from outside the EU
  /// (4a) and from EU countries (4b). Base and BTW.
  final int base2a;
  final int vat2a;
  final int base4a;
  final int vat4a;
  final int base4b;
  final int vat4b;
  final int inputVat5b;

  /// Supplies to EU businesses for the ICP-opgaaf, leaving out those made
  /// while the KOR applies (Wet OB 1968 art. 37a lid 1).
  final List<Invoice> icpInvoices;

  /// Services to businesses outside the EU. Not part of the return; shown
  /// so the user sees where that revenue went.
  final int revenueOutsideReturn;

  /// Supplies exempt under the KOR. Not part of the return either.
  final int revenueKorExempt;

  final ReturnDuty duty;

  /// BTW deducted on assets to repay because the KOR lowered their taxed
  /// use (herziening), per asset. Added to the BTW of rubriek 1a in the
  /// last return of the year, as the Belastingdienst instructs.
  final Map<FixedAsset, int> vatRevision;

  int get vatRevisionTotal => vatRevision.values.fold(0, (s, v) => s + v);

  /// Corrections of earlier filed periods carried into this return, per
  /// rubriek as (base, BTW), already added to the figures above.
  final Map<String, (int, int)> carriedCorrections;

  /// The earlier periods those corrections come from, with their figures as
  /// they are now, kept as filed once this return is filed.
  final Map<VatPeriod, Map<String, (int, int)>> carriedFrom;

  /// For a filed period: how its records now differ from what was filed,
  /// per rubriek. Empty when nothing changed or the period is not filed.
  final Map<String, (int, int)> changedSinceFiled;

  const VatReturnResult({
    required this.revenue1a,
    required this.vat1a,
    required this.revenue1b,
    required this.vat1b,
    required this.revenue1e,
    required this.vat1d,
    required this.revenue3a,
    required this.revenue3b,
    required this.base2a,
    required this.vat2a,
    required this.base4a,
    required this.vat4a,
    required this.base4b,
    required this.vat4b,
    required this.inputVat5b,
    required this.icpInvoices,
    this.revenueOutsideReturn = 0,
    this.revenueKorExempt = 0,
    this.duty = ReturnDuty.regular,
    this.vatRevision = const {},
    this.carriedCorrections = const {},
    this.carriedFrom = const {},
    this.changedSinceFiled = const {},
  });

  /// The figures per rubriek as the form asks them, (base, BTW) in cents.
  Map<String, (int, int)> get rubrieken => {
    '1a': (revenue1a, vat1a),
    '1b': (revenue1b, vat1b),
    '1d': (0, vat1d),
    '1e': (revenue1e, 0),
    '2a': (base2a, vat2a),
    '3a': (revenue3a, 0),
    '3b': (revenue3b, 0),
    '4a': (base4a, vat4a),
    '4b': (base4b, vat4b),
    '5b': (0, inputVat5b),
  };

  /// This return with [corrections] of earlier periods added, from
  /// [from], and [changed] as the change since it was filed.
  VatReturnResult withCorrections({
    Map<String, (int, int)> corrections = const {},
    Map<VatPeriod, Map<String, (int, int)>> from = const {},
    Map<String, (int, int)> changed = const {},
  }) {
    (int, int) c(String r) => corrections[r] ?? (0, 0);
    final net = VatService.netVatOf(corrections);
    return VatReturnResult(
      revenue1a: revenue1a + c('1a').$1,
      vat1a: vat1a + c('1a').$2,
      revenue1b: revenue1b + c('1b').$1,
      vat1b: vat1b + c('1b').$2,
      revenue1e: revenue1e + c('1e').$1,
      vat1d: vat1d + c('1d').$2,
      revenue3a: revenue3a + c('3a').$1,
      revenue3b: revenue3b + c('3b').$1,
      base2a: base2a + c('2a').$1,
      vat2a: vat2a + c('2a').$2,
      base4a: base4a + c('4a').$1,
      vat4a: vat4a + c('4a').$2,
      base4b: base4b + c('4b').$1,
      vat4b: vat4b + c('4b').$2,
      inputVat5b: inputVat5b + c('5b').$2,
      icpInvoices: icpInvoices,
      revenueOutsideReturn: revenueOutsideReturn,
      revenueKorExempt: revenueKorExempt,
      // A correction that changes the BTW needs a return, also in a period
      // the KOR covers.
      duty: duty == ReturnDuty.none && net != 0 ? ReturnDuty.incidental : duty,
      vatRevision: vatRevision,
      carriedCorrections: corrections,
      carriedFrom: from,
      changedSinceFiled: changed,
    );
  }

  /// Nothing to report in any rubriek: the return is a nil return.
  bool get isEmpty =>
      revenue1a == 0 &&
      revenue1b == 0 &&
      revenue1e == 0 &&
      vat1d == 0 &&
      revenue3a == 0 &&
      revenue3b == 0 &&
      base2a == 0 &&
      base4a == 0 &&
      base4b == 0 &&
      inputVat5b == 0;

  int get outputVat5a => vat1a + vat1b + vat1d + vat2a + vat4a + vat4b;

  /// Positive: to pay. Negative: to get back.
  int get netVat => outputVat5a - inputVat5b;
}

abstract final class VatService {
  /// Days before a deadline at which it is shown as urgent.
  static const urgentDeadlineDays = 14;

  /// Rubrieken per the Belastingdienst guidance in `docs/legal.md`. Exempt
  /// supplies, supplies exempt under the KOR and services to businesses
  /// outside the EU are not reported. [expenses] and [assets] are as they
  /// count, with the KOR applied: an asset's purchase counts like an
  /// expense, and its sale without an invoice like a supply at its rate.
  static VatReturnResult calculateQuarter({
    required List<Invoice> invoices,
    required List<InvoiceLine> lines,
    required List<Expense> expenses,
    List<FixedAsset> assets = const [],
    required int year,
    required int quarter,
    int privateUseVat = 0,
    KorStatus kor = KorStatus.none,
    Map<FixedAsset, int> vatRevision = const {},
  }) => calculatePeriod(
    invoices: invoices,
    lines: lines,
    expenses: expenses,
    assets: assets,
    period: (year: year, kind: VatFilingPeriod.quarterly, number: quarter),
    privateUseVat: privateUseVat,
    kor: kor,
    vatRevision: vatRevision,
  );

  /// The return of [period] from the records as they count (the KOR and the
  /// rule on gifts applied): the herziening and the BTW on private use of a
  /// car go in the last return of the year.
  static VatReturnResult fromRecords({
    required List<Invoice> invoices,
    required List<InvoiceLine> lines,
    required List<Expense> expenses,
    required List<FixedAsset> assets,
    required List<MileageTrip> trips,
    required VatPeriod period,
    required KorStatus kor,
    required TaxYearRules rules,
  }) => calculatePeriod(
    invoices: invoices,
    lines: lines,
    expenses: expenses,
    assets: assets,
    period: period,
    kor: kor,
    vatRevision: period.isLastOfYear
        ? KorService.revision(
            status: kor,
            assets: assets,
            invoices: invoices,
            year: period.year,
            rules: rules,
          )
        : const {},
    privateUseVat: period.isLastOfYear
        ? CarService.btwPrivateUse(
            assets: assets,
            trips: trips,
            expenses: expenses,
            year: period.year,
            rules: rules,
          )
        : 0,
  );

  /// The return of one [period], as [calculateQuarter] describes.
  static VatReturnResult calculatePeriod({
    required List<Invoice> invoices,
    required List<InvoiceLine> lines,
    required List<Expense> expenses,
    List<FixedAsset> assets = const [],
    required VatPeriod period,
    int privateUseVat = 0,
    KorStatus kor = KorStatus.none,
    Map<FixedAsset, int> vatRevision = const {},
  }) {
    bool inQuarter(DateTime d) => period.contains(d);
    final linesByInvoice = <int, List<InvoiceLine>>{};
    for (final line in lines) {
      linesByInvoice.putIfAbsent(line.invoiceId, () => []).add(line);
    }

    var r1a = 0, v1a = 0, r1b = 0, v1b = 0, r1e = 0, r3a = 0, r3b = 0;
    var outside = 0, korExempt = 0;
    void supply(VatRate rate, int base, int vat) {
      switch (rate) {
        case VatRate.high:
          r1a += base;
          v1a += vat;
        case VatRate.low:
          r1b += base;
          v1b += vat;
        case VatRate.zero:
          r1e += base;
        case VatRate.exempt:
          break;
      }
    }

    final icp = <Invoice>[];
    for (final inv in invoices) {
      if (!inv.isIssued || !inQuarter(inv.vatDate)) continue;
      final sign = inv.sign;
      switch (inv.vatTreatment) {
        case VatTreatment.reverseChargeNl:
          r1e += inv.signedExclVat;
        case VatTreatment.euServices:
        case VatTreatment.euGoods:
          r3b += inv.signedExclVat;
          // A KOR participant files no ICP-opgaaf (art. 37a lid 1).
          if (!kor.appliesOn(inv.vatDate)) icp.add(inv);
        case VatTreatment.exportOutsideEu:
          r3a += inv.signedExclVat;
        case VatTreatment.servicesOutsideEu:
          outside += inv.signedExclVat;
        case VatTreatment.kor:
          korExempt += inv.signedExclVat;
        case VatTreatment.standard:
          for (final line in linesByInvoice[inv.id] ?? const <InvoiceLine>[]) {
            supply(
              line.vatRate,
              sign * line.lineTotalExclVat,
              sign * line.vatAmount,
            );
          }
      }
    }
    // A sale invoiced in Florin is in that invoice; the BTW on a sale or
    // withdrawal without one is on the asset (Wet OB 1968 art. 3 lid 3 a).
    for (final a in assets) {
      final rate = a.disposalVatRate;
      if (a.disposalDate == null ||
          !inQuarter(a.disposalDate!) ||
          a.disposalInvoiceId != null ||
          rate == null) {
        continue;
      }
      supply(rate, a.businessProceeds, a.disposalVatAmount ?? 0);
    }

    final purchases = [
      for (final e in expenses)
        if (inQuarter(e.date)) e.asPurchase,
      for (final a in assets)
        if (inQuarter(a.purchaseDate)) a.asPurchase,
    ];
    final inputVat = purchases.fold(0, (s, p) => s + p.vatToReclaim);
    int base(PurchaseVat p) => purchases
        .where((e) => e.purchaseVat == p)
        .fold(0, (s, e) => s + e.base);
    int vat(PurchaseVat p) =>
        purchases.where((e) => e.purchaseVat == p).fold(0, (s, e) => s + e.vat);

    // BTW owed in a period is paid on a return (art. 14 lid 1), so a KOR
    // quarter with BTW owed, such as BTW shifted to the user, needs one.
    final owed =
        v1a +
        v1b +
        privateUseVat +
        vatRevision.values.fold(0, (s, v) => s + v) +
        vat(PurchaseVat.reverseChargeNl) +
        vat(PurchaseVat.fromOutsideEu) +
        vat(PurchaseVat.fromEu);
    final duty = !kor.covers(period.first, period.last)
        ? ReturnDuty.regular
        : owed != 0
        ? ReturnDuty.incidental
        : ReturnDuty.none;

    return VatReturnResult(
      revenue1a: r1a,
      vat1a: v1a + vatRevision.values.fold(0, (s, v) => s + v),
      revenue1b: r1b,
      vat1b: v1b,
      revenue1e: r1e,
      vat1d: privateUseVat,
      revenue3a: r3a,
      revenue3b: r3b,
      base2a: base(PurchaseVat.reverseChargeNl),
      vat2a: vat(PurchaseVat.reverseChargeNl),
      base4a: base(PurchaseVat.fromOutsideEu),
      vat4a: vat(PurchaseVat.fromOutsideEu),
      base4b: base(PurchaseVat.fromEu),
      vat4b: vat(PurchaseVat.fromEu),
      inputVat5b: inputVat,
      icpInvoices: icp,
      revenueOutsideReturn: outside,
      revenueKorExempt: korExempt,
      duty: duty,
      vatRevision: vatRevision,
    );
  }

  /// Supplies with Dutch BTW to consumers in other member states in [year],
  /// excl. BTW, by invoice date. Florin cannot tell which of them are
  /// electronic services or distance sales, so this is the most they can be
  /// for the threshold of Wet OB 1968 art. 6k: the cautious figure.
  static int euConsumerSales(
    List<Invoice> invoices,
    Map<int, Client> clients,
    int year,
  ) => invoices
      .where(
        (i) =>
            i.isIssued &&
            i.invoiceDate.year == year &&
            i.vatTreatment == VatTreatment.standard &&
            (clients[i.clientId]?.isEuConsumerAbroad ?? false),
      )
      .fold(0, (s, i) => s + i.signedExclVat);

  /// The last day of the term after [period] that the rules of its year
  /// give: the last day of the month after a month or quarter, and the
  /// later term for a yearly return.
  static DateTime filingDeadline(VatPeriod period) {
    final rules = taxRulesFor(period.year)!;
    final months = period.kind == VatFilingPeriod.yearly
        ? rules.vatYearlyReturnDueMonths
        : rules.vatReturnDueMonths;
    final end = period.last;
    return DateTime(end.year, end.month + months + 1, 0);
  }

  /// [now] minus [filed] per rubriek, leaving out rubrieken that did not
  /// change.
  static Map<String, (int, int)> difference(
    Map<String, (int, int)> now,
    Map<String, (int, int)> filed,
  ) => {
    for (final r in {...now.keys, ...filed.keys})
      if ((now[r] ?? (0, 0)) != (filed[r] ?? (0, 0)))
        r: (
          (now[r]?.$1 ?? 0) - (filed[r]?.$1 ?? 0),
          (now[r]?.$2 ?? 0) - (filed[r]?.$2 ?? 0),
        ),
  };

  /// The BTW to pay that [rubrieken] add up to: the BTW of rubrieken 1 to 4
  /// minus the voorbelasting of 5b.
  static int netVatOf(Map<String, (int, int)> rubrieken) => rubrieken.entries
      .fold(0, (s, e) => s + (e.key == '5b' ? -e.value.$2 : e.value.$2));

  /// Whether a change to a filed return goes into the next return (true) or
  /// needs a suppletie (false), by its BTW (Belastingdienst, Btw-aangifte
  /// corrigeren). The page does not say how changes in several rubrieken add
  /// up, so Florin asks both the net change and each rubriek's change to
  /// stay within the amount: the reading that sends more to a suppletie.
  static bool fitsNextReturn(Map<String, (int, int)> change, TaxYearRules r) =>
      netVatOf(change).abs() <= r.correctionNextReturnMax &&
      change.entries.every(
        (e) => e.value.$2.abs() <= r.correctionNextReturnMax,
      );

  /// Whether a year's figures break a condition for a yearly return: BTW to
  /// pay of at least the limit, or EU supplies or EU purchases of at least
  /// their limit. Florin keeps goods and services together where the
  /// Belastingdienst counts them apart, so it flags sooner: the cautious
  /// side.
  static bool yearlyFilingIssue(VatReturnResult year, TaxYearRules rules) =>
      year.netVat >= rules.yearlyFilingMaxVat ||
      year.revenue3b >= rules.yearlyFilingMaxEu ||
      year.base4b >= rules.yearlyFilingMaxEu;

  /// The last day of the ICP-opgaaf over a quarter: the last day of the
  /// month after it (Wet OB 1968 art. 37a lid 1 and 3).
  static DateTime icpDeadline(int year, int quarter) =>
      DateTime(year, quarter * 3 + taxRulesFor(year)!.icpDueMonths + 1, 0);
}
