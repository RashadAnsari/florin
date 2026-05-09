import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import '../db/database.dart';
import '../theme/app_theme.dart';

class CsvExportService {
  final AppDatabase db;
  CsvExportService(this.db);

  Future<String?> exportYear(int year) async {
    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Kies exportmap',
    );
    if (dir == null) return null;

    final invoices = await (db.select(
      db.invoices,
    )..where((i) => i.fiscalYear.equals(year))).get();
    final expenses = await (db.select(
      db.expenses,
    )..where((e) => e.fiscalYear.equals(year))).get();
    final hours = await (db.select(
      db.hourEntries,
    )..where((h) => h.fiscalYear.equals(year))).get();
    final mileage = await (db.select(
      db.mileageTrips,
    )..where((m) => m.fiscalYear.equals(year))).get();
    final assets = await (db.select(
      db.fixedAssets,
    )..where((a) => a.fiscalYear.equals(year))).get();

    await _writeCsv('$dir/florin_${year}_invoices.csv', [
      [
        'Nummer',
        'Datum',
        'Type',
        'Status',
        'Klant ID',
        'Excl. BTW',
        'BTW',
        'Incl. BTW',
        'Kwartaal',
      ],
      ...invoices.map(
        (i) => [
          i.invoiceNumber,
          AppFormat.date(i.invoiceDate),
          i.invoiceType,
          i.status,
          i.clientId,
          i.totalExclVat / 100,
          i.totalVat / 100,
          i.totalInclVat / 100,
          i.quarter,
        ],
      ),
    ]);

    await _writeCsv('$dir/florin_${year}_expenses.csv', [
      [
        'Datum',
        'Leverancier',
        'Omschrijving',
        'Categorie',
        'Excl. BTW',
        'BTW',
        'Totaal',
        'Aftrekbaar',
        'Kwartaal',
      ],
      ...expenses.map(
        (e) => [
          AppFormat.date(e.date),
          e.supplier,
          e.description,
          e.category,
          e.amountExclVat / 100,
          e.vatAmount / 100,
          e.totalInclVat / 100,
          e.deductibleAmount / 100,
          e.quarter,
        ],
      ),
    ]);

    await _writeCsv('$dir/florin_${year}_hours.csv', [
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
          h.billable,
          h.clientProject ?? '',
          h.isWbso,
          h.weekNumber,
        ],
      ),
    ]);

    await _writeCsv('$dir/florin_${year}_mileage.csv', [
      [
        'Datum',
        'Voertuig',
        'Van',
        'Naar',
        'Km start',
        'Km eind',
        'Afstand',
        'Type',
        'Doel',
      ],
      ...mileage.map(
        (m) => [
          AppFormat.date(m.date),
          '${m.vehicleMakeModel} ${m.vehicleLicensePlate}',
          m.departureAddress,
          m.arrivalAddress,
          m.odometerStart,
          m.odometerEnd,
          m.distanceKm,
          m.tripType,
          m.purpose,
        ],
      ),
    ]);

    await _writeCsv('$dir/florin_${year}_assets.csv', [
      [
        'Naam',
        'Kosten excl. BTW',
        'Aankoopdatum',
        'Gebruik %',
        'Levensduur',
        'KIA',
      ],
      ...assets.map(
        (a) => [
          a.assetName,
          a.costExclVat / 100,
          AppFormat.date(a.purchaseDate),
          a.businessUsePct,
          a.usefulLifeYears,
          a.kiaEligible,
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
