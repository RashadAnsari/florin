import 'dart:io';
import 'package:csv/csv.dart';
import 'package:drift/drift.dart' hide DataClass;
import 'package:file_picker/file_picker.dart';
import '../db/database.dart';
import '../theme/app_theme.dart';

class CsvExportService {
  final AppDatabase db;
  CsvExportService(this.db);

  Future<String?> exportYear(int year, {required String dialogTitle}) async {
    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: dialogTitle,
    );
    if (dir == null) return null;

    final invoices =
        await (db.select(db.invoices)
              ..where((i) => i.fiscalYear.equals(year))
              ..orderBy([(i) => OrderingTerm.asc(i.invoiceDate)]))
            .get();
    final expenses =
        await (db.select(db.expenses)
              ..where((e) => e.fiscalYear.equals(year))
              ..orderBy([(e) => OrderingTerm.asc(e.date)]))
            .get();
    final hours =
        await (db.select(db.hourEntries)
              ..where((h) => h.fiscalYear.equals(year))
              ..orderBy([(h) => OrderingTerm.asc(h.date)]))
            .get();
    final mileage =
        await (db.select(db.mileageTrips)
              ..where((m) => m.fiscalYear.equals(year))
              ..orderBy([(m) => OrderingTerm.asc(m.date)]))
            .get();
    final assets =
        await (db.select(db.fixedAssets)
              ..where((a) => a.fiscalYear.equals(year))
              ..orderBy([(a) => OrderingTerm.asc(a.purchaseDate)]))
            .get();
    final lines =
        await (db.select(db.invoiceLines).join([
                innerJoin(
                  db.invoices,
                  db.invoices.id.equalsExp(db.invoiceLines.invoiceId),
                ),
              ])
              ..where(
                db.invoices.fiscalYear.equals(year) &
                    db.invoices.status.isNotValue('Draft'),
              )
              ..orderBy([
                OrderingTerm.asc(db.invoices.invoiceNumber),
                OrderingTerm.asc(db.invoiceLines.sortOrder),
              ]))
            .get();
    final clients = await db.select(db.clients).get();
    final clientNames = {for (final c in clients) c.id: c.name};
    final invoiceNumbers = {for (final i in invoices) i.id: i.invoiceNumber};

    await _writeCsv('$dir/florin_${year}_facturen.csv', [
      [
        'Nummer',
        'Datum',
        'Vervaldatum',
        'Type',
        'Status',
        'Betaaldatum',
        'Klant',
        'ICP',
        'BTW verlegd',
        'Excl. BTW',
        'BTW',
        'Incl. BTW',
        'Kwartaal',
      ],
      ...invoices
          .where((i) => i.status != 'Draft')
          .map(
            (i) => [
              i.invoiceNumber,
              AppFormat.date(i.invoiceDate),
              AppFormat.date(i.dueDate),
              i.invoiceType,
              i.status,
              i.paidDate != null ? AppFormat.date(i.paidDate!) : '',
              clientNames[i.clientId] ?? '',
              i.isIcp ? 'Ja' : 'Nee',
              i.isReverseCharge ? 'Ja' : 'Nee',
              i.totalExclVat / 100,
              i.totalVat / 100,
              i.totalInclVat / 100,
              i.quarter,
            ],
          ),
    ]);

    await _writeCsv('$dir/florin_${year}_factuurregels.csv', [
      [
        'Factuurnummer',
        'Omschrijving',
        'Aantal',
        'Eenheid',
        'Prijs excl. BTW',
        'BTW tarief',
        'BTW bedrag',
        'Totaal excl. BTW',
      ],
      ...lines.map((row) {
        final line = row.readTable(db.invoiceLines);
        final inv = row.readTable(db.invoices);
        return [
          invoiceNumbers[line.invoiceId] ?? inv.invoiceNumber,
          line.description,
          line.quantity,
          line.quantityUnit,
          line.unitPriceExclVat / 100,
          line.vatRate,
          line.vatAmount / 100,
          line.lineTotalExclVat / 100,
        ];
      }),
    ]);

