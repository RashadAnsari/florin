import 'tax_rules/tax_year_rules.dart';
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
/// content follows Wet OB 1968 art. 35a; see `docs/legal.md`. A self-billed
/// invoice is the customer's document, so Florin makes no PDF of it.
abstract final class InvoicePdfService {
  /// The note under the totals that names the treatment: «btw verlegd»
  /// (art. 35a lid 1 m), the ground of the zero rate or exemption (lid 1 l),
  /// or the article that places a service outside the Netherlands.
  static String treatmentNote(Invoice invoice, Client client) =>
      switch (invoice.vatTreatment) {
        VatTreatment.standard => '',
        VatTreatment.reverseChargeNl => 'Btw verlegd',
        VatTreatment.euServices => 'Btw verlegd',
        VatTreatment.euGoods =>
          'Intracommunautaire levering, 0% btw: artikel 138, lid 1, '
              'Richtlijn 2006/112',
        VatTreatment.exportOutsideEu => 'Uitvoer buiten de EU, 0% btw',
        VatTreatment.servicesOutsideEu =>
          client.isConsumer
              ? 'Niet in Nederland belast: dienst aan een afnemer buiten de '
                    'EU (artikel 6e, 6h of 6i, Wet OB 1968)'
              : 'Niet in Nederland belast: dienst aan een ondernemer buiten '
                    'de EU (artikel 6, lid 1, Wet OB 1968)',
        // Art. 25a lid 4 forbids any mention of the tax on the invoice; the
        // Belastingdienst asks to state that an exemption applies.
        VatTreatment.kor =>
          'Vrijgesteld op grond van de kleineondernemersregeling',
      };

  /// Art. 25a lid 4: a KOR invoice mentions no BTW at all.
  static bool _mentionsNoVat(Invoice invoice) =>
      invoice.vatTreatment == VatTreatment.kor;

  /// The seller block: name and address, the btw-id (art. 35a lid 1 c and e)
  /// except under the KOR, and the KvK number (Handelsregisterwet 2007
  /// art. 27 lid 1).
  static List<String> sellerRows(Invoice invoice) => [
    invoice.sellerName,
    ...invoice.sellerAddress.split('\n'),
    if (!_mentionsNoVat(invoice)) 'Btw-id: ${invoice.sellerVatNumber}',
    'KvK: ${invoice.sellerKvkNumber}',
  ];

  /// The customer block: name and address (art. 35a lid 1 e), and the
  /// customer's btw-id when known, except under the KOR.
  static List<String> clientRows(Invoice invoice, Client client) => [
    client.name,
    ...client.address.split('\n'),
    if (client.country != 'NL') client.country,
    if ((client.vatNumber ?? '').isNotEmpty && !_mentionsNoVat(invoice))
      'Btw-id: ${client.vatNumber}',
  ];

  /// The heads of the line table; under the KOR without the BTW column.
  static List<String> columnHeads(Invoice invoice) {
    final kor = _mentionsNoVat(invoice);
    return [
      'Omschrijving',
      'Aantal',
      kor ? 'Prijs' : 'Prijs excl. btw',
      if (!kor) 'Btw',
      kor ? 'Bedrag' : 'Bedrag excl. btw',
    ];
  }

  /// The rows under the line table, the last one the amount to pay: under
  /// the KOR only the total, otherwise the subtotal, the BTW rows and the
  /// total incl. BTW.
  static List<(String, String)> totalRows(
    Invoice invoice,
    List<InvoiceLine> lines,
  ) {
    final total = AppFormat.cents(invoice.sign * invoice.totalInclVat);
    if (_mentionsNoVat(invoice)) return [('Totaal', total)];
    return [
      (
        'Totaal excl. btw',
        AppFormat.cents(invoice.sign * invoice.totalExclVat),
      ),
      ...vatRows(invoice, lines),
      ('Totaal incl. btw', total),
    ];
  }

  /// The line that makes a credit note an invoice: a specific reference to
  /// the invoice it corrects (art. 34f, art. 35a lid 2 e).
  static String creditReference(Invoice corrected) =>
      'Creditnota bij factuur ${corrected.invoiceNumber} '
      'van ${AppFormat.date(corrected.invoiceDate)}';

