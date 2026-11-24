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
    final raw =
        (grondslag * rules.jaarruimtePct -
                rules.factorAMultiplier * (entry?.factorA ?? 0))
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

  /// The planned premium, limited to the available room.
  static int deductiblePremium(TaxYearRules rules, PensionEntry? entry) {
    final planned = entry?.plannedContribution ?? 0;
    final room = calculate(rules, entry).totalRoom;
    return planned < room ? planned : room;
  }
}