    await _writeCsv('$dir/florin_${year}_uitgaven.csv', [
      [
        'Datum',
        'Leverancier',
        'Omschrijving',
        'Categorie',
        'BTW tarief',
        'Excl. BTW',
        'BTW',
        'Totaal',
        'Zakelijk gebruik %',
        'Aftrekbaar',
        'BTW te vorderen',
        'Bon aanwezig',
        'Kwartaal',
      ],
      ...expenses.map(
        (e) => [
          AppFormat.date(e.date),
          e.supplier,
          e.description,
          e.category,
          e.vatRate,
          e.amountExclVat / 100,
          e.vatAmount / 100,
          e.totalInclVat / 100,
          (e.businessUsePct * 100).round(),
          e.deductibleAmount / 100,
          e.vatToReclaim / 100,
          e.receiptAttached ? 'Ja' : 'Nee',
          e.quarter,
        ],
      ),
    ]);

    await _writeCsv('$dir/florin_${year}_uren.csv', [
      [
        'Datum',
        'Omschrijving',
        'Type',
        'Uren',
        'Facturabel',
        'Klant/Project',
        'WBSO',
        'Week',
      ],
      ...hours.map(
        (h) => [
          AppFormat.date(h.date),
          h.description,
          h.workType,
          h.hours,
          h.billable ? 'Ja' : 'Nee',
          h.clientProject ?? '',
          h.isWbso ? 'Ja' : 'Nee',
          h.weekNumber,
        ],
      ),
    ]);

    await _writeCsv('$dir/florin_${year}_kilometers.csv', [
      [
        'Datum',
        'Merk/Model',
        'Kenteken',
        'Van',
        'Naar',
        'Km start',
        'Km eind',
        'Afstand',
        'Type',
        'Doel',
        'Routeafwijking',
      ],
      ...mileage.map(
        (m) => [
          AppFormat.date(m.date),
          m.vehicleMakeModel,
          m.vehicleLicensePlate,
          m.departureAddress,
          m.arrivalAddress,
          m.odometerStart,
          m.odometerEnd,
          m.distanceKm,
          m.tripType,
          m.purpose,
          m.routeDeviation ? 'Ja' : 'Nee',
        ],
      ),
    ]);

    await _writeCsv('$dir/florin_${year}_activa.csv', [
      [
        'Naam',
        'Kosten excl. BTW',
        'Aankoopdatum',
        'Zakelijk gebruik %',
        'Levensduur (jaar)',
        'KIA',
        'EIA/MIA',
        'Verkoopdatum',
        'Verkoopopbrengst',
      ],
      ...assets.map(
        (a) => [
          a.assetName,
          a.costExclVat / 100,
          AppFormat.date(a.purchaseDate),
          (a.businessUsePct * 100).round(),
          a.usefulLifeYears,
          a.kiaEligible ? 'Ja' : 'Nee',
          a.eiaOrMia ? 'Ja' : 'Nee',
          a.disposalDate != null ? AppFormat.date(a.disposalDate!) : '',
          a.disposalProceeds != null ? a.disposalProceeds! / 100 : '',
        ],
      ),
    ]);

    await _writeCsv('$dir/florin_${year}_klanten.csv', [
      [
        'Naam',
        'Land',
        'BTW nummer',
        'KVK nummer',
        'Adres',
        'Contactpersoon',
        'E-mail',
        'Telefoon',
        'Wet DBA risico',
        'Contract getekend',
        'Contract vervaldatum',
        'Actief',
      ],
      ...clients.map(
        (c) => [
          c.name,
          c.country,
          c.vatNumber ?? '',
          c.kvkNumber ?? '',
          c.address,
          c.contactPerson ?? '',
          c.email ?? '',
          c.phone ?? '',
          c.wetDbaRiskLevel,
          c.contractSigned ? 'Ja' : 'Nee',
          c.contractExpiry != null ? AppFormat.date(c.contractExpiry!) : '',
          c.isActive ? 'Ja' : 'Nee',
        ],
      ),
    ]);

    return dir;
  }

  Future<void> _writeCsv(String path, List<List<dynamic>> rows) async {
    final content = const ListToCsvConverter().convert(rows);
    await File(path).writeAsString(content);
  }
}
