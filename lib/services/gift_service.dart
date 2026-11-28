import '../db/database.dart';
import 'domain.dart';
import 'tax_rules/tax_year_rules.dart';

/// Business gifts and the BTW on them (Besluit uitsluiting aftrek
/// omzetbelasting 1968 art. 1 lid 1 b and art. 4, `docs/legal.md`).
abstract final class GiftService {
  /// The key that groups gifts to one recipient: the name as typed, without
  /// case or surrounding spaces.
  static String recipientKey(String name) => name.trim().toLowerCase();

  /// The cost excl. BTW of the gifts of [year] per recipient. A gift
  /// without BTW does not count: "U telt alleen de uitgaven mee waarover u
  /// btw hebt betaald" (Belastingdienst, drempelbedrag giften).
  static Map<String, int> totalsByRecipient(
    Iterable<Expense> expenses,
    int year,
  ) {
    final totals = <String, int>{};
    for (final e in expenses) {
      final recipient = e.giftRecipient;
      if (e.category != ExpenseCategory.gifts ||
          recipient == null ||
          e.date.year != year ||
          e.vatAmount == 0) {
        continue;
      }
      final key = recipientKey(recipient);
      totals[key] = (totals[key] ?? 0) + e.amountExclVat;
    }
    return totals;
  }

  /// [expenses] with the BTW on gifts not reclaimed for every recipient
  /// whose gifts in the year cost more than the threshold. Florin cannot
  /// tell whether a recipient could deduct the BTW themselves, which keeps
  /// the deduction (art. 1 lid 1 b), so it takes the cautious reading that
  /// they cannot. A gift without a recipient is treated the same way.
  static List<Expense> applyDeductionRule(
    List<Expense> expenses,
    TaxYearRules? Function(int year) rulesFor,
  ) {
    final totals = <int, Map<String, int>>{};
    return [
      for (final e in expenses)
        if (e.category != ExpenseCategory.gifts || !e.vatReclaimable)
          e
        else if (_overThreshold(e, expenses, totals, rulesFor))
          e.withoutVatReclaim()
        else
          e,
    ];
  }

  static bool _overThreshold(
    Expense e,
    List<Expense> expenses,
    Map<int, Map<String, int>> totals,
    TaxYearRules? Function(int year) rulesFor,
  ) {
    final recipient = e.giftRecipient;
    final threshold = rulesFor(e.date.year)?.buaGiftThreshold;
    if (recipient == null || threshold == null) return true;
    final byRecipient = totals.putIfAbsent(
      e.date.year,
      () => totalsByRecipient(expenses, e.date.year),
    );
    return (byRecipient[recipientKey(recipient)] ?? 0) > threshold;
  }
}
