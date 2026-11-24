import '../db/database.dart';
import 'asset_service.dart';
import 'domain.dart';
import 'tax_rules/tax_year_rules.dart';

/// Income tax estimate for one year. Amounts are in cents.
class TaxResult {
  final int grossRevenue;
  final int creditNotes;
  final int totalCosts;
  final int disposalResult;
  final int desinvesteringsbijtelling;
  final int carPrivateUse;
  final int reserveReleased;
  final InvestmentDeduction investmentDeduction;
  final int zelfstandigenaftrek;
  final int startersaftrek;
  final int unrealisedZelfstandigenaftrek;
  final int soAftrek;
  final int meewerkaftrek;
  final int disabilityStartersaftrek;
  final int stakingsaftrek;
  final int mkbWinstvrijstelling;
  final int belastbareWinst;
  final int lijfrenteDeduction;
  final int aovDeduction;
  final int lossOffset;
  final int taxableIncome;
  final List<int> bracketTax;

  /// Tax added back on deductions above the top bracket (art. 2.10 lid 2).
  final int tariefaanpassing;
  final int algemeneHeffingskorting;
  final int arbeidskorting;
  final int box1Tax;
  final int zvwContribution;

  const TaxResult({
    required this.grossRevenue,
    required this.creditNotes,
    required this.totalCosts,
    required this.disposalResult,
    required this.desinvesteringsbijtelling,
    required this.carPrivateUse,
    required this.reserveReleased,
    required this.investmentDeduction,
    required this.zelfstandigenaftrek,
    required this.startersaftrek,
    required this.unrealisedZelfstandigenaftrek,
    required this.soAftrek,
    required this.meewerkaftrek,
    required this.disabilityStartersaftrek,
    required this.stakingsaftrek,
    required this.mkbWinstvrijstelling,
    required this.belastbareWinst,
    required this.lijfrenteDeduction,
    required this.aovDeduction,
    required this.lossOffset,
    required this.taxableIncome,
    required this.bracketTax,
    required this.tariefaanpassing,
    required this.algemeneHeffingskorting,
    required this.arbeidskorting,
    required this.box1Tax,
    required this.zvwContribution,
  });

  int get netRevenue => grossRevenue - creditNotes;

  /// Revenue minus costs plus additions such as sale gains and private use.
  int get grossProfit =>
      netRevenue -
      totalCosts +
      disposalResult +
      desinvesteringsbijtelling +
      carPrivateUse +
      reserveReleased;
  int get profit => grossProfit - investmentDeduction.total;
  int get grossBox1Tax => bracketTax.fold(0, (s, t) => s + t);
  int get totalTax => box1Tax + zvwContribution;
  int get netProfitAfterTax => grossProfit - totalTax;

  /// Total tax as a share of gross profit, in basis points.
  int get effectiveTaxRate =>
      grossProfit > 0 ? totalTax * 10000 ~/ grossProfit : 0;
}

abstract final class TaxService {
  /// Revenue excl. VAT from issued invoices.
  static int grossRevenue(List<Invoice> invoices) => invoices
      .where((i) => i.invoiceType == InvoiceType.invoice && i.isIssued)
      .fold(0, (s, i) => s + i.totalExclVat);

  /// Credit notes excl. VAT, as a positive amount.
  static int creditNotes(List<Invoice> invoices) => invoices
      .where((i) => i.invoiceType == InvoiceType.creditNote && i.isIssued)
      .fold(0, (s, i) => s + i.totalExclVat);

  /// Food, drinks and representation costs of the year.
  static int gemengdeKosten(List<Expense> expenses) => expenses
      .where((e) => e.category == ExpenseCategory.foodAndRepresentation)
      .fold(0, (s, e) => s + e.deductibleAmount);

