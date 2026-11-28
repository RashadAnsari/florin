import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../mileage/mileage_screen.dart';
import '../../services/car_service.dart';
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
import '../../services/domain.dart';
import '../../services/kor_service.dart';
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
import '../../widgets/form_error_text.dart';
import '../../widgets/form_row.dart';
import '../../widgets/list_scaffold.dart';
import '../../widgets/notice_banner.dart';
import '../../widgets/summary_bar.dart';
import '../../widgets/tone_badge.dart';

class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final year = ref.watch(fiscalYearProvider);
    final assets = ref.watch(assetsInUseProvider(year));
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
          AppFormat.cents(AssetService.totalDepreciation(list, year, rules)),
        ),
      ]),
      itemBuilder: (context, a) {
        final disposed = a.disposalDate != null;
        return ListTile(
          title: EllipsisText(a.assetName),
          subtitle: EllipsisText(
            '${AppFormat.cents(a.cost)}  '
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
                child: Text(
                  AppFormat.cents(AssetService.bookValue(a, year, rules)),
                ),
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
    text: widget.asset == null ? '' : '${widget.asset!.usefulLifeYears}',
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
  // A new asset starts at the general rate; a stored one without a rate
  // (bought in a year without rules, or saved before rates were asked)
  // keeps none until the user picks one.
  late VatRate? _vatRate = widget.asset == null
      ? VatRate.high
      : widget.asset!.vatRate;
  late PurchaseVat _purchaseVat =
      widget.asset?.purchaseVat ?? PurchaseVat.domestic;
  late int _enteredVat = widget.asset?.vatAmount ?? 0;
  late bool _vatReclaimable =
      widget.asset?.vatReclaimable ?? !_kor.appliesOn(_purchaseDate);
  late int? _saleInvoiceId = widget.asset?.disposalInvoiceId;
  late VatRate? _disposalVatRate = widget.asset?.disposalVatRate;

  bool get _isCar => _kind == AssetKind.car;

  /// A car counts in full: the bijtelling and the BTW on private use correct
  /// its private use (`docs/legal.md`).
  double get _share => _isCar ? 1.0 : _businessUsePct;

  KorStatus get _kor =>
      ref.read(korStatusProvider).valueOrNull ?? KorStatus.none;

  bool get _korOnPurchase => _kor.appliesOn(_purchaseDate);

  /// The rules of the purchase year, which set the BTW rate; null for a year
  /// before Florin's first, when the BTW amount is entered.
  TaxYearRules? get _purchaseRules => taxRulesFor(_purchaseDate.year);

  int get _vatAmount {
    final rules = _purchaseRules;
    if (rules == null) return _enteredVat;
    return _vatRate == null ? 0 : rules.vatOn(_vatRate!, _costExclVat);
  }

  int get _vatToReclaim => PurchaseMath.vatToReclaim(
    vatAmount: _vatAmount,
    businessUsePct: _share,
    vatReclaimable: _vatReclaimable,
  );

  int get _cost => PurchaseMath.cost(
    amountExclVat: _costExclVat,
    vatAmount: _vatAmount,
    vatReclaimable: _vatReclaimable,
  );

  List<Invoice> get _invoices =>
      ref.read(allInvoicesProvider).valueOrNull ?? const [];

  int get _proceeds => _saleInvoiceId == null
      ? _disposalProceeds
      : AssetService.invoicedProceeds(_saleInvoiceId!, _invoices);

  /// A sale without an invoice in Florin carries its BTW on the asset,
  /// unless the KOR exempts it.
  bool get _chargesSaleVat =>
      _disposalDate != null &&
      _saleInvoiceId == null &&
      !_kor.appliesOn(_disposalDate!);

  // A sale lies in a supported year, so its rules exist.
  int get _saleVat => _chargesSaleVat && _disposalVatRate != null
      ? taxRulesFor(
          _disposalDate!.year,
        )!.vatOn(_disposalVatRate!, PurchaseMath.share(_proceeds, _share))
      : 0;

  /// Issued invoices that can be this asset's sale invoice: not a credit
  /// note and not the sale invoice of another asset.
  List<Invoice> _saleInvoiceChoices(List<FixedAsset> all) {
    final taken = AssetService.saleInvoiceIds(
      all.where((a) => a.id != widget.asset?.id),
    );
    return _invoices
        .where(
          (i) =>
              i.isIssued &&
              !i.isCreditNote &&
              (!taken.contains(i.id) || i.id == _saleInvoiceId),
        )
        .toList()
      ..sort((a, b) => b.invoiceDate.compareTo(a.invoiceDate));
  }

  void _setPurchaseDate(DateTime d) => setState(() {
    _purchaseDate = d;
    // Under the KOR no BTW is deducted (Wet OB 1968 art. 25a lid 4).
    if (_korOnPurchase) _vatReclaimable = false;
    if (_purchaseRules != null) _vatRate ??= VatRate.high;
  });

  void _setDisposalDate(DateTime d) => setState(() {
    _disposalDate = d;
    _disposalVatRate ??= VatRate.high;
  });

  /// The rules of the selected year, which set the depreciation limits.
  TaxYearRules get _rules =>
      ref.read(taxRulesProvider(ref.read(fiscalYearProvider)));

  /// The purchase year has no rules in Florin, so the deduction received
  /// there is entered rather than computed.
  bool get _needsDeductionInput =>
      taxRulesFor(_purchaseDate.year) == null &&
      (!_isCar && (_kiaEligible || _eiaEligible) || _miaCategory != null);

  /// Herinvesteringsreserve available when this asset was bought.
  int _availableReserve(List<FixedAsset> all) {
    final others = all.where((a) => a.id != widget.asset?.id).toList();
    final before = AssetService.reserveLedger(
      others,
      _purchaseDate.year - 1,
      _rules,
    )[_purchaseDate.year - 1];
    final formedThisYear =
        AssetService.reserveLedger(
          others,
          _purchaseDate.year,
          _rules,
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
              vatRate: Value(_purchaseRules == null ? null : _vatRate),
              purchaseVat: Value(_purchaseVat),
              vatAmount: Value(_vatAmount),
              vatReclaimable: Value(_vatReclaimable),
              vatToReclaim: Value(_vatToReclaim),
              residualValue: Value(_residualValue),
              purchaseDate: Value(_purchaseDate),
              businessUsePct: Value(_share),
              usefulLifeYears: Value(parseWholeNumber(_usefulLife.text)!),
              kiaEligible: Value(!_isCar && _kiaEligible),
              eiaEligible: Value(!_isCar && _eiaEligible),
              miaCategory: Value(!_isCar && _eiaEligible ? null : _miaCategory),
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
              notes: Value(optionalText(_notes.text)),
              disposalDate: Value(_disposalDate),
              disposalProceeds: Value(_disposalDate == null ? null : _proceeds),
              disposalInvoiceId: Value(
                _disposalDate == null ? null : _saleInvoiceId,
              ),
              disposalVatRate: Value(_chargesSaleVat ? _disposalVatRate : null),
              disposalVatAmount: Value(_chargesSaleVat ? _saleVat : null),
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
    ref.watch(korStatusProvider);
    ref.watch(allInvoicesProvider);
    final allAssets = ref.watch(allAssetsProvider).valueOrNull ?? const [];
    final purchaseRules = _purchaseRules;
    final saleRules = _disposalDate == null
        ? null
        : ref.watch(taxRulesProvider(_disposalDate!.year));
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
                  onChanged: _setPurchaseDate,
                  required: true,
                ),
                TextFormField(
                  controller: _usefulLife,
                  decoration: fieldDecoration(
                    label: l.assetsFieldUsefulLife,
                    help: l.assetsFieldUsefulLifeHelp(
                      AppFormat.percentLabel(_rules.maxDepreciationRate),
                    ),
                    required: true,
                    suffixText: l.assetsFieldUsefulLifeUnit,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => Validate.wholeNumber(
                    v,
                    l.assetsValidateUsefulLife,
                    min: 1,
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
                  check: (v) =>
                      v > _cost ? l.assetsValidateResidualAboveCost : null,
                  onChanged: (v) => setState(() => _residualValue = v),
                ),
                const SizedBox.shrink(),
                const SizedBox.shrink(),
              ],
            ),
            if (!_isCar) ...[
              const SizedBox(height: AppSpacing.group),
              BusinessUseSlider(
                value: _businessUsePct,
                onChanged: (v) => setState(() => _businessUsePct = v),
              ),
            ],
            const SizedBox(height: AppSpacing.section),
            SectionLabel(l.assetsVatSection, help: l.assetsVatSectionHelp),
            const SizedBox(height: AppSpacing.heading),
            if (_korOnPurchase) ...[
              NoticeBanner(l.assetsKorNotice),
              const SizedBox(height: AppSpacing.field),
            ],
            FormRow(
              children: [
                if (purchaseRules != null)
                  EnumDropdown<VatRate>(
                    label: l.assetsFieldVatRate,
                    help: l.assetsFieldVatRateHelp(
                      AppFormat.percentLabel(
                        purchaseRules.vatRates[VatRate.high]!,
                      ),
                      AppFormat.percentLabel(
                        purchaseRules.vatRates[VatRate.low]!,
                      ),
                    ),
                    required: true,
                    requiredMessage: l.assetsValidateVatRate,
                    value: _vatRate,
                    values: VatRate.values,
                    labelOf: (r) => r.label(l, purchaseRules),
                    onChanged: (r) => setState(() => _vatRate = r),
                  )
                else
                  AmountField(
                    label: l.assetsFieldVatAmount,
                    help: l.assetsFieldVatAmountHelp,
                    initialValueCents: _enteredVat,
                    onChanged: (v) => setState(() => _enteredVat = v),
                  ),
                EnumDropdown<PurchaseVat>(
                  label: l.assetsFieldPurchaseVat,
                  help: l.assetsFieldPurchaseVatHelp,
                  required: true,
                  value: _purchaseVat,
                  values: PurchaseVat.values,
                  labelOf: (p) => p.label(l),
                  onChanged: (p) => setState(() => _purchaseVat = p),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            HelpCheckbox(
              value: _vatReclaimable,
              onChanged: (v) => setState(() => _vatReclaimable = v),
              title: l.assetsReclaimVat,
              help: l.assetsReclaimVatHelp,
            ),
            FormErrorText(
              validator: () => _korOnPurchase && _vatReclaimable
                  ? l.assetsValidateKorReclaim
                  : null,
            ),
            const SizedBox(height: AppSpacing.field),
            if (purchaseRules != null)
              ValueRow(
                label: l.assetsFieldVat,
                value: AppFormat.cents(_vatAmount),
              ),
            ValueRow(
              label: l.assetsVatBack,
              value: AppFormat.cents(_vatToReclaim),
            ),
            ValueRow(
              label: l.assetsCostForTax,
              help: l.assetsCostForTaxHelp,
              value: AppFormat.cents(_cost),
              bold: true,
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
                    label: l.assetsFieldMarketValue,
                    help: l.assetsFieldMarketValueHelp(
                      _rules.carMarketValueAfterYears,
                      AppFormat.percentLabel(_rules.carOldBijtellingRate),
                    ),
                    initialValueCents: _marketValue,
                    onChanged: (v) => setState(() => _marketValue = v),
                  ),
                  const SizedBox.shrink(),
                  const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: AppSpacing.field),
              HelpCheckbox(
                value: _keepsTripLog,
                onChanged: (v) => setState(() => _keepsTripLog = v),
                title: l.assetsFieldTripLog,
                help: l.assetsFieldTripLogHelp(_rules.carPrivateKmLimit),
              ),
              if (_keepsTripLog && widget.asset != null)
                _TripLogNotice(car: widget.asset!),
            ],
            const SizedBox(height: AppSpacing.section),
            SectionLabel(
              l.assetsInvestmentSection,
              help: l.assetsInvestmentSectionHelp(_rules.desinvesteringYears),
            ),
            const SizedBox(height: AppSpacing.heading),
            if (!_isCar)
              HelpCheckbox(
                value: _kiaEligible,
                onChanged: (v) => setState(() => _kiaEligible = v),
                title: l.assetsFieldKia,
                help: l.assetsFieldKiaHelp(
                  AppFormat.euros(_rules.kiaMinAssetCost),
                ),
              ),
            // No EIA on a car (art. 3.45 lid 1 d); the MIA is allowed.
            if (!_isCar) ...[
              HelpCheckbox(
                value: _eiaEligible,
                onChanged: (v) => setState(() {
                  _eiaEligible = v;
                  if (v) _miaCategory = null;
                }),
                title: l.assetsFieldEia,
                help: l.assetsFieldEiaHelp(
                  _rules.eiaMiaReportMonths,
                  AppFormat.euros(_rules.eiaMiaMinAssetCost),
                ),
              ),
              const SizedBox(height: AppSpacing.field),
            ],
            DropdownButtonFormField<MiaCategory?>(
              style: fieldTextStyle(context),
              initialValue: _miaCategory,
              isExpanded: true,
              decoration: fieldDecoration(
                label: l.assetsFieldMia,
                help: l.assetsFieldMiaHelp(
                  _rules.eiaMiaReportMonths,
                  AppFormat.euros(_rules.eiaMiaMinAssetCost),
                ),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(l.assetsMiaNone)),
                for (final c in MiaCategory.values)
                  DropdownMenuItem(value: c, child: Text(c.label(l))),
              ],
              onChanged: !_isCar && _eiaEligible
                  ? null
                  : (c) => setState(() => _miaCategory = c),
            ),
            if (_needsDeductionInput) ...[
              const SizedBox(height: AppSpacing.field),
              AmountField(
                label: l.assetsFieldDeductionReceived,
                help: l.assetsFieldDeductionReceivedHelp(
                  _rules.desinvesteringYears,
                ),
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
                AppFormat.cents(_availableReserve(allAssets)),
              ),
              initialValueCents: _reserveApplied,
              check: (v) {
                if (v > _availableReserve(allAssets)) {
                  return l.assetsValidateReserveAboveAvailable;
                }
                if (v > _cost - _residualValue) {
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
                  onChanged: _setDisposalDate,
                ),
                if (_disposalDate == null)
                  const SizedBox.shrink()
                else if (_saleInvoiceId != null)
                  ReadOnlyField(
                    label: l.assetsFieldDisposalProceeds,
                    help: l.assetsProceedsFromInvoiceHelp,
                    value: AppFormat.cents(_proceeds),
                  )
                else
                  AmountField(
                    label: l.assetsFieldDisposalProceeds,
                    help: l.assetsFieldDisposalProceedsHelp,
                    initialValueCents: _disposalProceeds,
                    onChanged: (v) => setState(() => _disposalProceeds = v),
                  ),
              ],
            ),
            if (_disposalDate != null) ...[
              const SizedBox(height: AppSpacing.field),
              FormRow(
                children: [
                  DropdownButtonFormField<int?>(
                    style: fieldTextStyle(context),
                    initialValue: _saleInvoiceId,
                    isExpanded: true,
                    decoration: fieldDecoration(
                      label: l.assetsFieldSaleInvoice,
                      help: l.assetsFieldSaleInvoiceHelp,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: Text(l.assetsSaleInvoiceNone),
                      ),
                      for (final i in _saleInvoiceChoices(allAssets))
                        DropdownMenuItem(
                          value: i.id,
                          child: EllipsisText(
                            '${i.invoiceNumber}  '
                            '${AppFormat.date(i.invoiceDate)}  '
                            '${AppFormat.cents(i.totalExclVat)}',
                          ),
                        ),
                    ],
                    onChanged: (id) => setState(() => _saleInvoiceId = id),
                  ),
                  if (_chargesSaleVat)
                    EnumDropdown<VatRate>(
                      label: l.assetsFieldDisposalVatRate,
                      help: l.assetsFieldDisposalVatRateHelp(
                        AppFormat.percentLabel(
                          saleRules!.vatRates[VatRate.high]!,
                        ),
                      ),
                      required: true,
                      requiredMessage: l.assetsValidateDisposalVatRate,
                      value: _disposalVatRate,
                      values: VatRate.values,
                      labelOf: (r) => r.label(l, saleRules),
                      onChanged: (r) => setState(() => _disposalVatRate = r),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
              if (_chargesSaleVat) ...[
                const SizedBox(height: AppSpacing.field),
                ValueRow(
                  label: l.assetsFieldVat,
                  value: AppFormat.cents(_saleVat),
                ),
              ] else if (_saleInvoiceId == null) ...[
                const SizedBox(height: AppSpacing.field),
                NoticeBanner(l.assetsSaleKorNotice),
              ],
              const SizedBox(height: AppSpacing.field),
              HelpCheckbox(
                value: _reserveGain,
                onChanged: (v) => setState(() => _reserveGain = v),
                title: l.assetsFieldReserveGain,
                help: l.assetsFieldReserveGainHelp(
                  _rules.reinvestmentReserveYears,
                ),
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
              help: l.receiptsAssetHelp(_rules.retentionYears),
              // The purchase invoice stays current while the asset is used.
              keepUntil: _disposalDate == null
                  ? l.receiptsKeepWhileInUse(_rules.retentionYears)
                  : AppFormat.date(
                      ref
                          .watch(taxRulesProvider(_disposalDate!.year))
                          .keepUntil(_disposalDate!.year),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Whether the trip log of [car] holds up in the selected year.
class _TripLogNotice extends ConsumerWidget {
  final FixedAsset car;

  const _TripLogNotice({required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final trips = ref.watch(mileageTripsProvider(year)).valueOrNull;
    if (trips == null || !AssetService.inUse(car, year)) {
      return const SizedBox.shrink();
    }
    final check = CarService.checkTripLog(car, trips, year);
    if (check.complete) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.field),
      child: NoticeBanner(
        tripLogIssues(l, car.assetName, check),
        tone: NoticeTone.warning,
      ),
    );
  }
}
