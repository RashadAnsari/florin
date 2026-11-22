import 'package:florin/db/database.dart';
import 'package:florin/services/asset_service.dart';
import 'package:florin/services/car_service.dart';
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
}) => FixedAsset(
  id: id,
  kind: kind,
  assetName: 'Asset $id',
  costExclVat: cost,
  residualValue: 0,
  purchaseDate: bought ?? DateTime(2026, 1, 1),
  businessUsePct: 1,
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
  vatDeductedOnPurchase: vatOnPurchase,
);

Expense carExpense(int carId, int amount, int vat) => Expense(
  id: carId * 100,
  date: DateTime(2026, 6, 1),
  supplier: 's',
  description: 'fuel',
  category: ExpenseCategory.travel,
  receiptAttached: true,
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

void main() {
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
