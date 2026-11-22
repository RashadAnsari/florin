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
  static JaarruimteResult calculate(TaxYearRules rules, PensionEntry? entry) {
    final income = entry?.priorYearIncome ?? 0;
    final grondslag = (income - rules.aowFranchise).clamp(
      0,
      (rules.jaarruimteMax / rules.jaarruimtePct).round(),
    );
    final raw =
        (grondslag * rules.jaarruimtePct -
                rules.factorAMultiplier * (entry?.factorA ?? 0))
            .round();
    return JaarruimteResult(
      premiegrondslag: grondslag,
      jaarruimte: raw.clamp(0, rules.jaarruimteMax),
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
