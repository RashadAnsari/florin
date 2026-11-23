import 'dart:io';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

import '../db/database.dart';
import '../theme/app_theme.dart';
import 'domain.dart';
import 'tax_service.dart';
import 'vat_service.dart';

/// Exports one year of bookkeeping as CSV files. Headers and values are Dutch
/// whatever the app language. The BTW files follow the rubrieken of the
/// return, one per quarter, so each figure can be typed into the form.
class CsvExportService {
  final AppDatabase db;

  CsvExportService(this.db);

  static String _yesNo(bool b) => b ? 'Ja' : 'Nee';
  static String _date(DateTime? d) => d == null ? '' : AppFormat.date(d);
  static double _euro(int cents) => cents / 100;

  static String _type(InvoiceType t) => switch (t) {
    InvoiceType.invoice => 'Factuur',
    InvoiceType.creditNote => 'Creditnota',
  };

  static String _status(InvoiceStatus s) => switch (s) {
    InvoiceStatus.draft => 'Concept',
    InvoiceStatus.sent => 'Verzonden',
    InvoiceStatus.paid => 'Betaald',
  };

  static String _treatment(VatTreatment t) => switch (t) {
    VatTreatment.standard => 'Nederlandse btw',
    VatTreatment.reverseChargeNl => 'Btw verlegd (binnenland)',
    VatTreatment.euServices => 'Diensten EU, btw verlegd',
    VatTreatment.euGoods => 'Intracommunautaire levering',
    VatTreatment.exportOutsideEu => 'Uitvoer buiten de EU',
    VatTreatment.servicesOutsideEu =>
      'Diensten buiten de EU, niet in NL belast',
    VatTreatment.kor => 'Vrijgesteld, kleineondernemersregeling',
  };

  static String _category(ExpenseCategory c) => switch (c) {
    ExpenseCategory.office => 'Kantoor en benodigdheden',
    ExpenseCategory.travel => 'Reizen en verblijf',
    ExpenseCategory.foodAndRepresentation => 'Voedsel, drank en representatie',
    ExpenseCategory.software => 'Software en abonnementen',
    ExpenseCategory.hardware => 'Hardware en apparatuur',
    ExpenseCategory.marketing => 'Marketing en reclame',
    ExpenseCategory.professionalServices => 'Professionele diensten',
    ExpenseCategory.phoneAndInternet => 'Telefoon en internet',
    ExpenseCategory.insurance => 'Verzekeringen',
    ExpenseCategory.training => 'Opleiding',
    ExpenseCategory.other => 'Overig',
  };

  static String _work(WorkType w) => switch (w) {
    WorkType.billable => 'Declarabel',
    WorkType.nonBillable => 'Niet declarabel',
    WorkType.administrative => 'Administratie',
    WorkType.wbso => 'WBSO',
    WorkType.other => 'Overig',
  };

  static String _trip(TripType t) => switch (t) {
    TripType.business => 'Zakelijk',
    TripType.commute => 'Woon-werk',
    TripType.private => 'Privé',
  };

  static String _risk(WetDbaRisk r) => switch (r) {
    WetDbaRisk.low => 'Laag',
    WetDbaRisk.medium => 'Middel',
    WetDbaRisk.high => 'Hoog',
  };

  /// Whole euros as the return asks, rounded in the filer's favour as the
  /// Belastingdienst allows (`docs/legal.md`, BTW return rounding): amounts
  /// owed round down, voorbelasting rounds up.
  static int _owed(int cents) => (cents / 100).floor();
  static int _reclaim(int cents) => (cents / 100).ceil();

