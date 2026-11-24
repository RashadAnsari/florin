import '../db/database.dart';
import 'asset_service.dart';
import 'domain.dart';
import 'tax_rules/car_reductions.dart';
import 'tax_rules/tax_year_rules.dart';

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

  static int _days(DateTime a, DateTime b) => b.difference(a).inDays + 1;

  static int _yearDays(int year) =>
      DateTime(year + 1).difference(DateTime(year)).inDays;

  static Iterable<MileageTrip> _tripsIn(
    List<MileageTrip> trips,
    FixedAsset car,
  ) => trips.where((t) => t.carAssetId == car.id);

  /// Car costs in [year]: linked expenses and depreciation. The income tax
  /// addition cannot exceed them.
  static int carCosts(FixedAsset car, List<Expense> expenses, int year) =>
      expenses
          .where((e) => e.carAssetId == car.id && e.date.year == year)
          .fold(0, (s, e) => s + e.deductibleAmount) +
      AssetService.depreciation(car, year);

  /// Whether a complete trip log shows at most the private kilometres the
  /// rules allow a year, over all business cars.
  static bool _underPrivateLimit(
    List<FixedAsset> cars,
    List<MileageTrip> trips,
    int year,
    TaxYearRules rules,
  ) {
    var annualised = 0.0;
    for (final car in cars) {
      if (!car.keepsTripLog) return false;
      final period = _period(car, year);
      if (period == null) continue;
      final privateKm = _tripsIn(trips, car)
          .where((t) => t.tripType == TripType.private && t.date.year == year)
          .fold(0, (s, t) => s + t.distanceKm);
      annualised += privateKm * _yearDays(year) / _days(period.$1, period.$2);
    }
    return annualised <= rules.carPrivateKmLimit;
  }

  /// The yearly addition for [car] on [day], before proration.
  static double _annualAddition(
    FixedAsset car,
    DateTime day,
    TaxYearRules rules,
  ) {
    final reg = car.firstRegistration ?? car.purchaseDate;
    final value = _moreThanYearsAgo(reg, day, rules.carMarketValueAfterYears)
        ? (car.marketValue ?? car.catalogueValue ?? 0)
        : (car.catalogueValue ?? 0);
    final rate = _moreThanYearsAgo(reg, day, rules.carOldAfterYears)
        ? rules.carOldBijtellingRate
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

  /// Whether [from] lies more than [years] years before [day]: "meer dan
  /// vijftien jaar geleden" (art. 3.20 lid 1 and 5 b). On the anniversary
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
      final cap = carCosts(car, expenses, year);
      total += addition.round() < cap ? addition.round() : cap;
    }
    return total;
  }

  /// The BTW to pay for private use of business cars in [year], reported in
  /// rubriek 1d of the last return of the year.
  static int btwPrivateUse({
    required List<FixedAsset> assets,
    required List<MileageTrip> trips,
    required List<Expense> expenses,
    required int year,
    required TaxYearRules rules,
  }) {
    var total = 0;
    for (final car in _cars(assets)) {
      final period = _period(car, year);
      if (period == null) continue;
      final costVat = expenses
          .where((e) => e.carAssetId == car.id && e.date.year == year)
          .fold(0, (s, e) => s + e.vatToReclaim);
      final purchaseYear = car.purchaseDate.year;
      final purchaseShare =
          car.vatToReclaim > 0 &&
              year < purchaseYear + rules.btwPrivateCarPurchaseYears
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
      if (car.keepsTripLog && totalKm > 0) {
        // Commuting is private use for BTW.
        final privateKm = yearTrips
            .where((t) => t.tripType != TripType.business)
            .fold(0, (s, t) => s + t.distanceKm);
        amount = deductedThisYear * privateKm / totalKm;
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
      total += amount.round();
    }
    return total;
  }
}
