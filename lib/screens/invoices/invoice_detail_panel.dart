import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/invoice_pdf_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/vat_rate_selector.dart';

String _centsToInput(int cents) =>
    (cents / 100).toStringAsFixed(2).replaceAll('.', ',');

int _inputToCents(String text) {
  final s = text
      .replaceAll('€', '')
      .replaceAll(' ', '')
      .replaceAll('.', '')
      .replaceAll(',', '.')
      .trim();
  return ((double.tryParse(s) ?? 0.0) * 100).round();
}

class _LineItem {
  final int? id;
  final TextEditingController description;
  final TextEditingController quantity;
  final TextEditingController unitPrice;
  final TextEditingController unit;
  String vatRate;

  _LineItem({
    this.id,
    String desc = '',
    double qty = 1.0,
    int priceCents = 0,
    String unitStr = '1',
    this.vatRate = '21%',
  }) : description = TextEditingController(text: desc),
       quantity = TextEditingController(
         text: qty == qty.truncateToDouble()
             ? qty.toInt().toString()
             : qty.toString(),
       ),
       unitPrice = TextEditingController(text: _centsToInput(priceCents)),
       unit = TextEditingController(text: unitStr == '1' ? '' : unitStr);

  double get _qty => double.tryParse(quantity.text.replaceAll(',', '.')) ?? 1.0;
  int get _price => _inputToCents(unitPrice.text);
  int get lineTotalExclVat => (_qty * _price).round();
  int get vatAmount => (lineTotalExclVat * parseVatRate(vatRate)).round();

  void dispose() {
    description.dispose();
    quantity.dispose();
    unitPrice.dispose();
    unit.dispose();
  }
}

class InvoiceDetailPanel extends ConsumerStatefulWidget {
  final int? invoiceId;
  final void Function(int id)? onCreated;
  final VoidCallback? onBack;

  const InvoiceDetailPanel({
    super.key,
    this.invoiceId,
    this.onCreated,
    this.onBack,
  });

  @override
  ConsumerState<InvoiceDetailPanel> createState() => _InvoiceDetailPanelState();
}

