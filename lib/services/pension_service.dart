import '../db/database.dart';

class JaarruimteResult {
  final int pensioengrondslag; // cents (can be negative)
  final int jaarruimte; // cents (0 if grondslag <= 0)
  final int jaarruimteCapped; // min(jaarruimte, jaarruimteMax)
  final int reserveringsruimte; // cents (user-supplied, capped)
  final int totalBudget; // jaarruimteCapped + reserveringsruimte
  final int estimatedTaxSaving; // cents

  const JaarruimteResult({
    required this.pensioengrondslag,
    required this.jaarruimte,
    required this.jaarruimteCapped,
    required this.reserveringsruimte,
    required this.totalBudget,
    required this.estimatedTaxSaving,
  });
}

class PensionService {
  const PensionService();

  JaarruimteResult calculate({
    required TaxParam params,
    required int taxableProfit, // cents
    required double factorA, // euros
    required int unusedPriorYears, // cents
    required double marginalRate, // e.g. 0.3575
  }) {
    final grondslag = taxableProfit - params.aowFranchise;

    if (grondslag <= 0) {
      return JaarruimteResult(
        pensioengrondslag: grondslag,
        jaarruimte: 0,
        jaarruimteCapped: 0,
        reserveringsruimte: 0,
        totalBudget: 0,
        estimatedTaxSaving: 0,
      );
    }

    // jaarruimte = 30% × grondslag − 6.27 × factorA
    // factorA is in euros; convert to cents for subtraction
    final jaarruimteRaw =
        (grondslag * params.jaarruimtePct -
                params.factorAMultiplier * factorA * 100)
            .round();
    final jaarruimte = jaarruimteRaw < 0 ? 0 : jaarruimteRaw;
    final jaarruimteCapped = jaarruimte.clamp(0, params.jaarruimteMax);

    final reserveringsruimte = unusedPriorYears.clamp(
      0,
      params.reserveringsruimteMax,
    );
    final totalBudget = jaarruimteCapped + reserveringsruimte;
    final saving = (totalBudget * marginalRate).round();

    return JaarruimteResult(
      pensioengrondslag: grondslag,
      jaarruimte: jaarruimte,
      jaarruimteCapped: jaarruimteCapped,
      reserveringsruimte: reserveringsruimte,
      totalBudget: totalBudget,
      estimatedTaxSaving: saving,
    );
  }
}
