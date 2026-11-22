import '../db/database.dart';
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
  /// Wet IB 2001 art. 3.30 lid 2: at most 20% of the cost a year.
  static const minUsefulLifeYears = 5;

  /// Years after the year of formation in which the herinvesteringsreserve
  /// must be used, after which it is added to the profit.
  static const reserveTermYears = 3;

  /// Years after the start of the purchase year in which a sale leads to a
  /// desinvesteringsbijtelling.
  static const desinvesteringYears = 5;

  // Depreciation

  /// The business share of cost above the residual value, after any
  /// herinvesteringsreserve booked off on it.
  static double _depreciable(FixedAsset a) =>
      (a.costExclVat - a.reinvestmentReserveApplied - a.residualValue) *
      a.businessUsePct;

  /// Straight-line depreciation written off up to [moment], spread by day
  /// over the useful life and stopped at disposal.
  static int _writtenOffBy(FixedAsset a, DateTime moment) {
    final p = a.purchaseDate;
    final lifeEnd = DateTime(p.year + a.usefulLifeYears, p.month, p.day);
    final disposal = a.disposalDate?.add(const Duration(days: 1));
    final until = disposal != null && disposal.isBefore(moment)
        ? disposal
        : moment;
    final fraction = (until.difference(p).inDays / lifeEnd.difference(p).inDays)
        .clamp(0.0, 1.0);
    return (_depreciable(a) * fraction).round();
  }

  static int depreciation(FixedAsset a, int year) =>
      _writtenOffBy(a, DateTime(year + 1)) - _writtenOffBy(a, DateTime(year));

  static int totalDepreciation(List<FixedAsset> assets, int year) =>
      assets.fold(0, (s, a) => s + depreciation(a, year));

  /// Book value of the business share at the end of [year], or at disposal.
  static int bookValue(FixedAsset a, int year) =>
      ((a.costExclVat - a.reinvestmentReserveApplied) * a.businessUsePct)
          .round() -
      _writtenOffBy(a, DateTime(year + 1));

  static bool _soldIn(FixedAsset a, int year) => a.disposalDate?.year == year;

  /// Business share of the proceeds minus the book value at sale.
  static int saleResult(FixedAsset a) {
    final year = a.disposalDate!.year;
    final proceeds = ((a.disposalProceeds ?? 0) * a.businessUsePct).round();
    return proceeds - bookValue(a, year);
  }

  /// Gains and losses on assets sold in [year], without gains put in the
  /// herinvesteringsreserve.
  static int disposalResult(List<FixedAsset> assets, int year) =>
      assets.where((a) => _soldIn(a, year)).fold(0, (s, a) {
        final r = saleResult(a);
        return s + (a.reserveGain && r > 0 ? 0 : r);
      });

  /// Gains on assets sold in [year], the stakingswinst when the business
  /// stops.
  static int saleGains(List<FixedAsset> assets, int year) => assets
      .where((a) => _soldIn(a, year))
      .fold(0, (s, a) => s + (saleResult(a) > 0 ? saleResult(a) : 0));

  // Investeringsaftrek

  static bool _countsForKia(FixedAsset a, TaxYearRules rules) =>
      a.kiaEligible &&
      a.kind != AssetKind.car &&
      a.costExclVat >= rules.kiaMinAssetCost;

  /// Investments in [year] that count towards the KIA.
  static int kiaInvestments(
    List<FixedAsset> assets,
    int year,
    TaxYearRules rules,
  ) => assets
      .where((a) => a.purchaseDate.year == year && _countsForKia(a, rules))
      .fold(0, (s, a) => s + a.costExclVat);

  static int _eia(FixedAsset a, TaxYearRules rules) =>
      a.eiaEligible && a.costExclVat >= rules.eiaMiaMinAssetCost
      ? (a.costExclVat * rules.eiaRate).round()
      : 0;

  static int _mia(FixedAsset a, TaxYearRules rules) =>
      a.miaCategory != null && a.costExclVat >= rules.eiaMiaMinAssetCost
      ? (a.costExclVat * rules.miaRates[a.miaCategory]!).round()
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
        received += (rules.kia.valueFor(total) * a.costExclVat / total).round();
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
      if (year >= a.purchaseDate.year + desinvesteringYears) return s;
      final received = deductionReceived(a, assets);
      if (received <= 0 || a.costExclVat <= 0) return s;
      final addBack = ((a.disposalProceeds ?? 0) * received / a.costExclVat)
          .round();
      return s + (addBack < received ? addBack : received);
    });
  }

  // Herinvesteringsreserve

  /// The reserve per year, from the first year with a reserved gain to
  /// [untilYear]. Applications use the oldest reserve first. A reserve not
  /// used within [reserveTermYears] after its year is released, and all of
  /// it is released in [ceasedYear].
  static Map<int, ReserveYear> reserveLedger(
    List<FixedAsset> assets,
    int untilYear, {
    int? ceasedYear,
  }) {
    final formedIn = <int, int>{};
    for (final a in assets) {
      if (a.disposalDate == null || !a.reserveGain) continue;
      final gain = saleResult(a);
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
        if (y == ceasedYear || pools[i].$1 + reserveTermYears <= y) {
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
