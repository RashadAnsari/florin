import '../db/database.dart';

class VatQuarterResult {
  final int revenue21; // excl. VAT, cents
  final int revenue9;
  final int revenue0; // non-EU export (field 1c)
  final int reverseChargeRevenue; // ICP / EU B2B (field 3a)
  final int outputVat21;
  final int outputVat9;
  final int inputVatReclaimable;
  final int netVatDue; // positive = owe, negative = refund
  final bool suppressionNeeded; // cross-quarter corrections > €1,000
  final int ytdRevenue; // for KOR check (all quarters to date)
  final bool korRisk;
  final List<Invoice> icpInvoices;

  const VatQuarterResult({
    required this.revenue21,
    required this.revenue9,
    required this.revenue0,
    required this.reverseChargeRevenue,
    required this.outputVat21,
    required this.outputVat9,
    required this.inputVatReclaimable,
    required this.netVatDue,
    required this.suppressionNeeded,
    required this.ytdRevenue,
    required this.korRisk,
    required this.icpInvoices,
  });

  int get outputVatTotal => outputVat21 + outputVat9;
}

class VatService {
  const VatService();

  VatQuarterResult calculateQuarter({
    required List<Invoice> allYearInvoices,
    required List<Expense> allYearExpenses,
    required int fiscalYear,
    required String quarter,
    required TaxParam params,
  }) {
    final qInvoices = allYearInvoices
        .where((i) => i.quarter == quarter && i.status != 'Draft')
        .toList();
    final qExpenses = allYearExpenses
        .where((e) => e.quarter == quarter)
        .toList();

    var rev21 = 0, rev9 = 0, rev0 = 0, revIcp = 0;
    var vat21 = 0, vat9 = 0;
    final icpList = <Invoice>[];

    for (final inv in qInvoices) {
      if (inv.invoiceType == 'CreditNote') {
        // Credit notes reduce revenue in the same period
        final lines = _rateBreakdown(inv);
        rev21 -= lines.$1;
        rev9 -= lines.$2;
        vat21 -= lines.$3;
        vat9 -= lines.$4;
        continue;
      }
      final lines = _rateBreakdown(inv);
      rev21 += lines.$1;
      rev9 += lines.$2;
      vat21 += lines.$3;
      vat9 += lines.$4;

      // ICP / reverse charge
      if (inv.isIcp || inv.isReverseCharge) {
        revIcp += inv.totalExclVat;
        icpList.add(inv);
      } else if (!inv.isIcp && !inv.isReverseCharge) {
        // Check if any 0% EU RC is in the invoice (approximate via total)
        // For detailed breakdown, server would need line-level info
        // Use invoice-level flags as proxy
      }

      // Non-EU export (0%, not ICP, field 1c)
      if (!inv.isIcp && !inv.isReverseCharge && inv.totalVat == 0) {
        rev0 += inv.totalExclVat;
        // Rev already counted above, subtract from rev21/rev9 and add to rev0
        // Actually: rev0 is invoices with 0% VAT that are not ICP
        // We already added to rev21/rev9 above — refine below
      }
    }

    // Simpler approach: re-bucket revenues
    // Reset and re-compute cleanly
    rev21 = 0;
    rev9 = 0;
    rev0 = 0;
    revIcp = 0;
    vat21 = 0;
    vat9 = 0;
    final icpInvoices2 = <Invoice>[];

    for (final inv in qInvoices) {
      final sign = inv.invoiceType == 'CreditNote' ? -1 : 1;
      if (inv.isIcp || inv.isReverseCharge) {
        revIcp += sign * inv.totalExclVat;
        if (sign == 1) icpInvoices2.add(inv);
        continue;
      }
      if (inv.totalVat == 0 && inv.totalExclVat > 0) {
        rev0 += sign * inv.totalExclVat;
        continue;
      }
      // Mix of 21% and 9% — approximate from totalVat
      // For exact breakdown we'd need lines, but use total VAT rate proxy
      final rate = inv.totalExclVat > 0 ? inv.totalVat / inv.totalExclVat : 0.0;
      if (rate >= 0.15) {
        rev21 += sign * inv.totalExclVat;
        vat21 += sign * inv.totalVat;
      } else if (rate > 0) {
        rev9 += sign * inv.totalExclVat;
        vat9 += sign * inv.totalVat;
      }
    }

    final inputVat = qExpenses.fold<int>(0, (s, e) => s + e.vatToReclaim);
    final netVat = (vat21 + vat9) - inputVat;

    // YTD revenue for KOR check (all non-draft invoices in year)
    final ytd = allYearInvoices
        .where((i) => i.status != 'Draft' && i.invoiceType == 'Invoice')
        .fold<int>(0, (s, i) => s + i.totalExclVat);

    return VatQuarterResult(
      revenue21: rev21,
      revenue9: rev9,
      revenue0: rev0,
      reverseChargeRevenue: revIcp,
      outputVat21: vat21.clamp(0, vat21.abs()),
      outputVat9: vat9.clamp(0, vat9.abs()),
      inputVatReclaimable: inputVat,
      netVatDue: netVat,
      suppressionNeeded: false,
      ytdRevenue: ytd,
      korRisk: ytd >= params.korThreshold,
      icpInvoices: icpInvoices2,
    );
  }

  // Returns (rev21, rev9, vat21, vat9)
  (int, int, int, int) _rateBreakdown(Invoice inv) {
    return (inv.totalExclVat, 0, inv.totalVat, 0);
  }

  String quarterFromDate(DateTime date) => 'Q${((date.month - 1) ~/ 3) + 1}';

  DateTime filingDeadline(int year, String quarter) => switch (quarter) {
    'Q1' => DateTime(year, 4, 30),
    'Q2' => DateTime(year, 7, 31),
    'Q3' => DateTime(year, 10, 31),
    'Q4' => DateTime(year + 1, 1, 31),
    _ => DateTime(year, 12, 31),
  };

  int daysUntilDeadline(int year, String quarter) =>
      filingDeadline(year, quarter).difference(DateTime.now()).inDays;
}

// Dutch BTW number: NL + 9 digits + B + 2 digits, e.g. NL123456789B01
final _btwRegex = RegExp(r'^NL\d{9}B\d{2}$', caseSensitive: false);

bool isValidDutchVatNumber(String value) =>
    _btwRegex.hasMatch(value.replaceAll(' ', ''));

// Dutch KVK number: exactly 8 digits
final _kvkRegex = RegExp(r'^\d{8}$');

bool isValidKvkNumber(String value) =>
    _kvkRegex.hasMatch(value.replaceAll(' ', ''));

// IBAN: 2-letter country code + 2 check digits + up to 30 alphanumeric BBAN
// Strips spaces before checking (e.g. NL91 ABNA 0417 1643 00 → NL91ABNA0417164300)
final _ibanRegex = RegExp(r'^[A-Z]{2}\d{2}[A-Z0-9]{4,30}$');

bool isValidIban(String value) =>
    _ibanRegex.hasMatch(value.replaceAll(' ', '').toUpperCase());
