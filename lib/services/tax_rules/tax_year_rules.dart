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

  /// Travel and stay for courses, studies and congresses deductible in a
  /// year; the part above it is not (Wet IB 2001 art. 3.16 lid 2 f).
  final int courseTravelMax;
  final double carBijtellingRate;
  final double carOldBijtellingRate;
  final CarReduction carZeroEmissionReduction;
  final double btwPrivateCarRate;
  final double btwPrivateCarReducedRate;
  final int mileageCentsPerKm;

  /// Most turnover in the Netherlands in a calendar year for the
  /// kleineondernemersregeling (Wet OB 1968 art. 25a lid 1).
  final int korThreshold;

  /// Telecommunication, broadcasting and electronic services and distance
  /// sales to consumers in other member states, excl. BTW, above which they
  /// are taxed in the consumer's country (Wet OB 1968 art. 6k lid 1 c).
  final int euConsumerSalesThreshold;
  final double gemengdeKostenPct;
  final double jaarruimtePct;
  final int aowFranchise;

  /// Most income of the previous year that counts for the premiegrondslag,
  /// before the [aowFranchise] is subtracted (Wet IB 2001 art. 3.127 lid 3).
  final int premiegrondslagMaxIncome;
  final int reserveringsruimteMax;
  final double factorAMultiplier;

  // Rules the law sets without a yearly figure. They are here so that a
  // change in the law is a change in a year's rules, not in the code. The
  // reference of every field is in `docs/tax-years/README.md`.

  /// BTW rate per category (Wet OB 1968 art. 9).
  final Map<VatRate, double> vatRates;

  /// Months after the end of a quarter in which its BTW return and payment
  /// are due (AWR art. 19 lid 1).
  final int vatReturnDueMonths;

  /// Months after the year in which a yearly BTW return and payment are due
  /// (Belastingdienst, Uiterste aangifte- en betaaldatums).
  final int vatYearlyReturnDueMonths;

  /// BTW a year below which a yearly return may be asked for.
  final int yearlyFilingMaxVat;

  /// Each kind of intra-Community transaction a year below which a yearly
  /// return may be asked for.
  final int yearlyFilingMaxEu;

  /// Day of the month after the supply by which the invoice is due
  /// (Wet OB 1968 art. 34g).
  final int invoiceDueDay;

  /// Month of the next year on whose first day a voorlopige aanslag for
  /// this year can last be asked for or changed, without a letter asking
  /// for a return (Belastingdienst).
  final int provisionalAssessmentMonth;

  /// Days after receiving the invoice from which statutory commercial
  /// interest is due when no payment day was agreed (BW 6:119a lid 2).
  final int statutoryPaymentDays;

  /// Longest payment term two businesses agree on without stating it
  /// explicitly (BW 6:119a lid 5).
  final int maxAgreedPaymentDays;

  /// Longest payment term a large legal person may agree with a small
  /// supplier (BW 6:119a lid 6).
  final int largeDebtorMaxPaymentDays;

  /// Least collection costs owed between businesses, without a reminder,
  /// from the day after the payment day (BW 6:96 lid 4).
  final int minCollectionCosts;

  /// Days a private person gets in a reminder before collection costs are
  /// owed (BW 6:96 lid 6).
  final int consumerReminderDays;

  /// Years after the day a claim fell due in which it can be claimed in
  /// court (BW 3:307 lid 1).
  final int claimLimitationYears;

  /// Years invoices and receipts are kept (AWR art. 52 lid 4).
  final int retentionYears;

  /// Years after the tax became due in which the Belastingdienst can raise
  /// it afterwards, extended by any extra time to file (AWR art. 16 lid 3).
  final int navorderingYears;

  /// The same for income or assets held abroad (AWR art. 16 lid 4).
  final int navorderingForeignYears;

  /// Goods to EU businesses in a quarter above which the ICP-opgaaf is due
  /// per month.
  final int icpQuarterlyGoodsMax;

  /// Previous quarters that must also stay at or below
  /// [icpQuarterlyGoodsMax] for a quarterly ICP-opgaaf (art. 37a lid 3).
  final int icpGoodsLookbackQuarters;

  /// Months after the end of its period in which the ICP-opgaaf is due
  /// (art. 37a lid 1).
  final int icpDueMonths;

  /// Gifts to one person in a year at or below which their BTW stays
  /// deductible (Besluit uitsluiting aftrek omzetbelasting 1968 art. 4).
  final int buaGiftThreshold;

  /// Most depreciation a year as a share of the cost (Wet IB 2001 art. 3.30
  /// lid 2), which sets the shortest useful life.
  final double maxDepreciationRate;

  /// Years after the year it was formed in which the herinvesteringsreserve
  /// must be used (art. 3.54 lid 5).
  final int reinvestmentReserveYears;

  /// Years from the start of the purchase year in which a sale leads to a
  /// desinvesteringsbijtelling (art. 3.47 lid 2).
  final int desinvesteringYears;

  /// Months within which an EIA or MIA investment is reported to RVO.
  final int eiaMiaReportMonths;

  /// Years unrealised zelfstandigenaftrek is carried forward (art. 3.76
  /// lid 7).
  final int unrealisedZelfstandigenaftrekYears;

  /// A starter was not an ondernemer in one or more of this many previous
  /// years (art. 3.76 lid 3, 3.77 lid 2, 3.78a lid 1).
  final int starterLookbackYears;

  /// ... and had the zelfstandigenaftrek at most this many times in them
  /// (art. 3.76 lid 3).
  final int starterMaxZelfstandigenaftrek;

  /// ... and an S&O-verklaring for at most this many years in them, for the
  /// S&O starter increase (art. 3.77 lid 2).
  final int soStarterMaxYears;

  /// Pay to the partner below this counts as unpaid for the meewerkaftrek.
  final int meewerkMaxPartnerPay;

  /// Private kilometres a year at or below which no car addition applies
  /// (art. 3.20 lid 1 and 3).
  final int carPrivateKmLimit;

  /// A car older than this many years counts at its market value (art. 3.20
  /// lid 5 b).
  final int carMarketValueAfterYears;

  /// A car older than this many years gets [carOldBijtellingRate] (art. 3.20
  /// lid 1 b).
  final int carOldAfterYears;

  /// Months the zero-emission reduction of the registration year holds
  /// (art. 3.20 lid 11).
  final int carReductionFreezeMonths;

  /// Years the BTW deducted on an asset is followed: the year it came into
  /// use and the years after (Belastingdienst, herziening vanwege de KOR).
  final int vatRevisionYears;

  /// Change in the taxed share of use above which deducted BTW is revised.
  final double vatRevisionMinShift;

  /// A year's revision because the KOR starts or ends, on assets in use
  /// since earlier years, below which nothing is revised.
  final int korRevisionMin;

  /// BTW on private use: the reduced rate from this many years after the
  /// year the car came into use (Belastingdienst).
  final int btwPrivateCarReducedAfterYears;

  /// BTW on private use: the purchase BTW counts as one share of this many
  /// years in the cap (Belastingdienst).
  final int btwPrivateCarPurchaseYears;

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
    required this.courseTravelMax,
    required this.carBijtellingRate,
    required this.carOldBijtellingRate,
    required this.carZeroEmissionReduction,
    required this.btwPrivateCarRate,
    required this.btwPrivateCarReducedRate,
    required this.mileageCentsPerKm,
    required this.korThreshold,
    required this.euConsumerSalesThreshold,
    required this.gemengdeKostenPct,
    required this.jaarruimtePct,
    required this.aowFranchise,
    required this.premiegrondslagMaxIncome,
    required this.reserveringsruimteMax,
    required this.factorAMultiplier,
    required this.vatRates,
    required this.vatReturnDueMonths,
    required this.vatYearlyReturnDueMonths,
    required this.yearlyFilingMaxVat,
    required this.yearlyFilingMaxEu,
    required this.invoiceDueDay,
    required this.provisionalAssessmentMonth,
    required this.statutoryPaymentDays,
    required this.maxAgreedPaymentDays,
    required this.largeDebtorMaxPaymentDays,
    required this.minCollectionCosts,
    required this.consumerReminderDays,
    required this.claimLimitationYears,
    required this.retentionYears,
    required this.navorderingYears,
    required this.navorderingForeignYears,
    required this.icpQuarterlyGoodsMax,
    required this.icpGoodsLookbackQuarters,
    required this.icpDueMonths,
    required this.buaGiftThreshold,
    required this.maxDepreciationRate,
    required this.reinvestmentReserveYears,
    required this.desinvesteringYears,
    required this.eiaMiaReportMonths,
    required this.unrealisedZelfstandigenaftrekYears,
    required this.starterLookbackYears,
    required this.starterMaxZelfstandigenaftrek,
    required this.soStarterMaxYears,
    required this.meewerkMaxPartnerPay,
    required this.carPrivateKmLimit,
    required this.carMarketValueAfterYears,
    required this.carOldAfterYears,
    required this.carReductionFreezeMonths,
    required this.vatRevisionYears,
    required this.vatRevisionMinShift,
    required this.korRevisionMin,
    required this.btwPrivateCarReducedAfterYears,
    required this.btwPrivateCarPurchaseYears,
  });

  /// The BTW on [amountExclVat] at [rate].
  int vatOn(VatRate rate, int amountExclVat) =>
      (amountExclVat * vatRates[rate]!).round();

  /// The most jaarruimte: the share of the highest premiegrondslag
  /// (art. 3.127 lid 1 and 3).
  int get jaarruimteMax =>
      ((premiegrondslagMaxIncome - aowFranchise) * jaarruimtePct).round();

  /// The shortest useful life the depreciation limit allows.
  int get minUsefulLifeYears => (1 / maxDepreciationRate).ceil();

  /// The last day to issue the invoice for a supply on [supply].
  DateTime latestInvoiceDate(DateTime supply) =>
      DateTime(supply.year, supply.month + 1, invoiceDueDay);

  /// The last day to ask for or change a voorlopige aanslag for this year
  /// without a letter asking for a return; such a letter or uitstel sets
  /// its own date.
  DateTime get provisionalAssessmentDeadline =>
      DateTime(year + 1, provisionalAssessmentMonth);

  /// The last day records of the bookkeeping [year] must be kept: the end
  /// of the retention term after that year, the cautious reading of when
  /// the term starts.
  DateTime keepUntil(int year) => DateTime(year + retentionYears, 12, 31);

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
