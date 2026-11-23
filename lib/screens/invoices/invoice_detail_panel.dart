import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../widgets/validators.dart';
import '../../widgets/form_error_text.dart';
import '../../widgets/amount_field.dart';
import '../../services/formats.dart';
import '../../widgets/help.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../l10n/labels.dart';
import '../../providers/providers.dart';
import '../../services/domain.dart';
import '../../services/invoice_pdf_service.dart';
import '../../services/kor_service.dart';
import '../../services/tax_rules/tax_year_rules.dart';
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
  final key = UniqueKey();
  final description = TextEditingController();
  final quantity = TextEditingController(text: '1');
  final unit = TextEditingController();
  int price = 0;
  VatRate vatRate = VatRate.high;

  _LineItem();

  _LineItem.from(InvoiceLine l) {
    description.text = l.description;
    quantity.text = AppFormat.number(l.quantity);
    unit.text = l.unit ?? '';
    price = l.unitPriceExclVat;
    vatRate = l.vatRate;
  }

  double get qty => parseDecimal(quantity.text) ?? 0;
  int get total => (qty * price).round();
  int vat(VatTreatment t) =>
      t == VatTreatment.standard ? vatRate.vatOn(total) : 0;

  void dispose() {
    for (final c in [description, quantity, unit]) {
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

  /// Why the invoice could not be loaded, shown instead of the form.
  Object? _loadError;
  Invoice? _original;
  Invoice? _corrected;

  /// What other credit notes already credit on [_corrected].
  int _alreadyCredited = 0;
  List<_LineItem> _lines = [];
  InvoiceType _type = InvoiceType.invoice;
  VatTreatment _treatment = VatTreatment.standard;
  bool _selfBilled = false;
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
    try {
      await _loadInvoice();
    } catch (e) {
      if (mounted) setState(() => _loadError = e);
    }
  }

  Future<void> _loadInvoice() async {
    final dao = ref.read(invoiceDaoProvider);
    final id = widget.invoiceId ?? widget.creditForId;
    final source = id == null ? null : await dao.getById(id);
    final lines = source == null ? <InvoiceLine>[] : await dao.getLines(id!);
    final corrected = source?.correctedInvoiceId == null
        ? null
        : await dao.getById(source!.correctedInvoiceId!);
    final isCredit = widget.creditForId != null;
    final correctedId = isCredit ? id : source?.correctedInvoiceId;
    final credited = correctedId == null
        ? 0
        : await dao.creditedExclVat(correctedId, excludingId: widget.invoiceId);
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
        _selfBilled = source.selfBilled;
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
      // A correction of a self-billed invoice is also issued by the customer.
      _alreadyCredited = credited;
      _number.text = isCredit && _selfBilled ? '' : number;
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
    if (_isNew && yearChanged && !_selfBilled) {
      final n = await _suggestNumber(d.year);
      if (mounted) setState(() => _number.text = n);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    BusinessProfile? profile;
    final loaded = await guardSave(context, () async {
      profile = await ref.read(businessProfileDaoProvider).get();
    });
    if (!loaded || !mounted) return;
    if (profile == null) {
      showSaveError(context, AppLocalizations.of(context)!.invoiceNoProfile);
      return;
    }
    final seller = profile!;
    final invoice = InvoicesCompanion(
      id: _isNew ? const Value.absent() : Value(_original!.id),
      invoiceNumber: Value(_number.text.trim()),
      invoiceType: Value(_type),
      correctedInvoiceId: Value(_corrected?.id),
      invoiceDate: Value(_invoiceDate),
      supplyDate: Value(_supplyDate),
      clientId: Value(_clientId!),
      vatTreatment: Value(_treatment),
      selfBilled: Value(_selfBilled),
      sellerName: Value(seller.name),
      sellerVatNumber: Value(seller.vatNumber),
      sellerKvkNumber: Value(seller.kvkNumber),
      sellerAddress: Value(seller.address),
      sellerIban: Value(seller.iban),
      paymentTermDays: Value(parseWholeNumber(_paymentTerm.text)!),
      status: Value(_original?.status ?? InvoiceStatus.draft),
      paidDate: Value(_original?.paidDate),
      notes: Value(optionalText(_notes.text)),
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
          unit: Value(optionalText(_lines[i].unit.text)),
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

  Future<void> _setStatus(InvoiceStatus status, {DateTime? paidDate}) async {
    final inv = _original!;
    final dao = ref.read(invoiceDaoProvider);
    Invoice? updated;
    await guardSave(context, () async {
      await dao.setStatus(inv.id, status, paidDate: paidDate);
      updated = await dao.getById(inv.id);
    });
    if (mounted && updated != null) setState(() => _original = updated);
  }

  Future<void> _issue() async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: _selfBilled ? l.invoiceRecordTitle : l.invoiceIssueTitle,
      message: _selfBilled ? l.invoiceRecordMessage : l.invoiceIssueMessage,
    );
    if (confirmed && mounted) await _setStatus(InvoiceStatus.sent);
  }

  /// Asks for the date the payment arrived, within the supported years and
  /// not before the invoice date.
  Future<void> _markPaid() async {
    final l = AppLocalizations.of(context)!;
    final inv = _original!;
    final last = DateTime(supportedYears.last, 12, 31);
    final today = todayIn(inv.invoiceDate.year);
    final initial = today.isBefore(inv.invoiceDate) ? inv.invoiceDate : today;
    final date = await showDatePicker(
      context: context,
      helpText: l.invoicePaidDateTitle,
      initialDate: initial.isAfter(last) ? last : initial,
      firstDate: inv.invoiceDate,
      lastDate: last,
    );
    if (date != null && mounted) {
      await _setStatus(InvoiceStatus.paid, paidDate: date);
    }
  }

  Future<void> _setSelfBilled(bool value) async {
    setState(() => _selfBilled = value);
    if (!_isNew) return;
    if (value) {
      setState(() => _number.clear());
    } else if (_number.text.trim().isEmpty) {
      final n = await _suggestNumber(_invoiceDate.year);
      if (mounted) setState(() => _number.text = n);
    }
  }

  void _setClient(int? id, List<Client> clients) {
    final c = clients.where((x) => x.id == id).firstOrNull;
    setState(() {
      _clientId = id;
      // A new invoice starts with the treatment that fits the client.
      if (c != null && _isNew) {
        _treatment = c.suggestedVatTreatment(
          korApplies: _kor.appliesOn(_invoiceDate),
        );
      }
    });
    // The option is hidden for other clients, so it may not stay ticked.
    if (_isNew && _selfBilled && !(c?.isMerchantOfRecord ?? false)) {
      _setSelfBilled(false);
    }
  }

  Future<void> _exportPdf() async {
    final l = AppLocalizations.of(context)!;
    final inv = _original!;
    await guardSave(context, () async {
      final client = await ref.read(clientDaoProvider).getById(inv.clientId);
      final lines = await ref.read(invoiceDaoProvider).getLines(inv.id);
      await InvoicePdfService.save(
        invoice: inv,
        lines: lines,
        client: client!,
        correctedInvoice: _corrected,
        dialogTitle: l.invoiceSaveAsDialog,
      );
    });
  }

  KorStatus get _kor =>
      ref.read(korStatusProvider).valueOrNull ?? KorStatus.none;

  /// Under the KOR a supply in the Netherlands carries no BTW, until the
  /// supply that takes the turnover past the limit, which carries BTW again
  /// (Wet OB 1968 art. 25a lid 4 and 9). A credit note follows its invoice.
  String? _korError(VatTreatment t, AppLocalizations l) {
    if (_corrected != null) return null;
    if (!_kor.appliesOn(_invoiceDate)) {
      return t == VatTreatment.kor ? l.invoiceValidateKorNotActive : null;
    }
    if (!KorService.coveredSupply(t)) return null;
    final limit = taxYears[_invoiceDate.year]?.korThreshold;
    final exceeds =
        limit != null &&
        KorService.wouldExceed(
          invoices: ref.read(allInvoicesProvider).valueOrNull ?? const [],
          date: _invoiceDate,
          treatment: t,
          amount: _totalExclVat,
          limit: limit,
          excludingId: _original?.id,
        );
    if (exceeds) {
      return t == VatTreatment.kor
          ? l.invoiceValidateKorExceeded(AppFormat.cents(limit))
          : null;
    }
    return t == VatTreatment.kor ? null : l.invoiceValidateKorTreatment;
  }

  /// A credit note reverses at most what is left of the corrected invoice.
  String? _creditLimitError(AppLocalizations l) {
    final c = _corrected;
    if (c == null) return null;
    final left = c.totalExclVat - _alreadyCredited;
    return _totalExclVat > left
        ? l.invoiceValidateCreditAboveInvoice(
            c.invoiceNumber,
            AppFormat.cents(left < 0 ? 0 : left),
          )
        : null;
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
    if (_loadError != null) {
      final l = AppLocalizations.of(context)!;
      return DetailScaffold(
        title: l.invoicesNewHeader,
        onBack: () => context.pop(),
        showSave: false,
        onSave: () {},
        body: NoticeBanner(
          l.genericLoadError(describeError(_loadError!, l)),
          tone: NoticeTone.error,
        ),
      );
    }
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final allClients = ref.watch(clientsProvider).valueOrNull ?? <Client>[];
    // Loaded here so the KOR checks in the validators have their data.
    ref.watch(korStatusProvider);
    ref.watch(allInvoicesProvider);
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
              icon: Icon(_selfBilled ? Icons.lock : Icons.send, size: 16),
              label: Text(
                _selfBilled ? l.invoiceActionRecord : l.invoiceActionSend,
              ),
              onPressed: _issue,
            ),
          if (status == InvoiceStatus.sent)
            OutlinedButton.icon(
              icon: const Icon(Icons.check, size: 16),
              label: Text(l.invoiceActionMarkPaid),
              onPressed: _markPaid,
            ),
          if (status != InvoiceStatus.draft && !isCredit)
            OutlinedButton.icon(
              icon: const Icon(Icons.undo, size: 16),
              label: Text(l.invoiceActionCreditNote),
              onPressed: () =>
                  context.push('/invoices/new?creditFor=${_original!.id}'),
            ),
          if (!_selfBilled)
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
              if (client != null && client.isMerchantOfRecord) ...[
                NoticeBanner(l.invoiceMerchantOfRecordNotice(client.name)),
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
                        : (v) => _setClient(v, allClients),
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
                      help: _selfBilled
                          ? l.invoiceFieldNumberSelfBilledHelp
                          : l.invoiceFieldNumberHelp,
                      required: true,
                    ),
                    validator: (v) => (v ?? '').trim().isNotEmpty
                        ? null
                        : _selfBilled
                        ? l.invoiceValidateNumberSelfBilled
                        : l.invoiceValidateNumber,
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
                    validator: (_) =>
                        _corrected != null &&
                            _invoiceDate.isBefore(_corrected!.invoiceDate)
                        ? l.invoiceValidateCreditDate(
                            AppFormat.date(_corrected!.invoiceDate),
                          )
                        : null,
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
                    validator: (v) =>
                        Validate.wholeNumber(v, l.invoiceValidatePaymentTerm),
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
                            days: parseWholeNumber(_paymentTerm.text) ?? 0,
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
                validator: (t) =>
                    client != null && !t.fitsCountry(client.country)
                    ? l.invoiceValidateTreatmentCountry
                    : _korError(t, l),
              ),
              // Self-billing is a reseller's practice, so the option shows
              // only there, or on an invoice that already uses it.
              if (_selfBilled || (client?.isMerchantOfRecord ?? false)) ...[
                const SizedBox(height: AppSpacing.field),
                HelpCheckbox(
                  value: _selfBilled,
                  onChanged: isCredit ? null : _setSelfBilled,
                  title: l.invoiceSelfBilled,
                  help: l.invoiceSelfBilledHelp,
                ),
              ],
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
                      // A KOR invoice mentions no VAT, so only its total.
                      if (_treatment != VatTreatment.kor) ...[
                        ValueRow(
                          label: l.invoiceSubtotal,
                          value: AppFormat.cents(_totalExclVat),
                        ),
                        ValueRow(
                          label: l.invoiceVatTotal,
                          value: AppFormat.cents(_totalVat),
                        ),
                        const Divider(),
                      ],
                      ValueRow(
                        label: _treatment == VatTreatment.kor
                            ? l.invoiceTotal
                            : l.invoiceTotalInclVat,
                        value: AppFormat.cents(_totalExclVat + _totalVat),
                        bold: true,
                      ),
                      if (_corrected != null)
                        FormErrorText(validator: () => _creditLimitError(l)),
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
      key: line.key,
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
            validator: (v) =>
                Validate.required(v, l.invoiceValidateLineDescription),
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
            validator: (v) =>
                Validate.decimal(v, l.invoiceValidateLineQuantity),
          ),
          TextFormField(
            controller: line.unit,
            decoration: fieldDecoration(
              label: l.invoiceFieldUnit,
              help: l.invoiceFieldUnitHelp,
              hintText: l.invoiceUnitHint,
            ),
          ),
          AmountField(
            key: ValueKey(('price', line.key)),
            label: l.invoiceFieldPrice,
            help: l.invoiceFieldPriceHelp,
            required: true,
            validatorMessage: l.invoiceValidateLinePrice,
            initialValueCents: line.price,
            onChanged: (v) => setState(() => line.price = v),
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
                  child: EllipsisText(_treatment.lineLabel(l)),
                ),
          Row(
            children: [
              // An amount stays on one line; it shrinks rather than wraps.
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(AppFormat.cents(line.total), maxLines: 1),
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
