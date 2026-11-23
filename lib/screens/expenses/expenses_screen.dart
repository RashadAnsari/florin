import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../widgets/validators.dart';
import '../../widgets/form_error_text.dart';
import '../../services/kor_service.dart';
import '../../services/receipt_service.dart';
import '../receipts/receipts_section.dart';
import '../../services/formats.dart';
import '../../widgets/help.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../l10n/labels.dart';
import '../../providers/providers.dart';
import '../../services/domain.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/amount_field.dart';
import '../../widgets/business_use_slider.dart';
import '../../widgets/car_picker.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/date_field.dart';
import '../../widgets/detail_scaffold.dart';
import '../../widgets/enum_dropdown.dart';
import '../../widgets/feedback.dart';
import '../../widgets/form_row.dart';
import '../../widgets/list_scaffold.dart';
import '../../widgets/notice_banner.dart';
import '../../widgets/quarter_chips.dart';
import '../../widgets/value_row.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  int? _quarter;
  ExpenseCategory? _category;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final withFiles = {
      for (final r in ref.watch(allReceiptsProvider).valueOrNull ?? const [])
        ?r.expenseId,
    };
    final expenses = ref
        .watch(expensesProvider(year))
        .whenData(
          (all) => all
              .where(
                (e) =>
                    (_quarter == null || quarterOf(e.date) == _quarter) &&
                    (_category == null || e.category == _category),
              )
              .toList(),
        );

    return ListScaffold<Expense>(
      title: l.expensesTitle,
      addTooltip: l.expensesNewTooltip,
      onAdd: () => context.push('/expenses/new'),
      items: expenses,
      emptyText: l.expensesNone,
      controls: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<ExpenseCategory?>(
            style: fieldTextStyle(context),
            initialValue: _category,
            isExpanded: true,
            decoration: fieldDecoration(
              label: l.labelCategory,
              help: l.labelCategoryHelp,
            ),
            items: [
              DropdownMenuItem(value: null, child: Text(l.labelAll)),
              for (final c in ExpenseCategory.values)
                DropdownMenuItem(value: c, child: Text(c.label(l))),
            ],
            onChanged: (c) => setState(() => _category = c),
          ),
          const SizedBox(height: AppSpacing.heading),
          QuarterChips(
            selected: _quarter,
            onSelected: (q) => setState(() => _quarter = q),
          ),
        ],
      ),
      itemBuilder: (context, e) => _ExpenseTile(
        expense: e,
        hasFiles: withFiles.contains(e.id),
        onTap: () => context.push('/expenses/${e.id}', extra: e),
      ),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  /// Whether receipt files are stored for this expense.
  final bool hasFiles;

  const _ExpenseTile({
    required this.expense,
    required this.hasFiles,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return ListTile(
      onTap: onTap,
      title: EllipsisText(expense.supplier),
      subtitle: EllipsisText(
        '${AppFormat.date(expense.date)}  ${expense.category.label(l)}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // An icon with a tooltip, so the proof shows without colour.
          if (hasFiles)
            Tooltip(
              message: l.expensesHasFiles,
              child: const Icon(Icons.attach_file, size: 16),
            )
          else if (expense.paperOriginalKept)
            Tooltip(
              message: l.expensesPaperOnly,
              child: const Icon(Icons.receipt_long, size: 16),
            ),
          const SizedBox(width: AppSpacing.heading),
          Text(AppFormat.cents(expense.totalInclVat)),
        ],
      ),
    );
  }
}

class ExpenseDetailPage extends ConsumerStatefulWidget {
  final Expense? expense;

  const ExpenseDetailPage({super.key, this.expense});

  @override
  ConsumerState<ExpenseDetailPage> createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends ConsumerState<ExpenseDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late final _supplier = TextEditingController(text: widget.expense?.supplier);
  late final _description = TextEditingController(
    text: widget.expense?.description,
  );
  late final _paidFrom = TextEditingController(text: widget.expense?.paidFrom);
  late final _paymentRef = TextEditingController(
    text: widget.expense?.paymentReference,
  );
  late final _notes = TextEditingController(text: widget.expense?.notes);

  late DateTime _date =
      widget.expense?.date ?? todayIn(ref.read(fiscalYearProvider));
  late ExpenseCategory? _category = widget.expense?.category;
  late VatRate _vatRate = widget.expense?.vatRate ?? VatRate.high;
  late PurchaseVat _purchaseVat =
      widget.expense?.purchaseVat ?? PurchaseVat.domestic;

  /// Shifted BTW is not paid to the supplier.
  bool get _shifted => _purchaseVat != PurchaseVat.domestic;
  late int _amountExclVat = widget.expense?.amountExclVat ?? 0;
  late double _businessUsePct = widget.expense?.businessUsePct ?? 1.0;
  late bool _vatReclaimable = widget.expense?.vatReclaimable ?? true;
  late bool _paperOriginalKept = widget.expense?.paperOriginalKept ?? false;
  final _receiptDraft = ReceiptDraft();
  late int? _carAssetId = widget.expense?.carAssetId;

