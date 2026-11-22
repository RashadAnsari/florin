// Creates `demo/florin.db`: a fictional freelance designer with a year of
// bookkeeping, to try Florin without entering data. Run `make demo`, then
// choose the `demo` folder on Florin's first start.
//
// Every name, number and address here is made up.

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:florin/db/daos/asset_dao.dart';
import 'package:florin/db/daos/business_profile_dao.dart';
import 'package:florin/db/daos/client_dao.dart';
import 'package:florin/db/daos/expense_dao.dart';
import 'package:florin/db/daos/hour_dao.dart';
import 'package:florin/db/daos/invoice_dao.dart';
import 'package:florin/db/daos/mileage_dao.dart';
import 'package:florin/db/daos/pension_dao.dart';
import 'package:florin/db/daos/tax_year_inputs_dao.dart';
import 'package:florin/db/daos/vat_return_dao.dart';
import 'package:florin/db/database.dart';

const _year = 2026;

Future<void> main(List<String> args) async {
  final dir = Directory(args.isEmpty ? 'demo' : args.first)
    ..createSync(recursive: true);
  final file = File('${dir.path}/florin.db');
  if (file.existsSync()) file.deleteSync();
  final db = AppDatabase(NativeDatabase(file));
  await fillDemo(db);
  await db.close();
  stdout.writeln('Demo database written to ${file.path}');
}