  /// The rows of one quarterly BTW return, in the order of the form.
  static List<List<Object>> btwReturnRows(VatQuarterResult r) {
    final vat = [r.vat1a, r.vat1b, r.vat1d, r.vat2a, r.vat4a, r.vat4b];
    final owed5a = vat.fold(0, (s, v) => s + _owed(v));
    final input5b = _reclaim(r.inputVat5b);
    return [
      ['Rubriek', 'Omschrijving', 'Bedrag waarover btw wordt berekend', 'Btw'],
      [
        '1a',
        'Leveringen/diensten belast met hoog tarief',
        _owed(r.revenue1a),
        _owed(r.vat1a),
      ],
      [
        '1b',
        'Leveringen/diensten belast met laag tarief',
        _owed(r.revenue1b),
        _owed(r.vat1b),
      ],
      [
        '1c',
        'Leveringen/diensten belast met overige tarieven behalve 0%',
        0,
        0,
      ],
      ['1d', 'Privégebruik', '', _owed(r.vat1d)],
      [
        '1e',
        'Leveringen/diensten belast met 0% of niet bij u belast',
        _owed(r.revenue1e),
        '',
      ],
      ['2a', 'Verleggingsregeling binnenland', _owed(r.base2a), _owed(r.vat2a)],
      ['3a', 'Uitvoer naar landen buiten de EU', _owed(r.revenue3a), ''],
      [
        '3b',
        'Leveringen naar of diensten in landen binnen de EU',
        _owed(r.revenue3b),
        '',
      ],
      ['3c', 'Installatie/afstandsverkopen binnen de EU', 0, ''],
      [
        '4a',
        'Leveringen/diensten uit landen buiten de EU',
        _owed(r.base4a),
        _owed(r.vat4a),
      ],
      [
        '4b',
        'Leveringen/diensten uit landen binnen de EU',
        _owed(r.base4b),
        _owed(r.vat4b),
      ],
      ['5a', 'Verschuldigde btw (rubrieken 1 t/m 4)', '', owed5a],
      ['5b', 'Voorbelasting', '', input5b],
      [
        '',
        'Te betalen (positief) of terug te vragen (negatief)',
        '',
        owed5a - input5b,
      ],
    ];
  }

  /// The supplies to EU businesses of one quarter, totalled per customer BTW
  /// number with goods and services apart, as the ICP-opgaaf lists them.
  static List<List<Object>> icpRows(
    VatQuarterResult r,
    Map<int, Client> clients,
  ) {
    final totals = <String, ({String country, int goods, int services})>{};
    for (final i in r.icpInvoices) {
      final c = clients[i.clientId];
      final key = c?.vatNumber ?? '';
      final t =
          totals[key] ?? (country: c?.country ?? '', goods: 0, services: 0);
      final amount = i.signedExclVat;
      totals[key] = i.vatTreatment == VatTreatment.euGoods
          ? (country: t.country, goods: t.goods + amount, services: t.services)
          : (country: t.country, goods: t.goods, services: t.services + amount);
    }
    return [
      [
        'Land',
        'Btw-identificatienummer afnemer',
        'Leveringen goederen',
        'Diensten',
      ],
      for (final e in totals.entries)
        [e.value.country, e.key, _euro(e.value.goods), _euro(e.value.services)],
    ];
  }

  /// The income tax estimate of the year, line by line as Florin computes it.
  static List<List<Object>> incomeTaxRows(TaxResult t) => [
    ['Onderdeel (schatting)', 'Bedrag'],
    ['Omzet', _euro(t.grossRevenue)],
    ['Creditnota\'s', _euro(-t.creditNotes)],
    ['Kosten', _euro(-t.totalCosts)],
    ['Resultaat verkoop bedrijfsmiddelen', _euro(t.disposalResult)],
    ['Desinvesteringsbijtelling', _euro(t.desinvesteringsbijtelling)],
    ['Bijtelling privégebruik auto', _euro(t.carPrivateUse)],
    ['Vrijval herinvesteringsreserve', _euro(t.reserveReleased)],
    ['Kleinschaligheidsinvesteringsaftrek', _euro(-t.investmentDeduction.kia)],
    ['Energie-investeringsaftrek', _euro(-t.investmentDeduction.eia)],
    ['Milieu-investeringsaftrek', _euro(-t.investmentDeduction.mia)],
    ['Winst uit onderneming', _euro(t.profit)],
    ['Zelfstandigenaftrek', _euro(-t.zelfstandigenaftrek)],
    ['Startersaftrek', _euro(-t.startersaftrek)],
    ['S&O-aftrek', _euro(-t.soAftrek)],
    ['Meewerkaftrek', _euro(-t.meewerkaftrek)],
    [
      'Startersaftrek bij arbeidsongeschiktheid',
      _euro(-t.disabilityStartersaftrek),
    ],
    ['Stakingsaftrek', _euro(-t.stakingsaftrek)],
    ['Mkb-winstvrijstelling', _euro(-t.mkbWinstvrijstelling)],
    ['Belastbare winst uit onderneming', _euro(t.belastbareWinst)],
    ['Lijfrentepremie', _euro(-t.lijfrenteDeduction)],
    ['Premie arbeidsongeschiktheidsverzekering', _euro(-t.aovDeduction)],
    ['Verrekende verliezen', _euro(-t.lossOffset)],
    ['Belastbaar inkomen box 1', _euro(t.taxableIncome)],
    ['Belasting box 1 vóór heffingskortingen', _euro(t.grossBox1Tax)],
    ['Algemene heffingskorting', _euro(-t.algemeneHeffingskorting)],
    ['Arbeidskorting', _euro(-t.arbeidskorting)],
    ['Inkomstenbelasting box 1', _euro(t.box1Tax)],
    ['Inkomensafhankelijke bijdrage Zvw', _euro(t.zvwContribution)],
    ['Totaal', _euro(t.totalTax)],
  ];

