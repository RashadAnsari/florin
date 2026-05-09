import 'package:flutter_test/flutter_test.dart';
import 'package:florin/services/vat_service.dart';
import 'package:florin/db/database.dart';

TaxParam _params() => const TaxParam(
      year: 2026,
      zelfstandigenaftrek: -120000,
      startersaftrek: -212300,
      mkbWinstvrijstellingPct: 0.127,
      bracket1Rate: 0.3575,
      bracket1Threshold: 3888300,
      bracket2Rate: 0.3756,
      bracket2Threshold: 7842600,
      bracket3Rate: 0.495,
      algHeffingskortingMax: 311500,
      arbeidskortingMax: 568500,
      zvwRate: 0.0485,
      zvwMax: 385100,
      mixedCostsThreshold: 570000,
      mixedCosts80Pct: 0.8,
      jaarruimtePct: 0.30,
      jaarruimteMax: 3558900,
      aowFranchise: 1917200,
      reserveringsruimteMax: 4275300,
      factorAMultiplier: 6.27,
      kiaLowerThreshold: 290100,
      kiaUpperThreshold: 7168300,
      kiaFlatThreshold: 13274600,
      kiaRate: 0.28,
      kiaFlatAmount: 2007200,
      mileageRatePerKm: 0.23,
      korThreshold: 2000000,
      ossThreshold: 1000000,
      belastingrentePct: 0.05,
    );

Invoice _invoice({
  required int id,
  required String quarter,
  required String type,
  required String status,
  required int totalExclVat,
  required int totalVat,
}) =>
    Invoice(
      id: id,
      invoiceNumber: 'F-2026-$id',
      invoiceDate: DateTime(2026, 3, 1),
      supplyDate: null,
      dueDate: DateTime(2026, 4, 1),
      clientId: 1,
      invoiceType: type,
      sellerName: 'Test BV',
      sellerVatNumber: 'NL123',
      sellerKvkNumber: '12345678',
      sellerAddress: 'Teststraat 1',
      paymentTermDays: 30,
      status: status,
      paidDate: null,
      paymentMethod: null,
      notes: null,
      isReverseCharge: false,
      isIcp: false,
      reverseChargeNote: null,
      totalExclVat: totalExclVat,
      totalVat: totalVat,
      totalInclVat: totalExclVat + totalVat,
      quarter: quarter,
      fiscalYear: 2026,
    );

void main() {
  const service = VatService();
  final params = _params();

  group('VatService.filingDeadline', () {
    test('Q1 deadline is April 30', () {
      expect(service.filingDeadline(2026, 'Q1'), DateTime(2026, 4, 30));
    });
    test('Q2 deadline is July 31', () {
      expect(service.filingDeadline(2026, 'Q2'), DateTime(2026, 7, 31));
    });
    test('Q3 deadline is October 31', () {
      expect(service.filingDeadline(2026, 'Q3'), DateTime(2026, 10, 31));
    });
    test('Q4 deadline is January 31 next year', () {
      expect(service.filingDeadline(2026, 'Q4'), DateTime(2027, 1, 31));
    });
  });

  group('VatService.calculateQuarter', () {
    test('draft invoices excluded from revenue', () {
      final inv = _invoice(
        id: 1,
        quarter: 'Q1',
        type: 'Invoice',
        status: 'Draft',
        totalExclVat: 100000,
        totalVat: 21000,
      );
      final result = service.calculateQuarter(
        allYearInvoices: [inv],
        allYearExpenses: [],
        fiscalYear: 2026,
        quarter: 'Q1',
        params: params,
      );
      expect(result.revenue21, 0);
      expect(result.outputVatTotal, 0);
    });

    test('sent invoice included in Q1 revenue', () {
      final inv = _invoice(
        id: 1,
        quarter: 'Q1',
        type: 'Invoice',
        status: 'Sent',
        totalExclVat: 100000,
        totalVat: 21000,
      );
      final result = service.calculateQuarter(
        allYearInvoices: [inv],
        allYearExpenses: [],
        fiscalYear: 2026,
        quarter: 'Q1',
        params: params,
      );
      expect(result.revenue21, 100000);
      expect(result.outputVat21, 21000);
      expect(result.netVatDue, 21000);
    });

    test('KOR risk when YTD revenue exceeds threshold', () {
      final invoices = List.generate(
        5,
        (i) => _invoice(
          id: i + 1,
          quarter: 'Q1',
          type: 'Invoice',
          status: 'Sent',
          totalExclVat: 500000, // 5 × €5k = €25k > €20k KOR threshold
          totalVat: 105000,
        ),
      );
      final result = service.calculateQuarter(
        allYearInvoices: invoices,
        allYearExpenses: [],
        fiscalYear: 2026,
        quarter: 'Q1',
        params: params,
      );
      expect(result.korRisk, isTrue);
    });

    test('invoices from other quarters not in current quarter', () {
      final q2inv = _invoice(
        id: 1,
        quarter: 'Q2',
        type: 'Invoice',
        status: 'Sent',
        totalExclVat: 100000,
        totalVat: 21000,
      );
      final result = service.calculateQuarter(
        allYearInvoices: [q2inv],
        allYearExpenses: [],
        fiscalYear: 2026,
        quarter: 'Q1',
        params: params,
      );
      expect(result.revenue21, 0);
    });
  });
}
