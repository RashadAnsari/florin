import '../db/database.dart';
import 'domain.dart';
import 'kor_service.dart';

/// Which return a quarter needs (`docs/legal.md`, Filing a return).
enum ReturnDuty {
  /// The regular return, also when there is nothing to report.
  regular,

  /// The KOR covers the quarter but BTW is owed in it, such as BTW shifted
  /// to the user. The user asks the Belastingdienst for this return.
  incidental,

  /// The KOR covers the quarter and no BTW is owed in it.
  none,
}

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

  /// Supplies to EU businesses for the ICP-opgaaf, leaving out those made
  /// while the KOR applies (Wet OB 1968 art. 37a lid 1).
  final List<Invoice> icpInvoices;

  /// Services to businesses outside the EU. Not part of the return; shown
  /// so the user sees where that revenue went.
  final int revenueOutsideReturn;

  /// Supplies exempt under the KOR. Not part of the return either.
  final int revenueKorExempt;

  final ReturnDuty duty;

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
    this.revenueOutsideReturn = 0,
    this.revenueKorExempt = 0,
    this.duty = ReturnDuty.regular,
  });

  /// Nothing to report in any rubriek: the return is a nil return.
  bool get isEmpty =>
      revenue1a == 0 &&
      revenue1b == 0 &&
      revenue1e == 0 &&
      vat1d == 0 &&
      revenue3a == 0 &&
      revenue3b == 0 &&
      base2a == 0 &&
      base4a == 0 &&
      base4b == 0 &&
      inputVat5b == 0;

  int get outputVat5a => vat1a + vat1b + vat1d + vat2a + vat4a + vat4b;

  /// Positive: to pay. Negative: to get back.
  int get netVat => outputVat5a - inputVat5b;
}

abstract final class VatService {
  /// Days before a deadline at which it is shown as urgent.
  static const urgentDeadlineDays = 14;

  /// Rubrieken per the Belastingdienst guidance in `docs/legal.md`. Exempt
  /// supplies, supplies exempt under the KOR and services to businesses
  /// outside the EU are not reported.
  static VatQuarterResult calculateQuarter({
    required List<Invoice> invoices,
    required List<InvoiceLine> lines,
    required List<Expense> expenses,
    required int year,
    required int quarter,
    int privateUseVat = 0,
    KorStatus kor = KorStatus.none,
  }) {
    final linesByInvoice = <int, List<InvoiceLine>>{};
    for (final line in lines) {
      linesByInvoice.putIfAbsent(line.invoiceId, () => []).add(line);
    }

    var r1a = 0, v1a = 0, r1b = 0, v1b = 0, r1e = 0, r3a = 0, r3b = 0;
    var outside = 0, korExempt = 0;
    final icp = <Invoice>[];
    for (final inv in invoices) {
      if (!inv.isIssued || quarterOf(inv.invoiceDate) != quarter) continue;
      final sign = inv.sign;
      switch (inv.vatTreatment) {
        case VatTreatment.reverseChargeNl:
          r1e += inv.signedExclVat;
        case VatTreatment.euServices:
        case VatTreatment.euGoods:
          r3b += inv.signedExclVat;
          // A KOR participant files no ICP-opgaaf (art. 37a lid 1).
          if (!kor.appliesOn(inv.invoiceDate)) icp.add(inv);
        case VatTreatment.exportOutsideEu:
          r3a += inv.signedExclVat;
        case VatTreatment.servicesOutsideEu:
          outside += inv.signedExclVat;
        case VatTreatment.kor:
          korExempt += inv.signedExclVat;
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

    // BTW owed in a period is paid on a return (art. 14 lid 1), so a KOR
    // quarter with BTW owed, such as BTW shifted to the user, needs one.
    final owed =
        v1a +
        v1b +
        privateUseVat +
        vat(PurchaseVat.reverseChargeNl) +
        vat(PurchaseVat.fromOutsideEu) +
        vat(PurchaseVat.fromEu);
    final duty = !kor.coversQuarter(year, quarter)
        ? ReturnDuty.regular
        : owed != 0
        ? ReturnDuty.incidental
        : ReturnDuty.none;

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
      revenueOutsideReturn: outside,
      revenueKorExempt: korExempt,
      duty: duty,
    );
  }

  /// Last day of the month after the quarter.
  static DateTime filingDeadline(int year, int quarter) =>
      DateTime(year, quarter * 3 + 2, 0);
}