  /// The payment instructions of an invoice.
  static String paymentText(Invoice invoice) =>
      'Graag ${AppFormat.cents(invoice.sign * invoice.totalInclVat)} '
      'overmaken vóór ${AppFormat.date(invoice.dueDate)} op '
      '${invoice.sellerIban} t.n.v. ${invoice.sellerName} o.v.v. '
      '${invoice.invoiceNumber}.';

  /// The rate column of [line]: the rate with Dutch BTW, and with domestic
  /// reverse charge the rate that would apply without it (art. 35a lid 1 i).
  static String rateCell(Invoice invoice, InvoiceLine line) =>
      invoice.vatTreatment.lineRates.contains(line.vatRate)
      ? line.vatRate.dutchLabel(taxRulesFor(invoice.invoiceDate.year)!)
      : '-';

  /// The BTW rows under the subtotal: per rate or exemption the base and the
  /// BTW (art. 35a lid 1 h and j); with domestic reverse charge the base per
  /// rate as without it, marked verlegd; otherwise a BTW of nil.
  static List<(String, String)> vatRows(
    Invoice invoice,
    List<InvoiceLine> lines,
  ) {
    String money(int cents) => AppFormat.cents(invoice.sign * cents);
    final rates = invoice.vatTreatment.lineRates;
    final byRate = <VatRate, (int, int)>{};
    for (final l in lines) {
      if (!rates.contains(l.vatRate)) continue;
      final (base, vat) = byRate[l.vatRate] ?? (0, 0);
      byRate[l.vatRate] = (base + l.lineTotalExclVat, vat + l.vatAmount);
    }
    if (byRate.isEmpty) return [('Btw', money(0))];
    final reverse = invoice.vatTreatment == VatTreatment.reverseChargeNl;
    // An invoice is dated in a supported year.
    final rules = taxRulesFor(invoice.invoiceDate.year)!;
    return [
      for (final MapEntry(key: rate, value: (base, vat)) in byRate.entries)
        rate == VatRate.exempt
            ? ('Vrijgesteld van btw over ${money(base)}', '-')
            : (
                'Btw ${rate.dutchLabel(rules)} over ${money(base)}',
                reverse ? 'verlegd' : money(vat),
              ),
    ];
  }

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
    await saveBytes(bytes, '${invoice.invoiceNumber}.pdf', dialogTitle);
  }

  /// Asks where to save [bytes], such as the stored PDF of an issued invoice.
  static Future<void> saveBytes(
    Uint8List bytes,
    String fileName,
    String dialogTitle,
  ) async {
    final path = await FilePicker.platform.saveFile(
      dialogTitle: dialogTitle,
      fileName: fileName,
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

    final isCredit = invoice.isCreditNote;
    String money(int cents) => AppFormat.cents(invoice.sign * cents);
    final note = treatmentNote(invoice, client);
    final kor = _mentionsNoVat(invoice);
    final heads = columnHeads(invoice);
    final totals = totalRows(invoice, lines);

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
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(child: pw.Text(l, style: strong ? heading : small)),
        pw.SizedBox(width: 8),
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
            pw.Text(creditReference(correctedInvoice), style: small),
          ],
          pw.SizedBox(height: 20),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              party('Van', sellerRows(invoice)),
              pw.SizedBox(width: 40),
              party('Aan', clientRows(invoice, client)),
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
            columnWidths: {
              0: const pw.FlexColumnWidth(5),
              1: const pw.FlexColumnWidth(1.4),
              2: const pw.FlexColumnWidth(1.8),
              if (!kor) 3: const pw.FlexColumnWidth(1.4),
              (kor ? 3 : 4): const pw.FlexColumnWidth(1.8),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  for (final (i, h) in heads.indexed)
                    cell(h, right: i > 0, head: true),
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
                    if (!kor) cell(rateCell(invoice, l), right: true),
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
                  for (final (label, value) in totals.take(totals.length - 1))
                    total(label, value),
                  if (totals.length > 1) pw.Divider(color: PdfColors.grey400),
                  total(totals.last.$1, totals.last.$2, strong: true),
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
            pw.Text(paymentText(invoice), style: small),
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
