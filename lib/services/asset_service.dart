import 'package:drift/drift.dart' show Value;

import '../db/database.dart';
import 'domain.dart';
import 'tax_rules/tax_year_rules.dart';

/// Investeringsaftrek of one year, by kind. Amounts in cents.
class InvestmentDeduction {
  final int kia;
  final int eia;
  final int mia;

  const InvestmentDeduction({this.kia = 0, this.eia = 0, this.mia = 0});

  int get total => kia + eia + mia;
}

/// The herinvesteringsreserve movements of one year. Amounts in cents.
class ReserveYear {
  final int formed;
  final int applied;
  final int released;

  /// The balance at the end of the year.
  final int balance;

  const ReserveYear({
    this.formed = 0,
    this.applied = 0,
    this.released = 0,
    this.balance = 0,
  });
}

/// Depreciation, investeringsaftrek, desinvesteringsbijtelling and the
/// herinvesteringsreserve. Sources: `docs/legal.md`.
abstract final class AssetService {
  /// Whether [a] belongs to the business on any day of [year].
  static bool inUse(FixedAsset a, int year) =>
      a.purchaseDate.year <= year &&
      (a.disposalDate == null || a.disposalDate!.year >= year);

  // Sales invoiced in Florin

  /// The invoices that sell an asset. Their amounts are the proceeds of that
  /// asset, not revenue, and do not count for the KOR (Wet OB 1968 art. 25
  /// lid 2).
  static Set<int> saleInvoiceIds(Iterable<FixedAsset> assets) => {
    for (final a in assets)
      if (a.disposalInvoiceId != null) a.disposalInvoiceId!,
  };

  /// What the sale invoice [invoiceId] and the credit notes that correct it
  /// come to, excl. VAT.
  static int invoicedProceeds(int invoiceId, Iterable<Invoice> invoices) =>
      invoices
          .where(
            (i) =>
                i.isIssued &&
                (i.id == invoiceId || i.correctedInvoiceId == invoiceId),
          )
          .fold(0, (s, i) => s + i.signedExclVat);

  /// [assets] with the proceeds of a sale invoiced in Florin taken from the
  /// invoice, so a later credit note is counted.
  static List<FixedAsset> withSaleInvoices(
    List<FixedAsset> assets,
    List<Invoice> invoices,
  ) => [
    for (final a in assets)
      a.disposalInvoiceId == null
          ? a
          : a.copyWith(
              disposalProceeds: Value(
                invoicedProceeds(a.disposalInvoiceId!, invoices),
              ),
            ),
  ];

  // Depreciation

  /// The business share of cost above the residual value, after any
  /// herinvesteringsreserve booked off on it.
  static double _depreciable(FixedAsset a) =>
      (a.cost - a.reinvestmentReserveApplied - a.residualValue) *
      a.businessUsePct;

  /// Straight-line depreciation written off up to [moment], spread by day
  /// over the useful life and stopped at disposal, and at most the maximum
  /// rate of the cost for each year in use (art. 3.30 lid 2).
  static int _writtenOffBy(FixedAsset a, DateTime moment, TaxYearRules rules) {
    final p = a.purchaseDate;
    final lifeEnd = DateTime(p.year + a.usefulLifeYears, p.month, p.day);
    final disposal = a.disposalDate?.add(const Duration(days: 1));
    final until = disposal != null && disposal.isBefore(moment)
        ? disposal
        : moment;
    final depreciable = _depreciable(a);
    final straight =
        depreciable *
        (until.difference(p).inDays / lifeEnd.difference(p).inDays).clamp(
          0.0,
          1.0,
        );
    final cap =
        rules.maxDepreciationRate *
        (a.cost - a.reinvestmentReserveApplied) *
        a.businessUsePct *
        _yearsBetween(p, until);
    final written = straight < cap ? straight : cap;
    return (written < depreciable ? written : depreciable).round();
  }

