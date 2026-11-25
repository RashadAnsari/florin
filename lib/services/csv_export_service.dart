import 'tax_rules/tax_year_rules.dart';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import '../db/database.dart';
import 'asset_service.dart';
import '../theme/app_theme.dart';
import 'domain.dart';
import 'receipt_store.dart';
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

  static String _purchaseVat(PurchaseVat p) => switch (p) {
    PurchaseVat.domestic => 'Nederlandse btw',
    PurchaseVat.reverseChargeNl => 'Btw verlegd binnenland',
    PurchaseVat.fromEu => 'Verlegd uit EU-land',
    PurchaseVat.fromOutsideEu => 'Verlegd uit land buiten de EU',
  };

  /// A rate in the words of the year it applied in, or nothing for a year
  /// without rules in Florin.
  static String _rateIn(VatRate? rate, DateTime? date) {
    final rules = date == null ? null : taxRulesFor(date.year);
    return rate == null || rules == null ? '' : rate.dutchLabel(rules);
  }

  static String _category(ExpenseCategory c) => switch (c) {
    ExpenseCategory.office => 'Kantoor en benodigdheden',
    ExpenseCategory.travel => 'Reizen en verblijf',
    ExpenseCategory.foodAndRepresentation =>
      'Voedsel, drank, representatie en congressen',
    ExpenseCategory.software => 'Software en abonnementen',
    ExpenseCategory.hardware => 'Hardware en apparatuur',
    ExpenseCategory.marketing => 'Marketing en reclame',
    ExpenseCategory.gifts => 'Relatiegeschenken en giften',
    ExpenseCategory.professionalServices => 'Professionele diensten',
    ExpenseCategory.phoneAndInternet => 'Telefoon en internet',
    ExpenseCategory.insurance => 'Verzekeringen',
    ExpenseCategory.training => 'Opleiding',
    ExpenseCategory.courseTravel =>
      'Reizen en verblijf voor cursussen en congressen',
    ExpenseCategory.clothingAndCare => 'Kleding en persoonlijke verzorging',
    ExpenseCategory.homePhoneLine => 'Telefoonabonnement aansluiting woning',
    ExpenseCategory.generalLiterature => 'Literatuur, geen vakliteratuur',
    ExpenseCategory.fines => 'Boetes',
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

  static String _zeroEmission(ZeroEmission z) => switch (z) {
    ZeroEmission.none => 'Nee',
    ZeroEmission.battery => 'Elektrisch (batterij)',
    ZeroEmission.hydrogenOrSolar => 'Waterstof of geïntegreerde zonnecellen',
  };

  static String _cents(int? cents) => cents == null ? '' : '${_euro(cents)}';

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
    [
      'Verrekende niet-gerealiseerde zelfstandigenaftrek',
      _euro(-t.unrealisedZelfstandigenaftrek),
    ],
    ['S&O-aftrek', _euro(-t.soAftrek)],
    ['Meewerkaftrek', _euro(-t.meewerkaftrek)],
    [
      'Startersaftrek bij arbeidsongeschiktheid',
      _euro(-t.disabilityStartersaftrek),
    ],
    ['Stakingsaftrek', _euro(-t.stakingsaftrek)],
    ['Mkb-winstvrijstelling', _euro(-t.mkbWinstvrijstelling)],
    ['Belastbare winst uit onderneming', _euro(t.belastbareWinst)],
    ['Loon uit dienstbetrekking', _euro(t.wages)],
    ['Lijfrentepremie', _euro(-t.lijfrenteDeduction)],
    ['Premie arbeidsongeschiktheidsverzekering', _euro(-t.aovDeduction)],
    ['Verrekende verliezen', _euro(-t.lossOffset)],
    ['Belastbaar inkomen box 1', _euro(t.taxableIncome)],
    ['Belasting box 1 vóór heffingskortingen', _euro(t.grossBox1Tax)],
    ['Tariefaanpassing', _euro(t.tariefaanpassing)],
    ['Algemene heffingskorting', _euro(-t.algemeneHeffingskorting)],
    ['Arbeidskorting', _euro(-t.arbeidskorting)],
    ['Inkomstenbelasting box 1', _euro(t.box1Tax)],
    ['Inkomensafhankelijke bijdrage Zvw', _euro(t.zvwContribution)],
    ['Totaal', _euro(t.totalTax)],
    ['Ingehouden loonheffing', _euro(-t.wageTaxWithheld)],
    ['Te betalen (negatief: terug te ontvangen)', _euro(t.taxToPay)],
  ];

  /// The seller details printed on invoices, and the KOR dates.
  static List<List<Object>> profileRows(BusinessProfile? b) => [
    ['Gegeven', 'Waarde'],
    ['Naam', b?.name ?? ''],
    ['Btw-identificatienummer', b?.vatNumber ?? ''],
    ['KvK-nummer', b?.kvkNumber ?? ''],
    ['Adres', b?.address ?? ''],
    ['IBAN', b?.iban ?? ''],
    ['Kleineondernemersregeling vanaf', _date(b?.korStart)],
    ['Kleineondernemersregeling tot', _date(b?.korEnd)],
  ];

  /// The figures behind the jaarruimte and the disability insurance.
  static List<List<Object>> pensionRows(PensionEntry? e) => [
    ['Gegeven', 'Waarde'],
    ['Premiegrondslag: inkomen vorig jaar', _cents(e?.priorYearIncome ?? 0)],
    ['Factor A', _cents(e?.factorA ?? 0)],
    ['Reserveringsruimte', _cents(e?.reserveringsruimte ?? 0)],
    ['Geplande lijfrentepremie', _cents(e?.plannedContribution ?? 0)],
    ['Arbeidsongeschiktheidsverzekering', _yesNo(e?.aovInsured ?? false)],
    ['Premie per maand', _cents(e?.monthlyAovPremium ?? 0)],
  ];

  /// The facts of the year the income tax estimate uses that the
  /// bookkeeping does not show.
  static List<List<Object>> taxYearInputRows(TaxYearInput? i) => [
    ['Gegeven', 'Waarde'],
    ['Uren meewerkende partner', i?.partnerHours ?? 0],
    ['S&O-verklaring', _yesNo(i?.hasSoVerklaring ?? false)],
    ['S&O-starter', _yesNo(i?.soStarter ?? false)],
    ['Onderneming gestaakt', _yesNo(i?.businessCeased ?? false)],
    ['Eerder genoten stakingsaftrek', _cents(i?.stakingsaftrekUsedBefore ?? 0)],
    ['Arbeidsongeschiktheidsuitkering', _yesNo(i?.disabilityBenefit ?? false)],
    [
      'Eerder gebruikte startersaftrek bij arbeidsongeschiktheid',
      i?.disabilityStartersUsed ?? 0,
    ],
    [
      'Niet-gerealiseerde zelfstandigenaftrek',
      _cents(i?.unrealisedZelfstandigenaftrek ?? 0),
    ],
    ['Te verrekenen verliezen', _cents(i?.lossCarryForward ?? 0)],
    ['In loondienst', _yesNo(i?.employed ?? false)],
    ['Loon', _cents(i?.wages ?? 0)],
    ['Ingehouden loonheffing', _cents(i?.wageTaxWithheld ?? 0)],
    ['Loon Zvw', _cents(i?.zvwWages ?? 0)],
    ['Uren in loondienst', i?.employmentHours ?? 0],
    [
      'Geen ondernemer in een van de vorige jaren',
      _yesNo(i?.notOndernemerBefore ?? false),
    ],
    ['Recht op startersaftrek', _yesNo(i?.isStarter ?? false)],
  ];

  /// Whether each quarter's BTW return was filed and paid, as the user
  /// marked it, with its last day.
  static List<List<Object>> vatStatusRows(int year, List<VatReturn> filed) {
    final byQuarter = {for (final v in filed) v.quarter: v};
    return [
      ['Kwartaal', 'Uiterste datum', 'Aangifte gedaan', 'Betaald'],
      for (var q = 1; q <= 4; q++)
        [
          'Q$q',
          _date(VatService.filingDeadline(year, q)),
          _yesNo(byQuarter[q]?.filed ?? false),
          _yesNo(byQuarter[q]?.paid ?? false),
        ],
    ];
  }

  /// A new folder inside [parent] for one export, named after the year and
  /// the moment of the export, so exports never mix with each other or with
  /// what the folder held: `florin_2026_export_2026-11-23_14-30-05`.
  static Future<Directory> createExportFolder(
    String parent,
    int year,
    DateTime now,
  ) async {
    final name =
        'florin_${year}_export_'
        '${DateFormat('yyyy-MM-dd_HH-mm-ss').format(now)}';
    var dir = Directory(p.join(parent, name));
    for (var n = 2; await dir.exists(); n++) {
      dir = Directory(p.join(parent, '${name}_$n'));
    }
    return dir.create(recursive: true);
  }

  static String _ownerKind(ReceiptOwnerKind k) => switch (k) {
    ReceiptOwnerKind.expense => 'Uitgave',
    ReceiptOwnerKind.asset => 'Bedrijfsmiddel',
    ReceiptOwnerKind.invoice => 'Factuur',
  };

  static String _receiptType(ReceiptType t) => switch (t) {
    ReceiptType.pdf => 'PDF',
    ReceiptType.jpeg => 'JPEG',
    ReceiptType.png => 'PNG',
    ReceiptType.heic => 'HEIC',
    ReceiptType.tiff => 'TIFF',
    ReceiptType.xml => 'E-factuur (UBL)',
  };

  /// Text made safe as part of a file name on every platform.
  static String _safe(String text) {
    final cleaned = text
        .replaceAll(RegExp(r'[\\/:*?"<>|\x00-\x1F]'), '-')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return cleaned.length > 60 ? cleaned.substring(0, 60).trim() : cleaned;
  }

  /// Where a receipt goes in an export, named so a person can find it:
  /// `bonnen/2026-03-04_Supplier_3f2c9a1e.pdf` for expenses and assets,
  /// `facturen/F-2026-001_3f2c9a1e.pdf` for invoices. The first part of the
  /// UUID keeps names unique.
  static String receiptExportPath(
    Receipt r, {
    required DateTime date,
    required String label,
  }) {
    // A removed receipt is exported too, apart from those in use.
    final invoice = r.removedAt == null
        ? r.invoiceId != null
        : r.removedFromKind == ReceiptOwnerKind.invoice;
    final folder = r.removedAt != null
        ? 'verwijderd'
        : invoice
        ? 'facturen'
        : 'bonnen';
    final day = DateFormat('yyyy-MM-dd').format(date);
    final stem = invoice ? _safe(label) : '${day}_${_safe(label)}';
    return '$folder/${stem}_${r.id.substring(0, 8)}.${r.type.extension}';
  }

  /// Writes the year's files. [quarters] holds the BTW returns for Q1 to Q4;
  /// every quarter gets its files, empty or not. The receipts of the year's
  /// expenses, invoices and the assets in use are copied from [receipts].
  Future<String?> exportYear(
    int year, {
    required String dialogTitle,
    required List<VatQuarterResult> quarters,
    required TaxResult? incomeTax,
    required ReceiptStore receipts,
  }) async {
    final parent = await FilePicker.platform.getDirectoryPath(
      dialogTitle: dialogTitle,
    );
    if (parent == null) return null;
    return writeYear(
      year,
      parent: parent,
      quarters: quarters,
      incomeTax: incomeTax,
      receipts: receipts,
    );
  }

  /// Writes the year's files into a new dated folder inside [parent] and
  /// returns that folder.
  Future<String> writeYear(
    int year, {
    required String parent,
    required List<VatQuarterResult> quarters,
    required TaxResult? incomeTax,
    required ReceiptStore receipts,
  }) async {
    assert(quarters.length == 4);
    final rules = taxRulesFor(year)!;
    final dir = (await createExportFolder(parent, year, DateTime.now())).path;

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
    final assetNames = {for (final a in assets) a.id: a.assetName};
    final saleInvoiceIds = AssetService.saleInvoiceIds(assets);
    final saleInvoiceNumbers = {
      for (final i in await (db.select(
        db.invoices,
      )..where((i) => i.id.isIn(saleInvoiceIds))).get())
        i.id: i.invoiceNumber,
    };
    final clients = await db.select(db.clients).get();
    final clientNames = {for (final c in clients) c.id: c.name};
    final clientsById = {for (final c in clients) c.id: c};

    // An asset's purchase invoice matters every year the asset is in use.
    final assetsInUse = {
      for (final a in assets)
        if (AssetService.inUse(a, year)) a.id: a,
    };
    final expensesById = {for (final e in expenses) e.id: e};
    final invoicesById = {for (final i in invoices) i.id: i};
    final exported = <(Receipt, String, String, DateTime, String)>[];
    for (final r in await db.select(db.receipts).get()) {
      final e = expensesById[r.expenseId];
      final a = assetsInUse[r.assetId];
      final i = invoicesById[r.invoiceId];
      // A removed receipt belongs to the year of the record it came from.
      final (kind, date, label) = r.removedAt != null
          ? r.removedFromDate!.year == year
                ? (
                    _ownerKind(r.removedFromKind!),
                    r.removedFromDate!,
                    r.removedFromName!,
                  )
                : ('', DateTime(0), '')
          : e != null
          ? (_ownerKind(ReceiptOwnerKind.expense), e.date, e.supplier)
          : a != null
          ? (_ownerKind(ReceiptOwnerKind.asset), a.purchaseDate, a.assetName)
          : i != null
          ? (
              _ownerKind(ReceiptOwnerKind.invoice),
              i.invoiceDate,
              i.invoiceNumber,
            )
          : ('', DateTime(0), '');
      if (kind.isEmpty) continue;
      exported.add((
        r,
        receiptExportPath(r, date: date, label: label),
        kind,
        date,
        label,
      ));
    }
    final filesOfExpense = <int, List<String>>{};
    for (final (r, path, _, _, _) in exported) {
      if (r.expenseId != null && r.removedAt == null) {
        filesOfExpense.putIfAbsent(r.expenseId!, () => []).add(path);
      }
    }

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
        'Opmerkingen',
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
          i.notes ?? '',
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
          l.vatRate.dutchLabel(rules),
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
        'Papieren origineel bewaard',
        'Bonnen',
        'Kwartaal',
        'Auto van de zaak',
        'Betaald vanaf',
        'Betalingskenmerk',
        'Ontvanger geschenk',
        'Opmerkingen',
      ],
      for (final e in expenses)
        [
          _date(e.date),
          e.supplier,
          e.description,
          _category(e.category),
          e.vatRate.dutchLabel(rules),
          _purchaseVat(e.purchaseVat),
          _euro(e.amountExclVat),
          _euro(e.vatAmount),
          _euro(e.totalInclVat),
          (e.businessUsePct * 100).round(),
          _euro(e.deductibleAmount),
          _euro(e.vatToReclaim),
          _yesNo(e.paperOriginalKept),
          (filesOfExpense[e.id] ?? const []).join('; '),
          'Q${quarterOf(e.date)}',
          assetNames[e.carAssetId] ?? '',
          e.paidFrom ?? '',
          e.paymentReference ?? '',
          e.giftRecipient ?? '',
          e.notes ?? '',
        ],
    ]);

    await write('uren', [
      [
        'Datum',
        'Omschrijving',
        'Soort',
        'Uren',
        'Klant / project',
        'Opmerkingen',
      ],
      for (final h in hours)
        [
          _date(h.date),
          h.description,
          _work(h.workType),
          h.hours,
          h.clientProject ?? '',
          h.notes ?? '',
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
        'Auto van de zaak',
        'Opmerkingen',
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
          assetNames[m.carAssetId] ?? '',
          m.notes ?? '',
        ],
    ]);

    await write('activa', [
      [
        'Naam',
        'Soort',
        'Kosten excl. btw',
        'Btw-tarief aankoop',
        'Btw-behandeling aankoop',
        'Btw aankoop',
        'Btw te vorderen',
        'Restwaarde',
        'Aankoopdatum',
        'Zakelijk gebruik %',
        'Levensduur (jaar)',
        'KIA',
        'EIA',
        'MIA-categorie',
        'Afgeboekte herinvesteringsreserve',
        'Cataloguswaarde',
        'Datum eerste toelating',
        'Nul-emissie',
        'Waarde in het economisch verkeer',
        'Rittenregistratie',
        'Ontvangen investeringsaftrek',
        'Verkoopdatum',
        'Verkoopopbrengst',
        'Verkoopfactuur',
        'Btw-tarief verkoop',
        'Btw verkoop',
        'Boekwinst naar herinvesteringsreserve',
        'Opmerkingen',
      ],
      for (final a in assets)
        [
          a.assetName,
          a.kind == AssetKind.car ? 'Auto van de zaak' : 'Bedrijfsmiddel',
          _euro(a.costExclVat),
          _rateIn(a.vatRate, a.purchaseDate),
          _purchaseVat(a.purchaseVat),
          _euro(a.vatAmount),
          _euro(a.vatToReclaim),
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
          _date(a.firstRegistration),
          a.kind == AssetKind.car ? _zeroEmission(a.zeroEmission) : '',
          _cents(a.marketValue),
          a.kind == AssetKind.car ? _yesNo(a.keepsTripLog) : '',
          _cents(a.investmentDeductionReceived),
          _date(a.disposalDate),
          a.disposalProceeds == null ? '' : _euro(a.disposalProceeds!),
          a.disposalInvoiceId == null
              ? ''
              : (saleInvoiceNumbers[a.disposalInvoiceId] ?? ''),
          _rateIn(a.disposalVatRate, a.disposalDate),
          a.disposalVatAmount == null ? '' : _euro(a.disposalVatAmount!),
          _yesNo(a.reserveGain),
          a.notes ?? '',
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
        'Particulier',
        'Wederverkoper (merchant of record)',
        'Wet DBA-risico',
        'Contract getekend',
        'Contract vervaldatum',
        'Actief',
        'Opmerkingen',
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
          _yesNo(c.isConsumer),
          _yesNo(c.isMerchantOfRecord),
          c.isMerchantOfRecord ? '' : _risk(c.wetDbaRisk),
          c.isMerchantOfRecord ? '' : _yesNo(c.contractSigned),
          _date(c.contractExpiry),
          _yesNo(c.isActive),
          c.notes ?? '',
        ],
    ]);

    final profile = await (db.select(
      db.businessProfiles,
    )..where((b) => b.id.equals(1))).getSingleOrNull();
    await write('bedrijfsgegevens', profileRows(profile));

    final pension = await (db.select(
      db.pensionEntries,
    )..where((e) => e.year.equals(year))).getSingleOrNull();
    await write('pensioen', pensionRows(pension));

    final inputs = await (db.select(
      db.taxYearInputs,
    )..where((e) => e.year.equals(year))).getSingleOrNull();
    await write('fiscale_gegevens', taxYearInputRows(inputs));

    final filed = await (db.select(
      db.vatReturns,
    )..where((v) => v.year.equals(year))).get();
    await write('btw_aangiften', vatStatusRows(year, filed));

    for (var q = 1; q <= 4; q++) {
      await write('btw_Q$q', btwReturnRows(quarters[q - 1]));
      await write('icp_Q$q', icpRows(quarters[q - 1], clientsById));
    }
    if (incomeTax != null) {
      await write('inkomstenbelasting_schatting', incomeTaxRows(incomeTax));
    }

    // Each file is copied as stored, so its SHA-256 still matches.
    final present = <String, bool>{};
    for (final (r, path, _, _, _) in exported) {
      final source = receipts.fileOf(r);
      final exists = await source.exists();
      present[r.id] = exists;
      if (!exists) continue;
      final target = File(p.join(dir, path));
      await target.parent.create(recursive: true);
      await source.copy(target.path);
    }
    await write('bonnen', [
      [
        'Bestand in export',
        'Hoort bij',
        'Datum',
        'Omschrijving',
        'Oorspronkelijke naam',
        'Soort',
        'Grootte (bytes)',
        'Toegevoegd',
        'SHA-256',
        'Aanwezig',
        'Verwijderd op',
      ],
      for (final (r, path, kind, date, label) in exported)
        [
          path,
          kind,
          _date(date),
          label,
          r.originalName,
          _receiptType(r.type),
          r.sizeBytes,
          _date(r.addedAt),
          r.sha256,
          _yesNo(present[r.id]!),
          r.removedAt == null ? '' : _date(r.removedAt),
        ],
    ]);

    return dir;
  }
}
