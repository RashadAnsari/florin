import 'package:drift/drift.dart' show Value;
import 'package:florin/db/database.dart';
import 'package:florin/services/asset_service.dart';
import 'package:florin/services/car_service.dart';
import 'package:florin/services/domain.dart';
import 'package:florin/services/kor_service.dart';
import 'package:florin/services/tax_service.dart';
import 'package:florin/services/vat_service.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:flutter_test/flutter_test.dart';

final rules = taxRulesFor(2026)!;

FixedAsset asset(
  int id, {
  int cost = 1000000,
  DateTime? bought,
  bool kia = false,
  bool eia = false,
  MiaCategory? mia,
  DateTime? sold,
  int? proceeds,
  bool reserveGain = false,
  int reserveApplied = 0,
  int? deductionReceived,
  AssetKind kind = AssetKind.general,
  int? catalogue,
  DateTime? registered,
  ZeroEmission zeroEmission = ZeroEmission.none,
  bool tripLog = false,
  int vatOnPurchase = 0,
  PurchaseVat purchaseVat = PurchaseVat.domestic,
  bool vatReclaimable = true,
  double businessUse = 1,
  VatRate? saleVatRate,
  int? saleVat,
  int? saleInvoiceId,
}) => FixedAsset(
  id: id,
  kind: kind,
  assetName: 'Asset $id',
  costExclVat: cost,
  vatRate: vatOnPurchase > 0 ? VatRate.high : null,
  purchaseVat: purchaseVat,
  vatAmount: vatOnPurchase,
  vatReclaimable: vatReclaimable,
  vatToReclaim: vatReclaimable ? (vatOnPurchase * businessUse).round() : 0,
  residualValue: 0,
  purchaseDate: bought ?? DateTime(2026, 1, 1),
  businessUsePct: businessUse,
  usefulLifeYears: 5,
  kiaEligible: kia,
  eiaEligible: eia,
  miaCategory: mia,
  investmentDeductionReceived: deductionReceived,
  reinvestmentReserveApplied: reserveApplied,
  reserveGain: reserveGain,
  disposalDate: sold,
  disposalProceeds: proceeds,
  catalogueValue: catalogue,
  firstRegistration: registered,
  zeroEmission: zeroEmission,
  keepsTripLog: tripLog,
  disposalVatRate: saleVatRate,
  disposalVatAmount: saleVat,
  disposalInvoiceId: saleInvoiceId,
);

Expense carExpense(int carId, int amount, int vat) => Expense(
  id: carId * 100,
  date: DateTime(2026, 6, 1),
  supplier: 's',
  description: 'fuel',
  category: ExpenseCategory.travel,
  paperOriginalKept: true,
  amountExclVat: amount,
  vatRate: VatRate.high,
  purchaseVat: PurchaseVat.domestic,
  vatAmount: vat,
  totalInclVat: amount + vat,
  businessUsePct: 1,
  deductibleAmount: amount,
  vatReclaimable: true,
  vatToReclaim: vat,
  carAssetId: carId,
);

MileageTrip trip(int carId, TripType type, int km) => MileageTrip(
  id: km,
  date: DateTime(2026, 3, 1),
  carAssetId: carId,
  vehicleMakeModel: 'Car',
  vehicleLicensePlate: 'AB-123-C',
  departureAddress: 'A',
  arrivalAddress: 'B',
  odometerStart: 0,
  odometerEnd: km,
  tripType: type,
  purpose: 'p',
  routeDeviation: false,
);

Invoice saleInvoice(
  int id,
  int total, {
  InvoiceType type = InvoiceType.invoice,
  int? corrects,
  VatTreatment treatment = VatTreatment.standard,
}) => Invoice(
  id: id,
  invoiceNumber: 'F-2026-$id',
  invoiceType: type,
  correctedInvoiceId: corrects,
  invoiceDate: DateTime(2026, 9, 10),
  clientId: 1,
  vatTreatment: treatment,
  selfBilled: false,
  sellerName: 'S',
  sellerVatNumber: 'NL000000000B00',
  sellerKvkNumber: '00000000',
  sellerAddress: 'A',
  sellerIban: 'NL91ABNA0417164300',
  paymentTermDays: 14,
  status: InvoiceStatus.sent,
  totalExclVat: total,
  totalVat: 0,
  totalInclVat: total,
);