  /// The deductible part of food, drinks and representation: the better of
  /// 80% (Wet IB 2001 art. 3.15 lid 5) and the costs above the drempel
  /// (lid 1). The choice is made in the return, so Florin takes the higher.
  static int gemengdeKostenDeductible(int costs, TaxYearRules rules) {
    final pct = (costs * rules.gemengdeKostenPct).round();
    final aboveDrempel = costs - rules.gemengdeKostenDrempel;
    final best = pct > aboveDrempel ? pct : aboveDrempel;
    return best < 0 ? 0 : best;
  }

  /// Deductible business share of expenses, with the limit on food, drinks
  /// and representation.
  static int deductibleExpenses(List<Expense> expenses, TaxYearRules rules) {
    final food = gemengdeKosten(expenses);
    final other = expenses.fold(0, (s, e) => s + e.deductibleAmount) - food;
    return other + gemengdeKostenDeductible(food, rules);
  }

  /// Kilometres in a private vehicle deductible at the mileage rate.
  /// Commuting counts as business travel for income tax (Belastingdienst, see
  /// `docs/tax-years/`). Trips in a business car are not: its costs are.
  static int businessKm(List<MileageTrip> trips) => trips
      .where((t) => t.carAssetId == null && t.tripType != TripType.private)
      .fold(0, (s, t) => s + t.distanceKm);

  static int mileageAllowance(int businessKm, TaxYearRules rules) =>
      businessKm * rules.mileageCentsPerKm;

  /// The meewerkaftrek rate for the partner's [hours] (art. 3.78).
  static double meewerkRate(int hours, TaxYearRules rules) {
    var rate = 0.0;
    for (final (min, r) in rules.meewerkaftrek) {
      if (hours >= min) rate = r;
    }
    return rate;
  }

