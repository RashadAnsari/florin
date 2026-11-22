import '../db/database.dart';
import 'domain.dart';

/// One quarter of the BTW return, by rubriek. Amounts are in cents, signed
/// so that credit notes reduce them.
class VatQuarterResult {
  final int revenue1a;
  final int vat1a;
  final int revenue1b;
  final int vat1b;
  final int revenue1e;

  /// BTW on private use (rubriek 1d).
  final int vat1d;
  final int revenue3a;
  final int revenue3b;

  /// Purchases with BTW shifted to you: domestic (2a), from outside the EU
  /// (4a) and from EU countries (4b). Base and BTW.
  final int base2a;
  final int vat2a;
  final int base4a;
  final int vat4a;
  final int base4b;
  final int vat4b;
  final int inputVat5b;

  /// Supplies to EU businesses for the ICP-opgaaf.
  final List<Invoice> icpInvoices;

  const VatQuarterResult({
    required this.revenue1a,
    required this.vat1a,
    required this.revenue1b,
    required this.vat1b,
    required this.revenue1e,
    required this.vat1d,
    required this.revenue3a,
    required this.revenue3b,
    required this.base2a,
    required this.vat2a,
    required this.base4a,
    required this.vat4a,
    required this.base4b,
    required this.vat4b,
    required this.inputVat5b,
    required this.icpInvoices,
  });

  int get outputVat5a => vat1a + vat1b + vat1d + vat2a + vat4a + vat4b;

  /// Positive: to pay. Negative: to get back.
  int get netVat => outputVat5a - inputVat5b;
}

abstract final class VatService {
  /// Days before a deadline at which it is shown as urgent.
  static const urgentDeadlineDays = 14;

  /// Rubrieken per the Belastingdienst guidance in `docs/legal.md`. Exempt
  /// supplies are not reported.
  static VatQuarterResult calculateQuarter({
    required List<Invoice> invoices,
    required List<InvoiceLine> lines,
    required List<Expense> expenses,
    required int quarter,
    int privateUseVat = 0,
  }) {
    final linesByInvoice = <int, List<InvoiceLine>>{};
    for (final line in lines) {
      linesByInvoice.putIfAbsent(line.invoiceId, () => []).add(line);
    }

    var r1a = 0, v1a = 0, r1b = 0, v1b = 0, r1e = 0, r3a = 0, r3b = 0;
    final icp = <Invoice>[];
    for (final inv in invoices) {
      if (!inv.isIssued || quarterOf(inv.invoiceDate) != quarter) continue;
      final sign = inv.invoiceType == InvoiceType.creditNote ? -1 : 1;
      switch (inv.vatTreatment) {
        case VatTreatment.reverseChargeNl:
          r1e += sign * inv.totalExclVat;
        case VatTreatment.euServices:
        case VatTreatment.euGoods:
          r3b += sign * inv.totalExclVat;
          icp.add(inv);
        case VatTreatment.exportOutsideEu:
          r3a += sign * inv.totalExclVat;
        case VatTreatment.standard:
          for (final line in linesByInvoice[inv.id] ?? const <InvoiceLine>[]) {
            final base = sign * line.lineTotalExclVat;
            final vat = sign * line.vatAmount;
            switch (line.vatRate) {
              case VatRate.high:
                r1a += base;
                v1a += vat;
              case VatRate.low:
                r1b += base;
                v1b += vat;
              case VatRate.zero:
                r1e += base;
              case VatRate.exempt:
                break;
            }
          }
      }
    }

    final qExpenses = expenses.where((e) => quarterOf(e.date) == quarter);
    final inputVat = qExpenses.fold(0, (s, e) => s + e.vatToReclaim);
    int base(PurchaseVat p) => qExpenses
        .where((e) => e.purchaseVat == p)
        .fold(0, (s, e) => s + e.amountExclVat);
    int vat(PurchaseVat p) => qExpenses
        .where((e) => e.purchaseVat == p)
        .fold(0, (s, e) => s + e.vatAmount);

    return VatQuarterResult(
      revenue1a: r1a,
      vat1a: v1a,
      revenue1b: r1b,
      vat1b: v1b,
      revenue1e: r1e,
      vat1d: privateUseVat,
      revenue3a: r3a,
      revenue3b: r3b,
      base2a: base(PurchaseVat.reverseChargeNl),
      vat2a: vat(PurchaseVat.reverseChargeNl),
      base4a: base(PurchaseVat.fromOutsideEu),
      vat4a: vat(PurchaseVat.fromOutsideEu),
      base4b: base(PurchaseVat.fromEu),
      vat4b: vat(PurchaseVat.fromEu),
      inputVat5b: inputVat,
      icpInvoices: icp,
    );
  }

  /// Last day of the month after the quarter.
  static DateTime filingDeadline(int year, int quarter) =>
      DateTime(year, quarter * 3 + 2, 0);
}

final _btwRegex = RegExp(r'^NL\d{9}B\d{2}$', caseSensitive: false);

/// Dutch btw-identificatienummer: NL, 9 digits, B, 2 digits.
bool isValidDutchVatNumber(String value) =>
    _btwRegex.hasMatch(value.replaceAll(' ', ''));

final _kvkRegex = RegExp(r'^\d{8}$');

bool isValidKvkNumber(String value) =>
    _kvkRegex.hasMatch(value.replaceAll(' ', ''));

/// IBAN structure plus the ISO 13616 mod-97 check.
bool isValidIban(String value) {
  final iban = value.replaceAll(' ', '').toUpperCase();
  if (!RegExp(r'^[A-Z]{2}\d{2}[A-Z0-9]{11,30}$').hasMatch(iban)) return false;
  final rearranged = iban.substring(4) + iban.substring(0, 4);
  var remainder = 0;
  for (final c in rearranged.codeUnits) {
    final digits = c >= 65 ? '${c - 55}' : String.fromCharCode(c);
    for (final d in digits.codeUnits) {
      remainder = (remainder * 10 + d - 48) % 97;
    }
  }
  return remainder == 1;
}
