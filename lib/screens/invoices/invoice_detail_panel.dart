import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../widgets/validators.dart';
import '../../widgets/form_error_text.dart';
import '../../widgets/amount_field.dart';
import '../../services/vat_service.dart';
import '../../services/asset_service.dart';
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
import '../../services/receipt_service.dart';
import '../receipts/receipts_section.dart';
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
  int vat(VatTreatment t, TaxYearRules rules) =>
      t == VatTreatment.standard ? rules.vatOn(vatRate, total) : 0;

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
  final _receiptDraft = ReceiptDraft();
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
    _receiptDraft.dispose();
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
  // The rules of the invoice's own year; its dates lie in supported years.
  TaxYearRules get _rules => _rulesOf(_invoiceDate);
  TaxYearRules _rulesOf(DateTime d) => ref.watch(taxRulesProvider(d.year));

  int get _totalVat => _lines.fold(0, (s, l) => s + l.vat(_treatment, _rules));

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
            _treatment.lineRates.contains(_lines[i].vatRate)
                ? _lines[i].vatRate
                : VatRate.zero,
          ),
          vatAmount: Value(_lines[i].vat(_treatment, _rules)),
          lineTotalExclVat: Value(_lines[i].total),
          sortOrder: Value(i),
        ),
    ];
    int? id;
    final receipts = ref.read(receiptServiceProvider);
    final saved = await guardSave(context, () async {
      id = await ref.read(invoiceDaoProvider).saveWithLines(invoice, lines);
      final owner = ReceiptOwner.invoice(id!);
      await receipts.relocateFor(owner, _invoiceDate.year);
      await _receiptDraft.commit(receipts, owner, _invoiceDate.year);
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
    final dao = ref.read(invoiceDaoProvider);
    final inv = _original!;
    // Issued numbers follow on in their series (art. 35a lid 1 b); Florin
    // leaves no gaps: a draft in Florin's series is sent as the next number
    // after the last one issued.
    String? next;
    if (!_selfBilled) {
      final read = await guardSave(context, () async {
        next = await dao.nextIssuedNumber(inv.invoiceDate.year, _numberPrefix);
      });
      if (!read || !mounted) return;
    }
    final renumber = next != null && next != inv.invoiceNumber;
    final confirmed = await showConfirmationDialog(
      context,
      title: _selfBilled ? l.invoiceRecordTitle : l.invoiceIssueTitle,
      confirmLabel: _selfBilled
          ? l.invoiceActionRecord
          : renumber
          ? l.invoiceActionSendAs(next!)
          : l.invoiceActionSend,
      message: _selfBilled
          ? l.invoiceRecordMessage
          : renumber
          ? '${l.invoiceIssueMessage}\n\n'
                '${l.invoiceIssueRenumber(inv.invoiceNumber, next!)}'
          : l.invoiceIssueMessage,
    );
    if (!confirmed || !mounted) return;
    if (renumber) {
      Invoice? renamed;
      final done = await guardSave(context, () async {
        await dao.renumberDraft(inv.id, next!);
        renamed = await dao.getById(inv.id);
      });
      if (!done || !mounted || renamed == null) return;
      setState(() {
        _original = renamed;
        _number.text = renamed!.invoiceNumber;
      });
    }
    // The PDF is kept as it is sent; a customer's own document is added by
    // the user instead.
    if (!_selfBilled) {
      final stored = await guardSave(context, _storeIssuedPdf);
      if (!stored || !mounted) return;
    }
    await _setStatus(InvoiceStatus.sent);
  }

  /// The PDF of this invoice as Florin makes it now.
  Future<Uint8List> _generatePdf() async {
    final inv = _original!;
    final client = await ref.read(clientDaoProvider).getById(inv.clientId);
    final lines = await ref.read(invoiceDaoProvider).getLines(inv.id);
    return InvoicePdfService.generate(
      invoice: inv,
      lines: lines,
      client: client!,
      correctedInvoice: _corrected,
    );
  }

  /// Stores the PDF of the invoice being issued, replacing one left by an
  /// earlier attempt that did not finish.
  Future<Receipt> _storeIssuedPdf() async {
    final inv = _original!;
    final receipts = ref.read(receiptServiceProvider);
    final owner = ReceiptOwner.invoice(inv.id);
    await receipts.removeAllFor(owner);
    return receipts.attachBytes(
      owner,
      await _generatePdf(),
      '${inv.invoiceNumber}.pdf',
      inv.invoiceDate.year,
    );
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
    final receipts = ref.read(receiptServiceProvider);
    await guardSave(context, () async {
      final name = '${inv.invoiceNumber}.pdf';
      if (!inv.isIssued) {
        // A draft is a preview: nothing is kept.
        await InvoicePdfService.saveBytes(
          await _generatePdf(),
          name,
          l.invoiceSaveAsDialog,
        );
        return;
      }
      // An issued invoice is handed out exactly as stored when it was sent.
      // One issued before Florin kept PDFs gets its PDF stored now.
      final stored = (await receipts.dao.forOwner(
        ReceiptOwner.invoice(inv.id),
      )).where((r) => r.type == ReceiptType.pdf).firstOrNull;
      final receipt = stored ?? await _storeIssuedPdf();
      await InvoicePdfService.saveBytes(
        await receipts.store.fileOf(receipt).readAsBytes(),
        name,
        l.invoiceSaveAsDialog,
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
    // The supply counts on the day it was made (Wet OB 1968 art. 25 lid 1 a).
    final supplied = suppliedOnOf(_invoiceDate, _supplyDate);
    final limit = taxYears[supplied.year]?.korThreshold;
    final exceeds =
        limit != null &&
        KorService.wouldExceed(
          invoices: ref.read(allInvoicesProvider).valueOrNull ?? const [],
          date: supplied,
          treatment: t,
          amount: _totalExclVat,
          limit: limit,
          excludingId: _original?.id,
          assetSales: AssetService.saleInvoiceIds(
            ref.read(allAssetsProvider).valueOrNull ?? const [],
          ),
        );
    if (exceeds) {
      return t == VatTreatment.kor
          ? l.invoiceValidateKorExceeded(AppFormat.cents(limit))
          : null;
    }
    return t == VatTreatment.kor ? null : l.invoiceValidateKorTreatment;
  }

  /// Electronic services and distance sales to consumers in other member
  /// states are taxed there above the threshold (Wet OB 1968 art. 6h, 6k).
  /// Florin cannot tell which supplies those are, so it compares all of them
  /// with the threshold, this year and the year before, and warns.
  Widget _euConsumerNotice(List<Client> clients, AppLocalizations l) {
    final year = _invoiceDate.year;
    final threshold = _rulesOf(_invoiceDate).euConsumerSalesThreshold;
    final invoices = ref.read(allInvoicesProvider).valueOrNull ?? const [];
    final byId = {for (final c in clients) c.id: c};
    final others = invoices.where((i) => i.id != _original?.id).toList();
    final thisYear =
        VatService.euConsumerSales(others, byId, year) + _totalExclVat;
    final lastYear = VatService.euConsumerSales(others, byId, year - 1);
    final over = thisYear > threshold || lastYear > threshold;
    return NoticeBanner(
      over
          ? l.invoiceEuConsumerOverNotice(AppFormat.cents(threshold))
          : l.invoiceEuConsumerNotice(
              AppFormat.cents(threshold),
              AppFormat.cents(thisYear),
            ),
      tone: over ? NoticeTone.warning : NoticeTone.info,
    );
  }

  /// What the law gives the user on an unpaid invoice past its due date:
  /// interest and collection costs (BW 6:119a, 6:96), and the date the claim
  /// lapses (BW 3:307).
  Widget _overdueNotice(Invoice inv, Client client, AppLocalizations l) {
    final rules = _rulesOf(inv.invoiceDate);
    final lapses = AppFormat.date(inv.claimLapsesOn(rules));
    return NoticeBanner(
      client.isConsumer
          ? l.invoiceOverdueConsumerNotice(
              AppFormat.date(inv.dueDate),
              rules.consumerReminderDays,
              lapses,
            )
          : l.invoiceOverdueBusinessNotice(
              AppFormat.date(inv.dueDate),
              AppFormat.euros(rules.minCollectionCosts),
              rules.statutoryPaymentDays,
              lapses,
            ),
      tone: NoticeTone.warning,
    );
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
      confirmLabel: l.actionDelete,
    );
    if (!confirmed || !mounted) return;
    final deleted = await guardSave(context, () async {
      await ref
          .read(receiptServiceProvider)
          .removeAllFor(ReceiptOwner.invoice(_original!.id));
      await ref.read(invoiceDaoProvider).remove(_original!);
    });
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: AbsorbPointer(
              absorbing: !_isEditable,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_isEditable) ...[
                    NoticeBanner(
                      isCredit
                          ? l.invoiceLockedCreditNotice
                          : l.invoiceLockedNotice,
                    ),
                    const SizedBox(height: AppSpacing.group),
                  ],
                  if (_corrected != null) ...[
                    NoticeBanner(l.invoiceCorrects(_corrected!.invoiceNumber)),
                    const SizedBox(height: AppSpacing.group),
                  ],
                  if (!isCredit &&
                      (_original?.isOverdue ?? false) &&
                      client != null) ...[
                    _overdueNotice(_original!, client, l),
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
                        style: fieldTextStyle(context),
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
                          help: l.invoiceFieldPaymentTermHelp(
                            _rulesOf(_invoiceDate).maxAgreedPaymentDays,
                            _rulesOf(_invoiceDate).statutoryPaymentDays,
                          ),
                          required: true,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                        validator: (v) => Validate.wholeNumber(
                          v,
                          l.invoiceValidatePaymentTerm,
                        ),
                      ),
                      ReadOnlyField(
                        label: l.invoiceFieldDueDate,
                        help: l.invoiceFieldDueDateHelp,
                        value: AppFormat.date(
                          dueDateOf(
                            _invoiceDate,
                            parseWholeNumber(_paymentTerm.text) ?? 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_isEditable &&
                      client != null &&
                      !client.isConsumer &&
                      (parseWholeNumber(_paymentTerm.text) ?? 0) >
                          _rulesOf(_invoiceDate).maxAgreedPaymentDays) ...[
                    const SizedBox(height: AppSpacing.field),
                    NoticeBanner(
                      l.invoiceLongTermNotice(
                        _rulesOf(_invoiceDate).maxAgreedPaymentDays,
                        _rulesOf(_invoiceDate).largeDebtorMaxPaymentDays,
                        _rulesOf(_invoiceDate).governmentPaymentDays,
                        _rulesOf(_invoiceDate).governmentMaxPaymentDays,
                      ),
                      tone: NoticeTone.warning,
                    ),
                  ],
                  if (_isEditable &&
                      _supplyDate != null &&
                      _invoiceDate.isAfter(
                        _rulesOf(_supplyDate!).latestInvoiceDate(_supplyDate!),
                      )) ...[
                    const SizedBox(height: AppSpacing.field),
                    NoticeBanner(
                      l.invoiceLateNotice(
                        _rulesOf(_supplyDate!).invoiceDueDay,
                        AppFormat.date(
                          _rulesOf(
                            _supplyDate!,
                          ).latestInvoiceDate(_supplyDate!),
                        ),
                      ),
                      tone: NoticeTone.warning,
                    ),
                  ],
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
                    validator: (t) => client == null
                        ? _korError(t, l)
                        : !t.fitsCountry(client.country)
                        ? l.invoiceValidateTreatmentCountry
                        : !t.fitsClient(client)
                        ? l.invoiceValidateTreatmentConsumer
                        : _korError(t, l),
                  ),
                  if (_isEditable &&
                      client != null &&
                      client.isEuConsumerAbroad &&
                      _treatment == VatTreatment.standard) ...[
                    const SizedBox(height: AppSpacing.field),
                    _euConsumerNotice(allClients, l),
                  ],
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
                  SectionLabel(l.invoiceFieldLines),
                  const SizedBox(height: AppSpacing.heading),
                  for (var i = 0; i < _lines.length; i++) _lineRow(i, l),
                  // An issued invoice keeps its lines.
                  if (_isEditable) ...[
                    const SizedBox(height: AppSpacing.heading),
                    TextButton.icon(
                      icon: const Icon(Icons.add, size: 16),
                      label: Text(l.invoiceFieldAddLine),
                      onPressed: () => setState(() => _lines.add(_LineItem())),
                    ),
                  ],
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
                            FormErrorText(
                              validator: () => _creditLimitError(l),
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
          // Outside the locked form: a customer's document can be added to a
          // recorded self-billed invoice; an issued PDF is shown read-only.
          if (_selfBilled || (_original?.isIssued ?? false)) ...[
            const SizedBox(height: AppSpacing.section),
            ReceiptsSection(
              owner: _isNew ? null : ReceiptOwner.invoice(_original!.id),
              draft: _receiptDraft,
              year: _invoiceDate.year,
              title: l.receiptsInvoiceTitle,
              help: l.receiptsInvoiceHelp,
              keepUntil: AppFormat.date(_rules.keepUntil(_invoiceDate.year)),
              editable: _selfBilled,
            ),
          ],
        ],
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
          _treatment.lineRates.isNotEmpty
              ? EnumDropdown(
                  label: l.invoiceFieldVat,
                  help: _treatment == VatTreatment.reverseChargeNl
                      ? l.invoiceFieldVatReverseHelp
                      : l.invoiceFieldVatHelp,
                  // A rate that does not fit the treatment must be chosen
                  // again, so nothing hidden stays set.
                  value: _treatment.lineRates.contains(line.vatRate)
                      ? line.vatRate
                      : null,
                  values: _treatment.lineRates,
                  requiredMessage: l.invoiceValidateLineRate,
                  labelOf: (r) => r.label(l, _rules),
                  onChanged: (r) => setState(() => line.vatRate = r),
                  required: true,
                )
              : ReadOnlyField(
                  label: l.invoiceFieldVat,
                  help: l.invoiceFieldVatHelp,
                  value: _treatment.lineLabel(l),
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
              // Kept in place when hidden, so amounts line up with the fields.
              Visibility.maintain(
                visible: _isEditable,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  tooltip: l.invoiceRemoveLine,
                  color: Theme.of(context).colorScheme.error,
                  onPressed: _lines.length > 1
                      ? () => setState(() => _lines.removeAt(i).dispose())
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
