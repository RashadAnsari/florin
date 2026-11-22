import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../widgets/help.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../l10n/labels.dart';
import '../../providers/providers.dart';
import '../../services/domain.dart';
import '../../services/invoice_pdf_service.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/date_field.dart';
import '../../widgets/detail_scaffold.dart';
import '../../widgets/enum_dropdown.dart';
import '../../widgets/feedback.dart';
import '../../widgets/form_row.dart';
import '../../widgets/invoice_status_badge.dart';
import '../../widgets/notice_banner.dart';
import '../../widgets/value_row.dart';

const _defaultPaymentTermDays = 14;
const _numberPrefix = 'F';

class _LineItem {
  final description = TextEditingController();
  final quantity = TextEditingController(text: '1');
  final unit = TextEditingController();
  final unitPrice = TextEditingController(text: AppFormat.centsInput(0));
  VatRate vatRate = VatRate.high;

  _LineItem();

  _LineItem.from(InvoiceLine l) {
    description.text = l.description;
    quantity.text = AppFormat.number(l.quantity);
    unit.text = l.unit ?? '';
    unitPrice.text = AppFormat.centsInput(l.unitPriceExclVat);
    vatRate = l.vatRate;
  }

  double get qty =>
      double.tryParse(quantity.text.replaceAll(',', '.').trim()) ?? 0;
  int get price => AppFormat.parseCents(unitPrice.text) ?? 0;
  int get total => (qty * price).round();
  int vat(VatTreatment t) =>
      t == VatTreatment.standard ? vatRate.vatOn(total) : 0;

  void dispose() {
    for (final c in [description, quantity, unit, unitPrice]) {
      c.dispose();
    }
  }
}

/// Creates or edits an invoice. With [creditForId], creates a credit note
/// that corrects that invoice.
class InvoiceDetailPanel extends ConsumerStatefulWidget {
  final int? invoiceId;
  final int? creditForId;

  const InvoiceDetailPanel({super.key, this.invoiceId, this.creditForId});

  @override
  ConsumerState<InvoiceDetailPanel> createState() => _InvoiceDetailPanelState();
}

