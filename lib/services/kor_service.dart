import '../db/database.dart';
import 'domain.dart';
import 'tax_rules/tax_year_rules.dart';

/// The kleineondernemersregeling for one business: whether it applies on a
/// date and how far the turnover is from the limit. Rules, sources and quotes
/// are in `docs/legal.md`, Kleineondernemersregeling.
class KorStatus {
  /// The first day the scheme applies, or null when the user does not take
  /// part.
  final DateTime? start;

  /// The first day it no longer applies after a voluntary deregistration.
  final DateTime? end;

  /// Per calendar year, the date of the supply that took the turnover past
  /// the limit. The scheme ends with that supply, for the rest of that year
  /// and the next (Wet OB 1968 art. 25a lid 9), and applies again only from
  /// a new start.
  final Map<int, DateTime> exceededOn;

  /// Per calendar year, the turnover that counts for the limit.
  final Map<int, int> turnover;

  const KorStatus({
    required this.start,
    required this.end,
    required this.exceededOn,
    required this.turnover,
  });

  static const none = KorStatus(
    start: null,
    end: null,
    exceededOn: {},
    turnover: {},
  );

  bool get participates => start != null;

  /// Whether the scheme covers supplies and purchases on [date].
  bool appliesOn(DateTime date) {
    final s = start;
    if (s == null || date.isBefore(s)) return false;
    if (end != null && !date.isBefore(end!)) return false;
    for (final d in exceededOn.values) {
      if (date.isBefore(d)) continue;
      // Passing the limit ends the scheme; it applies again only after a new
      // registration, at the earliest two calendar years later (art. 25a
      // lid 5 and 9).
      if (!s.isAfter(d) || date.year <= d.year + 1) return false;
    }
    return true;
  }

  /// For a start of the scheme on [date], the first day a start is possible
  /// again when the limit was passed before [date] in that year or the year
  /// before (art. 25a lid 9), or null when [date] is not blocked.
  DateTime? startBlockedUntil(DateTime date) {
    for (final d in exceededOn.values) {
      final until = DateTime(d.year + 2);
      if (date.isAfter(d) && date.isBefore(until)) return until;
    }
    return null;
  }

  /// Whether the scheme covers every day from [first] to [last], so no
  /// regular return is due for that period.
  bool covers(DateTime first, DateTime last) {
    if (!appliesOn(first) || !appliesOn(last)) return false;
    final exceeded = exceededOn[first.year];
    return exceeded == null || exceeded.isAfter(last);
  }

  /// Whether the scheme applies on any day from [first] to [last].
  bool touches(DateTime first, DateTime last) {
    for (
      var d = first;
      !d.isAfter(last);
      d = DateTime(d.year, d.month, d.day + 1)
    ) {
      if (appliesOn(d)) return true;
    }
    return false;
  }
}

abstract final class KorService {
  /// Whether an invoice with [treatment] counts for the turnover limit. The
  /// Belastingdienst counts supplies at 21%, 9% and 0% including exports and
  /// intra-Community supplies, and domestic reverse charge; not supplies
  /// taxed in another country. Florin cannot tell which exemption an exempt
  /// line has, so it counts them all: the cautious reading.
  static bool counts(VatTreatment treatment) => switch (treatment) {
    VatTreatment.standard ||
    VatTreatment.reverseChargeNl ||
    VatTreatment.euGoods ||
    VatTreatment.exportOutsideEu ||
    VatTreatment.kor => true,
    VatTreatment.euServices || VatTreatment.servicesOutsideEu => false,
  };

  /// Whether issued invoice [i] counts for the turnover. The sale of an
  /// asset Florin depreciates does not (art. 25 lid 2): [assetSales] holds
  /// the invoices that sell one, and their credit notes follow them.
  static bool _countsInvoice(Invoice i, Set<int> assetSales) =>
      i.isIssued &&
      counts(i.vatTreatment) &&
      !assetSales.contains(i.id) &&
      !assetSales.contains(i.correctedInvoiceId);

  /// The turnover that counts, from issued invoices for supplies made in
  /// [year] up to and including [through], leaving out [excludingId]. A
  /// supply counts on the day it was made, the supply date when it precedes
  /// the invoice (art. 25 lid 1 a).
  static int turnover(
    Iterable<Invoice> invoices,
    int year, {
    DateTime? through,
    int? excludingId,
    Set<int> assetSales = const {},
  }) => invoices
      .where(
        (i) =>
            _countsInvoice(i, assetSales) &&
            i.id != excludingId &&
            i.suppliedOn.year == year &&
            (through == null || !i.suppliedOn.isAfter(through)),
      )
      .fold(0, (s, i) => s + i.signedExclVat);

