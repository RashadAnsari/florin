// Creates `demo/florin.db`: a fictional freelance designer with a year of
// bookkeeping, to try Florin without entering data. Run `make demo`, then
// choose the `demo` folder on Florin's first start.
//
// Every name, number and address here is made up.

import 'package:florin/services/tax_rules/tax_year_2026.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
import 'package:florin/db/daos/receipt_dao.dart';
import 'package:florin/services/domain.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:florin/services/receipt_service.dart';
import 'package:pdf/widgets.dart' as pw;

const _year = 2026;

// The business took part in the KOR from 1 January. The invoice of 28 April
// takes the turnover past € 20.000, which ends the KOR from that supply.
final _korStart = DateTime(_year, 1, 1);
final _korEndedOn = DateTime(_year, 4, 28);

bool _underKor(DateTime d) => !d.isBefore(_korStart) && d.isBefore(_korEndedOn);

Future<void> main(List<String> args) async {
  final dir = Directory(args.isEmpty ? 'demo' : args.first)
    ..createSync(recursive: true);
  final file = File('${dir.path}/florin.db');
  if (file.existsSync()) file.deleteSync();
  final receipts = Directory('${dir.path}/${ReceiptStore.folderName}');
  if (receipts.existsSync()) receipts.deleteSync(recursive: true);
  final db = AppDatabase(NativeDatabase(file));
  await fillDemo(db, folder: dir.path);
  await db.close();
  stdout.writeln('Demo database written to ${file.path}');
}

