import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../widgets/validators.dart';
import '../../services/formats.dart';
import '../../widgets/help.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../l10n/labels.dart';
import '../../services/asset_service.dart';
import '../../services/receipt_service.dart';
import '../receipts/receipts_section.dart';
import '../../services/tax_rules/tax_year_rules.dart';
import '../../widgets/enum_dropdown.dart';
import '../../widgets/value_row.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/amount_field.dart';
import '../../widgets/business_use_slider.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/date_field.dart';
import '../../widgets/detail_scaffold.dart';
import '../../widgets/feedback.dart';
import '../../widgets/form_row.dart';
import '../../widgets/list_scaffold.dart';
import '../../widgets/summary_bar.dart';
import '../../widgets/tone_badge.dart';

class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final year = ref.watch(fiscalYearProvider);
    final assets = ref.watch(assetsProvider(year));
    final rules = ref.watch(taxRulesProvider(year));
    final list = assets.valueOrNull ?? const <FixedAsset>[];

    return ListScaffold<FixedAsset>(
      title: l.assetsTitle,
      addTooltip: l.assetsNewAsset,
      onAdd: () => context.push('/assets/new'),
      items: assets,
      emptyText: l.assetsNone,
      controls: SummaryBar([
        SummaryStat(
          l.assetsKiaInvestments,
          AppFormat.cents(AssetService.kiaInvestments(list, year, rules)),
        ),
        SummaryStat(
          l.assetsKiaDeduction,
          AppFormat.cents(
            rules.kia.valueFor(AssetService.kiaInvestments(list, year, rules)),
          ),
          color: context.colors.income,
        ),
        SummaryStat(
          l.assetsDepreciationThisYear,
          AppFormat.cents(AssetService.totalDepreciation(list, year)),
        ),
      ]),
      itemBuilder: (context, a) {
        final disposed = a.disposalDate != null;
        return ListTile(
          title: EllipsisText(a.assetName),
          subtitle: EllipsisText(
            '${AppFormat.cents(a.costExclVat)}  '
            '${l.assetsYears(a.usefulLifeYears)}',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (disposed) ...[
                ToneBadge(
                  label: l.assetsSoldBadge,
                  color: theme.colorScheme.outline,
                ),
                const SizedBox(width: AppSpacing.heading),
              ],
              if (a.kiaEligible && a.purchaseDate.year == year) ...[
                ToneBadge(
                  label: l.assetsKiaBadge,
                  color: context.colors.income,
                ),
                const SizedBox(width: AppSpacing.heading),
              ],
              Tooltip(
                message: l.assetsBookValueTooltip(year),
                child: Text(AppFormat.cents(AssetService.bookValue(a, year))),
              ),
            ],
          ),
          onTap: () => context.push('/assets/${a.id}', extra: a),
        );
      },
    );
  }
}

class AssetDetailPage extends ConsumerStatefulWidget {
  final FixedAsset? asset;

  const AssetDetailPage({super.key, this.asset});

  @override
  ConsumerState<AssetDetailPage> createState() => _AssetDetailPageState();
}