  /// Writes the year's files. [quarters] holds the BTW returns for Q1 to Q4;
  /// every quarter gets its files, empty or not.
  Future<String?> exportYear(
    int year, {
    required String dialogTitle,
    required List<VatQuarterResult> quarters,
    required TaxResult? incomeTax,
  }) async {
    assert(quarters.length == 4);
    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: dialogTitle,
    );
    if (dir == null) return null;

    final invoices =
        await (db.select(db.invoices)
              ..where(
                (i) =>
                    i.invoiceDate.inYear(year) &
                    i.status.equalsValue(InvoiceStatus.draft).not(),
              )
              ..orderBy([(i) => OrderingTerm.asc(i.invoiceNumber)]))
            .get();
    final numbers = {for (final i in invoices) i.id: i.invoiceNumber};
    final lines =
        (await (db.select(
          db.invoiceLines,
        )..orderBy([(l) => OrderingTerm.asc(l.sortOrder)])).get()).where(
          (l) => numbers.containsKey(l.invoiceId),
        );
    final expenses =
        await (db.select(db.expenses)
              ..where((e) => e.date.inYear(year))
              ..orderBy([(e) => OrderingTerm.asc(e.date)]))
            .get();
    final hours =
        await (db.select(db.hourEntries)
              ..where((h) => h.date.inYear(year))
              ..orderBy([(h) => OrderingTerm.asc(h.date)]))
            .get();
    final trips =
        await (db.select(db.mileageTrips)
              ..where((m) => m.date.inYear(year))
              ..orderBy([(m) => OrderingTerm.asc(m.date)]))
            .get();
    final assets = await (db.select(
      db.fixedAssets,
    )..orderBy([(a) => OrderingTerm.asc(a.purchaseDate)])).get();
    final clients = await db.select(db.clients).get();
    final clientNames = {for (final c in clients) c.id: c.name};
    final clientsById = {for (final c in clients) c.id: c};

    Future<void> write(String name, List<List<Object>> rows) => File(
      p.join(dir, 'florin_${year}_$name.csv'),
    ).writeAsString(const ListToCsvConverter().convert(rows));

    await write('facturen', [
      [
        'Nummer',
        'Type',
        'Corrigeert factuur',
        'Datum',
        'Leveringsdatum',
        'Vervaldatum',
        'Status',
        'Betaaldatum',
        'Klant',
        'Btw-behandeling',
        'Uitgereikt door afnemer',
        'Excl. btw',
        'Btw',
        'Incl. btw',
        'Kwartaal',
      ],
      for (final i in invoices)
        [
          i.invoiceNumber,
          _type(i.invoiceType),
          numbers[i.correctedInvoiceId] ?? '',
          _date(i.invoiceDate),
          _date(i.supplyDate),
          _date(i.dueDate),
          _status(i.status),
          _date(i.paidDate),
          clientNames[i.clientId] ?? '',
          _treatment(i.vatTreatment),
          _yesNo(i.selfBilled),
          _euro(i.totalExclVat),
          _euro(i.totalVat),
          _euro(i.totalInclVat),
          'Q${quarterOf(i.invoiceDate)}',
        ],
    ]);

    await write('factuurregels', [
      [
        'Factuurnummer',
        'Omschrijving',
        'Aantal',
        'Eenheid',
        'Prijs excl. btw',
        'Btw-tarief',
        'Btw',
        'Totaal excl. btw',
      ],
      for (final l in lines)
        [
          numbers[l.invoiceId]!,
          l.description,
          l.quantity,
          l.unit ?? '',
          _euro(l.unitPriceExclVat),
          l.vatRate.dutchLabel,
          _euro(l.vatAmount),
          _euro(l.lineTotalExclVat),
        ],
    ]);