VatQuarterResult quarterOf2026(
  int quarter,
  List<FixedAsset> assets, {
  KorStatus kor = KorStatus.none,
}) => VatService.calculateQuarter(
  invoices: const [],
  lines: const [],
  expenses: const [],
  assets: assets,
  year: 2026,
  quarter: quarter,
  kor: kor,
);

final korAll2026 = KorStatus(
  start: DateTime(2026),
  end: null,
  exceededOn: const {},
  turnover: const {},
);

void main() {
  group('BTW on an asset (Wet OB 1968 art. 3 lid 3 a, 15 and 25a)', () {
    test('purchase BTW goes in 5b in its quarter, for the business share', () {
      final laptop = asset(
        1,
        cost: 200000,
        bought: DateTime(2026, 5, 10),
        vatOnPurchase: 42000,
        businessUse: 0.8,
      );
      final older = asset(
        2,
        cost: 200000,
        bought: DateTime(2025, 5, 10),
        vatOnPurchase: 42000,
      );
      expect(quarterOf2026(2, [laptop, older]).inputVat5b, 33600);
      expect(quarterOf2026(1, [laptop, older]).inputVat5b, 0);
    });

    test('BTW shifted on an asset from an EU supplier: 4b and back in 5b', () {
      final machine = asset(
        1,
        bought: DateTime(2026, 2, 1),
        vatOnPurchase: 210000,
        purchaseVat: PurchaseVat.fromEu,
      );
      final r = quarterOf2026(1, [machine]);
      expect(r.base4b, 1000000);
      expect(r.vat4b, 210000);
      expect(r.inputVat5b, 210000);
      expect(r.netVat, 0);
    });

    test('BTW not reclaimed is part of the investment (Wet IB 2001 art. '
        '3.43 lid 1): depreciation, the KIA and its € 450 limit', () {
      final kept = asset(1, vatOnPurchase: 210000, vatReclaimable: false);
      expect(kept.cost, 1210000);
      expect(
        AssetService.depreciation(kept, 2026),
        AssetService.depreciation(asset(2, cost: 1210000), 2026),
      );
      final small = [
        asset(3, cost: 40000, vatOnPurchase: 8400, kia: true),
        asset(
          4,
          cost: 40000,
          vatOnPurchase: 8400,
          vatReclaimable: false,
          kia: true,
        ),
      ];
      expect(AssetService.kiaInvestments(small, 2026, rules), 48400);
    });

    test('under the KOR purchase BTW is not deducted and becomes cost', () {
      final counted = KorService.applyToAssets([
        asset(1, bought: DateTime(2026, 3, 1), vatOnPurchase: 210000),
      ], korAll2026);
      expect(counted.single.vatToReclaim, 0);
      expect(counted.single.cost, 1210000);
      expect(quarterOf2026(1, counted).inputVat5b, 0);
    });

    test('BTW shifted on an asset in a KOR quarter is owed: an incidental '
        'return', () {
      final counted = KorService.applyToAssets([
        asset(
          1,
          bought: DateTime(2026, 2, 1),
          vatOnPurchase: 210000,
          purchaseVat: PurchaseVat.fromEu,
        ),
      ], korAll2026);
      final r = quarterOf2026(1, counted, kor: korAll2026);
      expect(r.vat4b, 210000);
      expect(r.inputVat5b, 0);
      expect(r.duty, ReturnDuty.incidental);
    });

    test('a sale without an invoice in Florin carries BTW over the business '
        'share of the proceeds, in its quarter', () {
      FixedAsset sold(VatRate rate) => asset(
        1,
        cost: 200000,
        bought: DateTime(2025, 1, 1),
        businessUse: 0.5,
        sold: DateTime(2026, 8, 14),
        proceeds: 100000,
        saleVatRate: rate,
        saleVat: rules.vatOn(rate, 50000),
      );
      final high = quarterOf2026(3, [sold(VatRate.high)]);
      expect(high.revenue1a, 50000);
      expect(high.vat1a, 10500);
      expect(quarterOf2026(2, [sold(VatRate.high)]).vat1a, 0);
      expect(quarterOf2026(3, [sold(VatRate.zero)]).revenue1e, 50000);
      expect(quarterOf2026(3, [sold(VatRate.exempt)]).isEmpty, isTrue);
    });

    test('the KOR exempts a sale without an invoice', () {
      final counted = KorService.applyToAssets([
        asset(
          1,
          bought: DateTime(2025, 1, 1),
          sold: DateTime(2026, 8, 14),
          proceeds: 100000,
          saleVatRate: VatRate.high,
          saleVat: 21000,
        ),
      ], korAll2026);
      expect(counted.single.disposalVatRate, isNull);
      expect(quarterOf2026(3, counted).vat1a, 0);
    });

    test('a sale invoiced in Florin: the invoice carries the BTW, and its '
        'amount, less credit notes, is the proceeds, not revenue or KOR '
        'turnover (art. 25 lid 2)', () {
      final invoices = [
        saleInvoice(9, 15000),
        saleInvoice(10, 5000, type: InvoiceType.creditNote, corrects: 9),
        saleInvoice(11, 100000),
      ];
      final monitor = asset(
        1,
        cost: 40000,
        bought: DateTime(2025, 2, 3),
        sold: DateTime(2026, 9, 10),
        proceeds: 15000,
        saleInvoiceId: 9,
      );
      final sales = AssetService.saleInvoiceIds([monitor]);
      expect(sales, {9});
      expect(
        AssetService.withSaleInvoices([
          monitor,
        ], invoices).single.disposalProceeds,
        10000,
      );
      expect(quarterOf2026(3, [monitor]).isEmpty, isTrue);
      expect(TaxService.grossRevenue(invoices, assetSales: sales), 100000);
      expect(TaxService.creditNotes(invoices, assetSales: sales), 0);
      expect(KorService.turnover(invoices, 2026, assetSales: sales), 100000);
    });

    test('a car whose purchase BTW was not deducted pays BTW on private use '
        'as one bought without BTW', () {
      int privateUse(FixedAsset car) => CarService.btwPrivateUse(
        assets: [car],
        trips: const [],
        expenses: [carExpense(1, 100000, 21000)],
        year: 2026,
        rules: rules,
      );
      FixedAsset car({int vat = 0, bool reclaimed = true}) => asset(
        1,
        cost: 3000000,
        kind: AssetKind.car,
        catalogue: 4000000,
        registered: DateTime(2026, 1, 1),
        vatOnPurchase: vat,
        vatReclaimable: reclaimed,
      );
      expect(privateUse(car(vat: 630000, reclaimed: false)), privateUse(car()));
    });
  });

  group('investeringsaftrek (Fiscale informatie 2026, 8.2)', () {
    test('EIA 40% and MIA by category, from € 2.500 per asset', () {
      final d = AssetService.investmentDeduction(
        [
          asset(1, eia: true),
          asset(2, mia: MiaCategory.two),
          asset(3, cost: 200000, eia: true),
        ],
        2026,
        rules,
      );
      expect(d.eia, 400000);
      expect(d.mia, 360000);
    });

    test('KIA excludes passenger cars and assets under € 450', () {
      final assets = [
        asset(1, kia: true),
        asset(2, kia: true, kind: AssetKind.car),
        asset(3, kia: true, cost: 44999),
      ];
      expect(AssetService.kiaInvestments(assets, 2026, rules), 1000000);
    });

    test('no EIA on a car (Wet IB 2001 art. 3.45 lid 1 d), MIA is allowed '
        '(lid 3)', () {
      final d = AssetService.investmentDeduction(
        [
          asset(1, kind: AssetKind.car, eia: true, cost: 3000000),
          asset(2, kind: AssetKind.car, mia: MiaCategory.three, cost: 3000000),
        ],
        2026,
        rules,
      );
      expect(d.eia, 0);
      expect(d.mia, 810000);
    });
  });

  group('desinvesteringsbijtelling (Fiscale informatie 2026, 8.2.4)', () {
    test('proceeds times the deduction percentage, capped', () {
      final sold = asset(
        1,
        kia: true,
        eia: true,
        sold: DateTime(2026, 12, 1),
        proceeds: 500000,
      );
      // KIA 28% + EIA 40% = 68% of the cost
      expect(AssetService.deductionReceived(sold, [sold]), 680000);
      expect(
        AssetService.desinvesteringsbijtelling([sold], 2026, rules),
        340000,
      );
    });

    test('nothing when total sales are at most € 2.900', () {
      final sold = asset(
        1,
        kia: true,
        sold: DateTime(2026, 12, 1),
        proceeds: 290000,
      );
      expect(AssetService.desinvesteringsbijtelling([sold], 2026, rules), 0);
    });

    test('uses the entered deduction for a year without rules', () {
      final sold = asset(
        1,
        bought: DateTime(2024, 1, 1),
        deductionReceived: 100000,
        sold: DateTime(2026, 6, 1),
        proceeds: 500000,
      );
      // 10% of the cost was deducted, so 10% of the proceeds is added back
      expect(
        AssetService.desinvesteringsbijtelling([sold], 2026, rules),
        50000,
      );
    });

    test('nothing after five years from the start of the purchase year', () {
      final sold = asset(
        1,
        bought: DateTime(2021, 12, 31),
        deductionReceived: 100000,
        sold: DateTime(2026, 1, 1),
        proceeds: 500000,
      );
      expect(AssetService.desinvesteringsbijtelling([sold], 2026, rules), 0);
    });
  });

  group('herinvesteringsreserve (Fiscale informatie 2026, 7.7.1.2)', () {
    test('a reserved gain is not profit, and is released after 3 years', () {
      final sold = asset(
        1,
        bought: DateTime(2020, 1, 1),
        sold: DateTime(2026, 1, 1),
        proceeds: 300000,
        reserveGain: true,
      );
      expect(AssetService.disposalResult([sold], 2026), 0);
      final ledger = AssetService.reserveLedger([sold], 2029);
      expect(ledger[2026]!.formed, 300000);
      expect(ledger[2029]!.released, 300000);
    });

    test('booking it off lowers the release and the depreciation', () {
      final sold = asset(
        1,
        bought: DateTime(2020, 1, 1),
        sold: DateTime(2026, 1, 1),
        proceeds: 300000,
        reserveGain: true,
      );
      final next = asset(
        2,
        bought: DateTime(2027, 1, 1),
        reserveApplied: 100000,
      );
      final ledger = AssetService.reserveLedger([sold, next], 2029);
      expect(ledger[2027]!.applied, 100000);
      expect(ledger[2029]!.released, 200000);
      // € 9.000 after booking off, × 365 of 1,826 days
      expect(AssetService.depreciation(next, 2027), 179901);
    });

    test('everything is released when the business stops', () {
      final sold = asset(
        1,
        bought: DateTime(2020, 1, 1),
        sold: DateTime(2026, 1, 1),
        proceeds: 300000,
        reserveGain: true,
      );
      expect(
        AssetService.reserveLedger(
          [sold],
          2026,
          ceasedYear: 2026,
        )[2026]!.released,
        300000,
      );
    });
  });

  group('business car (Wet IB 2001 art. 3.20)', () {
    test('22% of the catalogue value, capped at the car costs', () {
      final car = asset(
        1,
        kind: AssetKind.car,
        cost: 4000000,
        catalogue: 4000000,
        registered: DateTime(2026, 1, 1),
      );
      final costs = carExpense(1, 2000000, 0);
      expect(
        CarService.privateUseAddition(
          assets: [car],
          trips: const [],
          expenses: [costs],
          year: 2026,
          rules: rules,
        ),
        880000,
      );
    });

    test('nothing with a trip log of at most 500 private km', () {
      final car = asset(
        1,
        kind: AssetKind.car,
        catalogue: 4000000,
        registered: DateTime(2026, 1, 1),
        tripLog: true,
      );
      expect(
        CarService.privateUseAddition(
          assets: [car],
          trips: [trip(1, TripType.private, 500)],
          expenses: [carExpense(1, 2000000, 0)],
          year: 2026,
          rules: rules,
        ),
        0,
      );
    });

    test(
      '35% of the market value only once the car is more than 16 and 15 '
      'years old: not on the anniversary itself (art. 3.20 lid 1 b, 5 b)',
      () {
        // First registered on 1 July 2010: exactly 16 years on 1 July 2026,
        // more than 16 from 2 July.
        final car = asset(
          1,
          kind: AssetKind.car,
          catalogue: 3000000,
          registered: DateTime(2010, 7, 1),
        ).copyWith(marketValue: const Value(1000000));
        final addition = CarService.privateUseAddition(
          assets: [car],
          trips: const [],
          expenses: [carExpense(1, 9000000, 0)],
          year: 2026,
          rules: rules,
        );
        // 22% of the market value (more than 15 years) to 1 July, 35% after.
        expect(addition, closeTo((220000 * 182 + 350000 * 183) / 365, 2));
      },
    );

    test('zero emission: 4% off, at most € 1.200, or the frozen 2025 rule', () {
      final car2026 = asset(
        1,
        kind: AssetKind.car,
        catalogue: 5000000,
        registered: DateTime(2026, 1, 1),
        zeroEmission: ZeroEmission.battery,
      );
      final car2025 = asset(
        2,
        kind: AssetKind.car,
        catalogue: 5000000,
        registered: DateTime(2025, 1, 1),
        zeroEmission: ZeroEmission.battery,
      );
      int add(FixedAsset c) => CarService.privateUseAddition(
        assets: [c],
        trips: const [],
        expenses: [carExpense(c.id, 9000000, 0)],
        year: 2026,
        rules: rules,
      );
      expect(add(car2026), 1100000 - 120000);
      expect(add(car2025), 1100000 - 150000);
    });

    test('a car registered in a year with rules keeps that year\'s '
        'zero-emission reduction (art. 3.20 lid 11)', () {
      final car = asset(
        1,
        kind: AssetKind.car,
        catalogue: 5000000,
        registered: DateTime(2026, 3, 1),
        bought: DateTime(2026, 3, 1),
        zeroEmission: ZeroEmission.battery,
      );
      // 22% of € 50.000 minus the 2026 reduction of 4%, at most € 1.200,
      // over the ten months the car is in the business.
      final addition = CarService.privateUseAddition(
        assets: [car],
        trips: const [],
        expenses: [carExpense(1, 2000000, 0)],
        year: 2026,
        rules: rules,
      );
      expect(addition, closeTo((1100000 - 120000) * 306 / 365, 2));
    });

    test('BTW: 2.7% of the catalogue value, capped at deducted BTW', () {
      final car = asset(
        1,
        kind: AssetKind.car,
        catalogue: 4500000,
        registered: DateTime(2026, 1, 1),
        vatOnPurchase: 500000,
      );
      expect(
        CarService.btwPrivateUse(
          assets: [car],
          trips: const [],
          expenses: [carExpense(1, 500000, 105000)],
          year: 2026,
          rules: rules,
        ),
        121500,
      );
    });

    test('BTW cap: all purchase BTW in the year of purchase, one fifth in '
        'the 4 years after (Belastingdienst, Btw en privégebruik auto)', () {
      // The Belastingdienst's example: bought for € 18.150 with € 3.150
      // BTW, catalogue value € 75.000, € 735 BTW on upkeep and use.
      final car = asset(
        1,
        kind: AssetKind.car,
        catalogue: 7500000,
        registered: DateTime(2020, 1, 1),
        vatOnPurchase: 315000,
      );
      int owed(int year) => CarService.btwPrivateUse(
        assets: [car],
        trips: const [],
        expenses: [
          carExpense(1, 350000, 73500).copyWith(date: DateTime(year, 6, 1)),
        ],
        year: year,
        rules: rules,
      );
      expect(owed(2026), 202500);
      expect(owed(2027), 73500 + 63000);
    });

    test('BTW with a trip log: private and commuting share', () {
      final car = asset(
        1,
        kind: AssetKind.car,
        catalogue: 4500000,
        registered: DateTime(2026, 1, 1),
        tripLog: true,
      );
      expect(
        CarService.btwPrivateUse(
          assets: [car],
          trips: [
            trip(1, TripType.business, 2500),
            trip(1, TripType.commute, 500),
          ],
          expenses: [carExpense(1, 500000, 150000)],
          year: 2026,
          rules: rules,
        ),
        25000,
      );
    });
  });
}