class _AssetDetailPageState extends ConsumerState<AssetDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.asset?.assetName);
  late final _notes = TextEditingController(text: widget.asset?.notes);
  late final _usefulLife = TextEditingController(
    text: '${widget.asset?.usefulLifeYears ?? AssetService.minUsefulLifeYears}',
  );
  late DateTime _purchaseDate = widget.asset?.purchaseDate ?? DateTime.now();
  late int _costExclVat = widget.asset?.costExclVat ?? 0;
  late int _residualValue = widget.asset?.residualValue ?? 0;
  late double _businessUsePct = widget.asset?.businessUsePct ?? 1.0;
  late bool _kiaEligible = widget.asset?.kiaEligible ?? false;
  late DateTime? _disposalDate = widget.asset?.disposalDate;
  late int _disposalProceeds = widget.asset?.disposalProceeds ?? 0;
  late AssetKind _kind = widget.asset?.kind ?? AssetKind.general;
  late bool _eiaEligible = widget.asset?.eiaEligible ?? false;
  late MiaCategory? _miaCategory = widget.asset?.miaCategory;
  late int? _deductionReceived = widget.asset?.investmentDeductionReceived;
  late int _reserveApplied = widget.asset?.reinvestmentReserveApplied ?? 0;
  late bool _reserveGain = widget.asset?.reserveGain ?? false;
  late int? _catalogueValue = widget.asset?.catalogueValue;
  late DateTime? _firstRegistration = widget.asset?.firstRegistration;
  late ZeroEmission _zeroEmission =
      widget.asset?.zeroEmission ?? ZeroEmission.none;
  late int? _marketValue = widget.asset?.marketValue;
  late bool _keepsTripLog = widget.asset?.keepsTripLog ?? false;
  late int _vatOnPurchase = widget.asset?.vatDeductedOnPurchase ?? 0;

  bool get _isCar => _kind == AssetKind.car;

  /// The purchase year has no rules in Florin, so the deduction received
  /// there is entered rather than computed.
  bool get _needsDeductionInput =>
      taxRulesFor(_purchaseDate.year) == null &&
      (_kiaEligible || _eiaEligible || _miaCategory != null);

  /// Herinvesteringsreserve available when this asset was bought.
  int _availableReserve(List<FixedAsset> all) {
    final others = all.where((a) => a.id != widget.asset?.id).toList();
    final before = AssetService.reserveLedger(
      others,
      _purchaseDate.year - 1,
    )[_purchaseDate.year - 1];
    final formedThisYear =
        AssetService.reserveLedger(
          others,
          _purchaseDate.year,
        )[_purchaseDate.year]?.formed ??
        0;
    return (before?.balance ?? 0) + formedThisYear;
  }

  final _receiptDraft = ReceiptDraft();

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    _usefulLife.dispose();
    _receiptDraft.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final receipts = ref.read(receiptServiceProvider);
    final saved = await guardSave(context, () async {
      final id = await ref
          .read(assetDaoProvider)
          .save(
            FixedAssetsCompanion(
              id: widget.asset == null
                  ? const Value.absent()
                  : Value(widget.asset!.id),
              kind: Value(_kind),
              assetName: Value(_name.text.trim()),
              costExclVat: Value(_costExclVat),
              residualValue: Value(_residualValue),
              purchaseDate: Value(_purchaseDate),
              businessUsePct: Value(_businessUsePct),
              usefulLifeYears: Value(parseWholeNumber(_usefulLife.text)!),
              kiaEligible: Value(!_isCar && _kiaEligible),
              eiaEligible: Value(_eiaEligible),
              miaCategory: Value(_eiaEligible ? null : _miaCategory),
              investmentDeductionReceived: Value(
                _needsDeductionInput ? _deductionReceived : null,
              ),
              reinvestmentReserveApplied: Value(_reserveApplied),
              reserveGain: Value(_disposalDate != null && _reserveGain),
              catalogueValue: Value(_isCar ? _catalogueValue : null),
              firstRegistration: Value(_isCar ? _firstRegistration : null),
              zeroEmission: Value(_isCar ? _zeroEmission : ZeroEmission.none),
              marketValue: Value(_isCar ? _marketValue : null),
              keepsTripLog: Value(_isCar && _keepsTripLog),
              vatDeductedOnPurchase: Value(_isCar ? _vatOnPurchase : 0),
              notes: Value(optionalText(_notes.text)),
              disposalDate: Value(_disposalDate),
              disposalProceeds: Value(
                _disposalDate == null ? null : _disposalProceeds,
              ),
            ),
          );
      // Files of an asset sit in the folder of its purchase year.
      final owner = ReceiptOwner.asset(widget.asset?.id ?? id);
      await receipts.relocateFor(owner, _purchaseDate.year);
      await _receiptDraft.commit(receipts, owner, _purchaseDate.year);
    });
    if (saved && mounted) context.pop();
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.assetsDeleteTitle,
      message: l.assetsDeleteMessage(widget.asset!.assetName),
      isDestructive: true,
      confirmLabel: l.actionDelete,
    );
    if (!confirmed || !mounted) return;
    final deleted = await guardSave(context, () async {
      await ref
          .read(receiptServiceProvider)
          .removeAllFor(ReceiptOwner.asset(widget.asset!.id));
      await ref.read(assetDaoProvider).remove(widget.asset!);
    });
    if (deleted && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return DetailScaffold(
      title: widget.asset == null ? l.assetsNewAsset : widget.asset!.assetName,
      onBack: () => context.pop(),
      onDelete: widget.asset == null ? null : _delete,
      onSave: _save,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EnumDropdown<AssetKind>(
              label: l.assetsFieldKind,
              help: l.assetsFieldKindHelp,
              required: true,
              value: _kind,
              values: AssetKind.values,
              labelOf: (k) => k.label(l),
              onChanged: (k) => setState(() => _kind = k),
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _name,
              decoration: fieldDecoration(
                label: l.assetsFieldName,
                help: l.assetsFieldNameHelp,
                required: true,
              ),
              validator: (v) => Validate.required(v, l.assetsValidateName),
            ),
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                AmountField(
                  label: l.assetsFieldCost,
                  help: l.assetsFieldCostHelp,
                  initialValueCents: _costExclVat,
                  required: true,
                  positive: true,
                  validatorMessage: l.assetsValidateCost,
                  onChanged: (v) => setState(() => _costExclVat = v),
                ),
                DateField(
                  label: l.assetsFieldPurchaseDate,
                  help: l.assetsFieldPurchaseDateHelp,
                  value: _purchaseDate,
                  firstDate: DateTime(1990),
                  onChanged: (d) => setState(() => _purchaseDate = d),
                  required: true,
                ),
                TextFormField(
                  controller: _usefulLife,
                  decoration: fieldDecoration(
                    label: l.assetsFieldUsefulLife,
                    help: l.assetsFieldUsefulLifeHelp,
                    required: true,
                    suffixText: l.assetsFieldUsefulLifeUnit,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => Validate.wholeNumber(
                    v,
                    l.assetsFieldUsefulLifeMin(AssetService.minUsefulLifeYears),
                    min: AssetService.minUsefulLifeYears,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                AmountField(
                  label: l.assetsFieldResidualValue,
                  help: l.assetsFieldResidualValueHelp,
                  initialValueCents: _residualValue,
                  required: true,
                  validatorMessage: l.assetsValidateResidualValue,
                  check: (v) => v > _costExclVat
                      ? l.assetsValidateResidualAboveCost
                      : null,
                  onChanged: (v) => setState(() => _residualValue = v),
                ),
                const SizedBox.shrink(),
                const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: AppSpacing.group),
            BusinessUseSlider(
              value: _businessUsePct,
              onChanged: (v) => setState(() => _businessUsePct = v),
            ),
            if (_isCar) ...[
              const SizedBox(height: AppSpacing.section),
              SectionLabel(l.assetsCarSection, help: l.assetsCarSectionHelp),
              const SizedBox(height: AppSpacing.heading),
              FormRow(
                children: [
                  AmountField(
                    label: l.assetsFieldCatalogueValue,
                    help: l.assetsFieldCatalogueValueHelp,
                    initialValueCents: _catalogueValue,
                    required: true,
                    positive: true,
                    validatorMessage: l.assetsValidateCatalogueValue,
                    onChanged: (v) => setState(() => _catalogueValue = v),
                  ),
                  DateField(
                    label: l.assetsFieldFirstRegistration,
                    help: l.assetsFieldFirstRegistrationHelp,
                    required: true,
                    value: _firstRegistration,
                    firstDate: DateTime(1950),
                    validator: (_) => _firstRegistration == null
                        ? l.assetsValidateFirstRegistration
                        : null,
                    onChanged: (d) => setState(() => _firstRegistration = d),
                  ),
                  EnumDropdown<ZeroEmission>(
                    label: l.assetsFieldZeroEmission,
                    help: l.assetsFieldZeroEmissionHelp,
                    required: true,
                    value: _zeroEmission,
                    values: ZeroEmission.values,
                    labelOf: (z) => z.label(l),
                    onChanged: (z) => setState(() => _zeroEmission = z),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.field),
              FormRow(
                children: [
                  AmountField(
                    label: l.assetsFieldVatOnPurchase,
                    help: l.assetsFieldVatOnPurchaseHelp,
                    initialValueCents: _vatOnPurchase,
                    onChanged: (v) => setState(() => _vatOnPurchase = v),
                  ),
                  AmountField(
                    label: l.assetsFieldMarketValue,
                    help: l.assetsFieldMarketValueHelp,
                    initialValueCents: _marketValue,
                    onChanged: (v) => setState(() => _marketValue = v),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.field),
              HelpCheckbox(
                value: _keepsTripLog,
                onChanged: (v) => setState(() => _keepsTripLog = v),
                title: l.assetsFieldTripLog,
                help: l.assetsFieldTripLogHelp,
              ),
            ],
            const SizedBox(height: AppSpacing.section),
            SectionLabel(
              l.assetsInvestmentSection,
              help: l.assetsInvestmentSectionHelp,
            ),
            const SizedBox(height: AppSpacing.heading),
            if (!_isCar)
              HelpCheckbox(
                value: _kiaEligible,
                onChanged: (v) => setState(() => _kiaEligible = v),
                title: l.assetsFieldKia,
                help: l.assetsFieldKiaHelp,
              ),
            HelpCheckbox(
              value: _eiaEligible,
              onChanged: (v) => setState(() {
                _eiaEligible = v;
                if (v) _miaCategory = null;
              }),
              title: l.assetsFieldEia,
              help: l.assetsFieldEiaHelp,
            ),
            const SizedBox(height: AppSpacing.field),
            DropdownButtonFormField<MiaCategory?>(
              style: fieldTextStyle(context),
              initialValue: _miaCategory,
              isExpanded: true,
              decoration: fieldDecoration(
                label: l.assetsFieldMia,
                help: l.assetsFieldMiaHelp,
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(l.assetsMiaNone)),
                for (final c in MiaCategory.values)
                  DropdownMenuItem(value: c, child: Text(c.label(l))),
              ],
              onChanged: _eiaEligible
                  ? null
                  : (c) => setState(() => _miaCategory = c),
            ),
            if (_needsDeductionInput) ...[
              const SizedBox(height: AppSpacing.field),
              AmountField(
                label: l.assetsFieldDeductionReceived,
                help: l.assetsFieldDeductionReceivedHelp,
                initialValueCents: _deductionReceived,
                required: true,
                validatorMessage: l.assetsValidateDeductionReceived,
                onChanged: (v) => setState(() => _deductionReceived = v),
              ),
            ],
            const SizedBox(height: AppSpacing.field),
            AmountField(
              label: l.assetsFieldReserveApplied,
              help: l.assetsFieldReserveAppliedHelp,
              helperText: l.assetsReserveAvailable(
                AppFormat.cents(
                  _availableReserve(
                    ref.watch(allAssetsProvider).valueOrNull ?? const [],
                  ),
                ),
              ),
              initialValueCents: _reserveApplied,
              check: (v) {
                final all = ref.read(allAssetsProvider).valueOrNull ?? const [];
                if (v > _availableReserve(all)) {
                  return l.assetsValidateReserveAboveAvailable;
                }
                if (v > _costExclVat - _residualValue) {
                  return l.assetsValidateReserveAboveCost;
                }
                return null;
              },
              onChanged: (v) => setState(() => _reserveApplied = v),
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _notes,
              decoration: fieldDecoration(
                label: l.assetsFieldNotes,
                help: l.assetsFieldNotesHelp,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.section),
            SectionLabel(l.assetsDisposal),
            const SizedBox(height: AppSpacing.heading),
            FormRow(
              children: [
                DateField(
                  label: l.assetsFieldDisposalDate,
                  help: l.assetsFieldDisposalDateHelp,
                  value: _disposalDate,
                  // A sale is booked in a supported year, after the purchase.
                  firstDate:
                      _purchaseDate.isAfter(DateTime(supportedYears.first))
                      ? _purchaseDate
                      : DateTime(supportedYears.first),
                  validator: (_) =>
                      _disposalDate != null &&
                          _disposalDate!.isBefore(_purchaseDate)
                      ? l.assetsValidateDisposalBeforePurchase
                      : null,
                  onChanged: (d) => setState(() => _disposalDate = d),
                ),
                if (_disposalDate != null)
                  AmountField(
                    label: l.assetsFieldDisposalProceeds,
                    help: l.assetsFieldDisposalProceedsHelp,
                    initialValueCents: _disposalProceeds,
                    onChanged: (v) => setState(() => _disposalProceeds = v),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
            if (_disposalDate != null) ...[
              const SizedBox(height: AppSpacing.field),
              HelpCheckbox(
                value: _reserveGain,
                onChanged: (v) => setState(() => _reserveGain = v),
                title: l.assetsFieldReserveGain,
                help: l.assetsFieldReserveGainHelp,
              ),
            ],
            if (_disposalDate != null) ...[
              const SizedBox(height: AppSpacing.heading),
              TextButton.icon(
                onPressed: () => setState(() => _disposalDate = null),
                icon: const Icon(Icons.clear, size: 16),
                label: Text(l.assetsClearDisposalDate),
              ),
            ],
            const SizedBox(height: AppSpacing.section),
            ReceiptsSection(
              owner: widget.asset == null
                  ? null
                  : ReceiptOwner.asset(widget.asset!.id),
              draft: _receiptDraft,
              year: _purchaseDate.year,
              title: l.receiptsAssetTitle,
              help: l.receiptsAssetHelp,
              // The purchase invoice stays current while the asset is used.
              keepUntil: _disposalDate == null
                  ? l.receiptsKeepWhileInUse
                  : AppFormat.date(
                      ReceiptService.keepUntil(_disposalDate!.year),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
