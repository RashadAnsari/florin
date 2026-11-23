import 'package:florin/db/database.dart';
import 'package:florin/services/domain.dart';
import 'package:florin/services/kor_service.dart';
import 'package:florin/services/vat_service.dart';
import 'package:flutter_test/flutter_test.dart';

Invoice _invoice(
  int id,
  DateTime date,
  int total, {
  VatTreatment treatment = VatTreatment.kor,
  InvoiceStatus status = InvoiceStatus.sent,
  InvoiceType type = InvoiceType.invoice,
}) => Invoice(
  id: id,
  invoiceNumber: 'F-$id',
  invoiceType: type,
  invoiceDate: date,
  clientId: 1,
  vatTreatment: treatment,
  selfBilled: false,
  sellerName: 'S',
  sellerVatNumber: 'NL000000000B00',
  sellerKvkNumber: '00000000',
  sellerAddress: 'A',
  sellerIban: 'NL91ABNA0417164300',
  paymentTermDays: 14,
  status: status,
  totalExclVat: total,
  totalVat: 0,
  totalInclVat: total,
);

BusinessProfile _profile({DateTime? start, DateTime? end}) => BusinessProfile(
  id: 1,
  name: 'S',
  vatNumber: 'NL000000000B00',
  kvkNumber: '00000000',
  address: 'A',
  iban: 'NL91ABNA0417164300',
  isStarter: false,
  korStart: start,
  korEnd: end,
);

void main() {
  test('turnover counts supplies taxed in NL, not services taxed abroad '
      '(Belastingdienst, Omzet die meetelt voor KOR)', () {
    for (final t in [
      VatTreatment.standard,
      VatTreatment.reverseChargeNl,
      VatTreatment.euGoods,
      VatTreatment.exportOutsideEu,
      VatTreatment.kor,
    ]) {
      expect(KorService.counts(t), isTrue, reason: t.name);
    }
    expect(KorService.counts(VatTreatment.euServices), isFalse);
    expect(KorService.counts(VatTreatment.servicesOutsideEu), isFalse);

    final invoices = [
      _invoice(1, DateTime(2026, 1, 10), 500000),
      _invoice(
        2,
        DateTime(2026, 2, 10),
        300000,
        treatment: VatTreatment.servicesOutsideEu,
      ),
      _invoice(3, DateTime(2026, 3, 10), 100000, type: InvoiceType.creditNote),
      _invoice(4, DateTime(2026, 3, 11), 999999, status: InvoiceStatus.draft),
    ];
    expect(KorService.turnover(invoices, 2026), 400000);
    expect(
      KorService.turnover(invoices, 2026, through: DateTime(2026, 1, 31)),
      500000,
    );
  });

  test('the KOR ends with the supply that passes the limit, for the rest of '
      'that year and the next (art. 25a lid 9)', () {
    final invoices = [
      _invoice(1, DateTime(2026, 1, 28), 1530000),
      _invoice(
        2,
        DateTime(2026, 4, 28),
        510000,
        treatment: VatTreatment.standard,
      ),
    ];
    final status = KorService.status(
      _profile(start: DateTime(2026, 1, 1)),
      invoices,
    );
    expect(status.exceededOn[2026], DateTime(2026, 4, 28));
    expect(status.appliesOn(DateTime(2026, 4, 27)), isTrue);
    expect(status.appliesOn(DateTime(2026, 4, 28)), isFalse);
    expect(status.appliesOn(DateTime(2026, 12, 31)), isFalse);
    expect(status.appliesOn(DateTime(2027, 6, 1)), isFalse);
    expect(status.coversQuarter(2026, 1), isTrue);
    expect(status.coversQuarter(2026, 2), isFalse);
    expect(status.touchesQuarter(2026, 2), isTrue);
    expect(status.touchesQuarter(2026, 3), isFalse);
  });

  test('the KOR applies from its start and until a voluntary end '
      '(art. 25a lid 5 and 7)', () {
    final status = KorService.status(
      _profile(start: DateTime(2026, 4, 1), end: DateTime(2026, 10, 1)),
      const [],
    );
    expect(status.appliesOn(DateTime(2026, 3, 31)), isFalse);
    expect(status.appliesOn(DateTime(2026, 4, 1)), isTrue);
    expect(status.appliesOn(DateTime(2026, 9, 30)), isTrue);
    expect(status.appliesOn(DateTime(2026, 10, 1)), isFalse);
    expect(KorService.status(_profile(), const []).participates, isFalse);
  });

  test('an invoice that would pass the limit is found before it is saved', () {
    final invoices = [_invoice(1, DateTime(2026, 3, 1), 1900000)];
    bool exceeds(int amount, VatTreatment t) => KorService.wouldExceed(
      invoices: invoices,
      date: DateTime(2026, 3, 5),
      treatment: t,
      amount: amount,
      limit: 2000000,
    );
    expect(exceeds(100000, VatTreatment.kor), isFalse);
    expect(exceeds(100001, VatTreatment.kor), isTrue);
    // A service taxed abroad does not count.
    expect(exceeds(500000, VatTreatment.euServices), isFalse);
  });

  test('under the KOR no BTW on purchases is reclaimed; it becomes cost '
      '(art. 25a lid 4)', () {
    final expense = Expense(
      id: 1,
      date: DateTime(2026, 2, 1),
      supplier: 's',
      description: 'd',
      category: ExpenseCategory.software,
      receiptAttached: true,
      amountExclVat: 10000,
      vatRate: VatRate.high,
      purchaseVat: PurchaseVat.domestic,
      vatAmount: 2100,
      totalInclVat: 12100,
      businessUsePct: 1,
      deductibleAmount: 10000,
      vatReclaimable: true,
      vatToReclaim: 2100,
    );
    final status = KorService.status(
      _profile(start: DateTime(2026, 1, 1)),
      const [],
    );
    final [applied] = KorService.applyToExpenses([expense], status);
    expect(applied.vatToReclaim, 0);
    expect(applied.deductibleAmount, 12100);
    final outside = KorService.applyToExpenses([
      expense.copyWith(date: DateTime(2025, 12, 31)),
    ], status).single;
    expect(outside.vatToReclaim, 2100);
  });

  test('KOR-exempt invoices are in no rubriek and the treatment fits a client '
      'anywhere', () {
    final r = VatService.calculateQuarter(
      invoices: [_invoice(1, DateTime(2026, 2, 1), 50000)],
      lines: const [],
      expenses: const [],
      quarter: 1,
    );
    expect(r.revenueKorExempt, 50000);
    expect(r.revenue1a + r.revenue1e + r.revenue3a + r.revenue3b, 0);
    expect(r.outputVat5a, 0);
    expect(VatTreatment.kor.fitsCountry('US'), isTrue);
  });
}
