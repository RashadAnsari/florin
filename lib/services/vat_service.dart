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
    required List<InvoiceLine> allYearInvoiceLines,
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

    var rev21 = 0;
    var rev9 = 0;
    var rev0 = 0;
    var revIcp = 0;
    var vat21 = 0;
    var vat9 = 0;
    final icpInvoices2 = <Invoice>[];
    final linesByInvoiceId = <int, List<InvoiceLine>>{};
    for (final line in allYearInvoiceLines) {
      linesByInvoiceId.putIfAbsent(line.invoiceId, () => []).add(line);
    }

    for (final inv in qInvoices) {
      final sign = inv.invoiceType == 'CreditNote' ? -1 : 1;
      if (inv.isIcp || inv.isReverseCharge) {
        revIcp += sign * inv.totalExclVat;
        if (sign == 1) icpInvoices2.add(inv);
        continue;
      }
      final lines = linesByInvoiceId[inv.id] ?? const <InvoiceLine>[];
      if (lines.isEmpty) {
        if (inv.totalVat == 0) {
          rev0 += sign * inv.totalExclVat;
        } else {
          rev21 += sign * inv.totalExclVat;
          vat21 += sign * inv.totalVat;
        }
        continue;
      }
      for (final line in lines) {
        final revenue = sign * line.lineTotalExclVat;
        final vat = sign * line.vatAmount;
        switch (line.vatRate) {
          case '21%':
            rev21 += revenue;
            vat21 += vat;
          case '9%':
            rev9 += revenue;
            vat9 += vat;
          case '0% EU Reverse Charge':
            revIcp += revenue;
          case '0%':
          case 'Exempt':
            rev0 += revenue;
          default:
            rev0 += revenue;
        }
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
      outputVat21: vat21,
      outputVat9: vat9,
      inputVatReclaimable: inputVat,
      netVatDue: netVat,
      suppressionNeeded: false,
      ytdRevenue: ytd,
      korRisk: ytd >= params.korThreshold,
      icpInvoices: icpInvoices2,
    );
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
