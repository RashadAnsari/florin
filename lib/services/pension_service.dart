import '../db/database.dart';
import 'tax_rules/tax_year_rules.dart';

/// Lijfrente room for one year (Wet IB 2001 art. 3.127). Amounts in cents.
class JaarruimteResult {
  final int premiegrondslag;
  final int jaarruimte;
  final int reserveringsruimte;

  const JaarruimteResult({
    required this.premiegrondslag,
    required this.jaarruimte,
    required this.reserveringsruimte,
  });

  int get totalRoom => jaarruimte + reserveringsruimte;
}

abstract final class PensionService {
  /// The income of the previous year as it counts: at most
  /// [TaxYearRules.premiegrondslagMaxIncome] (art. 3.127 lid 3).
  static int countedIncome(TaxYearRules rules, PensionEntry? entry) {
    final income = entry?.priorYearIncome ?? 0;
    return income < rules.premiegrondslagMaxIncome
        ? income
        : rules.premiegrondslagMaxIncome;
  }

  static JaarruimteResult calculate(TaxYearRules rules, PensionEntry? entry) {
    final above = countedIncome(rules, entry) - rules.aowFranchise;
    final grondslag = above < 0 ? 0 : above;
    // Lid 4 lowers the room by last year's Wtp premiums 1:1; art. 10a.25
    // keeps the factor A reduction for schemes not yet under the Wtp.
    final raw =
        (grondslag * rules.jaarruimtePct -
                rules.factorAMultiplier * (entry?.factorA ?? 0) -
                (entry?.pensionPremiumsPriorYear ?? 0))
            .round();
    return JaarruimteResult(
      premiegrondslag: grondslag,
      jaarruimte: raw < 0 ? 0 : raw,
      reserveringsruimte: (entry?.reserveringsruimte ?? 0).clamp(
        0,
        rules.reserveringsruimteMax,
      ),
    );
  }

  /// The AOV premiums paid in [months] of the year: they are deducted when
  /// paid (art. 3.147).
  static int aovPremiumPaid(PensionEntry? entry, int months) =>
      (entry?.aovInsured ?? false) ? entry!.monthlyAovPremium * months : 0;

  /// The months of [year] that have ended on [now]. The day a premium is
  /// paid is not recorded, so the current month does not count yet.
  static int aovMonthsPaid(int year, DateTime now) => year < now.year
      ? 12
      : year > now.year
      ? 0
      : now.month - 1;

  /// The planned premium, limited to the available room.
  static int deductiblePremium(TaxYearRules rules, PensionEntry? entry) {
    final planned = entry?.plannedContribution ?? 0;
    final room = calculate(rules, entry).totalRoom;
    return planned < room ? planned : room;
  }
}
