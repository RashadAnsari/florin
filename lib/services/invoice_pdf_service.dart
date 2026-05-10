import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../db/database.dart';

class InvoicePdfService {
  static final _curr = NumberFormat.currency(locale: 'nl_NL', symbol: '€');
  static final _date = DateFormat('dd-MM-yyyy', 'nl_NL');

  static String _c(int cents) => _curr.format(cents / 100);
  static String _d(DateTime? d) => d == null ? '' : _date.format(d);

  static Future<void> share({
    required Invoice invoice,
    required List<InvoiceLine> lines,
    required Client client,
  }) async {
    final bytes = await generate(
      invoice: invoice,
      lines: lines,
      client: client,
    );
    await Printing.sharePdf(
      bytes: bytes,
      filename: '${invoice.invoiceNumber}.pdf',
    );
  }

  static Future<Uint8List> generate({
    required Invoice invoice,
    required List<InvoiceLine> lines,
    required Client client,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 48),
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // ── Title row ──────────────────────────────────────────────────
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  invoice.invoiceType == 'CreditNote'
                      ? 'CREDITNOTA'
                      : 'FACTUUR',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  invoice.invoiceNumber,
                  style: const pw.TextStyle(
                    fontSize: 13,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // ── Seller | Client ─────────────────────────────────────────────
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Van',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 9,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        invoice.sellerName,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      ...invoice.sellerAddress
                          .split('\n')
                          .map(
                            (l) => pw.Text(
                              l,
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                          ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'BTW: ${invoice.sellerVatNumber}',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      pw.Text(
                        'KVK: ${invoice.sellerKvkNumber}',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(width: 40),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Aan',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 9,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        client.name,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      if (client.address.isNotEmpty)
                        ...client.address
                            .split('\n')
                            .map(
                              (l) => pw.Text(
                                l,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                      if (invoice.isIcp && client.vatNumber != null) ...[
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'BTW: ${client.vatNumber}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 16),

            // ── Invoice metadata ────────────────────────────────────────────
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              child: pw.Row(
                children: [
                  _detailCell('Factuurdatum', _d(invoice.invoiceDate)),
                  _detailCell('Vervaldatum', _d(invoice.dueDate)),
                  _detailCell(
                    'Betalingstermijn',
                    '${invoice.paymentTermDays} dagen',
                  ),
                  if (invoice.supplyDate != null)
                    _detailCell('Leveringsdatum', _d(invoice.supplyDate)),
                ],
              ),
            ),
            pw.SizedBox(height: 16),

            // ── Line items ──────────────────────────────────────────────────
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              columnWidths: const {
                0: pw.FlexColumnWidth(4),
                1: pw.FixedColumnWidth(40),
                2: pw.FixedColumnWidth(85),
                3: pw.FixedColumnWidth(50),
                4: pw.FixedColumnWidth(65),
                5: pw.FixedColumnWidth(80),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    _th('Omschrijving'),
                    _th('Antal', right: true),
                    _th('Prijs (excl.)', right: true),
                    _th('BTW%', right: true),
                    _th('BTW', right: true),
                    _th('Totaal (excl.)', right: true),
                  ],
                ),
                ...lines.map(
                  (l) => pw.TableRow(
                    children: [
                      _td(
                        l.quantityUnit != '1'
                            ? '${l.description} (${l.quantity} ${l.quantityUnit})'
                            : l.description,
                      ),
                      _td('${l.quantity}', right: true),
                      _td(_c(l.unitPriceExclVat), right: true),
                      _td(l.vatRate, right: true),
                      _td(_c(l.vatAmount), right: true),
                      _td(_c(l.lineTotalExclVat), right: true),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),

            // ── Totals ──────────────────────────────────────────────────────
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.SizedBox(
                width: 230,
                child: pw.Column(
                  children: [
                    _totRow('Subtotaal (excl. BTW)', _c(invoice.totalExclVat)),
                    ..._vatBreakdown(lines),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Divider(color: PdfColors.grey400),
                    ),
                    _totRow(
                      'Totaal (incl. BTW)',
                      _c(invoice.totalInclVat),
                      bold: true,
                    ),
                  ],
                ),
              ),
            ),

            // ── Reverse charge note ─────────────────────────────────────────
            if (invoice.isReverseCharge) ...[
              pw.SizedBox(height: 12),
              pw.Container(
                padding: const pw.EdgeInsets.all(7),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.orange),
                ),
                child: pw.Text(
                  'BTW verlegd naar afnemer (Art. 196 Richtlijn 2006/112/EG)',
                  style: const pw.TextStyle(fontSize: 9),
                ),
              ),
            ],

            // ── Notes ───────────────────────────────────────────────────────
            if (invoice.notes != null && invoice.notes!.isNotEmpty) ...[
              pw.SizedBox(height: 14),
              pw.Text(
                'Opmerkingen',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(invoice.notes!, style: const pw.TextStyle(fontSize: 10)),
            ],
          ],
        ),
      ),
    );

    return doc.save();
  }

  static pw.Widget _detailCell(String label, String value) => pw.Expanded(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
        ),
        pw.Text(value, style: const pw.TextStyle(fontSize: 10)),
      ],
    ),
  );

  static pw.Widget _th(String t, {bool right = false}) => pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    alignment: right ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
    child: pw.Text(
      t,
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
    ),
  );

  static pw.Widget _td(String t, {bool right = false}) => pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 4),
    alignment: right ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
    child: pw.Text(t, style: const pw.TextStyle(fontSize: 9)),
  );

  static pw.Widget _totRow(String label, String value, {bool bold = false}) =>
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: bold
                ? pw.TextStyle(fontWeight: pw.FontWeight.bold)
                : const pw.TextStyle(fontSize: 10),
          ),
          pw.Text(
            value,
            style: bold
                ? pw.TextStyle(fontWeight: pw.FontWeight.bold)
                : const pw.TextStyle(fontSize: 10),
          ),
        ],
      );

  static List<pw.Widget> _vatBreakdown(List<InvoiceLine> lines) {
    final Map<String, int> byRate = {};
    for (final l in lines) {
      if (l.vatAmount > 0) {
        byRate[l.vatRate] = (byRate[l.vatRate] ?? 0) + l.vatAmount;
      }
    }
    return byRate.entries
        .map((e) => _totRow('BTW ${e.key}', _c(e.value)))
        .toList();
  }
}
