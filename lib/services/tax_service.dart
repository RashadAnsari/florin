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

  /// Loon from employment, added to box 1 income (art. 3.1 lid 2).
  final int wages;
  final int taxableIncome;
  final List<int> bracketTax;

  /// Tax added back on deductions above the top bracket (art. 2.10 lid 2).
  final int tariefaanpassing;
  final int algemeneHeffingskorting;
  final int arbeidskorting;
  final int box1Tax;
  final int zvwContribution;

  /// Loonheffing withheld on the wages, settled in the return (art. 9.2).
  final int wageTaxWithheld;

  /// Box 1 tax on the wages alone, with their own heffingskortingen: what
  /// the year would cost without the business.
  final int wageOnlyTax;

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
    this.wages = 0,
    required this.taxableIncome,
    required this.bracketTax,
    required this.tariefaanpassing,
    required this.algemeneHeffingskorting,
    required this.arbeidskorting,
    required this.box1Tax,
    required this.zvwContribution,
    this.wageTaxWithheld = 0,
    this.wageOnlyTax = 0,
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

  /// Box 1 tax and Zvw contribution on all box 1 income, wages included.
  int get totalTax => box1Tax + zvwContribution;

  /// What the return leaves to pay after the loonheffing withheld; below
  /// zero it is a refund.
  int get taxToPay => totalTax - wageTaxWithheld;

  /// The tax the business adds on top of the tax on the wages alone.
  int get businessTax => totalTax - wageOnlyTax;
  int get netProfitAfterTax => grossProfit - businessTax;

  /// The business's tax as a share of gross profit, in basis points.
  int get effectiveTaxRate =>
      grossProfit > 0 ? businessTax * 10000 ~/ grossProfit : 0;
}

abstract final class TaxService {
  /// Revenue excl. VAT from issued invoices. An invoice in [assetSales]
  /// sells an asset: its amount is that asset's proceeds instead.
  static int grossRevenue(
    List<Invoice> invoices, {
    Set<int> assetSales = const {},
  }) => invoices
      .where(
        (i) =>
            i.invoiceType == InvoiceType.invoice &&
            i.isIssued &&
            !assetSales.contains(i.id),
      )
      .fold(0, (s, i) => s + i.totalExclVat);

  /// Credit notes excl. VAT, as a positive amount, leaving out those that
  /// correct the sale of an asset.
  static int creditNotes(
    List<Invoice> invoices, {
    Set<int> assetSales = const {},
  }) => invoices
      .where(
        (i) =>
            i.invoiceType == InvoiceType.creditNote &&
            i.isIssued &&
            !assetSales.contains(i.correctedInvoiceId),
      )
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

  /// The urencriterium (art. 3.6 lid 1): at least the yearly hours in the
  /// business and, with a job, more time in the business than in the job.
  /// Only logged hours count: assuming the hours would understate the tax
  /// (AGENTS.md rule 5).
  static bool meetsUrencriterium({
    required TaxYearRules rules,
    required double totalHours,
    required bool isStarter,
    required TaxYearInput? inputs,
  }) {
    final job = timeTestHours(isStarter: isStarter, inputs: inputs);
    return totalHours >= rules.urencriterium &&
        (job == null || totalHours > job);
  }

  /// The hours in employment the business hours must exceed (art. 3.6 lid 1
  /// a), or null without a job or when the user was not an ondernemer in
  /// one of the previous years (lid 1 b). A startersaftrek starter was not
  /// (art. 3.76 lid 3), so the condition does not apply to them either.
  static int? timeTestHours({
    required bool isStarter,
    required TaxYearInput? inputs,
  }) {
    final i = inputs;
    if (i == null || !i.employed || isStarter || i.notOndernemerBefore) {
      return null;
    }
    return i.employmentHours;
  }

  /// Box 1 tax on [wages] alone, after the heffingskortingen.
  static int wageOnlyTax(int wages, TaxYearRules rules) {
    if (wages <= 0) return 0;
    final gross = rules.box1Tax(wages);
    final credits =
        rules.algemeneHeffingskorting.valueFor(wages) +
        rules.arbeidskorting.valueFor(wages);
    return (gross - credits).clamp(0, gross);
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
    final uren = meetsUrencriterium(
      rules: rules,
      totalHours: totalHours,
      isStarter: isStarter,
      inputs: i,
    );
    final employed = i?.employed ?? false;
    final wages = employed ? i!.wages : 0;

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
    // Wages and profit are both inkomen uit werk en woning (art. 3.1 lid 2).
    final beforeLosses =
        belastbareWinst + wages - lijfrentePremium - aovPremium;
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
    // Arbeidsinkomen is profit and loon together (art. 8.1 lid 1 e).
    final ak = rules.arbeidskorting.valueFor(profit + wages);
    final box1 = (grossBox1 - ahk - ak).clamp(0, grossBox1);

    // The loon Zvw the employers paid the werkgeversheffing on lowers the
    // maximum for the profit (Zvw art. 43 lid 5).
    final zvwMax = rules.zvwMaxIncome - (employed ? i!.zvwWages : 0);
    final zvwBase = zvwMax <= 0 ? 0 : belastbareWinst.clamp(0, zvwMax);
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
      wages: wages,
      taxableIncome: taxableIncome,
      bracketTax: bracketTax,
      tariefaanpassing: tariefaanpassing,
      algemeneHeffingskorting: ahk,
      arbeidskorting: ak,
      box1Tax: box1,
      zvwContribution: zvw,
      wageTaxWithheld: employed ? i!.wageTaxWithheld : 0,
      wageOnlyTax: wageOnlyTax(wages, rules),
    );
  }
}
