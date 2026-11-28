import '../db/database.dart';
import 'asset_service.dart';
import 'domain.dart';
import 'kor_service.dart';
import 'tax_rules/car_reductions.dart';
import 'tax_rules/tax_year_rules.dart';

/// What the trip log of one car in one year shows against the rules of the
/// Belastingdienst (`docs/legal.md`, Trip log).
class TripLogCheck {
  /// Trips logged in the car in the year.
  final int trips;

  /// Places where a trip starts at a higher odometer reading than the one
  /// before it ended: kilometres driven that are not in the log.
  final int gaps;
  final int gapKm;

  /// Places where a trip starts below where the one before it ended.
  final int overlaps;

  /// Trips marked as not the usual route without the route in the notes.
  final int routesMissing;

  const TripLogCheck({
    required this.trips,
    required this.gaps,
    required this.gapKm,
    required this.overlaps,
    required this.routesMissing,
  });

  bool get complete =>
      trips > 0 && gaps == 0 && overlaps == 0 && routesMissing == 0;
}

/// Private use of business cars: the income tax addition (Wet IB 2001
/// art. 3.20) and the BTW correction in rubriek 1d. Sources: `docs/legal.md`.
abstract final class CarService {
  static Iterable<FixedAsset> _cars(List<FixedAsset> assets) =>
      assets.where((a) => a.kind == AssetKind.car);

  /// First and last day the car belongs to the business in [year], or null.
  static (DateTime, DateTime)? _period(FixedAsset car, int year) {
    final first = car.purchaseDate.isAfter(DateTime(year))
        ? car.purchaseDate
        : DateTime(year);
    final end = DateTime(year, 12, 31);
    final last = car.disposalDate != null && car.disposalDate!.isBefore(end)
        ? car.disposalDate!
        : end;
    return last.isBefore(first) ? null : (first, last);
  }

  static int _yearDays(int year) =>
      DateTime(year + 1).difference(DateTime(year)).inDays;

  static Iterable<MileageTrip> _tripsIn(
    List<MileageTrip> trips,
    FixedAsset car,
  ) => trips.where((t) => t.carAssetId == car.id);

  /// Car costs in [year]: linked expenses and depreciation. The income tax
  /// addition cannot exceed them.
  static int carCosts(
    FixedAsset car,
    List<Expense> expenses,
    int year,
    TaxYearRules rules,
  ) =>
      expenses
          .where((e) => e.carAssetId == car.id && e.date.year == year)
          .fold(0, (s, e) => s + e.deductibleAmount) +
      AssetService.depreciation(car, year, rules);

  /// Checks the trips of [car] in [year] in odometer order: every kilometre
  /// must be in a trip, and a trip off the usual route must name the route.
  /// The make, type, plate and period of the car are on its record.
  static TripLogCheck checkTripLog(
    FixedAsset car,
    List<MileageTrip> trips,
    int year,
  ) {
    final list = _tripsIn(trips, car).where((t) => t.date.year == year).toList()
      ..sort(
        (a, b) => a.odometerStart != b.odometerStart
            ? a.odometerStart.compareTo(b.odometerStart)
            : a.date.compareTo(b.date),
      );
    var gaps = 0, gapKm = 0, overlaps = 0;
    for (var i = 1; i < list.length; i++) {
      final step = list[i].odometerStart - list[i - 1].odometerEnd;
      if (step > 0) {
        gaps++;
        gapKm += step;
      } else if (step < 0) {
        overlaps++;
      }
    }
    return TripLogCheck(
      trips: list.length,
      gaps: gaps,
      gapKm: gapKm,
      overlaps: overlaps,
      routesMissing: list
          .where((t) => t.routeDeviation && (t.notes ?? '').trim().isEmpty)
          .length,
    );
  }

  /// The user keeps a trip log for [car] and it holds up for [year]. An
  /// incomplete log counts as none, as the Belastingdienst says.
  static bool hasCompleteTripLog(
    FixedAsset car,
    List<MileageTrip> trips,
    int year,
  ) => car.keepsTripLog && checkTripLog(car, trips, year).complete;