  /// The status from the profile and every issued invoice. Years without
  /// verified rules have no known limit and are left out.
  static KorStatus status(
    BusinessProfile? profile,
    List<Invoice> invoices, {
    Set<int> assetSales = const {},
  }) {
    final byYear = <int, List<Invoice>>{};
    for (final i in invoices) {
      if (_countsInvoice(i, assetSales)) {
        byYear.putIfAbsent(i.suppliedOn.year, () => []).add(i);
      }
    }
    final exceeded = <int, DateTime>{};
    final totals = <int, int>{};
    for (final MapEntry(key: year, value: list) in byYear.entries) {
      final limit = taxYears[year]?.korThreshold;
      list.sort((a, b) {
        final byDate = a.suppliedOn.compareTo(b.suppliedOn);
        return byDate != 0 ? byDate : a.id.compareTo(b.id);
      });
      var total = 0;
      for (final i in list) {
        total += i.signedExclVat;
        if (limit != null && total > limit && !exceeded.containsKey(year)) {
          exceeded[year] = i.suppliedOn;
        }
      }
      totals[year] = total;
    }
    return KorStatus(
      start: profile?.korStart,
      end: profile?.korEnd,
      exceededOn: exceeded,
      turnover: totals,
    );
  }

  /// Whether an invoice of [amount] excl. VAT for a supply made on [date]
  /// with [treatment] takes the turnover past [limit], counting the other
  /// issued invoices of that year up to that date.
  static bool wouldExceed({
    required Iterable<Invoice> invoices,
    required DateTime date,
    required VatTreatment treatment,
    required int amount,
    required int limit,
    int? excludingId,
    Set<int> assetSales = const {},
  }) {
    if (!counts(treatment)) return false;
    final before = turnover(
      invoices,
      date.year,
      through: date,
      excludingId: excludingId,
      assetSales: assetSales,
    );
    return before + amount > limit;
  }

  /// The KOR treatment fits a supply in the Netherlands; a service taxed in
  /// another country keeps its own treatment.
  static bool coveredSupply(VatTreatment treatment) =>
      treatment != VatTreatment.euServices &&
      treatment != VatTreatment.servicesOutsideEu;

  /// [expenses] as they count while the scheme applies: no BTW is deducted,
  /// so it becomes part of the cost (art. 25a lid 4).
  static List<Expense> applyToExpenses(
    List<Expense> expenses,
    KorStatus status,
  ) => [
    for (final e in expenses)
      status.appliesOn(e.date) && e.vatReclaimable ? e.withoutVatReclaim() : e,
  ];

  /// [assets] as they count while the scheme applies: no BTW on a purchase
  /// is deducted, so it becomes part of the cost, and a sale without an
  /// invoice carries no BTW, as the scheme exempts it (art. 25a lid 1 and 4).
  /// A sale invoiced in Florin follows its invoice's treatment.
  static List<FixedAsset> applyToAssets(
    List<FixedAsset> assets,
    KorStatus status,
  ) => [for (final a in assets) _applyToAsset(a, status)];

  static FixedAsset _applyToAsset(FixedAsset a, KorStatus status) {
    var counted = status.appliesOn(a.purchaseDate) && a.vatReclaimable
        ? a.withoutVatReclaim()
        : a;
    final sold = a.disposalDate;
    if (sold != null &&
        a.disposalInvoiceId == null &&
        a.disposalVatRate != null &&
        status.appliesOn(sold)) {
      counted = counted.withoutSaleVat();
    }
    return counted;
  }

  /// The share of supplies from [from] to [to], both included, that is
  /// taxed rather than exempt under the scheme: by turnover when the period
  /// has any, else by the days the scheme does not cover.
  static double taxedShare(
    KorStatus status,
    List<Invoice> invoices,
    DateTime from,
    DateTime to,
  ) {
    final end = DateTime(to.year, to.month, to.day + 1);
    var taxed = 0, exempt = 0;
    for (final i in invoices) {
      if (!i.isIssued ||
          i.invoiceDate.isBefore(from) ||
          !i.invoiceDate.isBefore(end)) {
        continue;
      }
      if (i.vatTreatment == VatTreatment.kor) {
        exempt += i.signedExclVat;
      } else {
        taxed += i.signedExclVat;
      }
    }
    if (taxed + exempt > 0) return taxed / (taxed + exempt);
    var days = 0, free = 0;
    for (
      var d = DateTime(from.year, from.month, from.day);
      d.isBefore(end);
      d = DateTime(d.year, d.month, d.day + 1)
    ) {
      days++;
      if (!status.appliesOn(d)) free++;
    }
    return days == 0 ? 1 : free / days;
  }