class _InvoiceDetailPanelState extends ConsumerState<InvoiceDetailPanel> {
  final _formKey = GlobalKey<FormState>();
  final _number = TextEditingController();
  final _paymentTerm = TextEditingController(text: '$_defaultPaymentTermDays');
  final _notes = TextEditingController();
  bool _loading = true;
  Invoice? _original;
  Invoice? _corrected;
  List<_LineItem> _lines = [];
  InvoiceType _type = InvoiceType.invoice;
  VatTreatment _treatment = VatTreatment.standard;
  int? _clientId;
  late DateTime _invoiceDate = todayIn(ref.read(fiscalYearProvider));
  DateTime? _supplyDate;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _number.dispose();
    _paymentTerm.dispose();
    _notes.dispose();
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final dao = ref.read(invoiceDaoProvider);
    final id = widget.invoiceId ?? widget.creditForId;
    final source = id == null ? null : await dao.getById(id);
    final lines = source == null ? <InvoiceLine>[] : await dao.getLines(id!);
    final corrected = source?.correctedInvoiceId == null
        ? null
        : await dao.getById(source!.correctedInvoiceId!);
    final isCredit = widget.creditForId != null;
    final number = widget.invoiceId == null
        ? await _suggestNumber(_invoiceDate.year)
        : source!.invoiceNumber;
    if (!mounted) return;
    setState(() {
      _lines = lines.isEmpty
          ? [_LineItem()]
          : lines.map(_LineItem.from).toList();
      if (source != null) {
        _clientId = source.clientId;
        _treatment = source.vatTreatment;
        _paymentTerm.text = '${source.paymentTermDays}';
        if (isCredit) {
          _type = InvoiceType.creditNote;
          _corrected = source;
        } else {
          _original = source;
          _corrected = corrected;
          _type = source.invoiceType;
          _invoiceDate = source.invoiceDate;
          _supplyDate = source.supplyDate;
          _notes.text = source.notes ?? '';
        }
      }
      _number.text = number;
      _loading = false;
    });
  }

  Future<String> _suggestNumber(int year) async {
    final seq = await ref
        .read(invoiceDaoProvider)
        .nextSequenceNumber(year, _numberPrefix);
    return '$_numberPrefix-$year-${seq.toString().padLeft(3, '0')}';
  }

  bool get _isNew => _original == null;
  bool get _isEditable => _isNew || _original!.status == InvoiceStatus.draft;

  int get _totalExclVat => _lines.fold(0, (s, l) => s + l.total);
  int get _totalVat => _lines.fold(0, (s, l) => s + l.vat(_treatment));

  Client? _client(List<Client> clients) =>
      clients.where((c) => c.id == _clientId).firstOrNull;

  Future<void> _setInvoiceDate(DateTime d) async {
    final yearChanged = d.year != _invoiceDate.year;
    setState(() => _invoiceDate = d);
    if (_isNew && yearChanged) {
      final n = await _suggestNumber(d.year);
      if (mounted) setState(() => _number.text = n);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final profile = await ref.read(businessProfileDaoProvider).get();
    if (profile == null || !mounted) return;
    final notes = _notes.text.trim();
    final invoice = InvoicesCompanion(
      id: _isNew ? const Value.absent() : Value(_original!.id),
      invoiceNumber: Value(_number.text.trim()),
      invoiceType: Value(_type),
      correctedInvoiceId: Value(_corrected?.id),
      invoiceDate: Value(_invoiceDate),
      supplyDate: Value(_supplyDate),
      clientId: Value(_clientId!),
      vatTreatment: Value(_treatment),
      sellerName: Value(profile.name),
      sellerVatNumber: Value(profile.vatNumber),
      sellerKvkNumber: Value(profile.kvkNumber),
      sellerAddress: Value(profile.address),
      sellerIban: Value(profile.iban),
      paymentTermDays: Value(int.parse(_paymentTerm.text.trim())),
      status: Value(_original?.status ?? InvoiceStatus.draft),
      paidDate: Value(_original?.paidDate),
      notes: Value(notes.isEmpty ? null : notes),
      totalExclVat: Value(_totalExclVat),
      totalVat: Value(_totalVat),
      totalInclVat: Value(_totalExclVat + _totalVat),
    );
    final lines = [
      for (var i = 0; i < _lines.length; i++)
        InvoiceLinesCompanion(
          invoiceId: const Value(0),
          description: Value(_lines[i].description.text.trim()),
          quantity: Value(_lines[i].qty),
          unit: Value(
            _lines[i].unit.text.trim().isEmpty
                ? null
                : _lines[i].unit.text.trim(),
          ),
          unitPriceExclVat: Value(_lines[i].price),
          vatRate: Value(
            _treatment == VatTreatment.standard
                ? _lines[i].vatRate
                : VatRate.zero,
          ),
          vatAmount: Value(_lines[i].vat(_treatment)),
          lineTotalExclVat: Value(_lines[i].total),
          sortOrder: Value(i),
        ),
    ];
    int? id;
    final saved = await guardSave(context, () async {
      id = await ref.read(invoiceDaoProvider).saveWithLines(invoice, lines);
    });
    if (!saved || !mounted) return;
    if (_isNew) {
      context.pushReplacement('/invoices/$id');
    } else {
      context.pop();
    }
  }

  Future<void> _setStatus(InvoiceStatus status) async {
    final inv = _original!;
    final dao = ref.read(invoiceDaoProvider);
    await guardSave(
      context,
      () => dao.setStatus(
        inv.id,
        status,
        paidDate: status == InvoiceStatus.paid ? DateTime.now() : null,
      ),
    );
    final updated = await dao.getById(inv.id);
    if (mounted) setState(() => _original = updated);
  }

  Future<void> _issue() async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.invoiceIssueTitle,
      message: l.invoiceIssueMessage,
    );
    if (confirmed && mounted) await _setStatus(InvoiceStatus.sent);
  }

  Future<void> _exportPdf() async {
    final l = AppLocalizations.of(context)!;
    final inv = _original!;
    final client = await ref.read(clientDaoProvider).getById(inv.clientId);
    final lines = await ref.read(invoiceDaoProvider).getLines(inv.id);
    if (client == null || !mounted) return;
    await guardSave(
      context,
      () => InvoicePdfService.save(
        invoice: inv,
        lines: lines,
        client: client,
        correctedInvoice: _corrected,
        dialogTitle: l.invoiceSaveAsDialog,
      ),
    );
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.invoiceDeleteTitle,
      message: l.invoiceDeleteMessage(_original!.invoiceNumber),
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    final deleted = await guardSave(
      context,
      () => ref.read(invoiceDaoProvider).remove(_original!),
    );
    if (deleted && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final allClients = ref.watch(clientsProvider).valueOrNull ?? <Client>[];
    final clients = allClients
        .where((c) => c.isActive || c.id == _clientId)
        .toList();
    final client = _client(allClients);
    final status = _original?.status;
    final isCredit = _type == InvoiceType.creditNote;

    return DetailScaffold(
      title: _isNew
          ? (isCredit ? l.invoiceNewCreditNoteHeader : l.invoicesNewHeader)
          : _original!.invoiceNumber,
      onBack: () => context.pop(),
      showSave: _isEditable,
      onSave: _save,
      onDelete: !_isNew && _isEditable ? _delete : null,
      actions: [
        if (!_isNew) ...[
          InvoiceStatusBadge(_original!),
          if (status == InvoiceStatus.draft)
            OutlinedButton.icon(
              icon: const Icon(Icons.send, size: 16),
              label: Text(l.invoiceActionSend),
              onPressed: _issue,
            ),
          if (status == InvoiceStatus.sent)
            OutlinedButton.icon(
              icon: const Icon(Icons.check, size: 16),
              label: Text(l.invoiceActionMarkPaid),
              onPressed: () => _setStatus(InvoiceStatus.paid),
            ),
          if (status != InvoiceStatus.draft && !isCredit)
            OutlinedButton.icon(
              icon: const Icon(Icons.undo, size: 16),
              label: Text(l.invoiceActionCreditNote),
              onPressed: () =>
                  context.push('/invoices/new?creditFor=${_original!.id}'),
            ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            tooltip: l.invoiceActionExportPdf,
            onPressed: _exportPdf,
          ),
        ],
      ],
      body: Form(
        key: _formKey,
        child: AbsorbPointer(
          absorbing: !_isEditable,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_corrected != null) ...[
                NoticeBanner(l.invoiceCorrects(_corrected!.invoiceNumber)),
                const SizedBox(height: AppSpacing.group),
              ],
              FormRow(
                flex: const [3, 2],
                children: [
                  DropdownButtonFormField<int>(
                    initialValue: _clientId,
                    isExpanded: true,
                    decoration: fieldDecoration(
                      label: l.invoiceFieldClient,
                      help: l.invoiceFieldClientHelp,
                      required: true,
                    ),
                    items: [
                      for (final c in clients)
                        DropdownMenuItem(value: c.id, child: Text(c.name)),
                    ],
                    onChanged: isCredit
                        ? null
                        : (v) => setState(() => _clientId = v),
                    validator: (_) {
                      if (client == null) return l.invoiceValidateClient;
                      if (_treatment.needsCustomerVatNumber &&
                          (client.vatNumber ?? '').isEmpty) {
                        return l.invoiceValidateClientVat;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _number,
                    decoration: fieldDecoration(
                      label: l.invoiceFieldNumber,
                      help: l.invoiceFieldNumberHelp,
                      required: true,
                    ),
                    validator: (v) => (v ?? '').trim().isEmpty
                        ? l.invoiceValidateNumber
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.field),
              FormRow(
                children: [
                  DateField(
                    label: l.invoiceFieldInvoiceDate,
                    help: l.invoiceFieldInvoiceDateHelp,
                    value: _invoiceDate,
                    onChanged: _setInvoiceDate,
                    required: true,
                  ),
                  DateField(
                    label: l.invoiceFieldSupplyDate,
                    help: l.invoiceFieldSupplyDateHelp,
                    value: _supplyDate,
                    onChanged: (d) => setState(() => _supplyDate = d),
                  ),
                  TextFormField(
                    controller: _paymentTerm,
                    decoration: fieldDecoration(
                      label: l.invoiceFieldPaymentTerm,
                      help: l.invoiceFieldPaymentTermHelp,
                      required: true,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    validator: (v) {
                      final n = int.tryParse((v ?? '').trim());
                      return n == null || n < 0
                          ? l.invoiceValidatePaymentTerm
                          : null;
                    },
                  ),
                  InputDecorator(
                    decoration: fieldDecoration(
                      label: l.invoiceFieldDueDate,
                      help: l.invoiceFieldDueDateHelp,
                    ),
                    child: Text(
                      AppFormat.date(
                        _invoiceDate.add(
                          Duration(
                            days: int.tryParse(_paymentTerm.text.trim()) ?? 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.field),
              EnumDropdown<VatTreatment>(
                label: l.invoiceFieldVatTreatment,
                help: l.invoiceFieldVatTreatmentHelp,
                value: _treatment,
                values: VatTreatment.values,
                labelOf: (t) => t.label(l),
                onChanged: isCredit
                    ? null
                    : (t) => setState(() => _treatment = t),
                required: true,
              ),
              const SizedBox(height: AppSpacing.section),
              Text(l.invoiceFieldLines, style: theme.textTheme.titleSmall),
              const SizedBox(height: AppSpacing.heading),
              for (var i = 0; i < _lines.length; i++) _lineRow(i, l),
              const SizedBox(height: AppSpacing.heading),
              TextButton.icon(
                icon: const Icon(Icons.add, size: 16),
                label: Text(l.invoiceFieldAddLine),
                onPressed: () => setState(() => _lines.add(_LineItem())),
              ),
              const SizedBox(height: AppSpacing.section),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 320,
                  child: Column(
                    children: [
                      ValueRow(
                        label: l.invoiceSubtotal,
                        value: AppFormat.cents(_totalExclVat),
                      ),
                      ValueRow(
                        label: l.invoiceVatTotal,
                        value: AppFormat.cents(_totalVat),
                      ),
                      const Divider(),
                      ValueRow(
                        label: l.invoiceTotalInclVat,
                        value: AppFormat.cents(_totalExclVat + _totalVat),
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.section),
              TextFormField(
                controller: _notes,
                decoration: fieldDecoration(
                  label: l.invoiceFieldRemarks,
                  help: l.invoiceFieldRemarksHelp,
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lineRow(int i, AppLocalizations l) {
    final line = _lines[i];
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.heading),
      child: FormRow(
        flex: const [6, 2, 2, 3, 3, 2],
        children: [
          TextFormField(
            controller: line.description,
            decoration: fieldDecoration(
              label: l.invoiceFieldDescription,
              help: l.invoiceFieldDescriptionHelp,
              required: true,
            ),
            validator: (v) => (v ?? '').trim().isEmpty
                ? l.invoiceValidateLineDescription
                : null,
          ),
          TextFormField(
            controller: line.quantity,
            decoration: fieldDecoration(
              label: l.invoiceFieldQuantity,
              help: l.invoiceFieldQuantityHelp,
              required: true,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            validator: (_) =>
                line.qty <= 0 ? l.invoiceValidateLineQuantity : null,
          ),
          TextFormField(
            controller: line.unit,
            decoration: fieldDecoration(
              label: l.invoiceFieldUnit,
              help: l.invoiceFieldUnitHelp,
              hintText: l.invoiceUnitHint,
            ),
          ),
          TextFormField(
            controller: line.unitPrice,
            decoration: fieldDecoration(
              label: l.invoiceFieldPrice,
              help: l.invoiceFieldPriceHelp,
              required: true,
              prefixText: '€ ',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            validator: (v) {
              final c = AppFormat.parseCents(v ?? '');
              if (c == null) return l.invoiceValidateLinePrice;
              return c < 0 ? l.amountNegativeError : null;
            },
          ),
          _treatment == VatTreatment.standard
              ? EnumDropdown(
                  label: l.invoiceFieldVat,
                  help: l.invoiceFieldVatHelp,
                  value: line.vatRate,
                  values: VatRate.values,
                  labelOf: (r) => r.label(l),
                  onChanged: (r) => setState(() => line.vatRate = r),
                  required: true,
                )
              : InputDecorator(
                  decoration: fieldDecoration(
                    label: l.invoiceFieldVat,
                    help: l.invoiceFieldVatHelp,
                  ),
                  child: Text(_treatment.label(l)),
                ),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppFormat.cents(line.total),
                  textAlign: TextAlign.right,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                tooltip: l.invoiceRemoveLine,
                color: Theme.of(context).colorScheme.error,
                onPressed: _lines.length > 1
                    ? () => setState(() => _lines.removeAt(i).dispose())
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
