import '../db/database.dart';

class TaxResult {
  final int grossRevenue;
  final int creditNotes;
  final int netRevenue;
  final int totalExpenses;
  final int grossProfit;
  final int zelfstandigenaftrekApplied; // cents, negative
  final int startersaftrekApplied; // cents, negative
  final int wbsoDeductionApplied; // cents, positive
  final int ondernemersaftrekTotal; // cents, negative sum
  final int profitAfterOndernemer;
  final int mkbDeduction; // cents, positive
  final int kiaDeduction; // cents, positive
  final int lijrenteDeduction; // cents, positive
  final int taxableProfit;
  final int bracket1Tax;
  final int bracket2Tax;
  final int bracket3Tax;
  final int grossBox1Tax;
  final int algHeffingskortingApplied;
  final int arbeidskortingApplied;
  final int box1Tax; // after kortingen, min 0
  final int zvwContribution;
  final int totalTax;
  final int netProfitAfterTax;
  final int effectiveTaxRate; // basis points, e.g. 3200 = 32.00%

  const TaxResult({
    required this.grossRevenue,
    required this.creditNotes,
    required this.netRevenue,
    required this.totalExpenses,
    required this.grossProfit,
    required this.zelfstandigenaftrekApplied,
    required this.startersaftrekApplied,
    required this.wbsoDeductionApplied,
    required this.ondernemersaftrekTotal,
    required this.profitAfterOndernemer,
    required this.mkbDeduction,
    required this.kiaDeduction,
    required this.lijrenteDeduction,
    required this.taxableProfit,
    required this.bracket1Tax,
    required this.bracket2Tax,
    required this.bracket3Tax,
    required this.grossBox1Tax,
    required this.algHeffingskortingApplied,
    required this.arbeidskortingApplied,
    required this.box1Tax,
    required this.zvwContribution,
    required this.totalTax,
    required this.netProfitAfterTax,
    required this.effectiveTaxRate,
  });
}

class TaxService {
  const TaxService();

  static const double urencriteriumThreshold = 1225;
  static const double defaultMileageRatePerKm = 0.23;
  static const double kiaDecreaseRate = 0.0756;

  // ── Aggregation helpers ───────────────────────────────────────────────────

  static int computeGrossRevenue(List<Invoice> invoices) => invoices
      .where((i) => i.invoiceType == 'Invoice' && i.status != 'Draft')
      .fold<int>(0, (s, i) => s + i.totalExclVat);

  static int computeCreditNotes(List<Invoice> invoices) => invoices
      .where((i) => i.invoiceType == 'CreditNote' && i.status != 'Draft')
      .fold<int>(0, (s, i) => s + i.totalExclVat);

  static int computeDeductibleExpenses(List<Expense> expenses) =>
      expenses.fold<int>(0, (s, e) => s + e.deductibleAmount);

  static int computeBusinessKm(List<MileageTrip> trips) => trips
      .where((t) => t.tripType == 'Business')
      .fold<int>(0, (s, t) => s + t.distanceKm);

  static int computeMileageAllowance(int businessKm, double ratePerKm) =>
      (businessKm * ratePerKm * 100).round();

  static int computeKiaTotal(List<FixedAsset> assets, int year) => assets
      .where((a) => a.kiaEligible && a.fiscalYear == year)
      .fold<int>(0, (s, a) => s + a.costExclVat);

  static int computeTotalDepreciation(List<FixedAsset> assets, int year) =>
      assets.fold<int>(0, (s, a) {
        // Disposed before this fiscal year: no depreciation.
        if (a.disposalDate != null && a.disposalDate!.year < year) return s;

        final yrs = (year - a.purchaseDate.year).clamp(0, a.usefulLifeYears);
        if (yrs >= a.usefulLifeYears) return s;

        final annual = computeAnnualDepreciation(
          costExclVat: a.costExclVat,
          usefulLifeYears: a.usefulLifeYears,
          businessUsePct: a.businessUsePct,
        );

        // Disposed during this fiscal year: prorate from start of in-service
        // period to disposal date (Dutch IB Art. 3.30).
        if (a.disposalDate != null && a.disposalDate!.year == year) {
          final startOfYear = DateTime(year, 1, 1);
          final inServiceStart = a.purchaseDate.isAfter(startOfYear)
              ? a.purchaseDate
              : startOfYear;
          final daysInYear =
              DateTime(year, 12, 31).difference(startOfYear).inDays + 1;
          final daysActive =
              a.disposalDate!.difference(inServiceStart).inDays + 1;
          if (daysActive <= 0) return s;
          return s + (annual * daysActive / daysInYear).round();
        }

        return s + annual;
      });

  // ── Tax calculations ──────────────────────────────────────────────────────