  /// The days of [year] whose figures set the taxed share of [asset]: the
  /// whole boekjaar (Uitvoeringsbeschikking OB 1968 art. 12 lid 3), up to
  /// the sale in the year of sale.
  static (DateTime, DateTime) _useIn(FixedAsset asset, int year) {
    final sold = asset.disposalDate;
    final end = sold != null && sold.year == year
        ? sold
        : DateTime(year, 12, 31);
    return (DateTime(year), end);
  }

  /// The BTW to repay in [year] on assets whose purchase BTW was deducted,
  /// because the scheme lowers the taxed share of their use (herziening,
  /// `docs/legal.md`). Only a year in which the asset is in the business on
  /// a day the scheme applies is revised. In the year of purchase the whole
  /// deduction follows that year's share (Uitvoeringsbeschikking OB 1968
  /// art. 12 lid 3); in
  /// the later years of the period one part a year follows the change from
  /// the first year's share (art. 13 lid 3). These go in [yearEnd], for the
  /// last return of the year. A later year's change of at most
  /// [TaxYearRules.vatRevisionMinShift] of the first year's share, and the
  /// later years' total below [TaxYearRules.korRevisionMin], are not
  /// revised (art. 13 lid 4). A sale while the scheme applies settles the
  /// remaining years at once as exempt use (art. 13a lid 1 b); it goes in
  /// [sales], for the return of the sale's period (art. 13a lid 2). BTW the
  /// user may get back on leaving the scheme is not computed: the cautious
  /// side.
  static ({Map<FixedAsset, int> yearEnd, Map<FixedAsset, int> sales}) revision({
    required KorStatus status,
    required List<FixedAsset> assets,
    required List<Invoice> invoices,
    required int year,
    required TaxYearRules rules,
  }) {
    if (!status.participates) return (yearEnd: const {}, sales: const {});
    final firstYear = <FixedAsset, int>{};
    final laterYears = <FixedAsset, int>{};
    final sales = <FixedAsset, int>{};
    for (final a in assets) {
      final bought = a.purchaseDate.year;
      if (a.vatToReclaim <= 0 ||
          year < bought ||
          year >= bought + rules.vatRevisionYears ||
          (a.disposalDate != null && a.disposalDate!.year < year)) {
        continue;
      }
      // The deduction was made for full taxed use. An asset that is not in
      // the business on any day the scheme applies in the year served only
      // taxed supplies and keeps its deduction (art. 11 lid 1 a).
      final (from, to) = _useIn(a, year);
      final inUse = a.purchaseDate.isAfter(from) ? a.purchaseDate : from;
      if (!status.touches(inUse, to)) continue;
      final share = taxedShare(status, invoices, from, to);
      final (firstFrom, firstTo) = _useIn(a, bought);
      final first = year == bought
          ? 1.0
          : taxedShare(status, invoices, firstFrom, firstTo).clamp(0.0, 1.0);
      final sold = a.disposalDate;
      final soldExempt =
          sold != null && sold.year == year && status.appliesOn(sold);
      final shift = first - (soldExempt ? 0.0 : share);
      if (shift <= 0 ||
          (year != bought && shift <= rules.vatRevisionMinShift * first)) {
        continue;
      }
      if (soldExempt) {
        final remaining = bought + rules.vatRevisionYears - year;
        sales[a] = (a.vatToReclaim * remaining / rules.vatRevisionYears * shift)
            .round();
      } else if (year == bought) {
        firstYear[a] = (a.vatToReclaim * shift).round();
      } else {
        laterYears[a] = (a.vatToReclaim / rules.vatRevisionYears * shift)
            .round();
      }
    }
    final later = laterYears.values.fold(0, (s, v) => s + v);
    return (
      yearEnd: {...firstYear, if (later >= rules.korRevisionMin) ...laterYears},
      sales: sales,
    );
  }
}
