import 'package:florin/db/database.dart';
import 'package:florin/services/asset_service.dart';
import 'package:florin/services/balance_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:florin/services/vat_service.dart';
import 'package:flutter_test/flutter_test.dart';

VatReturnResult _return(int vat1a, int input5b) => VatReturnResult(
  revenue1a: 0,
  vat1a: vat1a,
  revenue1b: 0,
  vat1b: 0,
  revenue1e: 0,
  vat1d: 0,
  revenue3a: 0,
  revenue3b: 0,
  base2a: 0,
  vat2a: 0,
  base4a: 0,
  vat4a: 0,
  base4b: 0,
  vat4b: 0,
  inputVat5b: input5b,
  icpInvoices: const [],
);

void main() {
  test('the equity comparison follows vraag 19 of the return: 19a plus 19b '
      'minus 19d minus 19e', () {
    const b = BalanceSheet(
      fixedAssets: 300000,
      receivables: 121000,
      vatReceivable: 0,
      bank: 500000,
      cash: 10000,
      vatPayable: 80000,
      unpaidPurchases: 51000,
      longTermLoans: 200000,
      equityStart: 400000,
      withdrawals: 3000000,
      deposits: 20000,
    );
    expect(b.totalAssets, 931000);
    expect(b.shortTermDebts, 131000);
    expect(b.equityEnd, 600000);
    expect(b.equityProfit, 600000 + 3000000 - 400000 - 20000);
  });

  test('a reserved gain and the desinvesteringsbijtelling do not show as a '
      'difference (Fiscale informatie 2026, 7.7.1.2)', () {
    // A gain of 3,000 kept in the reserve raises equity, not profit; 1,000
    // of it booked off a new asset lowers its book value, not profit; the
    // release of 500 and an add-back of 200 raise profit, not equity.
    expect(
      BalanceService.comparableProfit(
        grossProfit: 1000000,
        desinvesteringsbijtelling: 20000,
        reserve: const ReserveYear(
          formed: 300000,
          applied: 100000,
          released: 50000,
        ),
      ),
      1000000 - 20000 + 300000 - 100000 - 50000,
    );
    expect(
      BalanceService.comparableProfit(
        grossProfit: 1000000,
        desinvesteringsbijtelling: 0,
        reserve: null,
      ),
      1000000,
    );
  });

  test('BTW of the last period of the year and of unpaid periods is open on '
      '31 December; paid ones are not', () {
    const kind = VatFilingPeriod.quarterly;
    final b = BalanceService.yearEnd(
      year: 2026,
      assets: const [],
      invoices: const [],
      vatPeriods: [
        ((year: 2026, kind: kind, number: 3), _return(50000, 0)),
        ((year: 2026, kind: kind, number: 4), _return(20000, 5000)),
        ((year: 2026, kind: kind, number: 2), _return(90000, 0)),
      ],
      vatReturns: const [
        VatReturn(year: 2026, kind: kind, number: 2, filed: true, paid: true),
        VatReturn(year: 2026, kind: kind, number: 4, filed: true, paid: true),
      ],
      inputs: null,
      rules: taxRulesFor(2026)!,
    );
    expect(b.vatPayable, 50000 + 15000);
    expect(b.vatReceivable, 0);
  });
}