/// Fills [db] with the fictional business.
Future<void> fillDemo(AppDatabase db) async {
  await BusinessProfileDao(db).save(
    const BusinessProfilesCompanion(
      id: Value(1),
      name: Value('Studio Voorbeeld'),
      vatNumber: Value('NL000099998B57'),
      kvkNumber: Value('12345678'),
      address: Value('Voorbeeldstraat 1\n1234 AB Utrecht'),
      iban: Value('NL91ABNA0417164300'),
      isStarter: Value(false),
    ),
  );

  final clients = ClientDao(db);
  Future<int> client(
    String name,
    String country,
    String? vat,
    String address,
    WetDbaRisk risk, {
    bool active = true,
    String? kvk,
  }) => clients.save(
    ClientsCompanion(
      name: Value(name),
      country: Value(country),
      vatNumber: Value(vat),
      kvkNumber: Value(kvk),
      address: Value(address),
      wetDbaRisk: Value(risk),
      contractSigned: Value(risk != WetDbaRisk.high),
      contractExpiry: Value(DateTime(_year + 1, 6, 30)),
      contactPerson: const Value('Sam Voorbeeld'),
      phone: const Value('+31 20 000 0000'),
      email: Value('finance@${name.toLowerCase().split(' ').first}.example'),
      notes: const Value('Fictieve klant voor de demo'),
      isActive: Value(active),
    ),
  );
  final dutch = await client(
    'Voorbeeld Media BV',
    'NL',
    'NL000099997B65',
    'Marktplein 10\n3511 AA Utrecht',
    WetDbaRisk.low,
  );
  final german = await client(
    'Beispiel GmbH',
    'DE',
    'DE999999999',
    'Musterstraße 5\n10115 Berlin\nDeutschland',
    WetDbaRisk.low,
  );
  final agency = await client(
    'Bureau Fictief',
    'NL',
    'NL000099996B73',
    'Kade 22\n1011 AB Amsterdam',
    WetDbaRisk.medium,
    kvk: '87654321',
  );
  final builder = await client(
    'Bouwbedrijf Proef',
    'NL',
    'NL000099995B81',
    'Werfweg 3\n3542 AA Utrecht',
    WetDbaRisk.high,
    kvk: '11223344',
  );
  final belgian = await client(
    'Exemple SPRL',
    'BE',
    'BE0999999999',
    'Rue Exemple 1\n1000 Bruxelles\nBelgique',
    WetDbaRisk.low,
  );
  final swiss = await client(
    'Beispiel AG',
    'CH',
    null,
    'Musterweg 9\n8000 Zürich\nSchweiz',
    WetDbaRisk.low,
  );
  await client(
    'Oud Klant BV',
    'NL',
    null,
    'Oude Gracht 1\n3511 AB Utrecht',
    WetDbaRisk.low,
    active: false,
  );

  final invoices = InvoiceDao(db);
  var seq = 0;
  Future<int> invoice({
    required int clientId,
    required DateTime date,
    required List<(String, double, int, VatRate)> lines,
    VatTreatment treatment = VatTreatment.standard,
    InvoiceStatus status = InvoiceStatus.paid,
    InvoiceType type = InvoiceType.invoice,
    int? corrects,
  }) {
    seq++;
    var excl = 0, vat = 0;
    final companions = <InvoiceLinesCompanion>[];
    for (var i = 0; i < lines.length; i++) {
      final (text, qty, price, rate) = lines[i];
      final total = (qty * price).round();
      final lineVat = treatment == VatTreatment.standard
          ? rate.vatOn(total)
          : 0;
      excl += total;
      vat += lineVat;
      companions.add(
        InvoiceLinesCompanion(
          invoiceId: const Value(0),
          description: Value(text),
          quantity: Value(qty),
          unit: const Value('uur'),
          unitPriceExclVat: Value(price),
          vatRate: Value(
            treatment == VatTreatment.standard ? rate : VatRate.zero,
          ),
          vatAmount: Value(lineVat),
          lineTotalExclVat: Value(total),
          sortOrder: Value(i),
        ),
      );
    }
    return invoices.saveWithLines(
      InvoicesCompanion(
        invoiceNumber: Value('F-$_year-${seq.toString().padLeft(3, '0')}'),
        invoiceType: Value(type),
        correctedInvoiceId: Value(corrects),
        invoiceDate: Value(date),
        supplyDate: Value(date),
        clientId: Value(clientId),
        vatTreatment: Value(treatment),
        sellerName: const Value('Studio Voorbeeld'),
        sellerVatNumber: const Value('NL000099998B57'),
        sellerKvkNumber: const Value('12345678'),
        sellerAddress: const Value('Voorbeeldstraat 1\n1234 AB Utrecht'),
        sellerIban: const Value('NL91ABNA0417164300'),
        paymentTermDays: const Value(30),
        status: Value(status),
        paidDate: Value(
          status == InvoiceStatus.paid
              ? date.add(const Duration(days: 20))
              : null,
        ),
        totalExclVat: Value(excl),
        totalVat: Value(vat),
        totalInclVat: Value(excl + vat),
      ),
      companions,
    );
  }

  for (var month = 1; month <= 10; month++) {
    await invoice(
      clientId: dutch,
      date: DateTime(_year, month, 28),
      lines: [('Ontwerpwerk website', 60, 8500, VatRate.high)],
    );
  }
  final german1 = await invoice(
    clientId: german,
    date: DateTime(_year, 3, 15),
    lines: [('Brand design workshop', 16, 9500, VatRate.high)],
    treatment: VatTreatment.euServices,
  );
  await invoice(
    clientId: german,
    date: DateTime(_year, 4, 2),
    lines: [('Workshop: Korrektur Stunden', 2, 9500, VatRate.high)],
    treatment: VatTreatment.euServices,
    type: InvoiceType.creditNote,
    corrects: german1,
  );
  await invoice(
    clientId: agency,
    date: DateTime(_year, 11, 10),
    lines: [
      ('Illustraties campagne', 24, 7500, VatRate.high),
      ('Drukproef boekje', 1, 45000, VatRate.low),
      ('Lesmateriaal workshop', 1, 20000, VatRate.zero),
      ('Bemiddeling', 1, 15000, VatRate.exempt),
    ],
    status: InvoiceStatus.sent,
  );
  await invoice(
    clientId: agency,
    date: DateTime(_year, 8, 1),
    lines: [('Ontwerp nieuwsbrief', 10, 7500, VatRate.high)],
    status: InvoiceStatus.sent,
  );
  await invoice(
    clientId: builder,
    date: DateTime(_year, 6, 12),
    lines: [('Bouwtekeningen', 12, 8000, VatRate.high)],
    treatment: VatTreatment.reverseChargeNl,
  );
  await invoice(
    clientId: belgian,
    date: DateTime(_year, 7, 3),
    lines: [('Drukwerk posters', 200, 450, VatRate.high)],
    treatment: VatTreatment.euGoods,
  );
  await invoice(
    clientId: swiss,
    date: DateTime(_year, 9, 15),
    lines: [('Gedrukte catalogi', 50, 1200, VatRate.high)],
    treatment: VatTreatment.exportOutsideEu,
  );
  await invoice(
    clientId: dutch,
    date: DateTime(_year, 11, 20),
    lines: [('Ontwerp jaarverslag', 30, 8500, VatRate.high)],
    status: InvoiceStatus.draft,
  );

  final assets = AssetDao(db);
  Future<int> asset(
    String name,
    int cost,
    DateTime bought, {
    int residual = 0,
    double use = 1.0,
    int life = 5,
    bool kia = false,
    bool eia = false,
    MiaCategory? mia,
    int? deductionReceived,
    int reserveApplied = 0,
    DateTime? sold,
    int? proceeds,
    bool reserveGain = false,
    AssetKind kind = AssetKind.general,
    int? catalogue,
    DateTime? registered,
    ZeroEmission zeroEmission = ZeroEmission.none,
    int? marketValue,
    bool tripLog = false,
    int vatOnPurchase = 0,
  }) => assets.save(
    FixedAssetsCompanion(
      kind: Value(kind),
      assetName: Value(name),
      costExclVat: Value(cost),
      residualValue: Value(residual),
      purchaseDate: Value(bought),
      businessUsePct: Value(use),
      usefulLifeYears: Value(life),
      kiaEligible: Value(kia),
      eiaEligible: Value(eia),
      miaCategory: Value(mia),
      investmentDeductionReceived: Value(deductionReceived),
      reinvestmentReserveApplied: Value(reserveApplied),
      disposalDate: Value(sold),
      disposalProceeds: Value(proceeds),
      reserveGain: Value(reserveGain),
      catalogueValue: Value(catalogue),
      firstRegistration: Value(registered),
      zeroEmission: Value(zeroEmission),
      marketValue: Value(marketValue),
      keepsTripLog: Value(tripLog),
      vatDeductedOnPurchase: Value(vatOnPurchase),
      notes: Value(kind == AssetKind.car ? 'Fictieve auto voor de demo' : null),
    ),
  );

  await asset(
    'MacBook Pro',
    320000,
    DateTime(_year, 2, 1),
    residual: 20000,
    kia: true,
  );
  await asset('Bureau en stoel', 180000, DateTime(_year, 1, 15), kia: true);
  await asset(
    'Warmtepomp atelier',
    900000,
    DateTime(_year, 3, 1),
    residual: 50000,
    life: 10,
    kia: true,
    eia: true,
  );
  await asset(
    'Elektrische bakfiets',
    450000,
    DateTime(_year, 5, 1),
    life: 6,
    kia: true,
    mia: MiaCategory.three,
  );
  await asset(
    'Tablet (privé en zakelijk)',
    90000,
    DateTime(_year, 6, 1),
    use: 0.6,
    kia: true,
  );
  // Bought in a year without rules, sold with a gain kept in the
  // herinvesteringsreserve: shows the deduction input, the
  // desinvesteringsbijtelling and the reserve.
  await asset(
    'Fotocamera',
    400000,
    DateTime(2024, 4, 1),
    residual: 40000,
    deductionReceived: 112000,
    sold: DateTime(_year, 3, 31),
    proceeds: 380000,
    reserveGain: true,
  );
  await asset(
    'Nieuwe fotocamera',
    500000,
    DateTime(_year, 6, 15),
    residual: 50000,
    kia: true,
    reserveApplied: 100000,
  );
  await asset(
    'Printer',
    60000,
    DateTime(2023, 1, 10),
    sold: DateTime(_year, 2, 1),
    proceeds: 5000,
  );
  final car = await asset(
    'Elektrische auto',
    3200000,
    DateTime(_year, 4, 1),
    residual: 800000,
    kind: AssetKind.car,
    catalogue: 3900000,
    registered: DateTime(2025, 3, 20),
    zeroEmission: ZeroEmission.battery,
    vatOnPurchase: 672000,
  );
  final van = await asset(
    'Bestelauto',
    1800000,
    DateTime(_year, 1, 1),
    residual: 300000,
    kind: AssetKind.car,
    catalogue: 2600000,
    registered: DateTime(2022, 5, 1),
    tripLog: true,
    vatOnPurchase: 378000,
  );
  await asset(
    'Klassieke auto',
    1500000,
    DateTime(_year, 1, 1),
    residual: 1000000,
    life: 10,
    kind: AssetKind.car,
    catalogue: 2500000,
    registered: DateTime(2005, 1, 1),
    marketValue: 1800000,
  );
  await asset(
    'Waterstofauto',
    4500000,
    DateTime(_year, 9, 1),
    residual: 1500000,
    kind: AssetKind.car,
    catalogue: 6500000,
    registered: DateTime(_year, 8, 15),
    zeroEmission: ZeroEmission.hydrogenOrSolar,
  );

  final expenses = ExpenseDao(db);
  Future<void> expense(
    DateTime date,
    String supplier,
    String description,
    ExpenseCategory category,
    int amount, {
    VatRate rate = VatRate.high,
    bool reclaim = true,
    int? carId,
    PurchaseVat purchaseVat = PurchaseVat.domestic,
    double use = 1.0,
    bool receipt = true,
  }) {
    final vat = rate.vatOn(amount);
    return expenses
        .save(
          ExpensesCompanion(
            date: Value(date),
            supplier: Value(supplier),
            description: Value(description),
            category: Value(category),
            receiptAttached: Value(receipt),
            amountExclVat: Value(amount),
            vatRate: Value(rate),
            purchaseVat: Value(purchaseVat),
            vatAmount: Value(vat),
            totalInclVat: Value(
              amount + (purchaseVat == PurchaseVat.domestic ? vat : 0),
            ),
            businessUsePct: Value(use),
            deductibleAmount: Value(
              ((amount + (reclaim ? 0 : vat)) * use).round(),
            ),
            vatReclaimable: Value(reclaim),
            vatToReclaim: Value(reclaim ? (vat * use).round() : 0),
            carAssetId: Value(carId),
            paidFrom: const Value('Zakelijke rekening'),
            paymentReference: Value('REF-${date.month}-${amount % 997}'),
          ),
        )
        .then((_) {});
  }

  for (var month = 1; month <= 11; month++) {
    await expense(
      DateTime(_year, month, 3),
      'Design Software Europe Ltd',
      'Abonnement ontwerpsoftware',
      ExpenseCategory.software,
      5500,
      purchaseVat: PurchaseVat.fromEu,
    );
    await expense(
      DateTime(_year, month, 5),
      'Telecom Voorbeeld',
      'Mobiel en internet',
      ExpenseCategory.phoneAndInternet,
      4500,
      use: 0.8,
    );
    if (month >= 4) {
      await expense(
        DateTime(_year, month, 12),
        'Laadpaal Voorbeeld',
        'Laden auto',
        ExpenseCategory.travel,
        6000,
        carId: car,
      );
    }
    await expense(
      DateTime(_year, month, 15),
      'Tankstation Voorbeeld',
      'Brandstof bestelauto',
      ExpenseCategory.travel,
      9000,
      carId: van,
    );
  }
  await expense(
    DateTime(_year, 1, 8),
    'Kantoorartikelen Voorbeeld',
    'Papier en pennen',
    ExpenseCategory.office,
    4200,
  );
  await expense(
    DateTime(_year, 2, 9),
    'NS Voorbeeld',
    'Treinkaartjes',
    ExpenseCategory.travel,
    6400,
    rate: VatRate.low,
  );
  await expense(
    DateTime(_year, 5, 14),
    'Café De Voorbeeld',
    'Lunch met klant',
    ExpenseCategory.foodAndRepresentation,
    8500,
    rate: VatRate.low,
    reclaim: false,
  );
  await expense(
    DateTime(_year, 12, 1),
    'Restaurant Proef',
    'Kerstdiner met klanten',
    ExpenseCategory.foodAndRepresentation,
    62000,
    rate: VatRate.low,
    reclaim: false,
  );
  await expense(
    DateTime(_year, 3, 4),
    'Hardware Voorbeeld',
    'Externe schijf',
    ExpenseCategory.hardware,
    12000,
  );
  await expense(
    DateTime(_year, 4, 18),
    'Adverteren Voorbeeld',
    'Online advertenties',
    ExpenseCategory.marketing,
    30000,
    purchaseVat: PurchaseVat.fromOutsideEu,
  );
  await expense(
    DateTime(_year, 5, 2),
    'Boekhouder Voorbeeld',
    'Advies jaarrekening',
    ExpenseCategory.professionalServices,
    45000,
  );
  await expense(
    DateTime(_year, 6, 1),
    'Verzekeraar Voorbeeld',
    'Autoverzekering',
    ExpenseCategory.insurance,
    96000,
    rate: VatRate.exempt,
    carId: car,
  );
  await expense(
    DateTime(_year, 9, 20),
    'Opleidingen Voorbeeld',
    'Cursus typografie',
    ExpenseCategory.training,
    45000,
  );
  await expense(
    DateTime(_year, 7, 7),
    'Onderaannemer Proef',
    'Montage stand (btw verlegd)',
    ExpenseCategory.other,
    50000,
    purchaseVat: PurchaseVat.reverseChargeNl,
  );
  await expense(
    DateTime(_year, 10, 10),
    'Markt Voorbeeld',
    'Boek over design',
    ExpenseCategory.training,
    3500,
    rate: VatRate.zero,
    receipt: false,
  );

  final hours = HourDao(db);
  for (
    var d = DateTime(_year);
    d.month <= 11;
    d = d.add(const Duration(days: 1))
  ) {
    if (d.weekday > 5) continue;
    final type = switch (d.weekday) {
      1 => WorkType.billable,
      2 || 3 => WorkType.wbso,
      4 => d.day.isEven ? WorkType.nonBillable : WorkType.other,
      _ => WorkType.administrative,
    };
    await hours.save(
      HourEntriesCompanion(
        date: Value(d),
        description: Value(switch (type) {
          WorkType.billable => 'Ontwerpwerk',
          WorkType.wbso => 'Onderzoek nieuw ontwerpgereedschap',
          WorkType.nonBillable => 'Offertes schrijven',
          WorkType.other => 'Netwerkbijeenkomst',
          WorkType.administrative => 'Administratie',
        }),
        workType: Value(type),
        hours: const Value(6.0),
        clientProject: Value(
          type == WorkType.billable ? 'Voorbeeld Media' : null,
        ),
        notes: Value(d.day == 1 ? 'Begin van de maand' : null),
      ),
    );
  }

  final trips = MileageDao(db);
  var odo = 12000;
  Future<void> trip(
    DateTime date,
    TripType type,
    int km, {
    int? carId,
    bool deviation = false,
    String purpose = 'Overleg klant',
  }) {
    final start = odo;
    odo += km;
    return trips
        .save(
          MileageTripsCompanion(
            date: Value(date),
            carAssetId: Value(carId),
            vehicleMakeModel: Value(
              carId == null ? 'Privéauto Voorbeeld' : 'Auto van de zaak',
            ),
            vehicleLicensePlate: Value(carId == null ? 'AB-123-C' : 'ZZ-999-Z'),
            departureAddress: const Value('Voorbeeldstraat 1\n1234 AB Utrecht'),
            arrivalAddress: const Value('Marktplein 10\n3511 AA Utrecht'),
            odometerStart: Value(start),
            odometerEnd: Value(odo),
            tripType: Value(type),
            purpose: Value(purpose),
            routeDeviation: Value(deviation),
            notes: Value(deviation ? 'Omleiding door wegwerkzaamheden' : null),
          ),
        )
        .then((_) {});
  }

  for (var month = 1; month <= 11; month++) {
    await trip(DateTime(_year, month, 20), TripType.business, 42);
    await trip(DateTime(_year, month, 21), TripType.commute, 18);
    await trip(
      DateTime(_year, month, 22),
      TripType.private,
      30,
      purpose: 'Privérit',
    );
    await trip(
      DateTime(_year, month, 9),
      TripType.business,
      120,
      carId: van,
      deviation: month == 6,
    );
    await trip(DateTime(_year, month, 10), TripType.commute, 18, carId: van);
    if (month.isOdd) {
      await trip(
        DateTime(_year, month, 11),
        TripType.private,
        40,
        carId: van,
        purpose: 'Privérit',
      );
    }
  }

  await PensionDao(db).save(
    PensionEntriesCompanion(
      year: const Value(_year),
      priorYearIncome: const Value(5200000),
      factorA: const Value(50000),
      reserveringsruimte: const Value(300000),
      plannedContribution: const Value(400000),
      aovInsured: const Value(true),
      monthlyAovPremium: const Value(18000),
    ),
  );

  await TaxYearInputsDao(db).save(
    const TaxYearInputsCompanion(
      year: Value(_year),
      partnerHours: Value(900),
      hasSoVerklaring: Value(true),
      soStarter: Value(false),
      unrealisedZelfstandigenaftrek: Value(50000),
      lossCarryForward: Value(100000),
    ),
  );

  final vatReturns = VatReturnDao(db);
  await vatReturns.save(
    const VatReturnsCompanion(
      year: Value(_year),
      quarter: Value(1),
      filed: Value(true),
      paid: Value(true),
    ),
  );
  await vatReturns.save(
    const VatReturnsCompanion(
      year: Value(_year),
      quarter: Value(2),
      filed: Value(true),
      paid: Value(true),
    ),
  );
  await vatReturns.save(
    const VatReturnsCompanion(
      year: Value(_year),
      quarter: Value(3),
      filed: Value(true),
    ),
  );
}