    await write('uitgaven', [
      [
        'Datum',
        'Leverancier',
        'Omschrijving',
        'Categorie',
        'Btw-tarief',
        'Btw-behandeling',
        'Excl. btw',
        'Btw',
        'Totaal',
        'Zakelijk gebruik %',
        'Zakelijk deel',
        'Btw te vorderen',
        'Bon aanwezig',
        'Kwartaal',
      ],
      for (final e in expenses)
        [
          _date(e.date),
          e.supplier,
          e.description,
          _category(e.category),
          e.vatRate.dutchLabel,
          switch (e.purchaseVat) {
            PurchaseVat.domestic => 'Nederlandse btw',
            PurchaseVat.reverseChargeNl => 'Btw verlegd binnenland',
            PurchaseVat.fromEu => 'Verlegd uit EU-land',
            PurchaseVat.fromOutsideEu => 'Verlegd uit land buiten de EU',
          },
          _euro(e.amountExclVat),
          _euro(e.vatAmount),
          _euro(e.totalInclVat),
          (e.businessUsePct * 100).round(),
          _euro(e.deductibleAmount),
          _euro(e.vatToReclaim),
          _yesNo(e.receiptAttached),
          'Q${quarterOf(e.date)}',
        ],
    ]);

    await write('uren', [
      ['Datum', 'Omschrijving', 'Soort', 'Uren', 'Klant / project'],
      for (final h in hours)
        [
          _date(h.date),
          h.description,
          _work(h.workType),
          h.hours,
          h.clientProject ?? '',
        ],
    ]);

    await write('kilometers', [
      [
        'Datum',
        'Merk / model',
        'Kenteken',
        'Van',
        'Naar',
        'Km begin',
        'Km eind',
        'Afstand',
        'Soort',
        'Doel',
        'Routeafwijking',
      ],
      for (final m in trips)
        [
          _date(m.date),
          m.vehicleMakeModel,
          m.vehicleLicensePlate,
          m.departureAddress,
          m.arrivalAddress,
          m.odometerStart,
          m.odometerEnd,
          m.distanceKm,
          _trip(m.tripType),
          m.purpose,
          _yesNo(m.routeDeviation),
        ],
    ]);

    await write('activa', [
      [
        'Naam',
        'Soort',
        'Kosten excl. btw',
        'Restwaarde',
        'Aankoopdatum',
        'Zakelijk gebruik %',
        'Levensduur (jaar)',
        'KIA',
        'EIA',
        'MIA-categorie',
        'Afgeboekte herinvesteringsreserve',
        'Cataloguswaarde',
        'Verkoopdatum',
        'Verkoopopbrengst',
        'Boekwinst naar herinvesteringsreserve',
      ],
      for (final a in assets)
        [
          a.assetName,
          a.kind == AssetKind.car ? 'Auto van de zaak' : 'Bedrijfsmiddel',
          _euro(a.costExclVat),
          _euro(a.residualValue),
          _date(a.purchaseDate),
          (a.businessUsePct * 100).round(),
          a.usefulLifeYears,
          _yesNo(a.kiaEligible),
          _yesNo(a.eiaEligible),
          switch (a.miaCategory) {
            null => '',
            MiaCategory.one => 'I',
            MiaCategory.two => 'II',
            MiaCategory.three => 'III',
          },
          _euro(a.reinvestmentReserveApplied),
          a.catalogueValue == null ? '' : _euro(a.catalogueValue!),
          _date(a.disposalDate),
          a.disposalProceeds == null ? '' : _euro(a.disposalProceeds!),
          _yesNo(a.reserveGain),
        ],
    ]);

    await write('klanten', [
      [
        'Naam',
        'Land',
        'Btw-id',
        'KvK-nummer',
        'Adres',
        'Contactpersoon',
        'E-mail',
        'Telefoon',
        'Wederverkoper (merchant of record)',
        'Wet DBA-risico',
        'Contract getekend',
        'Contract vervaldatum',
        'Actief',
      ],
      for (final c in clients)
        [
          c.name,
          c.country,
          c.vatNumber ?? '',
          c.kvkNumber ?? '',
          c.address,
          c.contactPerson ?? '',
          c.email ?? '',
          c.phone ?? '',
          _yesNo(c.isMerchantOfRecord),
          c.isMerchantOfRecord ? '' : _risk(c.wetDbaRisk),
          c.isMerchantOfRecord ? '' : _yesNo(c.contractSigned),
          _date(c.contractExpiry),
          _yesNo(c.isActive),
        ],
    ]);

    for (var q = 1; q <= 4; q++) {
      await write('btw_Q$q', btwReturnRows(quarters[q - 1]));
      await write('icp_Q$q', icpRows(quarters[q - 1], clientsById));
    }
    if (incomeTax != null) {
      await write('inkomstenbelasting_schatting', incomeTaxRows(incomeTax));
    }

    return dir;
  }
}