  TaxResult calculate({
    required TaxParam params,
    required int grossRevenue,
    required int creditNotes,
    required int totalDeductibleExpenses,
    required int totalDepreciation,
    required int carMileageAllowance,
    required int kiaDeduction,
    required bool claimZelfstandigenaftrek,
    required bool claimStartersaftrek,
    required int wbsoDeduction,
    required int algHeffingskorting,
    required int arbeidskorting,
    required int lijrenteDeduction,
  }) {
    final netRevenue = grossRevenue - creditNotes;
    final totalExpenses =
        totalDeductibleExpenses + totalDepreciation + carMileageAllowance;
    final grossProfit = netRevenue - totalExpenses;

    final zelfs = claimZelfstandigenaftrek ? params.zelfstandigenaftrek : 0;
    final starters = claimStartersaftrek ? params.startersaftrek : 0;
    final wbsoCents = -wbsoDeduction;
    final ondernemersaftrekTotal = zelfs + starters + wbsoCents;
    final profitAfterOndernemer = grossProfit + ondernemersaftrekTotal;

    // MKB base is winst after ondernemersaftrek AND KIA (Dutch IB form order).
    final mkbBase = profitAfterOndernemer - kiaDeduction;
    final mkb = mkbBase > 0
        ? (mkbBase * params.mkbWinstvrijstellingPct).round()
        : 0;

    final taxableProfit = mkbBase - mkb - lijrenteDeduction;

    final b1 = _bracket1Tax(params, taxableProfit);
    final b2 = _bracket2Tax(params, taxableProfit);
    final b3 = _bracket3Tax(params, taxableProfit);
    final grossBox1Tax = b1 + b2 + b3;

    final kortingen = algHeffingskorting + arbeidskorting;
    final box1Tax = (grossBox1Tax - kortingen).clamp(0, grossBox1Tax);

    final zvw = computeZvw(params, taxableProfit);
    final totalTax = box1Tax + zvw;
    final netProfitAfterTax = grossProfit - totalTax;
    final effectiveRate = grossProfit > 0
        ? (totalTax * 10000 ~/ grossProfit)
        : 0;

    return TaxResult(
      grossRevenue: grossRevenue,
      creditNotes: creditNotes,
      netRevenue: netRevenue,
      totalExpenses: totalExpenses,
      grossProfit: grossProfit,
      zelfstandigenaftrekApplied: zelfs,
      startersaftrekApplied: starters,
      wbsoDeductionApplied: wbsoDeduction,
      ondernemersaftrekTotal: ondernemersaftrekTotal,
      profitAfterOndernemer: profitAfterOndernemer,
      mkbDeduction: mkb,
      kiaDeduction: kiaDeduction,
      lijrenteDeduction: lijrenteDeduction,
      taxableProfit: taxableProfit,
      bracket1Tax: b1,
      bracket2Tax: b2,
      bracket3Tax: b3,
      grossBox1Tax: grossBox1Tax,
      algHeffingskortingApplied: algHeffingskorting,
      arbeidskortingApplied: arbeidskorting,
      box1Tax: box1Tax,
      zvwContribution: zvw,
      totalTax: totalTax,
      netProfitAfterTax: netProfitAfterTax,
      effectiveTaxRate: effectiveRate,
    );
  }

  int computeBox1Tax(TaxParam params, int taxableIncome) {
    if (taxableIncome <= 0) return 0;
    return _bracket1Tax(params, taxableIncome) +
        _bracket2Tax(params, taxableIncome) +
        _bracket3Tax(params, taxableIncome);
  }

  int _bracket1Tax(TaxParam params, int income) {
    if (income <= 0) return 0;
    final b = income.clamp(0, params.bracket1Threshold);
    return (b * params.bracket1Rate).round();
  }

  int _bracket2Tax(TaxParam params, int income) {
    if (income <= params.bracket1Threshold) return 0;
    final b = (income - params.bracket1Threshold).clamp(
      0,
      params.bracket2Threshold - params.bracket1Threshold,
    );
    return (b * params.bracket2Rate).round();
  }

  int _bracket3Tax(TaxParam params, int income) {
    if (income <= params.bracket2Threshold) return 0;
    final b = income - params.bracket2Threshold;
    return (b * params.bracket3Rate).round();
  }

  int computeZvw(TaxParam params, int taxableProfit) {
    if (taxableProfit <= 0) return 0;
    return (taxableProfit * params.zvwRate).round().clamp(0, params.zvwMax);
  }

  int computeMkb(TaxParam params, int mkbBase) {
    if (mkbBase <= 0) return 0;
    return (mkbBase * params.mkbWinstvrijstellingPct).round();
  }

  int computeKia(TaxParam params, int totalQualifyingInvestments) {
    final v = totalQualifyingInvestments;
    if (v < params.kiaLowerThreshold) return 0;
    if (v <= params.kiaUpperThreshold) return (v * params.kiaRate).round();
    if (v <= params.kiaFlatThreshold) return params.kiaFlatAmount;
    // Decrease zone: 7.56% of amount above kiaFlatThreshold (Dutch law Art. 3.41).
    final reduction = ((v - params.kiaFlatThreshold) * params.kiaDecreaseRate)
        .round();
    return (params.kiaFlatAmount - reduction).clamp(0, params.kiaFlatAmount);
  }

  static int computeAnnualDepreciation({
    required int costExclVat,
    required int usefulLifeYears,
    required double businessUsePct,
  }) {
    if (usefulLifeYears <= 0) return 0;
    return ((costExclVat * businessUsePct) / usefulLifeYears).round();
  }

  static int computeBookValue({
    required int costExclVat,
    required int usefulLifeYears,
    required double businessUsePct,
    required int yearsElapsed,
  }) {
    final annual = computeAnnualDepreciation(
      costExclVat: costExclVat,
      usefulLifeYears: usefulLifeYears,
      businessUsePct: businessUsePct,
    );
    final years = yearsElapsed.clamp(0, usefulLifeYears);
    return ((costExclVat * businessUsePct).round() - annual * years).clamp(
      0,
      costExclVat,
    );
  }
}