  /// Whether a complete trip log shows at most the private kilometres the
  /// rules allow a year, over all business cars together: their private
  /// kilometres annualised over the days the business had a car
  /// (Fiscale informatie 2026, 6.4.1.2).
  static bool _underPrivateLimit(
    List<FixedAsset> cars,
    List<MileageTrip> trips,
    int year,
    TaxYearRules rules,
  ) {
    var privateKm = 0;
    final periods = <(DateTime, DateTime)>[];
    for (final car in cars) {
      final period = _period(car, year);
      if (period == null) continue;
      if (!hasCompleteTripLog(car, trips, year)) return false;
      periods.add(period);
      privateKm += _tripsIn(trips, car)
          .where((t) => t.tripType == TripType.private && t.date.year == year)
          .fold(0, (s, t) => s + t.distanceKm);
    }
    var carDays = 0;
    for (
      var d = DateTime(year);
      d.year == year;
      d = DateTime(d.year, d.month, d.day + 1)
    ) {
      if (periods.any((p) => !d.isBefore(p.$1) && !d.isAfter(p.$2))) {
        carDays++;
      }
    }
    return privateKm * _yearDays(year) / carDays <= rules.carPrivateKmLimit;
  }

  /// The yearly addition for [car] on [day], before proration.
  static double _annualAddition(
    FixedAsset car,
    DateTime day,
    TaxYearRules rules,
  ) {
    final reg = car.firstRegistration ?? car.purchaseDate;
    final catalogue = car.catalogueValue ?? 0;
    final market = car.marketValue ?? catalogue;
    // The statute takes the market value after carMarketValueAfterYears
    // (art. 3.20 lid 5 b), the Belastingdienst after carOldAfterYears; while
    // only one of them does, the higher value counts (`docs/legal.md`).
    final old = _moreThanYearsAgo(reg, day, rules.carOldAfterYears);
    final byStatute = _moreThanYearsAgo(
      reg,
      day,
      rules.carMarketValueAfterYears,
    );
    final value = old && byStatute
        ? market
        : old || byStatute
        ? (market > catalogue ? market : catalogue)
        : catalogue;
    final rate = old
        ? rules.carOldBijtellingRate
        : reg.year <= rules.carTransitionalLastYear
        ? rules.carTransitionalBijtellingRate
        : rules.carBijtellingRate;
    var addition = value * rate;
    if (car.zeroEmission != ZeroEmission.none) {
      final freezeStart = DateTime(reg.year, reg.month + 1);
      final freezeEnd = DateTime(
        freezeStart.year,
        freezeStart.month + rules.carReductionFreezeMonths,
      );
      // The reduction of the registration year: from that year's rules, or
      // for years before Florin's first one from the statute versions.
      final frozen =
          taxRulesFor(reg.year)?.carZeroEmissionReduction ??
          carReductionByRegistrationYear[reg.year];
      final reduction = frozen != null && day.isBefore(freezeEnd)
          ? frozen
          : rules.carZeroEmissionReduction;
      var cut = value * reduction.rate;
      if (car.zeroEmission == ZeroEmission.battery && cut > reduction.max) {
        cut = reduction.max.toDouble();
      }
      addition -= cut;
    }
    return addition < 0 ? 0 : addition;
  }

  /// Whether [from] lies more than [years] years before [day]: "meer dan 16
  /// jaar geleden" (art. 3.20 lid 1), "meer dan vijftien jaar" (lid 5 b). On the anniversary
  /// itself exactly that many years have passed, not more.
  static bool _moreThanYearsAgo(DateTime from, DateTime day, int years) =>
      day.isAfter(DateTime(from.year + years, from.month, from.day));

