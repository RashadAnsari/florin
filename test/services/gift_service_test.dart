import 'package:florin/db/database.dart';
import 'package:florin/services/gift_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:flutter_test/flutter_test.dart';

Expense gift(int id, String? recipient, int amount, {int year = 2026}) =>
    Expense(
      id: id,
      date: DateTime(year, 5, id),
      supplier: 's',
      description: 'gift',
      category: ExpenseCategory.gifts,
      paperOriginalKept: false,
      amountExclVat: amount,
      vatRate: VatRate.high,
      purchaseVat: PurchaseVat.domestic,
      vatAmount: (amount * 0.21).round(),
      totalInclVat: amount + (amount * 0.21).round(),
      businessUsePct: 1,
      deductibleAmount: amount,
      vatReclaimable: true,
      vatToReclaim: (amount * 0.21).round(),
      giftRecipient: recipient,
    );

void main() {
  test(
    'gifts to one recipient above EUR 227 a year lose their BTW '
    'deduction (Besluit uitsluiting aftrek omzetbelasting 1968 art. 1, 4)',
    () {
      final expenses = [
        gift(1, 'Jan Klant', 15000),
        gift(2, ' jan klant ', 10000),
        gift(3, 'Piet', 22700),
        gift(4, 'Piet', 5000, year: 2025),
        gift(5, null, 1000),
      ];
      final applied = GiftService.applyDeductionRule(expenses, taxRulesFor);
      expect(applied.map((e) => e.vatToReclaim).toList(), [
        0,
        0,
        expenses[2].vatToReclaim,
        // A year without rules in Florin: the cautious answer.
        0,
        // No recipient: the cautious answer.
        0,
      ]);
      expect(applied.first.deductibleAmount, 15000 + 3150);
      expect(GiftService.totalsByRecipient(expenses, 2026), {
        'jan klant': 25000,
        'piet': 22700,
      });
    },
  );
}
