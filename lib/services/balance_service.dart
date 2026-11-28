import '../db/database.dart';
import 'asset_service.dart';
import 'domain.dart';
import 'tax_rules/tax_year_rules.dart';
import 'vat_service.dart';

/// The business on 31 December and the equity comparison of the income tax
/// return (vraag 19), in cents. Florin takes what its records show and the
/// user's year inputs for the rest (`docs/legal.md`, Balance sheet).
class BalanceSheet {
  /// Book value of the assets still in the business.
  final int fixedAssets;

  /// Invoices not paid on 31 December, incl. BTW.
  final int receivables;

  /// BTW to get back over periods of the year not settled on 31 December.
  final int vatReceivable;
  final int bank;
  final int cash;

  /// BTW to pay over periods of the year not settled on 31 December.
  final int vatPayable;
  final int unpaidPurchases;
  final int longTermLoans;

  final int equityStart;
  final int withdrawals;
  final int deposits;

  const BalanceSheet({
    required this.fixedAssets,
    required this.receivables,
    required this.vatReceivable,
    required this.bank,
    required this.cash,
    required this.vatPayable,
    required this.unpaidPurchases,
    required this.longTermLoans,
    required this.equityStart,
    required this.withdrawals,
    required this.deposits,
  });

  int get totalAssets =>
      fixedAssets + receivables + vatReceivable + bank + cash;

  /// Kortlopende schulden: suppliers and tax still to pay.
  int get shortTermDebts => vatPayable + unpaidPurchases;
  int get totalDebts => shortTermDebts + longTermLoans;

  /// Ondernemingsvermogen at the end of the year (vraag 19a).
  int get equityEnd => totalAssets - totalDebts;

  /// Saldo fiscale winstberekening (vraag 19g): 19a plus 19b, minus the sum
  /// of 19d and 19e.
  int get equityProfit => equityEnd + withdrawals - (equityStart + deposits);
}

abstract final class BalanceService {
  /// The estimate's profit as the equity comparison counts it. The
  /// desinvesteringsbijtelling and a reserve released change the profit but
  /// no asset or debt; a gain kept in the herinvesteringsreserve raises the
  /// ondernemingsvermogen but not the profit, and booking the reserve off a
  /// new asset lowers its book value without a loss (Fiscale informatie
  /// 2026, 7.7.1.2).
  static int comparableProfit({
    required int grossProfit,
    required int desinvesteringsbijtelling,
    required ReserveYear? reserve,
  }) =>
      grossProfit -
      desinvesteringsbijtelling +
      (reserve?.formed ?? 0) -
      (reserve?.applied ?? 0) -
      (reserve?.released ?? 0);

  static BalanceSheet yearEnd({
    required int year,
    required List<FixedAsset> assets,
    required List<Invoice> invoices,
    required List<(VatPeriod, VatReturnResult)> vatPeriods,
    required List<VatReturn> vatReturns,
    required TaxYearInput? inputs,
    required TaxYearRules rules,
  }) {
    final end = DateTime(year, 12, 31);
    final fixed = assets
        .where(
          (a) =>
              a.purchaseDate.year <= year &&
              (a.disposalDate == null || a.disposalDate!.year > year),
        )
        .fold(0, (s, a) => s + AssetService.bookValue(a, year, rules));
    final paid = {
      for (final v in vatReturns)
        if (v.paid) (v.kind, v.number),
    };
    // The last return of the year falls due after 31 December, so it is open
    // then; an earlier one is open unless the user marked it paid.
    var openVat = 0;
    for (final (p, r) in vatPeriods) {
      if (p.isLastOfYear || !paid.contains((p.kind, p.number))) {
        openVat += r.netVat;
      }
    }
    final i = inputs;
    return BalanceSheet(
      fixedAssets: fixed,
      receivables: openReceivables(invoices, end),
      vatReceivable: openVat < 0 ? -openVat : 0,
      bank: i?.bankBalance ?? 0,
      cash: i?.cashBalance ?? 0,
      vatPayable: openVat > 0 ? openVat : 0,
      unpaidPurchases: i?.unpaidPurchases ?? 0,
      longTermLoans: i?.longTermLoans ?? 0,
      equityStart: i?.equityStart ?? 0,
      withdrawals: i?.privateWithdrawals ?? 0,
      deposits: i?.privateDeposits ?? 0,
    );
  }
}