/// Fills [db] with the fictional business. Receipt files go into the
/// receipts folder inside [folder], next to the database.
Future<void> fillDemo(AppDatabase db, {required String folder}) async {
  final receipts = ReceiptService(ReceiptDao(db), ReceiptStore(folder));
  await BusinessProfileDao(db).save(
    BusinessProfilesCompanion(
      id: const Value(1),
      name: const Value('Studio Voorbeeld'),
      vatNumber: const Value('NL000099998B57'),
      kvkNumber: const Value('12345678'),
      address: const Value('Voorbeeldstraat 1\n1234 AB Utrecht'),
      iban: const Value('NL91ABNA0417164300'),
      isStarter: const Value(false),
      korStart: Value(_korStart),
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
    bool reseller = false,
    String? kvk,
  }) => clients.save(
    ClientsCompanion(
      name: Value(name),
      country: Value(country),
      vatNumber: Value(vat),
      kvkNumber: Value(kvk),
      address: Value(address),
      wetDbaRisk: Value(risk),
      contractSigned: Value(!reseller && risk != WetDbaRisk.high),
      contractExpiry: Value(reseller ? null : DateTime(_year + 1, 6, 30)),
      isMerchantOfRecord: Value(reseller),
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
  final reseller = await client(
    'Voorbeeld Reseller Ltd',
    'GB',
    'GB999999973',
    '1 Example Street\nLondon EC1A 1AA\nUnited Kingdom',
    WetDbaRisk.low,
    reseller: true,
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
    String? selfBilledNumber,
    String unit = 'uur',
    DateTime? supplyDate,
  }) {
    if (selfBilledNumber == null) seq++;
    var excl = 0, vat = 0;
    final companions = <InvoiceLinesCompanion>[];
    for (var i = 0; i < lines.length; i++) {
      final (text, qty, price, rate) = lines[i];
      final total = (qty * price).round();
      final lineVat = treatment == VatTreatment.standard
          ? taxYear2026.vatOn(rate, total)
          : 0;
      excl += total;
      vat += lineVat;
      companions.add(
        InvoiceLinesCompanion(
          invoiceId: const Value(0),
          description: Value(text),
          quantity: Value(qty),
          unit: Value(unit),
          unitPriceExclVat: Value(price),
          vatRate: Value(
            treatment.lineRates.contains(rate) ? rate : VatRate.zero,
          ),
          vatAmount: Value(lineVat),
          lineTotalExclVat: Value(total),
          sortOrder: Value(i),
        ),
      );
    }
    return invoices.saveWithLines(
      InvoicesCompanion(
        invoiceNumber: Value(
          selfBilledNumber ?? 'F-$_year-${seq.toString().padLeft(3, '0')}',
        ),
        selfBilled: Value(selfBilledNumber != null),
        invoiceType: Value(type),
        correctedInvoiceId: Value(corrects),
        invoiceDate: Value(date),
        supplyDate: Value(supplyDate ?? date),
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
    final date = DateTime(_year, month, 28);
    await invoice(
      clientId: dutch,
      date: date,
      lines: [('Ontwerpwerk website', 60, 8500, VatRate.high)],
      treatment: date.isBefore(_korEndedOn)
          ? VatTreatment.kor
          : VatTreatment.standard,
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
  // Template sales through the reseller, which issues a self-billed invoice
  // per calendar month for what it owes.
  const licences = [0, 0, 0, 0, 0, 0, 12, 18, 25, 31];
  for (var month = 7; month <= 10; month++) {
    await invoice(
      clientId: reseller,
      date: DateTime(_year, month + 1, 5),
      lines: [
        (
          'Verkopen ontwerpsjabloon ${month.toString().padLeft(2, '0')}-$_year',
          licences[month - 1].toDouble(),
          2900,
          VatRate.high,
        ),
      ],
      treatment: VatTreatment.servicesOutsideEu,
      selfBilledNumber: 'VR-$_year-${month.toString().padLeft(2, '0')}',
      status: month == 10 ? InvoiceStatus.sent : InvoiceStatus.paid,
      unit: 'licentie',
      supplyDate: DateTime(_year, month + 1, 0),
    );
    // The reseller's own document is the invoice.
    final number = 'VR-$_year-${month.toString().padLeft(2, '0')}';
    final id = (await (db.select(
      db.invoices,
    )..where((i) => i.invoiceNumber.equals(number))).getSingle()).id;
    await receipts.attachBytes(
      ReceiptOwner.invoice(id),
      await _demoPdf('Voorbeeld Reseller Ltd', [
        'Self-billed invoice $number',
        'Template sales ${month.toString().padLeft(2, '0')}-$_year: '
            '${licences[month - 1]} x EUR 29,00',
        'Factuur uitgereikt door afnemer',
      ]),
      'statement-$number.pdf',
      _year,
    );
  }
  await invoice(
    clientId: dutch,
    date: DateTime(_year, 11, 20),
    lines: [('Ontwerp jaarverslag', 30, 8500, VatRate.high)],
    status: InvoiceStatus.draft,
  );
  // The sale of a used monitor, linked to its asset below: its amount is the
  // proceeds, not revenue.
  final monitorSale = await invoice(
    clientId: dutch,
    date: DateTime(_year, 9, 10),
    lines: [('Verkoop gebruikte monitor', 1, 15000, VatRate.high)],
    unit: 'stuk',
  );

  // Number the own invoices in date order, as one consecutive series
  // (Wet OB 1968 art. 35a lid 1 b). Self-billed invoices keep the reseller's.
  final own =
      await (db.select(db.invoices)
            ..where((i) => i.selfBilled.not())
            ..orderBy([
              (i) => OrderingTerm.asc(i.invoiceDate),
              (i) => OrderingTerm.asc(i.id),
            ]))
          .get();
  for (final i in own) {
    await (db.update(db.invoices)..where((r) => r.id.equals(i.id))).write(
      InvoicesCompanion(invoiceNumber: Value('tmp-${i.id}')),
    );
  }
  for (final (n, i) in own.indexed) {
    await (db.update(db.invoices)..where((r) => r.id.equals(i.id))).write(
      InvoicesCompanion(
        invoiceNumber: Value('F-$_year-${(n + 1).toString().padLeft(3, '0')}'),
      ),
    );
  }

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
    VatRate rate = VatRate.high,
    PurchaseVat purchaseVat = PurchaseVat.domestic,
    int? enteredVat,
    VatRate? saleRate,
    int? saleInvoiceId,
  }) {
    // A year without rules has its BTW entered rather than worked out.
    final rules = taxRulesFor(bought.year);
    final vat = rules == null ? enteredVat ?? 0 : rules.vatOn(rate, cost);
    final share = kind == AssetKind.car ? 1.0 : use;
    // Under the KOR no BTW is reclaimed, and a sale carries none.
    final reclaimed = !_underKor(bought);
    final chargesSaleVat =
        sold != null && saleInvoiceId == null && !_underKor(sold);
    return assets.save(
      FixedAssetsCompanion(
        kind: Value(kind),
        assetName: Value(name),
        costExclVat: Value(cost),
        vatRate: Value(rules == null ? null : rate),
        purchaseVat: Value(purchaseVat),
        vatAmount: Value(vat),
        vatReclaimable: Value(reclaimed),
        vatToReclaim: Value(
          PurchaseMath.vatToReclaim(
            vatAmount: vat,
            businessUsePct: share,
            vatReclaimable: reclaimed,
          ),
        ),
        residualValue: Value(residual),
        purchaseDate: Value(bought),
        businessUsePct: Value(share),
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
        disposalInvoiceId: Value(saleInvoiceId),
        disposalVatRate: Value(
          chargesSaleVat ? saleRate ?? VatRate.high : null,
        ),
        disposalVatAmount: Value(
          chargesSaleVat
              ? taxRulesFor(sold.year)!.vatOn(
                  saleRate ?? VatRate.high,
                  PurchaseMath.share(proceeds ?? 0, share),
                )
              : null,
        ),
        notes: Value(
          kind == AssetKind.car ? 'Fictieve auto voor de demo' : null,
        ),
      ),
    );
  }

  final macbook = await asset(
    'MacBook Pro',
    320000,
    DateTime(_year, 2, 1),
    residual: 20000,
    kia: true,
  );
  await receipts.attachBytes(
    ReceiptOwner.asset(macbook),
    await _demoPdf('Computerwinkel Voorbeeld', [
      'Factuur 2026-0117, 01-02-2026',
      'MacBook Pro: EUR 3.200,00 excl. btw',
      'Btw 21%: EUR 672,00',
    ]),
    'factuur-macbook.pdf',
    _year,
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
    enteredVat: 84000,
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
    enteredVat: 12600,
    sold: DateTime(_year, 8, 14),
    proceeds: 5000,
  );
  await asset(
    'Monitor',
    40000,
    DateTime(2025, 2, 3),
    enteredVat: 8400,
    sold: DateTime(_year, 9, 10),
    proceeds: 15000,
    saleInvoiceId: monitorSale,
  );
  final car = await asset(
    'Elektrische auto',
    3200000,
    DateTime(_year, 5, 4),
    residual: 800000,
    kind: AssetKind.car,
    catalogue: 3900000,
    registered: DateTime(2025, 3, 20),
    zeroEmission: ZeroEmission.battery,
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
    List<(String, Uint8List)> files = const [],
    bool? paper,
  }) async {
    final vat = taxYear2026.vatOn(rate, amount);
    // Under the KOR no BTW is reclaimed.
    final reclaimed = reclaim && !date.isBefore(_korEndedOn);
    return expenses
        .save(
          ExpensesCompanion(
            date: Value(date),
            supplier: Value(supplier),
            description: Value(description),
            category: Value(category),
            // A digital receipt has no paper original, unless it is a photo
            // of one.
            paperOriginalKept: Value(paper ?? (receipt && files.isEmpty)),
            amountExclVat: Value(amount),
            vatRate: Value(rate),
            purchaseVat: Value(purchaseVat),
            vatAmount: Value(vat),
            totalInclVat: Value(
              amount + (purchaseVat == PurchaseVat.domestic ? vat : 0),
            ),
            businessUsePct: Value(use),
            deductibleAmount: Value(
              PurchaseMath.deductible(
                amountExclVat: amount,
                vatAmount: vat,
                businessUsePct: use,
                vatReclaimable: reclaimed,
              ),
            ),
            vatReclaimable: Value(reclaimed),
            vatToReclaim: Value(
              PurchaseMath.vatToReclaim(
                vatAmount: vat,
                businessUsePct: use,
                vatReclaimable: reclaimed,
              ),
            ),
            carAssetId: Value(carId),
            paidFrom: const Value('Zakelijke rekening'),
            paymentReference: Value('REF-${date.month}-${amount % 997}'),
          ),
        )
        .then((id) async {
          for (final (name, bytes) in files) {
            await receipts.attachBytes(
              ReceiptOwner.expense(id),
              bytes,
              name,
              date.year,
            );
          }
        });
  }

  for (var month = 1; month <= 11; month++) {
    final m = month.toString().padLeft(2, '0');
    await expense(
      DateTime(_year, month, 3),
      'Design Software Europe Ltd',
      'Abonnement ontwerpsoftware',
      ExpenseCategory.software,
      5500,
      purchaseVat: PurchaseVat.fromEu,
      files: [
        (
          'invoice-DSE-$_year-$m.pdf',
          await _demoPdf('Design Software Europe Ltd', [
            'Invoice DSE-$_year-$m, 03-$m-$_year',
            'Design software subscription: EUR 55,00',
            'VAT reverse-charged, customer NL000099998B57',
          ]),
        ),
      ],
    );
    await expense(
      DateTime(_year, month, 5),
      'Telecom Voorbeeld',
      'Mobiel en internet',
      ExpenseCategory.phoneAndInternet,
      4500,
      use: 0.8,
      // The telecom provider sends UBL e-invoices from October.
      files: month >= 10
          ? [('TV-$_year-$m.xml', _demoEInvoice('TV-$_year-$m'))]
          : const [],
    );
    if (month >= 5) {
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
    files: [
      (
        'verkeerde-bon.pdf',
        await _demoPdf('Lunchroom Voorbeeld', ['Kassabon 08-01-2026']),
      ),
    ],
    paper: true,
  );
  // A receipt added to the wrong expense and removed again: Florin keeps it.
  await receipts.remove(
    (await receipts.dao.all()).firstWhere(
      (r) => r.originalName == 'verkeerde-bon.pdf',
    ),
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
    files: [('bon-hardware.png', _demoPhoto())],
    paper: true,
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
      // A part-time job: its wages share box 1, and its hours stay below
      // the business hours for the urencriterium.
      employed: Value(true),
      wages: Value(1200000),
      wageTaxWithheld: Value(150000),
      zvwWages: Value(1200000),
      employmentHours: Value(520),
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

/// A one-page PDF standing in for a supplier's invoice.
Future<Uint8List> _demoPdf(String from, List<String> lines) async {
  // The font bundled for invoices, read from the project the tool runs in.
  final font = pw.Font.ttf(
    File(
      'assets/fonts/NotoSans-Regular.ttf',
    ).readAsBytesSync().buffer.asByteData(),
  );
  final doc = pw.Document(theme: pw.ThemeData.withFont(base: font))
    ..addPage(
      pw.Page(
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(from, style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 16),
            for (final l in lines) pw.Text(l),
            pw.SizedBox(height: 16),
            pw.Text('Fictief document voor de demo van Florin'),
          ],
        ),
      ),
    );
  return doc.save();
}

/// A small greyscale PNG of a till receipt: white paper with lines of print.
Uint8List _demoPhoto() {
  const width = 90, height = 160;
  final raw = BytesBuilder();
  for (var y = 0; y < height; y++) {
    raw.addByte(0); // No filter for this row.
    for (var x = 0; x < width; x++) {
      final printed =
          y > 12 &&
          y < height - 12 &&
          y % 9 < 3 &&
          x > 10 &&
          x < width - 10 - (y * 7 % 30);
      raw.addByte(printed ? 70 : 245);
    }
  }
  List<int> chunk(String type, List<int> data) {
    final body = [...ascii.encode(type), ...data];
    return [..._u32(data.length), ...body, ..._u32(_crc32(body))];
  }

  return Uint8List.fromList([
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
    ...chunk('IHDR', [..._u32(width), ..._u32(height), 8, 0, 0, 0, 0]),
    ...chunk('IDAT', zlib.encode(raw.toBytes())),
    ...chunk('IEND', const []),
  ]);
}

List<int> _u32(int v) => [v >> 24 & 255, v >> 16 & 255, v >> 8 & 255, v & 255];

int _crc32(List<int> bytes) {
  var crc = 0xFFFFFFFF;
  for (final b in bytes) {
    crc ^= b;
    for (var k = 0; k < 8; k++) {
      crc = crc & 1 != 0 ? 0xEDB88320 ^ (crc >> 1) : crc >> 1;
    }
  }
  return crc ^ 0xFFFFFFFF;
}

/// A UBL e-invoice as a supplier would send it.
Uint8List _demoEInvoice(String number) => Uint8List.fromList(
  utf8.encode('''<?xml version="1.0" encoding="UTF-8"?>
<Invoice xmlns="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
  xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2">
  <cbc:ID>$number</cbc:ID>
  <cbc:IssueDate>2026-10-05</cbc:IssueDate>
  <cbc:DocumentCurrencyCode>EUR</cbc:DocumentCurrencyCode>
  <cbc:Note>Fictieve e-factuur voor de demo van Florin</cbc:Note>
</Invoice>
'''),
);