  /// The income tax addition for private use of all business cars in [year].
  static int privateUseAddition({
    required List<FixedAsset> assets,
    required List<MileageTrip> trips,
    required List<Expense> expenses,
    required int year,
    required TaxYearRules rules,
  }) {
    final cars = _cars(assets).where((c) => _period(c, year) != null).toList();
    if (cars.isEmpty || _underPrivateLimit(cars, trips, year, rules)) {
      return 0;
    }
    final yearDays = _yearDays(year);
    var total = 0;
    for (final car in cars) {
      final (first, last) = _period(car, year)!;
      var addition = 0.0;
      for (
        var d = first;
        !d.isAfter(last);
        d = DateTime(d.year, d.month, d.day + 1)
      ) {
        addition += _annualAddition(car, d, rules) / yearDays;
      }
      final cap = carCosts(car, expenses, year, rules);
      total += addition.round() < cap ? addition.round() : cap;
    }
    return total;
  }

  /// The BTW to pay for private use of business cars in [year], reported in
  /// rubriek 1d of the last return of the year, with the base of its left
  /// column: 0 on the fixed rate, the private share of the costs whose BTW
  /// was deducted with a trip log (Belastingdienst, Btw en privégebruik auto
  /// van de zaak). [underKor] says whether a car charged was in the business
  /// on a day [kor] applies: the sources Florin quotes do not settle whether
  /// BTW on private use is owed then, so Florin charges it, the cautious
  /// side (`docs/legal.md`).
  static ({int base, int vat, bool underKor}) btwPrivateUse({
    required List<FixedAsset> assets,
    required List<MileageTrip> trips,
    required List<Expense> expenses,
    required int year,
    required TaxYearRules rules,
    KorStatus kor = KorStatus.none,
  }) {
    var total = 0, totalBase = 0;
    var underKor = false;
    for (final car in _cars(assets)) {
      final period = _period(car, year);
      if (period == null) continue;
      final deducted = expenses.where(
        (e) => e.carAssetId == car.id && e.date.year == year,
      );
      final costVat = deducted.fold(0, (s, e) => s + e.vatToReclaim);
      final purchaseYear = car.purchaseDate.year;
      final inPurchaseYears =
          car.vatToReclaim > 0 &&
          year < purchaseYear + rules.btwPrivateCarPurchaseYears;
      final purchaseShare = inPurchaseYears
          ? car.vatToReclaim / rules.btwPrivateCarPurchaseYears
          : 0.0;
      if (costVat == 0 && purchaseShare == 0) continue;
      final deductedThisYear = costVat + purchaseShare;
      final yearTrips = _tripsIn(
        trips,
        car,
      ).where((t) => t.date.year == year).toList();
      final totalKm = yearTrips.fold(0, (s, t) => s + t.distanceKm);
      double amount;
      var base = 0.0;
      if (totalKm > 0 && hasCompleteTripLog(car, trips, year)) {
        // Commuting is private use for BTW.
        final privateKm = yearTrips
            .where((t) => t.tripType != TripType.business)
            .fold(0, (s, t) => s + t.distanceKm);
        final share = privateKm / totalKm;
        amount = deductedThisYear * share;
        final costs =
            deducted
                .where((e) => e.vatToReclaim > 0)
                .fold(
                  0,
                  (s, e) =>
                      s + PurchaseMath.share(e.amountExclVat, e.businessUsePct),
                ) +
            (inPurchaseYears
                ? PurchaseMath.share(car.costExclVat, car.businessUsePct) /
                      rules.btwPrivateCarPurchaseYears
                : 0.0);
        base = costs * share;
      } else {
        final reduced =
            car.vatToReclaim == 0 ||
            year > purchaseYear + rules.btwPrivateCarReducedAfterYears;
        final rate = reduced
            ? rules.btwPrivateCarReducedRate
            : rules.btwPrivateCarRate;
        final months = period.$2.month - period.$1.month + 1;
        amount = (car.catalogueValue ?? 0) * rate * months / 12;
        // The cap counts one fifth of the purchase BTW in the 4 years after
        // the year of purchase; in that year itself all of it was deducted.
        final cap = year == purchaseYear
            ? costVat + car.vatToReclaim
            : deductedThisYear;
        if (amount > cap) amount = cap.toDouble();
      }
      if (amount.round() > 0 && kor.touches(period.$1, period.$2)) {
        underKor = true;
      }
      total += amount.round();
      totalBase += base.round();
    }
    return (base: totalBase, vat: total, underKor: underKor);
  }
}
