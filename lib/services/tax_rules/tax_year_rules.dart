import '../../db/enums.dart';
import 'tax_year_2026.dart';

/// One linear segment of a statutory table: `base + rate × (amount − from)`,
/// at most [cap], for amounts up to and including [upTo]. All amounts are
/// in cents.
class Segment {
  final int? upTo;
  final int base;
  final double rate;
  final int from;
  final int? cap;

  const Segment({
    this.upTo,
    this.base = 0,
    this.rate = 0,
    this.from = 0,
    this.cap,
  });
}

/// A statutory table such as a heffingskorting or the KIA, made of
/// [Segment]s in ascending order. Amounts above the last segment yield 0.
class SegmentTable {
  final List<Segment> segments;

  const SegmentTable(this.segments);

  int valueFor(int amount) {
    if (amount <= 0) return 0;
    for (final s in segments) {
      if (s.upTo == null || amount <= s.upTo!) {
        var v = (s.base + s.rate * (amount - s.from)).round();
        if (s.cap != null && v > s.cap!) v = s.cap!;
        return v < 0 ? 0 : v;
      }
    }
    return 0;
  }
}

/// A box 1 bracket: [rate] applies to income up to and including [upTo].
class TaxBracket {
  final int? upTo;
  final double rate;

  const TaxBracket({this.upTo, required this.rate});
}

/// The zero-emission reduction of the private-use addition for a car, as a
/// share of the car's value with a maximum amount (Wet IB 2001 art. 3.20 lid 2).
class CarReduction {
  final double rate;
  final int max;

  const CarReduction(this.rate, this.max);
}

/// Statutory figures for one tax year, for an ondernemer under the AOW age.
/// Every value is sourced in `docs/tax-years/<year>.md`.
class TaxYearRules {
  final int year;
  final List<TaxBracket> box1Brackets;
  final SegmentTable algemeneHeffingskorting;
  final SegmentTable arbeidskorting;
  final int zelfstandigenaftrek;
  final int startersaftrek;
  final double mkbWinstvrijstelling;

  /// The rate at which the ondernemersaftrek and mkb-winstvrijstelling are
  /// taxed back above the start of the top bracket (art. 2.10 lid 2).
  final double tariefaanpassingRate;
  final int urencriterium;
  final double zvwRate;
  final int zvwMaxIncome;
  final SegmentTable kia;
  final int kiaMinAssetCost;
  final double eiaRate;
  final int eiaMiaMinAssetCost;
  final Map<MiaCategory, double> miaRates;

  /// Total sales at or below this need no desinvesteringsbijtelling.
  final int desinvesteringDrempel;
  final int soAftrek;
  final int soStarterIncrease;
  final int soMinHours;

  /// Meewerkaftrek: share of profit by the partner's hours, ascending.
  final List<(int minHours, double rate)> meewerkaftrek;
  final int stakingsaftrekMax;

  /// Startersaftrek bij arbeidsongeschiktheid by times used in the five
  /// previous years: 0, 1, 2.
  final List<int> disabilityStartersaftrek;
  final int reducedUrencriterium;
  final int gemengdeKostenDrempel;
  final double carBijtellingRate;
  final double carOldBijtellingRate;
  final CarReduction carZeroEmissionReduction;
  final double btwPrivateCarRate;
  final double btwPrivateCarReducedRate;
  final int mileageCentsPerKm;

  /// Most turnover in the Netherlands in a calendar year for the
  /// kleineondernemersregeling (Wet OB 1968 art. 25a lid 1).
  final int korThreshold;
  final double gemengdeKostenPct;
  final double jaarruimtePct;
  final int aowFranchise;
  final int jaarruimteMax;
  final int reserveringsruimteMax;
  final double factorAMultiplier;

  const TaxYearRules({
    required this.year,
    required this.box1Brackets,
    required this.algemeneHeffingskorting,
    required this.arbeidskorting,
    required this.zelfstandigenaftrek,
    required this.startersaftrek,
    required this.mkbWinstvrijstelling,
    required this.tariefaanpassingRate,
    required this.urencriterium,
    required this.zvwRate,
    required this.zvwMaxIncome,
    required this.kia,
    required this.kiaMinAssetCost,
    required this.eiaRate,
    required this.eiaMiaMinAssetCost,
    required this.miaRates,
    required this.desinvesteringDrempel,
    required this.soAftrek,
    required this.soStarterIncrease,
    required this.soMinHours,
    required this.meewerkaftrek,
    required this.stakingsaftrekMax,
    required this.disabilityStartersaftrek,
    required this.reducedUrencriterium,
    required this.gemengdeKostenDrempel,
    required this.carBijtellingRate,
    required this.carOldBijtellingRate,
    required this.carZeroEmissionReduction,
    required this.btwPrivateCarRate,
    required this.btwPrivateCarReducedRate,
    required this.mileageCentsPerKm,
    required this.korThreshold,
    required this.gemengdeKostenPct,
    required this.jaarruimtePct,
    required this.aowFranchise,
    required this.jaarruimteMax,
    required this.reserveringsruimteMax,
    required this.factorAMultiplier,
  });

  /// Where the top bracket starts: "het in de eerste kolom van de in het
  /// eerste lid opgenomen tabel laatstvermelde bedrag" (art. 2.10 lid 2).
  int get topBracketStart => box1Brackets[box1Brackets.length - 2].upTo!;

  /// Box 1 tax per bracket on [income], in bracket order.
  List<int> box1TaxPerBracket(int income) {
    final result = <int>[];
    var lower = 0;
    for (final b in box1Brackets) {
      final upper = b.upTo;
      final taxed = income <= lower
          ? 0
          : (upper == null ? income : (income < upper ? income : upper)) -
                lower;
      result.add((taxed * b.rate).round());
      if (upper == null) break;
      lower = upper;
    }
    return result;
  }

  int box1Tax(int income) => box1TaxPerBracket(income).fold(0, (s, t) => s + t);
}

/// Every tax year whose figures have been verified against primary sources.
const Map<int, TaxYearRules> taxYears = {2026: taxYear2026};

/// The verified rules for [year], or null when the year has not been added.
/// A missing year is never filled in from another year.
TaxYearRules? taxRulesFor(int year) => taxYears[year];

/// The years users can select and book into, ascending.
final List<int> supportedYears = taxYears.keys.toList()..sort();

/// The supported year closest to [year].
int nearestSupportedYear(int year) => supportedYears.reduce(
  (a, b) => (a - year).abs() <= (b - year).abs() ? a : b,
);