  static TaxResult calculate({
    required TaxYearRules rules,
    required int grossRevenue,
    required int creditNotes,
    required int deductibleExpenses,
    required int depreciation,
    required int disposalResult,
    required int mileageAllowance,
    required InvestmentDeduction investmentDeduction,
    required int desinvesteringsbijtelling,
    required int carPrivateUse,
    required int reserveReleased,
    required int stakingswinst,
    required double totalHours,
    required double soHours,
    // Whether the year is over, so the hours logged are all there will be.
    required bool hoursFinal,
    required bool isStarter,
    required TaxYearInput? inputs,
    required int lijfrentePremium,
    required int aovPremium,
  }) {
    final i = inputs;
    final totalCosts = deductibleExpenses + depreciation + mileageAllowance;
    final additions =
        disposalResult +
        desinvesteringsbijtelling +
        carPrivateUse +
        reserveReleased;
    final profit =
        grossRevenue -
        creditNotes -
        totalCosts +
        additions -
        investmentDeduction.total;
    // Only logged hours count: assuming the urencriterium would understate
    // the tax (AGENTS.md rule 5).
    final uren = totalHours >= rules.urencriterium;

    // Ondernemersaftrek (art. 3.74), in the order of the return.
    var zelfstandigenaftrek = 0;
    var startersaftrek = 0;
    var unrealisedUsed = 0;
    var soAftrek = 0;
    var meewerkaftrek = 0;
    var disabilityStarters = 0;
    var stakingsaftrek = 0;
    if (uren) {
      zelfstandigenaftrek = rules.zelfstandigenaftrek;
      if (isStarter) {
        startersaftrek = rules.startersaftrek;
      } else if (zelfstandigenaftrek > profit) {
        zelfstandigenaftrek = profit < 0 ? 0 : profit;
      }
      final room = profit - zelfstandigenaftrek - startersaftrek;
      final unrealised = i?.unrealisedZelfstandigenaftrek ?? 0;
      if (room > 0) unrealisedUsed = unrealised < room ? unrealised : room;
      if ((i?.hasSoVerklaring ?? false) && soHours >= rules.soMinHours) {
        soAftrek =
            rules.soAftrek +
            ((i?.soStarter ?? false) ? rules.soStarterIncrease : 0);
      }
      final meewerkBase = profit - stakingswinst;
      if (meewerkBase > 0) {
        meewerkaftrek = (meewerkBase * meewerkRate(i?.partnerHours ?? 0, rules))
            .round();
      }
    } else if (hoursFinal &&
        isStarter &&
        (i?.disabilityBenefit ?? false) &&
        totalHours >= rules.reducedUrencriterium) {
      final used = i?.disabilityStartersUsed ?? 0;
      if (used < rules.disabilityStartersaftrek.length) {
        final amount = rules.disabilityStartersaftrek[used];
        disabilityStarters = profit <= 0
            ? 0
            : (amount < profit ? amount : profit);
      }
    }
    if (i?.businessCeased ?? false) {
      final max = rules.stakingsaftrekMax - (i?.stakingsaftrekUsedBefore ?? 0);
      if (max > 0 && stakingswinst > 0) {
        stakingsaftrek = stakingswinst < max ? stakingswinst : max;
      }
    }

    final ondernemersaftrek =
        zelfstandigenaftrek +
        startersaftrek +
        unrealisedUsed +
        soAftrek +
        meewerkaftrek +
        disabilityStarters +
        stakingsaftrek;
    final afterOndernemersaftrek = profit - ondernemersaftrek;
    final mkb = (afterOndernemersaftrek * rules.mkbWinstvrijstelling).round();
    final belastbareWinst = afterOndernemersaftrek - mkb;
    final beforeLosses = belastbareWinst - lijfrentePremium - aovPremium;
    final carry = i?.lossCarryForward ?? 0;
    final lossOffset = beforeLosses <= 0
        ? 0
        : (carry < beforeLosses ? carry : beforeLosses);
    final taxableIncome = beforeLosses - lossOffset;

    final bracketTax = rules.box1TaxPerBracket(taxableIncome);
    // Art. 2.10 lid 2 and 3: the ondernemersaftrek, and the mkb-
    // winstvrijstelling while the profit after ondernemersaftrek is positive,
    // save at most the rate below the top bracket.
    final grondslagverminderend =
        ondernemersaftrek + (afterOndernemersaftrek > 0 ? mkb : 0);
    final aboveTop =
        taxableIncome + grondslagverminderend - rules.topBracketStart;
    final tariefaanpassing = grondslagverminderend <= 0 || aboveTop <= 0
        ? 0
        : ((aboveTop < grondslagverminderend
                      ? aboveTop
                      : grondslagverminderend) *
                  rules.tariefaanpassingRate)
              .round();
    final grossBox1 = bracketTax.fold(0, (s, t) => s + t) + tariefaanpassing;
    final ahk = rules.algemeneHeffingskorting.valueFor(taxableIncome);
    final ak = rules.arbeidskorting.valueFor(profit);
    final box1 = (grossBox1 - ahk - ak).clamp(0, grossBox1);

    final zvwBase = belastbareWinst.clamp(0, rules.zvwMaxIncome);
    final zvw = (zvwBase * rules.zvwRate).round();

    return TaxResult(
      grossRevenue: grossRevenue,
      creditNotes: creditNotes,
      totalCosts: totalCosts,
      disposalResult: disposalResult,
      desinvesteringsbijtelling: desinvesteringsbijtelling,
      carPrivateUse: carPrivateUse,
      reserveReleased: reserveReleased,
      investmentDeduction: investmentDeduction,
      zelfstandigenaftrek: zelfstandigenaftrek,
      startersaftrek: startersaftrek,
      unrealisedZelfstandigenaftrek: unrealisedUsed,
      soAftrek: soAftrek,
      meewerkaftrek: meewerkaftrek,
      disabilityStartersaftrek: disabilityStarters,
      stakingsaftrek: stakingsaftrek,
      mkbWinstvrijstelling: mkb,
      belastbareWinst: belastbareWinst,
      lijfrenteDeduction: lijfrentePremium,
      aovDeduction: aovPremium,
      lossOffset: lossOffset,
      taxableIncome: taxableIncome,
      bracketTax: bracketTax,
      tariefaanpassing: tariefaanpassing,
      algemeneHeffingskorting: ahk,
      arbeidskorting: ak,
      box1Tax: box1,
      zvwContribution: zvw,
    );
  }
}