  /// The years from [from] to [until], each calendar year counted by its
  /// share of days, so a full year is 1 also in a leap year.
  static double _yearsBetween(DateTime from, DateTime until) {
    var years = 0.0;
    for (var y = from.year; y <= until.year; y++) {
      final start = DateTime.utc(y);
      final end = DateTime.utc(y + 1);
      final a = y == from.year ? DateTime.utc(y, from.month, from.day) : start;
      final b = y == until.year ? DateTime.utc(y, until.month, until.day) : end;
      if (b.isAfter(a)) {
        years += b.difference(a).inDays / end.difference(start).inDays;
      }
    }
    return years;
  }

  static int depreciation(FixedAsset a, int year, TaxYearRules rules) =>
      _writtenOffBy(a, DateTime(year + 1), rules) -
      _writtenOffBy(a, DateTime(year), rules);

  static int totalDepreciation(
    List<FixedAsset> assets,
    int year,
    TaxYearRules rules,
  ) => assets.fold(0, (s, a) => s + depreciation(a, year, rules));

  /// Book value of the business share at the end of [year], or at disposal.
  static int bookValue(FixedAsset a, int year, TaxYearRules rules) =>
      PurchaseMath.share(
        a.cost - a.reinvestmentReserveApplied,
        a.businessUsePct,
      ) -
      _writtenOffBy(a, DateTime(year + 1), rules);

  static bool _soldIn(FixedAsset a, int year) => a.disposalDate?.year == year;

  /// Business share of the proceeds minus the book value at sale.
  static int saleResult(FixedAsset a, TaxYearRules rules) =>
      a.businessProceeds - bookValue(a, a.disposalDate!.year, rules);

  /// Gains and losses on assets sold in [year], without gains put in the
  /// herinvesteringsreserve.
  static int disposalResult(
    List<FixedAsset> assets,
    int year,
    TaxYearRules rules,
  ) => assets.where((a) => _soldIn(a, year)).fold(0, (s, a) {
    final r = saleResult(a, rules);
    return s + (a.reserveGain && r > 0 ? 0 : r);
  });

  /// Gains on assets sold in [year], the stakingswinst when the business
  /// stops.
  static int saleGains(List<FixedAsset> assets, int year, TaxYearRules rules) =>
      assets.where((a) => _soldIn(a, year)).fold(0, (s, a) {
        final r = saleResult(a, rules);
        return s + (r > 0 ? r : 0);
      });

  // Investeringsaftrek, on the investment of art. 3.43 lid 1: [FixedAsset.cost]

  static bool _countsForKia(FixedAsset a, TaxYearRules rules) =>
      a.kiaEligible &&
      a.kind != AssetKind.car &&
      a.cost >= rules.kiaMinAssetCost;

  /// Investments in [year] that count towards the KIA.
  static int kiaInvestments(
    List<FixedAsset> assets,
    int year,
    TaxYearRules rules,
  ) => assets
      .where((a) => a.purchaseDate.year == year && _countsForKia(a, rules))
      .fold(0, (s, a) => s + a.cost);

  /// Art. 3.45 lid 1 d excludes passenger cars from the EIA. Florin cannot
  /// tell a passenger car from a van, so no car gets it: the cautious reading.
  /// The MIA does apply to cars (lid 3).
  static int _eia(FixedAsset a, TaxYearRules rules) =>
      a.eiaEligible &&
          a.kind != AssetKind.car &&
          a.cost >= rules.eiaMiaMinAssetCost
      ? (a.cost * rules.eiaRate).round()
      : 0;

  static int _mia(FixedAsset a, TaxYearRules rules) =>
      a.miaCategory != null && a.cost >= rules.eiaMiaMinAssetCost
      ? (a.cost * rules.miaRates[a.miaCategory]!).round()
      : 0;

  static InvestmentDeduction investmentDeduction(
    List<FixedAsset> assets,
    int year,
    TaxYearRules rules,
  ) {
    final bought = assets.where((a) => a.purchaseDate.year == year);
    return InvestmentDeduction(
      kia: rules.kia.valueFor(kiaInvestments(assets, year, rules)),
      eia: bought.fold(0, (s, a) => s + _eia(a, rules)),
      mia: bought.fold(0, (s, a) => s + _mia(a, rules)),
    );
  }

