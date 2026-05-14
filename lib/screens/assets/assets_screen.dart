import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/tax_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/amount_field.dart';
import '../../widgets/confirmation_dialog.dart';

class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final assetsAsync = ref.watch(assetsStreamProvider(year));
    final assets = assetsAsync.valueOrNull ?? [];
    final paramsAsync = ref.watch(taxParamsStreamProvider(year));
    final params = paramsAsync.valueOrNull;

    final service = const TaxService();
    final kiaTotal = assets
        .where((a) => a.kiaEligible && a.fiscalYear == year)
        .fold<int>(0, (s, a) => s + a.costExclVat);
    final kiaDeduction = params != null
        ? service.computeKia(params, kiaTotal)
        : 0;
    final totalDepreciation = assets.fold<int>(0, (s, a) {
      if (a.disposalDate != null) return s;
      final yrs = (year - a.purchaseDate.year).clamp(0, a.usefulLifeYears);
      if (yrs >= a.usefulLifeYears) return s;
      return s +
          service.computeAnnualDepreciation(
            costExclVat: a.costExclVat,
            usefulLifeYears: a.usefulLifeYears,
            businessUsePct: a.businessUsePct,
          );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l.assetsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: l.assetsNewAsset,
            onPressed: () => context.push('/assets/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          _SummaryBar(
            kiaTotal: kiaTotal,
            kiaDeduction: kiaDeduction,
            totalDepreciation: totalDepreciation,
          ),
          const Divider(height: 1),
          Expanded(
            child: assetsAsync.when(
              data: (data) => _AssetList(
                assets: data,
                year: year,
                service: service,
                onTap: (a) => context.push('/assets/${a.id}', extra: a),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('$error')),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryBar extends StatelessWidget {
  final int kiaTotal;
  final int kiaDeduction;
  final int totalDepreciation;

  const _SummaryBar({
    required this.kiaTotal,
    required this.kiaDeduction,
    required this.totalDepreciation,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _stat(l.assetsKiaInvestments, AppFormat.cents(kiaTotal), theme),
              const SizedBox(width: 32),
              _stat(
                l.assetsKiaDeduction,
                AppFormat.cents(kiaDeduction),
                theme,
                valueColor: AppColors.income,
              ),
              const SizedBox(width: 32),
              _stat(
                l.assetsDepreciationThisYear,
                AppFormat.cents(totalDepreciation),
                theme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(
    String label,
    String value,
    ThemeData theme, {
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _AssetList extends StatelessWidget {
  final List<FixedAsset> assets;
  final int year;
  final TaxService service;
  final ValueChanged<FixedAsset> onTap;

  const _AssetList({
    required this.assets,
    required this.year,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    if (assets.isEmpty) {
      return Center(child: Text(l.assetsNone));
    }
    return ListView.builder(
      itemCount: assets.length,
      itemBuilder: (context, i) {
        final a = assets[i];
        final disposed = a.disposalDate != null;
        final yearsElapsed = year - a.purchaseDate.year;
        final bookValue = service.computeBookValue(
          costExclVat: a.costExclVat,
          usefulLifeYears: a.usefulLifeYears,
          businessUsePct: a.businessUsePct,
          yearsElapsed: yearsElapsed,
        );
        return ListTile(
          title: Text(
            a.assetName,
            style: disposed
                ? theme.textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: theme.colorScheme.outline,
                  )
                : null,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppFormat.cents(a.costExclVat),
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 2),
              Text(
                l.assetsYears(a.usefulLifeYears),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppFormat.cents(bookValue),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (a.kiaEligible)
                Text(
                  l.assetsKiaBadge,
                  style: const TextStyle(color: AppColors.income, fontSize: 11),
                ),
            ],
          ),
          onTap: () => onTap(a),
        );
      },
    );
  }
}

class _AssetForm extends ConsumerStatefulWidget {
  final FixedAsset? asset;
  final int year;
  final VoidCallback? onBack;
  final VoidCallback onSaved;
  final VoidCallback onDeleted;

  const _AssetForm({
    required this.asset,
    required this.year,
    this.onBack,
    required this.onSaved,
    required this.onDeleted,
  });

  @override
  ConsumerState<_AssetForm> createState() => _AssetFormState();
}

class _AssetFormState extends ConsumerState<_AssetForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _notes;
  late DateTime _purchaseDate;
  late int _costExclVat;
  late double _businessUsePct;
  late int _usefulLifeYears;
  late bool _kiaEligible;
  late bool _eiaOrMia;
  DateTime? _disposalDate;
  int _disposalProceeds = 0;

  @override
  void initState() {
    super.initState();
    final a = widget.asset;
    _name = TextEditingController(text: a?.assetName ?? '');
    _notes = TextEditingController(text: a?.notes ?? '');
    _purchaseDate = a?.purchaseDate ?? DateTime(widget.year, 1, 1);
    _costExclVat = a?.costExclVat ?? 0;
    _businessUsePct = a?.businessUsePct ?? 1.0;
    _usefulLifeYears = a?.usefulLifeYears ?? 5;
    _kiaEligible = a?.kiaEligible ?? false;
    _eiaOrMia = a?.eiaOrMia ?? false;
    _disposalDate = a?.disposalDate;
    _disposalProceeds = a?.disposalProceeds ?? 0;
  }

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final dao = ref.read(assetDaoProvider);
    final companion = FixedAssetsCompanion(
      id: widget.asset != null ? Value(widget.asset!.id) : const Value.absent(),
      fiscalYear: Value(widget.year),
      assetName: Value(_name.text.trim()),
      costExclVat: Value(_costExclVat),
      purchaseDate: Value(_purchaseDate),
      businessUsePct: Value(_businessUsePct),
      usefulLifeYears: Value(_usefulLifeYears),
      kiaEligible: Value(_kiaEligible),
      eiaOrMia: Value(_eiaOrMia),
      notes: Value(_notes.text.trim().isEmpty ? null : _notes.text.trim()),
      disposalDate: Value(_disposalDate),
      disposalProceeds: Value(_disposalDate != null ? _disposalProceeds : null),
    );
    if (widget.asset == null) {
      await dao.insertAsset(companion);
    } else {
      await dao.saveAsset(companion);
    }
    widget.onSaved();
  }

  Future<void> _delete() async {
    if (widget.asset == null) return;
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.assetsDeleteTitle,
      message: l.assetsDeleteMessage(widget.asset!.assetName),
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref.read(assetDaoProvider).deleteAsset(widget.asset!.id);
    if (mounted) widget.onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isNew = widget.asset == null;

    return Column(
      children: [
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
                  isNew ? l.assetsNewAsset : _name.text,
                  style: theme.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isNew)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: l.actionDelete,
                  color: theme.colorScheme.error,
                  onPressed: _delete,
                ),
              FilledButton.icon(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                ),
                icon: const Icon(Icons.save_outlined, size: 18),
                label: Text(l.actionSave),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(labelText: l.assetsFieldName),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l.assetsValidateName
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AmountField(
                          key: ValueKey('cost_${widget.asset?.id}'),
                          label: l.assetsFieldCost,
                          initialValueCents: _costExclVat,
                          onChanged: (v) => setState(() => _costExclVat = v),
                          required: true,
                          validatorMessage: l.assetsValidateCost,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          key: ValueKey(_purchaseDate.toString()),
                          initialValue: AppFormat.date(_purchaseDate),
                          readOnly: true,
                          strutStyle: StrutStyle.disabled,
                          decoration: InputDecoration(
                            labelText: l.assetsFieldPurchaseDate,
                          ),
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate: _purchaseDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(widget.year, 12, 31),
                            );
                            if (d != null) setState(() => _purchaseDate = d);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          initialValue: _usefulLifeYears.toString(),
                          decoration: InputDecoration(
                            labelText: l.assetsFieldUsefulLife,
                            suffixText: l.assetsFieldUsefulLifeUnit,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (v) => setState(
                            () => _usefulLifeYears = int.tryParse(v) ?? 5,
                          ),
                          validator: (v) {
                            final y = int.tryParse(v ?? '');
                            if (y == null || y < 1) {
                              return l.assetsFieldUsefulLifeMin;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l.assetsFieldBusinessUse((_businessUsePct * 100).round()),
                    style: theme.textTheme.bodySmall,
                  ),
                  Slider(
                    value: _businessUsePct,
                    min: 0,
                    max: 1,
                    divisions: 20,
                    label: '${(_businessUsePct * 100).round()}%',
                    onChanged: (v) => setState(() => _businessUsePct = v),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          value: _kiaEligible,
                          onChanged: (v) =>
                              setState(() => _kiaEligible = v ?? _kiaEligible),
                          title: Text(l.assetsFieldKia),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CheckboxListTile(
                          value: _eiaOrMia,
                          onChanged: (v) =>
                              setState(() => _eiaOrMia = v ?? _eiaOrMia),
                          title: Text(l.assetsFieldEiaMia),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notes,
                    decoration: InputDecoration(labelText: l.assetsFieldNotes),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  Text(l.assetsDisposal, style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  TextFormField(
                    key: ValueKey(_disposalDate?.toString() ?? 'null'),
                    initialValue: _disposalDate != null
                        ? AppFormat.date(_disposalDate!)
                        : '',
                    readOnly: true,
                    strutStyle: StrutStyle.disabled,
                    decoration: InputDecoration(
                      labelText: l.assetsFieldDisposalDate,
                      suffixIcon: _disposalDate == null
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              tooltip: l.assetsClearDisposalDate,
                              onPressed: () => setState(() {
                                _disposalDate = null;
                                _disposalProceeds = 0;
                              }),
                            ),
                    ),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _disposalDate ?? _purchaseDate,
                        firstDate: _purchaseDate,
                        lastDate: DateTime(2099),
                      );
                      if (d != null) setState(() => _disposalDate = d);
                    },
                  ),
                  if (_disposalDate != null) ...[
                    const SizedBox(height: 12),
                    AmountField(
                      key: ValueKey('proceeds_${widget.asset?.id}'),
                      label: l.assetsFieldDisposalProceeds,
                      initialValueCents: _disposalProceeds,
                      onChanged: (v) => setState(() => _disposalProceeds = v),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AssetDetailPage extends ConsumerWidget {
  final FixedAsset? asset;

  const AssetDetailPage({super.key, this.asset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = ref.watch(fiscalYearProvider);
    return Scaffold(
      body: _AssetForm(
        asset: asset,
        year: asset?.fiscalYear ?? year,
        onBack: () => context.pop(),
        onSaved: () => context.pop(),
        onDeleted: () => context.pop(),
      ),
    );
  }
}
