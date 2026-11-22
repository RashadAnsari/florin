import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

import '../db/database.dart';
import '../theme/app_theme.dart';
import 'domain.dart';

/// Invoice PDFs. The copy is Dutch whatever the app language. Required
/// content follows Wet OB 1968 art. 35a; see `docs/legal.md`.
abstract final class InvoicePdfService {
  static String _rate(VatRate r) => switch (r) {
    VatRate.high => '21%',
    VatRate.low => '9%',
    VatRate.zero => '0%',
    VatRate.exempt => 'Vrijgesteld',
  };

  static String _treatmentNote(VatTreatment t) => switch (t) {
    VatTreatment.standard => '',
    VatTreatment.reverseChargeNl => 'Btw verlegd',
    VatTreatment.euServices => 'Btw verlegd',
    VatTreatment.euGoods =>
      'Intracommunautaire levering, 0% btw: artikel 138, lid 1, '
          'Richtlijn 2006/112',
    VatTreatment.exportOutsideEu => 'Uitvoer buiten de EU, 0% btw',
  };

  static Future<void> save({
    required Invoice invoice,
    required List<InvoiceLine> lines,
    required Client client,
    required Invoice? correctedInvoice,
    required String dialogTitle,
  }) async {
    final bytes = await generate(
      invoice: invoice,
      lines: lines,
      client: client,
      correctedInvoice: correctedInvoice,
    );
    final path = await FilePicker.platform.saveFile(
      dialogTitle: dialogTitle,
      fileName: '${invoice.invoiceNumber}.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (path != null) await File(path).writeAsBytes(bytes);
  }

  static Future<Uint8List> generate({
    required Invoice invoice,
    required List<InvoiceLine> lines,
    required Client client,
    required Invoice? correctedInvoice,
  }) async {
    // Bundled, so every invoice looks the same online and offline.
    final regular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
    );
    final bold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
    );

    final isCredit = invoice.invoiceType == InvoiceType.creditNote;
    final sign = isCredit ? -1 : 1;
    String money(int cents) => AppFormat.cents(sign * cents);
    final note = _treatmentNote(invoice.vatTreatment);