  /// Investeringsaftrek received for [a]: computed when Florin has the rules
  /// of the purchase year, otherwise what the user entered.
  static int deductionReceived(FixedAsset a, List<FixedAsset> assets) {
    final year = a.purchaseDate.year;
    final rules = taxRulesFor(year);
    if (rules == null) return a.investmentDeductionReceived ?? 0;
    var received = _eia(a, rules) + _mia(a, rules);
    if (_countsForKia(a, rules)) {
      final total = kiaInvestments(assets, year, rules);
      if (total > 0) {
        received += (rules.kia.valueFor(total) * a.cost / total).round();
      }
    }
    return received;
  }

  /// Desinvesteringsbijtelling for sales in [year] (Wet IB 2001 art. 3.47).
  static int desinvesteringsbijtelling(
    List<FixedAsset> assets,
    int year,
    TaxYearRules rules,
  ) {
    final sold = assets.where((a) => _soldIn(a, year)).toList();
    final proceeds = sold.fold(0, (s, a) => s + (a.disposalProceeds ?? 0));
    if (proceeds <= rules.desinvesteringDrempel) return 0;
    return sold.fold(0, (s, a) {
      if (year >= a.purchaseDate.year + rules.desinvesteringYears) return s;
      final received = deductionReceived(a, assets);
      if (received <= 0 || a.cost <= 0) return s;
      final addBack = ((a.disposalProceeds ?? 0) * received / a.cost).round();
      return s + (addBack < received ? addBack : received);
    });
  }

  // Herinvesteringsreserve

  /// The reserve per year, from the first year with a reserved gain to
  /// [untilYear]. Applications use the oldest reserve first. A reserve not
  /// used within the term of the rules of its year is released, and all of
  /// it is released in [ceasedYear].
  static Map<int, ReserveYear> reserveLedger(
    List<FixedAsset> assets,
    int untilYear,
    TaxYearRules rules, {
    int? ceasedYear,
  }) {
    final formedIn = <int, int>{};
    for (final a in assets) {
      if (a.disposalDate == null || !a.reserveGain) continue;
      final gain = saleResult(a, rules);
      if (gain > 0) {
        formedIn[a.disposalDate!.year] =
            (formedIn[a.disposalDate!.year] ?? 0) + gain;
      }
    }
    final appliedIn = <int, int>{};
    for (final a in assets) {
      if (a.reinvestmentReserveApplied > 0) {
        appliedIn[a.purchaseDate.year] =
            (appliedIn[a.purchaseDate.year] ?? 0) +
            a.reinvestmentReserveApplied;
      }
    }
    final years = {...formedIn.keys, ...appliedIn.keys};
    if (years.isEmpty) return {};
    final ledger = <int, ReserveYear>{};
    final pools = <(int, int)>[];
    final start = years.reduce((a, b) => a < b ? a : b);
    for (var y = start; y <= untilYear; y++) {
      final formed = formedIn[y] ?? 0;
      if (formed > 0) pools.add((y, formed));
      var toApply = appliedIn[y] ?? 0;
      var applied = 0;
      for (var i = 0; i < pools.length && toApply > 0; i++) {
        final take = pools[i].$2 < toApply ? pools[i].$2 : toApply;
        pools[i] = (pools[i].$1, pools[i].$2 - take);
        toApply -= take;
        applied += take;
      }
      var released = 0;
      for (var i = 0; i < pools.length; i++) {
        // A reserve is formed at a sale, which lies in a supported year.
        final term = taxRulesFor(pools[i].$1)!.reinvestmentReserveYears;
        if (y == ceasedYear || pools[i].$1 + term <= y) {
          released += pools[i].$2;
          pools[i] = (pools[i].$1, 0);
        }
      }
      pools.removeWhere((p) => p.$2 == 0);
      ledger[y] = ReserveYear(
        formed: formed,
        applied: applied,
        released: released,
        balance: pools.fold(0, (s, p) => s + p.$2),
      );
    }
    return ledger;
  }
}
