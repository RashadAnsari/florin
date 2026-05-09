import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../app.dart' show localeProvider, kSupportedLocales;
import '../../providers/providers.dart';
import '../../services/csv_export_service.dart';
import '../../services/db_location_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _name;
  late final TextEditingController _vat;
  late final TextEditingController _kvk;
  late final TextEditingController _address;
  late final TextEditingController _iban;
  bool _isStarter = false;
  bool _exportRunning = false;

  @override
  void initState() {
    super.initState();
    final prefs = ref.read(sharedPreferencesProvider);
    _name = TextEditingController(text: prefs.getString('business_name') ?? '');
    _vat = TextEditingController(
      text: prefs.getString('business_vat_number') ?? '',
    );
    _kvk = TextEditingController(text: prefs.getString('business_kvk') ?? '');
    _address = TextEditingController(
      text: prefs.getString('business_address') ?? '',
    );
    _iban = TextEditingController(text: prefs.getString('business_iban') ?? '');
    _isStarter = prefs.getBool('is_starter') ?? false;
  }

  @override
  void dispose() {
    _name.dispose();
    _vat.dispose();
    _kvk.dispose();
    _address.dispose();
    _iban.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('business_name', _name.text.trim());
    await prefs.setString('business_vat_number', _vat.text.trim());
    await prefs.setString('business_kvk', _kvk.text.trim());
    await prefs.setString('business_address', _address.text.trim());
    await prefs.setString('business_iban', _iban.text.trim());
    await prefs.setBool('is_starter', _isStarter);
    if (mounted) {
      final l = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.settingsSaved)));
    }
  }

  Future<void> _moveDb() async {
    final service = DbLocationService(ref.read(sharedPreferencesProvider));
    final result = await service.pickAndSetLocation();
    if (result != null && mounted) {
      await ref.read(dbPathNotifierProvider).setPath(result);
      if (!mounted) return;
      final l = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.settingsDatabaseMoved(result))));
    }
  }

  Future<void> _exportCsv() async {
    final year = ref.read(fiscalYearProvider);
    final db = ref.read(databaseProvider);
    setState(() => _exportRunning = true);
    try {
      final dir = await CsvExportService(db).exportYear(year);
      if (dir != null && mounted) {
        final l = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.settingsExported(dir))));
      }
    } finally {
      if (mounted) setState(() => _exportRunning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final dbPath = ref.watch(dbPathNotifierProvider).path;
    final year = ref.watch(fiscalYearProvider);
    final paramsAsync = ref.watch(taxParamsStreamProvider(year));
    final params = paramsAsync.valueOrNull;
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.settingsLanguageSection,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'nl', label: Text(l.settingsLanguageNl)),
                  ButtonSegment(value: 'en', label: Text(l.settingsLanguageEn)),
                ],
                selected: {locale.languageCode},
                onSelectionChanged: (selection) {
                  final next = kSupportedLocales.firstWhere(
                    (loc) => loc.languageCode == selection.first,
                  );
                  ref.read(localeProvider.notifier).state = next;
                  ref
                      .read(sharedPreferencesProvider)
                      .setString('app_locale', next.languageCode);
                },
              ),
              const SizedBox(height: 40),

              Text(
                l.settingsBusinessSection,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: l.settingsBusinessName),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _vat,
                      decoration: InputDecoration(
                        labelText: l.settingsVatNumber,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _kvk,
                      decoration: InputDecoration(
                        labelText: l.settingsKvkNumber,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _address,
                decoration: InputDecoration(
                  labelText: l.settingsBusinessAddress,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _iban,
                decoration: InputDecoration(labelText: l.settingsIban),
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                value: _isStarter,
                onChanged: (v) => setState(() => _isStarter = v ?? false),
                title: Text(l.settingsStartersaftrek),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: _save, child: Text(l.actionSave)),
              const SizedBox(height: 40),

              Text(
                l.settingsDatabaseSection,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                l.settingsDatabaseLocation(dbPath ?? l.settingsDatabaseNotSet),
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _moveDb,
                icon: const Icon(Icons.drive_file_move_outlined),
                label: Text(l.settingsMoveDatabase),
              ),
              const SizedBox(height: 40),

              Text(l.settingsExportSection, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                l.settingsExportDescription(year),
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _exportRunning ? null : _exportCsv,
                icon: _exportRunning
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download_outlined),
                label: Text(
                  _exportRunning
                      ? l.settingsExportRunning
                      : l.settingsExportButton(year),
                ),
              ),
              const SizedBox(height: 40),

              Text(
                l.settingsTaxSection(year),
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (params == null)
                Text(
                  l.settingsTaxNoParams(year),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              else
                _TaxParamsEditor(params: params, year: year),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaxParamsEditor extends ConsumerStatefulWidget {
  final TaxParam params;
  final int year;

  const _TaxParamsEditor({required this.params, required this.year});

  @override
  ConsumerState<_TaxParamsEditor> createState() => _TaxParamsEditorState();
}

class _TaxParamsEditorState extends ConsumerState<_TaxParamsEditor> {
  late TextEditingController _zelfs;
  late TextEditingController _starters;
  late TextEditingController _mkbPct;
  late TextEditingController _b1Rate;
  late TextEditingController _b1Thresh;
  late TextEditingController _b2Rate;
  late TextEditingController _b2Thresh;
  late TextEditingController _b3Rate;
  late TextEditingController _algHeff;
  late TextEditingController _arbeids;
  late TextEditingController _zvwRate;
  late TextEditingController _zvwMax;
  late TextEditingController _mileageRate;
  late TextEditingController _korThresh;

  @override
  void initState() {
    super.initState();
    final p = widget.params;
    _zelfs = TextEditingController(
      text: (-p.zelfstandigenaftrek / 100).toStringAsFixed(2),
    );
    _starters = TextEditingController(
      text: (-p.startersaftrek / 100).toStringAsFixed(2),
    );
    _mkbPct = TextEditingController(
      text: (p.mkbWinstvrijstellingPct * 100).toStringAsFixed(1),
    );
    _b1Rate = TextEditingController(
      text: (p.bracket1Rate * 100).toStringAsFixed(2),
    );
    _b1Thresh = TextEditingController(
      text: (p.bracket1Threshold / 100).toStringAsFixed(2),
    );
    _b2Rate = TextEditingController(
      text: (p.bracket2Rate * 100).toStringAsFixed(2),
    );
    _b2Thresh = TextEditingController(
      text: (p.bracket2Threshold / 100).toStringAsFixed(2),
    );
    _b3Rate = TextEditingController(
      text: (p.bracket3Rate * 100).toStringAsFixed(2),
    );
    _algHeff = TextEditingController(
      text: (p.algHeffingskortingMax / 100).toStringAsFixed(2),
    );
    _arbeids = TextEditingController(
      text: (p.arbeidskortingMax / 100).toStringAsFixed(2),
    );
    _zvwRate = TextEditingController(
      text: (p.zvwRate * 100).toStringAsFixed(2),
    );
    _zvwMax = TextEditingController(text: (p.zvwMax / 100).toStringAsFixed(2));
    _mileageRate = TextEditingController(
      text: p.mileageRatePerKm.toStringAsFixed(2),
    );
    _korThresh = TextEditingController(
      text: (p.korThreshold / 100).toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    for (final c in [
      _zelfs,
      _starters,
      _mkbPct,
      _b1Rate,
      _b1Thresh,
      _b2Rate,
      _b2Thresh,
      _b3Rate,
      _algHeff,
      _arbeids,
      _zvwRate,
      _zvwMax,
      _mileageRate,
      _korThresh,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  double _pct(TextEditingController c) =>
      (double.tryParse(c.text.replaceAll(',', '.')) ?? 0) / 100;
  int _euros(TextEditingController c) =>
      ((double.tryParse(c.text.replaceAll(',', '.')) ?? 0) * 100).round();

  Future<void> _save() async {
    final dao = ref.read(taxParamsDaoProvider);
    final p = widget.params;
    await dao.upsert(
      TaxParamsCompanion(
        year: Value(widget.year),
        zelfstandigenaftrek: Value(-_euros(_zelfs)),
        startersaftrek: Value(-_euros(_starters)),
        mkbWinstvrijstellingPct: Value(_pct(_mkbPct)),
        bracket1Rate: Value(_pct(_b1Rate)),
        bracket1Threshold: Value(_euros(_b1Thresh)),
        bracket2Rate: Value(_pct(_b2Rate)),
        bracket2Threshold: Value(_euros(_b2Thresh)),
        bracket3Rate: Value(_pct(_b3Rate)),
        algHeffingskortingMax: Value(_euros(_algHeff)),
        arbeidskortingMax: Value(_euros(_arbeids)),
        zvwRate: Value(_pct(_zvwRate)),
        zvwMax: Value(_euros(_zvwMax)),
        mixedCostsThreshold: Value(p.mixedCostsThreshold),
        mixedCosts80Pct: Value(p.mixedCosts80Pct),
        jaarruimtePct: Value(p.jaarruimtePct),
        jaarruimteMax: Value(p.jaarruimteMax),
        aowFranchise: Value(p.aowFranchise),
        reserveringsruimteMax: Value(p.reserveringsruimteMax),
        factorAMultiplier: Value(p.factorAMultiplier),
        kiaLowerThreshold: Value(p.kiaLowerThreshold),
        kiaUpperThreshold: Value(p.kiaUpperThreshold),
        kiaFlatThreshold: Value(p.kiaFlatThreshold),
        kiaRate: Value(p.kiaRate),
        kiaFlatAmount: Value(p.kiaFlatAmount),
        mileageRatePerKm: Value(
          double.tryParse(_mileageRate.text.replaceAll(',', '.')) ??
              p.mileageRatePerKm,
        ),
        korThreshold: Value(_euros(_korThresh)),
        ossThreshold: Value(p.ossThreshold),
        belastingrentePct: Value(p.belastingrentePct),
      ),
    );
    if (mounted) {
      final l = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.settingsTaxParamsSaved)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.settingsTaxRates, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        _row2(
          _field(l.settingsTaxZelfs, _zelfs),
          _field(l.settingsTaxStarters, _starters),
        ),
        _row2(
          _field(l.settingsTaxMkb, _mkbPct),
          _field(l.settingsTaxMileage, _mileageRate),
        ),
        const SizedBox(height: 16),
        Text(l.settingsTaxBrackets, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        _row2(
          _field(l.settingsTaxB1Rate, _b1Rate),
          _field(l.settingsTaxB1Thresh, _b1Thresh),
        ),
        _row2(
          _field(l.settingsTaxB2Rate, _b2Rate),
          _field(l.settingsTaxB2Thresh, _b2Thresh),
        ),
        _row2(_field(l.settingsTaxB3Rate, _b3Rate), const SizedBox()),
        const SizedBox(height: 16),
        Text(l.settingsTaxKortingen, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        _row2(
          _field(l.settingsTaxAlgHeff, _algHeff),
          _field(l.settingsTaxArbeids, _arbeids),
        ),
        _row2(
          _field(l.settingsTaxZvwRate, _zvwRate),
          _field(l.settingsTaxZvwMax, _zvwMax),
        ),
        const SizedBox(height: 16),
        Text(l.settingsTaxKor, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        SizedBox(width: 280, child: _field(l.settingsTaxKorThresh, _korThresh)),
        const SizedBox(height: 20),
        FilledButton(onPressed: _save, child: Text(l.settingsTaxSaveParams)),
      ],
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }

  Widget _row2(Widget a, Widget b) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Expanded(child: a),
        const SizedBox(width: 12),
        Expanded(child: b),
      ],
    ),
  );
}
