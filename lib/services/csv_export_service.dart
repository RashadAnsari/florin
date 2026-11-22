import 'dart:io';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

import '../db/database.dart';
import '../theme/app_theme.dart';
import 'domain.dart';

/// Exports one year of bookkeeping as CSV files for an accountant. Headers
/// and values are Dutch whatever the app language.
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
  };

  static String _rate(VatRate r) => switch (r) {
    VatRate.high => '21%',
    VatRate.low => '9%',
    VatRate.zero => '0%',
    VatRate.exempt => 'Vrijgesteld',
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

  Future<String?> exportYear(int year, {required String dialogTitle}) async {
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
          _rate(l.vatRate),
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
          _rate(e.vatRate),
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
          _risk(c.wetDbaRisk),
          _yesNo(c.contractSigned),
          _date(c.contractExpiry),
          _yesNo(c.isActive),
        ],
    ]);

    return dir;
  }
}