class _InvoiceDetailPanelState extends ConsumerState<InvoiceDetailPanel> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = true;
  Invoice? _original;
  List<_LineItem> _lines = [];

  late final TextEditingController _invoiceNumber;
  late final TextEditingController _paymentTermDays;
  late final TextEditingController _notes;
  String _invoiceType = 'Invoice';
  int? _clientId;
  DateTime _invoiceDate = DateTime.now();
  DateTime? _supplyDate;
  bool _isIcp = false;
  bool _isReverseCharge = false;

  @override
  void initState() {
    super.initState();
    _invoiceNumber = TextEditingController();
    _paymentTermDays = TextEditingController(text: '14');
    _notes = TextEditingController();
    _load();
  }

  @override
  void dispose() {
    _invoiceNumber.dispose();
    _paymentTermDays.dispose();
    _notes.dispose();
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    if (widget.invoiceId == null) {
      await _loadNew();
      return;
    }
    final dao = ref.read(invoiceDaoProvider);
    final inv = await dao.getById(widget.invoiceId!);
    if (inv == null || !mounted) {
      setState(() => _loading = false);
      return;
    }
    final lineRecords = await dao.getLinesForInvoice(widget.invoiceId!);
    final loaded = lineRecords
        .map(
          (l) => _LineItem(
            id: l.id,
            desc: l.description,
            qty: l.quantity,
            priceCents: l.unitPriceExclVat,
            unitStr: l.quantityUnit,
            vatRate: l.vatRate,
          ),
        )
        .toList();
    setState(() {
      _original = inv;
      _lines = loaded;
      _invoiceNumber.text = inv.invoiceNumber;
      _invoiceType = inv.invoiceType;
      _clientId = inv.clientId;
      _invoiceDate = inv.invoiceDate;
      _supplyDate = inv.supplyDate;
      _paymentTermDays.text = inv.paymentTermDays.toString();
      _isIcp = inv.isIcp;
      _isReverseCharge = inv.isReverseCharge;
      _notes.text = inv.notes ?? '';
      _loading = false;
    });
  }

  Future<void> _loadNew() async {
    final year = ref.read(fiscalYearProvider);
    final dao = ref.read(invoiceDaoProvider);
    final prefix = 'F';
    final seq = await dao.nextSequenceNumber(year, prefix);
    if (!mounted) return;
    setState(() {
      _invoiceNumber.text = '$prefix-$year-${seq.toString().padLeft(3, '0')}';
      _lines = [_LineItem()];
      _loading = false;
    });
  }

  void _addLine() {
    setState(() => _lines.add(_LineItem()));
  }

  void _removeLine(int i) {
    setState(() {
      _lines[i].dispose();
      _lines.removeAt(i);
    });
  }

  DateTime get _dueDate {
    final days = int.tryParse(_paymentTermDays.text) ?? 0;
    return _invoiceDate.add(Duration(days: days));
  }

  int get _totalExclVat => _lines.fold(0, (s, l) => s + l.lineTotalExclVat);
  int get _totalVat => _lines.fold(0, (s, l) => s + l.vatAmount);
  int get _totalInclVat => _totalExclVat + _totalVat;

  bool get _isEditable => _original == null || _original!.status == 'Draft';

  Map<String, int> get _vatByRate {
    final m = <String, int>{};
    for (final l in _lines) {
      final v = l.vatAmount;
      if (v > 0) m[l.vatRate] = (m[l.vatRate] ?? 0) + v;
    }
    return m;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final dao = ref.read(invoiceDaoProvider);
    final year = ref.read(fiscalYearProvider);
    final prefs = await SharedPreferences.getInstance();
    final sellerName = prefs.getString('business_name') ?? '';
    final sellerVat = prefs.getString('business_vat_number') ?? '';
    final sellerKvk = prefs.getString('business_kvk') ?? '';
    final sellerAddress = prefs.getString('business_address') ?? '';
    final sellerIban = prefs.getString('business_iban');
    final companion = InvoicesCompanion(
      id: _original != null ? Value(_original!.id) : const Value.absent(),
      invoiceNumber: Value(_invoiceNumber.text.trim()),
      invoiceDate: Value(_invoiceDate),
      supplyDate: Value(_supplyDate),
      clientId: Value(_clientId!),
      invoiceType: Value(_invoiceType),
      sellerName: Value(sellerName),
      sellerVatNumber: Value(sellerVat),
      sellerKvkNumber: Value(sellerKvk),
      sellerAddress: Value(sellerAddress),
      sellerIban: Value(sellerIban?.isNotEmpty == true ? sellerIban : null),
      paymentTermDays: Value(int.tryParse(_paymentTermDays.text) ?? 0),
      dueDate: Value(_dueDate),
      status: Value(_original?.status ?? 'Draft'),
      paidDate: Value(_original?.paidDate),
      refundDate: Value(_original?.refundDate),
      notes: Value(_notes.text.trim().isEmpty ? null : _notes.text.trim()),
      isReverseCharge: Value(_isReverseCharge),
      isIcp: Value(_isIcp),
      reverseChargeNote: Value(_original?.reverseChargeNote),
      totalExclVat: Value(_totalExclVat),
      totalVat: Value(_totalVat),
      totalInclVat: Value(_totalInclVat),
      fiscalYear: Value(year),
      quarter: Value(AppFormat.quarter(_invoiceDate)),
    );

    int invoiceId;
    if (_original == null) {
      invoiceId = await dao.insertInvoice(companion);
    } else {
      await dao.saveInvoice(companion);
      invoiceId = _original!.id;
    }

    final lineCompanions = [
      for (var i = 0; i < _lines.length; i++)
        InvoiceLinesCompanion(
          invoiceId: Value(invoiceId),
          description: Value(_lines[i].description.text.trim()),
          quantityUnit: Value(
            _lines[i].unit.text.trim().isEmpty
                ? '1'
                : _lines[i].unit.text.trim(),
          ),
          quantity: Value(_lines[i]._qty),
          unitPriceExclVat: Value(_inputToCents(_lines[i].unitPrice.text)),
          vatRate: Value(_lines[i].vatRate),
          vatAmount: Value(_lines[i].vatAmount),
          lineTotalExclVat: Value(_lines[i].lineTotalExclVat),
          sortOrder: Value(i),
        ),
    ];

    if (_original != null) {
      await dao.replaceLines(invoiceId, lineCompanions);
    } else {
      for (final lc in lineCompanions) {
        await dao.insertLine(lc);
      }
    }

    if (_original == null) {
      final newInv = await dao.getById(invoiceId);
      if (mounted && newInv != null) {
        widget.onCreated?.call(invoiceId);
      }
    }
    if (mounted) widget.onBack?.call();
  }

  Future<void> _markStatus(
    String status, {
    DateTime? paidDate,
    DateTime? refundDate,
  }) async {
    if (_original == null) return;
    final dao = ref.read(invoiceDaoProvider);
    await dao.saveInvoice(
      InvoicesCompanion(
        id: Value(_original!.id),
        invoiceNumber: Value(_original!.invoiceNumber),
        invoiceDate: Value(_original!.invoiceDate),
        supplyDate: Value(_original!.supplyDate),
        clientId: Value(_original!.clientId),
        invoiceType: Value(_original!.invoiceType),
        sellerName: Value(_original!.sellerName),
        sellerVatNumber: Value(_original!.sellerVatNumber),
        sellerKvkNumber: Value(_original!.sellerKvkNumber),
        sellerAddress: Value(_original!.sellerAddress),
        sellerIban: Value(_original!.sellerIban),
        paymentTermDays: Value(_original!.paymentTermDays),
        dueDate: Value(_original!.dueDate),
        status: Value(status),
        paidDate: Value(paidDate),
        refundDate: Value(refundDate),
        notes: Value(_original!.notes),
        isReverseCharge: Value(_original!.isReverseCharge),
        isIcp: Value(_original!.isIcp),
        reverseChargeNote: Value(_original!.reverseChargeNote),
        totalExclVat: Value(_original!.totalExclVat),
        totalVat: Value(_original!.totalVat),
        totalInclVat: Value(_original!.totalInclVat),
        fiscalYear: Value(_original!.fiscalYear),
        quarter: Value(_original!.quarter),
      ),
    );
    final updated = await dao.getById(_original!.id);
    if (mounted && updated != null) setState(() => _original = updated);
  }

  Future<void> _sharePdf() async {
    if (_original == null || _clientId == null) return;
    final lines = await ref
        .read(invoiceDaoProvider)
        .getLinesForInvoice(_original!.id);
    final clients = ref.read(clientsStreamProvider).valueOrNull ?? [];
    final client = clients.firstWhere(
      (c) => c.id == _clientId,
      orElse: () => throw StateError('Client not found'),
    );
    await InvoicePdfService.share(
      invoice: _original!,
      lines: lines,
      client: client,
    );
  }

  Future<void> _delete() async {
    if (_original == null) return;
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.invoiceDeleteTitle,
      message: l.invoiceDeleteMessage(_original!.invoiceNumber),
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref.read(invoiceDaoProvider).deleteInvoice(_original!.id);
    if (mounted) widget.onBack?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    final theme = Theme.of(context);
    final clients = ref.watch(clientsStreamProvider).valueOrNull ?? [];
    final status = _original?.status ?? 'Draft';
    final isNew = _original == null;

    return Column(
      children: [
        // ── Header bar ──────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
          child: Row(
            children: [
              if (widget.onBack != null)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onBack,
                ),
              Expanded(
                child: Text(
                  isNew
                      ? AppLocalizations.of(context)!.invoicesNewHeader
                      : _invoiceNumber.text,
                  style: theme.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isNew) ...[
                _StatusBadge(status: status, dueDate: _original!.dueDate),
                const SizedBox(width: 8),
                if (status == 'Draft')
                  OutlinedButton.icon(
                    icon: const Icon(Icons.send, size: 16),
                    label: Text(
                      AppLocalizations.of(context)!.invoiceActionSend,
                    ),
                    onPressed: () => _markStatus('Sent'),
                  ),
                if (status == 'Sent')
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.check, size: 16),
                      label: Text(
                        AppLocalizations.of(context)!.invoiceActionMarkPaid,
                      ),
                      onPressed: () =>
                          _markStatus('Paid', paidDate: DateTime.now()),
                    ),
                  ),
                if (status == 'Paid')
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.undo, size: 16),
                      label: Text(
                        AppLocalizations.of(context)!.invoiceActionMarkRefunded,
                      ),
                      onPressed: () =>
                          _markStatus('Refunded', refundDate: DateTime.now()),
                    ),
                  ),
                if (status == 'Sent')
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.cancel_outlined, size: 16),
                      label: Text(
                        AppLocalizations.of(context)!.invoiceActionCancel,
                      ),
                      onPressed: () => _markStatus('Cancelled'),
                    ),
                  ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  tooltip: AppLocalizations.of(context)!.invoiceActionExportPdf,
                  onPressed: _sharePdf,
                ),
                if (_isEditable)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: AppLocalizations.of(context)!.invoiceActionDelete,
                    color: Theme.of(context).colorScheme.error,
                    onPressed: _delete,
                  ),
              ],
              if (_isEditable)
                FilledButton.icon(
                  onPressed: _save,
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.onPrimaryContainer,
                  ),
                  icon: const Icon(Icons.save_outlined, size: 18),
                  label: Text(AppLocalizations.of(context)!.actionSave),
                ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        const Divider(height: 1),
        // ── Form body ───────────────────────────────────────────────────────
        Expanded(
          child: Form(
            key: _formKey,
            child: AbsorbPointer(
              absorbing: !_isEditable,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Invoice type + client + dates
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: DropdownButtonFormField<String>(
                            initialValue: _invoiceType,
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.invoiceFieldType,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'Invoice',
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.invoiceTypeInvoice,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'CreditNote',
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.invoiceTypeCreditNote,
                                ),
                              ),
                            ],
                            onChanged: (v) => setState(() => _invoiceType = v!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            initialValue: clients.any((c) => c.id == _clientId)
                                ? _clientId
                                : null,
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.invoiceFieldClient,
                            ),
                            items: clients
                                .map(
                                  (c) => DropdownMenuItem(
                                    value: c.id,
                                    child: Text(c.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) => setState(() => _clientId = v),
                            validator: (_) => _clientId == null
                                ? AppLocalizations.of(
                                    context,
                                  )!.invoiceValidateClient
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 160,
                          child: TextFormField(
                            controller: _invoiceNumber,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.invoiceFieldNumber,
                            ),
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? AppLocalizations.of(
                                    context,
                                  )!.invoiceValidateNumber
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: ValueKey(_invoiceDate.toString()),
                            initialValue: AppFormat.date(_invoiceDate),
                            readOnly: true,
                            strutStyle: StrutStyle.disabled,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.invoiceFieldInvoiceDate,
                            ),
                            onTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: _invoiceDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2040),
                              );
                              if (d != null) setState(() => _invoiceDate = d);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            key: ValueKey(_supplyDate?.toString() ?? 'null'),
                            initialValue: _supplyDate != null
                                ? AppFormat.date(_supplyDate!)
                                : '-',
                            readOnly: true,
                            strutStyle: StrutStyle.disabled,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.invoiceFieldSupplyDate,
                            ),
                            onTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: _supplyDate ?? _invoiceDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2040),
                              );
                              if (d != null) setState(() => _supplyDate = d);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _paymentTermDays,
                            strutStyle: StrutStyle.disabled,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.invoiceFieldPaymentTerm,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                            validator: (v) {
                              final n = int.tryParse(v ?? '');
                              if (n == null || n < 0) {
                                return AppLocalizations.of(
                                  context,
                                )!.invoiceValidatePaymentTerm;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            key: ValueKey(_dueDate.toString()),
                            initialValue: AppFormat.date(_dueDate),
                            readOnly: true,
                            strutStyle: StrutStyle.disabled,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.invoiceFieldDueDate,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      value: _isIcp,
                      onChanged: (v) => setState(() => _isIcp = v ?? false),
                      title: Text(
                        AppLocalizations.of(context)!.invoiceFieldIcp,
                      ),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      value: _isReverseCharge,
                      onChanged: (v) =>
                          setState(() => _isReverseCharge = v ?? false),
                      title: Text(
                        AppLocalizations.of(context)!.invoiceFieldBtwVerlegd,
                      ),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 20),
                    // ── Line items ─────────────────────────────────────────────
                    Text(
                      AppLocalizations.of(context)!.invoiceFieldLines,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    _buildLineHeader(theme),
                    ..._lines.asMap().entries.map(
                      (e) => _buildLineRow(e.key, e.value, theme),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      icon: const Icon(Icons.add, size: 16),
                      label: Text(
                        AppLocalizations.of(context)!.invoiceFieldAddLine,
                      ),
                      onPressed: _addLine,
                    ),
                    const SizedBox(height: 20),
                    // ── Totals ─────────────────────────────────────────────────
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 280,
                        child: Column(
                          children: [
                            _totalRow(
                              AppLocalizations.of(context)!.invoiceSubtotal,
                              AppFormat.cents(_totalExclVat),
                              theme,
                            ),
                            ..._vatByRate.entries.map(
                              (e) => _totalRow(
                                AppLocalizations.of(
                                  context,
                                )!.invoiceVatLine(e.key),
                                AppFormat.cents(e.value),
                                theme,
                              ),
                            ),
                            const Divider(),
                            _totalRow(
                              AppLocalizations.of(context)!.invoiceTotalInclVat,
                              AppFormat.cents(_totalInclVat),
                              theme,
                              bold: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _notes,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(
                          context,
                        )!.invoiceFieldRemarks,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLineHeader(ThemeData theme) {
    final l = AppLocalizations.of(context)!;
    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.only(left: 2, top: 4, bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l.invoiceFieldDescription,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 50,
            child: Text(
              l.invoiceFieldQuantity,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 70,
            child: Text(
              l.invoiceFieldUnit,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 90,
            child: Text(
              l.invoiceFieldPrice,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 130,
            child: Text(
              l.invoiceFieldVat,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 80,
            child: Text(
              l.invoiceFieldVatAmount,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 80,
            child: Text(
              l.invoiceFieldLineTotal,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }

  Widget _buildLineRow(int i, _LineItem line, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: line.description,
              decoration: InputDecoration(
                isDense: true,
                hintText: AppLocalizations.of(context)!.invoiceHintDescription,
              ),
              onChanged: (_) => setState(() {}),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? AppLocalizations.of(context)!.invoiceValidateLineDescription
                  : null,
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 50,
            child: TextFormField(
              controller: line.quantity,
              decoration: const InputDecoration(isDense: true),
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
              validator: (v) {
                final n = double.tryParse((v ?? '').replaceAll(',', '.'));
                return (n == null || n <= 0)
                    ? AppLocalizations.of(context)!.invoiceValidateLineQuantity
                    : null;
              },
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 70,
            child: TextFormField(
              controller: line.unit,
              decoration: InputDecoration(
                isDense: true,
                hintText: AppLocalizations.of(context)!.invoiceUnitHint,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 90,
            child: TextFormField(
              controller: line.unitPrice,
              decoration: const InputDecoration(
                isDense: true,
                prefixText: '€ ',
              ),
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
              validator: (v) {
                final parsed = double.tryParse(
                  (v ?? '')
                      .replaceAll('€', '')
                      .replaceAll(' ', '')
                      .replaceAll('.', '')
                      .replaceAll(',', '.'),
                );
                return parsed == null
                    ? AppLocalizations.of(context)!.invoiceValidateLinePrice
                    : null;
              },
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 130,
            child: DropdownButtonFormField<String>(
              initialValue: line.vatRate,
              isDense: true,
              isExpanded: true,
              decoration: const InputDecoration(isDense: true),
              items: kVatRates
                  .map(
                    (r) => DropdownMenuItem(
                      value: r,
                      child: Text(
                        vatRateLabel(AppLocalizations.of(context)!, r),
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => line.vatRate = v);
              },
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 80,
            child: Text(
              AppFormat.cents(line.vatAmount),
              textAlign: TextAlign.right,
              style: theme.textTheme.bodySmall,
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 80,
            child: Text(
              AppFormat.cents(line.lineTotalExclVat),
              textAlign: TextAlign.right,
              style: theme.textTheme.bodySmall,
            ),
          ),
          SizedBox(
            width: 32,
            child: IconButton(
              icon: const Icon(Icons.close, size: 16),
              padding: EdgeInsets.zero,
              color: _lines.length > 1
                  ? Theme.of(context).colorScheme.error
                  : null,
              onPressed: _lines.length > 1 ? () => _removeLine(i) : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalRow(
    String label,
    String value,
    ThemeData theme, {
    bool bold = false,
  }) {
    final style = bold
        ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)
        : theme.textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final DateTime dueDate;

  const _StatusBadge({required this.status, required this.dueDate});

  @override
  Widget build(BuildContext context) {
    final isOverdue = status == 'Sent' && dueDate.isBefore(DateTime.now());
    final l = AppLocalizations.of(context)!;
    final (label, color) = isOverdue
        ? (l.invoiceStatusOverdue, AppColors.red)
        : switch (status) {
            'Draft' => (
              l.invoiceStatusConcept,
              Theme.of(context).colorScheme.outline,
            ),
            'Sent' => (l.invoiceStatusSent, AppColors.action),
            'Paid' => (l.invoiceStatusPaid, AppColors.income),
            'Cancelled' => (l.invoiceStatusCancelled, AppColors.red),
            'Refunded' => (l.invoiceStatusRefunded, AppColors.red),
            _ => (status, Theme.of(context).colorScheme.outline),
          };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