    // Wet OB art. 35a lid 1 h: the amount per rate or exemption.
    final byRate = <VatRate, (int, int)>{};
    for (final l in lines) {
      final (base, vat) = byRate[l.vatRate] ?? (0, 0);
      byRate[l.vatRate] = (base + l.lineTotalExclVat, vat + l.vatAmount);
    }

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: regular, bold: bold),
    );
    const small = pw.TextStyle(fontSize: 9);
    const label = pw.TextStyle(fontSize: 8, color: PdfColors.grey700);
    final heading = pw.TextStyle(fontWeight: pw.FontWeight.bold);

    pw.Widget party(String title, List<String> rows) => pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title, style: label),
          pw.SizedBox(height: 3),
          pw.Text(rows.first, style: heading),
          for (final r in rows.skip(1)) pw.Text(r, style: small),
        ],
      ),
    );

    pw.Widget cell(String text, {bool right = false, bool head = false}) =>
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          alignment: right ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
          child: pw.Text(
            text,
            style: head ? heading.copyWith(fontSize: 9) : small,
          ),
        );

    pw.Widget total(String l, String v, {bool strong = false}) => pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(l, style: strong ? heading : small),
        pw.Text(v, style: strong ? heading : small),
      ],
    );

    pw.Widget meta(String l, String v) => pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(l, style: label),
          pw.Text(v, style: small),
        ],
      ),
    );

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 48),
        build: (ctx) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                isCredit ? 'CREDITNOTA' : 'FACTUUR',
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(invoice.invoiceNumber, style: heading),
            ],
          ),
          if (correctedInvoice != null) ...[
            pw.SizedBox(height: 6),
            pw.Text(
              'Creditnota bij factuur ${correctedInvoice.invoiceNumber} '
              'van ${AppFormat.date(correctedInvoice.invoiceDate)}',
              style: small,
            ),
          ],
          pw.SizedBox(height: 20),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              party('Van', [
                invoice.sellerName,
                ...invoice.sellerAddress.split('\n'),
                'Btw-id: ${invoice.sellerVatNumber}',
                'KvK: ${invoice.sellerKvkNumber}',
              ]),
              pw.SizedBox(width: 40),
              party('Aan', [
                client.name,
                ...client.address.split('\n'),
                if (client.country != 'NL') client.country,
                if ((client.vatNumber ?? '').isNotEmpty)
                  'Btw-id: ${client.vatNumber}',
              ]),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            color: PdfColors.grey100,
            child: pw.Row(
              children: [
                meta('Factuurdatum', AppFormat.date(invoice.invoiceDate)),
                if (invoice.supplyDate != null)
                  meta('Leveringsdatum', AppFormat.date(invoice.supplyDate!)),
                if (!isCredit) ...[
                  meta('Vervaldatum', AppFormat.date(invoice.dueDate)),
                  meta('Betalingstermijn', '${invoice.paymentTermDays} dagen'),
                ],
              ],
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            columnWidths: const {
              0: pw.FlexColumnWidth(5),
              1: pw.FlexColumnWidth(1.4),
              2: pw.FlexColumnWidth(1.8),
              3: pw.FlexColumnWidth(1.4),
              4: pw.FlexColumnWidth(1.8),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  cell('Omschrijving', head: true),
                  cell('Aantal', right: true, head: true),
                  cell('Prijs excl. btw', right: true, head: true),
                  cell('Btw', right: true, head: true),
                  cell('Bedrag excl. btw', right: true, head: true),
                ],
              ),
              for (final l in lines)
                pw.TableRow(
                  children: [
                    cell(l.description),
                    cell(
                      '${AppFormat.number(l.quantity)}'
                      '${l.unit == null ? '' : ' ${l.unit}'}',
                      right: true,
                    ),
                    cell(AppFormat.cents(l.unitPriceExclVat), right: true),
                    cell(
                      invoice.vatTreatment == VatTreatment.standard
                          ? _rate(l.vatRate)
                          : '-',
                      right: true,
                    ),
                    cell(money(l.lineTotalExclVat), right: true),
                  ],
                ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.SizedBox(
              width: 260,
              child: pw.Column(
                children: [
                  total('Totaal excl. btw', money(invoice.totalExclVat)),
                  if (invoice.vatTreatment == VatTreatment.standard)
                    for (final e in byRate.entries)
                      total(
                        e.key == VatRate.exempt
                            ? 'Vrijgesteld van btw over ${money(e.value.$1)}'
                            : 'Btw ${_rate(e.key)} over ${money(e.value.$1)}',
                        e.key == VatRate.exempt ? '-' : money(e.value.$2),
                      )
                  else
                    total(note, money(0)),
                  pw.Divider(color: PdfColors.grey400),
                  total(
                    'Totaal incl. btw',
                    money(invoice.totalInclVat),
                    strong: true,
                  ),
                ],
              ),
            ),
          ),
          if (note.isNotEmpty) ...[
            pw.SizedBox(height: 12),
            pw.Container(
              padding: const pw.EdgeInsets.all(7),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey600),
              ),
              child: pw.Text(note, style: heading.copyWith(fontSize: 10)),
            ),
          ],
          if (!isCredit) ...[
            pw.SizedBox(height: 16),
            pw.Text('Betaalinstructies', style: heading.copyWith(fontSize: 9)),
            pw.SizedBox(height: 4),
            pw.Text(
              'Graag ${money(invoice.totalInclVat)} overmaken vóór '
              '${AppFormat.date(invoice.dueDate)} op ${invoice.sellerIban} '
              't.n.v. ${invoice.sellerName} o.v.v. ${invoice.invoiceNumber}.',
              style: small,
            ),
          ],
          if (invoice.notes != null) ...[
            pw.SizedBox(height: 14),
            pw.Text('Opmerkingen', style: heading.copyWith(fontSize: 9)),
            pw.SizedBox(height: 3),
            pw.Text(invoice.notes!, style: small),
          ],
        ],
      ),
    );

    return doc.save();
  }
}
