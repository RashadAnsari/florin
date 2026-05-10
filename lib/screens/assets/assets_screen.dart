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

class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = ref.watch(fiscalYearProvider);
    final assets = ref.watch(assetsStreamProvider(year)).valueOrNull ?? [];
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
        title: Text(AppLocalizations.of(context)!.assetsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
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
          Expanded(
            child: _AssetList(
              assets: assets,
              year: year,
              service: service,
              onTap: (a) => context.push('/assets/${a.id}', extra: a),
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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      child: Row(
        children: [
          _stat(
            AppLocalizations.of(context)!.assetsKiaInvestments,
            AppFormat.cents(kiaTotal),
            theme,
          ),
          const SizedBox(width: 32),
          _stat(
            AppLocalizations.of(context)!.assetsKiaDeduction,
            AppFormat.cents(kiaDeduction),
            theme,
            valueColor: AppColors.income,
          ),
          const SizedBox(width: 32),
          _stat(
            AppLocalizations.of(context)!.assetsDepreciationThisYear,
            AppFormat.cents(totalDepreciation),
            theme,
          ),
        ],
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
    if (assets.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.assetsNone));
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
                ? const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  )
                : null,
          ),
          subtitle: Text(
            '${AppFormat.cents(a.costExclVat)}  ·  ${AppLocalizations.of(context)!.assetsYears(a.usefulLifeYears)}',
            style: Theme.of(context).textTheme.bodySmall,
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
                const Text(
                  'KIA',
                  style: TextStyle(color: AppColors.income, fontSize: 11),
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
  final VoidCallback onSaved;
  final VoidCallback onDeleted;

  const _AssetForm({
    required this.asset,
    required this.year,
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
    final dao = ref.read(assetDaoProvider);
    await dao.deleteAsset(widget.asset!.id);
    widget.onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.asset == null
                    ? AppLocalizations.of(context)!.assetsNewAsset
                    : AppLocalizations.of(context)!.assetsEditAsset,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.assetsFieldName,
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? AppLocalizations.of(context)!.labelRequired
                    : null,
              ),
              const SizedBox(height: 12),
              AmountField(
                key: ValueKey('cost_${widget.asset?.id}'),
                label: AppLocalizations.of(context)!.assetsFieldCost,
                initialValueCents: _costExclVat,
                onChanged: (v) => setState(() => _costExclVat = v),
                required: true,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _purchaseDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(widget.year, 12, 31),
                  );
                  if (d != null) setState(() => _purchaseDate = d);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(
                      context,
                    )!.assetsFieldPurchaseDate,
                  ),
                  child: Text(AppFormat.date(_purchaseDate)),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.assetsFieldBusinessUse(
                            (_businessUsePct * 100).round(),
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Slider(
                          value: _businessUsePct,
                          min: 0,
                          max: 1,
                          divisions: 20,
                          label: '${(_businessUsePct * 100).round()}%',
                          onChanged: (v) => setState(() => _businessUsePct = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      initialValue: _usefulLifeYears.toString(),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(
                          context,
                        )!.assetsFieldUsefulLife,
                        suffixText: AppLocalizations.of(
                          context,
                        )!.assetsFieldUsefulLifeUnit,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (v) => setState(
                        () => _usefulLifeYears = int.tryParse(v) ?? 5,
                      ),
                      validator: (v) {
                        final y = int.tryParse(v ?? '');
                        if (y == null || y < 1) {
                          return AppLocalizations.of(
                            context,
                          )!.assetsFieldUsefulLifeMin;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _kiaEligible,
                onChanged: (v) =>
                    setState(() => _kiaEligible = v ?? _kiaEligible),
                title: Text(AppLocalizations.of(context)!.assetsFieldKia),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                value: _eiaOrMia,
                onChanged: (v) => setState(() => _eiaOrMia = v ?? _eiaOrMia),
                title: Text(AppLocalizations.of(context)!.assetsFieldEiaMia),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notes,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.assetsFieldNotes,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.assetsDisposal,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _disposalDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2099),
                  );
                  setState(() => _disposalDate = d);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(
                      context,
                    )!.assetsFieldDisposalDate,
                  ),
                  child: Text(
                    _disposalDate != null
                        ? AppFormat.date(_disposalDate!)
                        : '—',
                  ),
                ),
              ),
              if (_disposalDate != null) ...[
                const SizedBox(height: 12),
                AmountField(
                  key: ValueKey('proceeds_${widget.asset?.id}'),
                  label: AppLocalizations.of(
                    context,
                  )!.assetsFieldDisposalProceeds,
                  initialValueCents: _disposalProceeds,
                  onChanged: (v) => setState(() => _disposalProceeds = v),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                children: [
                  FilledButton(
                    onPressed: _save,
                    child: Text(AppLocalizations.of(context)!.actionSave),
                  ),
                  if (widget.asset != null) ...[
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _delete,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.red,
                      ),
                      child: Text(AppLocalizations.of(context)!.actionDelete),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssetDetailPage extends ConsumerWidget {
  final FixedAsset? asset;

  const AssetDetailPage({super.key, this.asset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(asset == null ? l.assetsNewAsset : l.assetsEditAsset),
      ),
      body: _AssetForm(
        asset: asset,
        year: asset?.fiscalYear ?? year,
        onSaved: () => context.pop(),
        onDeleted: () => context.pop(),
      ),
    );
  }
}
