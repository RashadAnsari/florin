import 'dart:io';

import 'package:drift/native.dart';
import 'package:florin/db/database.dart';
import 'package:florin/services/csv_export_service.dart';
import 'package:florin/services/domain.dart';
import 'package:florin/services/kor_service.dart';
import 'package:florin/services/receipt_store.dart';
import 'package:florin/services/tax_rules/tax_year_rules.dart';
import 'package:florin/services/vat_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path/path.dart' as p;

Invoice _invoice(
  int id,
  VatTreatment treatment,
  int total, {
  bool credit = false,
}) => Invoice(
  id: id,
  invoiceNumber: 'F-2026-$id',
  invoiceType: credit ? InvoiceType.creditNote : InvoiceType.invoice,
  invoiceDate: DateTime(2026, 2, 1),
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

VatReturnResult _quarter({
  int revenue1a = 0,
  int vat1a = 0,
  int vat2a = 0,
  int input5b = 0,
  int base1d = 0,
  int vat1d = 0,
  List<Invoice> icp = const [],
}) => VatReturnResult(
  revenue1a: revenue1a,
  vat1a: vat1a,
  revenue1b: 0,
  vat1b: 0,
  revenue1e: 0,
  base1d: base1d,
  vat1d: vat1d,
  revenue3a: 0,
  revenue3b: 0,
  base2a: 0,
  vat2a: vat2a,
  base4a: 0,
  vat4a: 0,
  base4b: 0,
  vat4b: 0,
  inputVat5b: input5b,
  icpInvoices: icp,
);

List<Object> _row(List<List<Object>> rows, String rubriek) =>
    rows.firstWhere((r) => r.first == rubriek);

void main() {
  group('BTW return export, rounding per docs/legal.md', () {
    test('lists every rubriek of the form in order', () {
      final codes = CsvExportService.btwReturnRows(
        _quarter(),
      ).skip(1).map((r) => r.first).toList();
      expect(codes, [
        '1a', '1b', '1c', '1d', '1e', '2a', '3a', '3b', '3c', '4a', '4b', //
        '5a', '5b', '',
      ]);
    });

    test('owed amounts round down, voorbelasting rounds up', () {
      final rows = CsvExportService.btwReturnRows(
        _quarter(revenue1a: 123499, vat1a: 25934, vat2a: 1099, input5b: 10001),
      );
      expect(_row(rows, '1a').sublist(2), [1234, 259]);
      expect(_row(rows, '2a').last, 10);
      expect(_row(rows, '5a').last, 269);
      expect(_row(rows, '5b').last, 101);
      expect(_row(rows, '').last, 168);
    });

    test('1d carries its base, 0 with the forfait (Belastingdienst, Btw en '
        'privégebruik auto van de zaak)', () {
      expect(
        _row(CsvExportService.btwReturnRows(_quarter(vat1d: 108000)), '1d'),
        ['1d', 'Privégebruik', 0, 1080],
      );
      expect(
        _row(
          CsvExportService.btwReturnRows(
            _quarter(base1d: 183333, vat1d: 38500),
          ),
          '1d',
        ).sublist(2),
        [1833, 385],
      );
    });

    test('2a and 3a carry the names of the form (Belastingdienst, Toelichting '
        'bij de btw-aangifte 2026)', () {
      final rows = CsvExportService.btwReturnRows(_quarter());
      expect(
        _row(rows, '2a')[1],
        'Leveringen/diensten waarbij de btw naar u is verlegd',
      );
      expect(
        _row(rows, '3a')[1],
        'Leveringen naar landen buiten de EU (uitvoer)',
      );
    });

    test(
      'negative amounts keep their sign and round in the filer\'s favour',
      () {
        final rows = CsvExportService.btwReturnRows(
          _quarter(revenue1a: -10050, vat1a: -2110),
        );
        expect(_row(rows, '1a').sublist(2), [-101, -22]);
        expect(_row(rows, '').last, -22);
      },
    );
  });

  test('ICP list totals per customer with goods and services apart', () {
    final client = Client(
      id: 1,
      name: 'K',
      country: 'BE',
      vatNumber: 'BE0123456789',
      address: 'A',
      wetDbaRisk: WetDbaRisk.low,
      contractSigned: false,
      isActive: true,
      isMerchantOfRecord: false,
      isConsumer: false,
    );
    final rows = CsvExportService.icpRows(
      [
        _invoice(1, VatTreatment.euGoods, 50000),
        _invoice(2, VatTreatment.euServices, 20000),
        _invoice(3, VatTreatment.euServices, 5000, credit: true),
      ],
      {1: client},
    );
    expect(rows, hasLength(3));
    expect(rows[1], ['BE', 'BE0123456789', 500.0, 150.0]);
    // The total to compare with rubriek 3b, in whole euros as there
    // (Belastingdienst, Toelichting bij de opgaaf ICP 2026).
    expect(rows[2], ['', 'Totaal (vergelijk met rubriek 3b)', 650, '']);
  });

  test('the export writes one ICP list per ICP period, also when empty (Wet '
      'OB 1968 art. 37a lid 3)', () {
    Invoice goods(int id, DateTime date) =>
        _invoice(id, VatTreatment.euGoods, 3000000).copyWith(invoiceDate: date);
    final files = CsvExportService.icpFiles(
      [goods(1, DateTime(2026, 4, 10)), goods(2, DateTime(2026, 5, 12))],
      const {},
      year: 2026,
      kor: KorStatus.none,
      rules: taxRulesFor(2026)!,
    );
    expect(files.keys, [
      'icp_Q1',
      'icp_M04-M05',
      'icp_M06',
      'icp_M07',
      'icp_M08',
      'icp_M09',
      'icp_M10',
      'icp_M11',
      'icp_M12',
    ]);
    expect(files['icp_Q1'], hasLength(2));
    expect(files['icp_M04-M05'], hasLength(3));
  });

  test('writes one BTW file per period of the filing period, empty ones '
      'included (AGENTS.md non-negotiable 7)', () async {
    await initializeDateFormatting('nl_NL');
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final parent = await Directory.systemTemp.createTemp('florin_export');
    addTearDown(() => parent.delete(recursive: true));
    final empty = _quarter();
    Future<Set<String>> btwFiles(VatFilingPeriod kind) async {
      final dir = await CsvExportService(db).writeYear(
        2026,
        parent: parent.path,
        periods: [for (final p in vatPeriodsOf(2026, kind)) (p, empty)],
        incomeTax: null,
        receipts: ReceiptStore(parent.path),
      );
      return {
        for (final f in Directory(dir).listSync())
          if (p.basename(f.path).startsWith('florin_2026_btw_') &&
              !p.basename(f.path).contains('aangiften') &&
              !p.basename(f.path).contains('herziening'))
            p.basename(f.path),
      };
    }

    expect(await btwFiles(VatFilingPeriod.monthly), {
      for (var m = 1; m <= 12; m++)
        'florin_2026_btw_M${m.toString().padLeft(2, '0')}.csv',
    });
    expect(await btwFiles(VatFilingPeriod.yearly), {
      'florin_2026_btw_jaar.csv',
    });
    expect(await btwFiles(VatFilingPeriod.quarterly), {
      for (var q = 1; q <= 4; q++) 'florin_2026_btw_Q$q.csv',
    });
  });

  test('each export gets its own folder named after the moment', () async {
    final parent = await Directory.systemTemp.createTemp('florin_export');
    addTearDown(() => parent.delete(recursive: true));
    final at = DateTime(2026, 11, 23, 14, 30, 5);
    final first = await CsvExportService.createExportFolder(
      parent.path,
      2026,
      at,
    );
    final second = await CsvExportService.createExportFolder(
      parent.path,
      2026,
      at,
    );
    expect(p.basename(first.path), 'florin_2026_export_2026-11-23_14-30-05');
    expect(p.basename(second.path), 'florin_2026_export_2026-11-23_14-30-05_2');
    expect(await first.exists(), isTrue);
  });

  test('receipts get readable, safe and unique names in an export', () {
    Receipt receipt({int? expenseId, int? invoiceId}) => Receipt(
      id: '3f2c9a1e-6b0d-4e8a-9c1f-2a7b5d4e3c10',
      expenseId: expenseId,
      invoiceId: invoiceId,
      year: 2026,
      type: ReceiptType.pdf,
      originalName: 'scan.pdf',
      sizeBytes: 1,
      sha256: 'h',
      addedAt: DateTime(2026, 3, 5),
    );
    expect(
      CsvExportService.receiptExportPath(
        receipt(expenseId: 1),
        date: DateTime(2026, 3, 4),
        label: 'Hardware: A/B "Voorbeeld"',
      ),
      'bonnen/2026-03-04_Hardware- A-B -Voorbeeld-_3f2c9a1e.pdf',
    );
    expect(
      CsvExportService.receiptExportPath(
        receipt(invoiceId: 1),
        date: DateTime(2026, 3, 4),
        label: 'F-2026-001',
      ),
      'facturen/F-2026-001_3f2c9a1e.pdf',
    );
  });
}