  int get _vatAmount => _vatRate.vatOn(_amountExclVat);

  int get _deductibleAmount => ExpenseMath.deductible(
    amountExclVat: _amountExclVat,
    vatAmount: _vatAmount,
    businessUsePct: _businessUsePct,
    vatReclaimable: _vatReclaimable,
  );

  int get _vatToReclaim => ExpenseMath.vatToReclaim(
    vatAmount: _vatAmount,
    businessUsePct: _businessUsePct,
    vatReclaimable: _vatReclaimable,
  );

  @override
  void dispose() {
    for (final c in [_supplier, _description, _paidFrom, _paymentRef, _notes]) {
      c.dispose();
    }
    _receiptDraft.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final receipts = ref.read(receiptServiceProvider);
    final saved = await guardSave(context, () async {
      final id = await ref
          .read(expenseDaoProvider)
          .save(
            ExpensesCompanion(
              id: widget.expense == null
                  ? const Value.absent()
                  : Value(widget.expense!.id),
              date: Value(_date),
              supplier: Value(_supplier.text.trim()),
              description: Value(_description.text.trim()),
              category: Value(_category!),
              paperOriginalKept: Value(_paperOriginalKept),
              amountExclVat: Value(_amountExclVat),
              vatRate: Value(_vatRate),
              purchaseVat: Value(_purchaseVat),
              vatAmount: Value(_vatAmount),
              totalInclVat: Value(_amountExclVat + (_shifted ? 0 : _vatAmount)),
              businessUsePct: Value(_businessUsePct),
              deductibleAmount: Value(_deductibleAmount),
              vatReclaimable: Value(_vatReclaimable),
              vatToReclaim: Value(_vatToReclaim),
              notes: Value(optionalText(_notes.text)),
              paidFrom: Value(optionalText(_paidFrom.text)),
              paymentReference: Value(optionalText(_paymentRef.text)),
              carAssetId: Value(_carAssetId),
            ),
          );
      final owner = ReceiptOwner.expense(widget.expense?.id ?? id);
      // Files follow the expense into the folder of its year.
      await receipts.relocateFor(owner, _date.year);
      await _receiptDraft.commit(receipts, owner, _date.year);
    });
    if (saved && mounted) context.pop();
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.expensesDeleteTitle,
      message: l.expensesDeleteMessage,
      isDestructive: true,
      confirmLabel: l.actionDelete,
    );
    if (!confirmed || !mounted) return;
    final deleted = await guardSave(context, () async {
      await ref
          .read(receiptServiceProvider)
          .removeAllFor(ReceiptOwner.expense(widget.expense!.id));
      await ref.read(expenseDaoProvider).remove(widget.expense!);
    });
    if (deleted && mounted) context.pop();
  }

  bool get _korApplies =>
      (ref.read(korStatusProvider).valueOrNull ?? KorStatus.none).appliesOn(
        _date,
      );

  /// Under the KOR no BTW is deducted (Wet OB 1968 art. 25a lid 4).
  void _setDate(DateTime d) => setState(() {
    _date = d;
    if (_korApplies) _vatReclaimable = false;
  });

  void _setCategory(ExpenseCategory c) => setState(() {
    if (c == ExpenseCategory.foodAndRepresentation &&
        _category != ExpenseCategory.foodAndRepresentation) {
      _vatReclaimable = false;
    }
    _category = c;
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    ref.watch(korStatusProvider);
    return DetailScaffold(
      title: widget.expense == null
          ? l.expensesNewHeader
          : widget.expense!.supplier,
      onBack: () => context.pop(),
      onDelete: widget.expense == null ? null : _delete,
      onSave: _save,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormRow(
              flex: const [1, 2],
              children: [
                DateField(
                  label: l.labelDate,
                  help: l.labelDateHelp,
                  value: _date,
                  onChanged: _setDate,
                  required: true,
                ),
                EnumDropdown(
                  label: l.expensesFieldCategory,
                  help: l.expensesFieldCategoryHelp,
                  value: _category,
                  values: ExpenseCategory.values,
                  labelOf: (c) => c.label(l),
                  onChanged: _setCategory,
                  requiredMessage: l.expensesValidateCategory,
                  required: true,
                ),
              ],
            ),
            if (_korApplies) ...[
              const SizedBox(height: AppSpacing.field),
              NoticeBanner(l.expensesKorNotice),
            ],
            if (_category == ExpenseCategory.foodAndRepresentation) ...[
              const SizedBox(height: AppSpacing.field),
              NoticeBanner(l.expensesFoodNotice),
            ],
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                TextFormField(
                  controller: _supplier,
                  decoration: fieldDecoration(
                    label: l.expensesFieldSupplier,
                    help: l.expensesFieldSupplierHelp,
                    required: true,
                    hintText: l.expensesHintSupplier,
                  ),
                  validator: (v) =>
                      Validate.required(v, l.expensesValidateSupplier),
                ),
                TextFormField(
                  controller: _description,
                  decoration: fieldDecoration(
                    label: l.expensesFieldDescription,
                    help: l.expensesFieldDescriptionHelp,
                    required: true,
                  ),
                  validator: (v) =>
                      Validate.required(v, l.expensesValidateDescription),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                AmountField(
                  label: l.expensesFieldAmountExcl,
                  help: l.expensesFieldAmountExclHelp,
                  initialValueCents: _amountExclVat,
                  required: true,
                  positive: true,
                  validatorMessage: l.expensesValidateAmount,
                  onChanged: (v) => setState(() => _amountExclVat = v),
                ),
                EnumDropdown(
                  label: l.expensesFieldVatRate,
                  help: l.expensesFieldVatRateHelp,
                  value: _vatRate,
                  values: VatRate.values,
                  labelOf: (r) => r.label(l),
                  onChanged: (r) => setState(() => _vatRate = r),
                  required: true,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            EnumDropdown<PurchaseVat>(
              label: l.expensesFieldPurchaseVat,
              help: l.expensesFieldPurchaseVatHelp,
              required: true,
              value: _purchaseVat,
              values: PurchaseVat.values,
              labelOf: (p) => p.label(l),
              onChanged: (p) => setState(() => _purchaseVat = p),
            ),
            const SizedBox(height: AppSpacing.field),
            ValueRow(
              label: l.expensesFieldVat,
              value: AppFormat.cents(_vatAmount),
            ),
            ValueRow(
              label: l.expensesFieldTotalIncl,
              value: AppFormat.cents(
                _amountExclVat + (_shifted ? 0 : _vatAmount),
              ),
              bold: true,
            ),
            const SizedBox(height: AppSpacing.section),
            BusinessUseSlider(
              value: _businessUsePct,
              onChanged: (v) => setState(() => _businessUsePct = v),
            ),
            ValueRow(
              label: l.expensesDeductible,
              value: AppFormat.cents(_deductibleAmount),
            ),
            ValueRow(
              label: l.expensesVatBack,
              value: AppFormat.cents(_vatToReclaim),
            ),
            const SizedBox(height: AppSpacing.field),
            HelpCheckbox(
              value: _vatReclaimable,
              onChanged: (v) => setState(() => _vatReclaimable = v),
              title: l.expensesReclaimVat,
              help: l.expensesReclaimVatHelp,
            ),
            FormErrorText(
              validator: () => _korApplies && _vatReclaimable
                  ? l.expensesValidateKorReclaim
                  : null,
            ),
            if ((ref.watch(allAssetsProvider).valueOrNull ??
                    const <FixedAsset>[])
                .any((a) => a.kind == AssetKind.car)) ...[
              const SizedBox(height: AppSpacing.field),
              carPicker(
                l: l,
                assets: ref.watch(allAssetsProvider).valueOrNull ?? const [],
                value: _carAssetId,
                label: l.expensesFieldCar,
                help: l.expensesFieldCarHelp,
                noneLabel: l.expensesNoCar,
                onChanged: (v) => setState(() => _carAssetId = v),
              ),
            ],
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                TextFormField(
                  controller: _paidFrom,
                  decoration: fieldDecoration(
                    label: l.expensesFieldPaidFrom,
                    help: l.expensesFieldPaidFromHelp,
                    hintText: l.expensesHintPaidFrom,
                  ),
                ),
                TextFormField(
                  controller: _paymentRef,
                  decoration: fieldDecoration(
                    label: l.expensesFieldPaymentRef,
                    help: l.expensesFieldPaymentRefHelp,
                    hintText: l.expensesHintPaymentRef,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _notes,
              decoration: fieldDecoration(
                label: l.labelNotes,
                help: l.labelNotesHelp,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.section),
            ReceiptsSection(
              owner: widget.expense == null
                  ? null
                  : ReceiptOwner.expense(widget.expense!.id),
              draft: _receiptDraft,
              year: _date.year,
              title: l.receiptsTitle,
              help: l.receiptsHelp,
              keepUntil: AppFormat.date(ReceiptService.keepUntil(_date.year)),
            ),
            const SizedBox(height: AppSpacing.field),
            HelpCheckbox(
              value: _paperOriginalKept,
              onChanged: (v) => setState(() => _paperOriginalKept = v),
              title: l.expensesPaperOriginalKept,
              help: l.expensesPaperOriginalKeptHelp,
            ),
          ],
        ),
      ),
    );
  }
}
