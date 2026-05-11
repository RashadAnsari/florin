import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../app.dart' show localeProvider, kSupportedLocales;
import '../../providers/providers.dart';
import '../../services/csv_export_service.dart';
import '../../services/db_location_service.dart';
import '../../services/vat_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
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
    if (!_formKey.currentState!.validate()) return;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.settingsLanguageSection, style: theme.textTheme.titleLarge),
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

            Text(l.settingsBusinessSection, style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: '${l.settingsBusinessName} *',
                    ),
                    validator: (s) => (s == null || s.trim().isEmpty)
                        ? l.settingsValidateName
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _vat,
                          decoration: InputDecoration(
                            labelText: '${l.settingsVatNumber} *',
                          ),
                          validator: (s) {
                            final v = s?.trim() ?? '';
                            if (v.isEmpty) return l.settingsValidateVat;
                            if (!isValidDutchVatNumber(v)) {
                              return l.settingsValidateVatFormat;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _kvk,
                          decoration: InputDecoration(
                            labelText: '${l.settingsKvkNumber} *',
                          ),
                          validator: (s) {
                            final v = s?.trim() ?? '';
                            if (v.isEmpty) return l.settingsValidateKvk;
                            if (!isValidKvkNumber(v)) {
                              return l.settingsValidateKvkFormat;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _address,
                    decoration: InputDecoration(
                      labelText: '${l.settingsBusinessAddress} *',
                    ),
                    maxLines: 4,
                    minLines: 3,
                    validator: (s) => (s == null || s.trim().isEmpty)
                        ? l.settingsValidateAddress
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _iban,
                    decoration: InputDecoration(
                      labelText: '${l.settingsIban} *',
                    ),
                    validator: (s) {
                      final v = s?.trim() ?? '';
                      if (v.isEmpty) return l.settingsValidateIban;
                      if (!isValidIban(v)) return l.settingsValidateIbanFormat;
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    value: _isStarter,
                    onChanged: (v) => setState(() => _isStarter = v ?? false),
                    title: Text(l.settingsStartersaftrek),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 16),
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
                    label: Text(l.actionSave),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Text(l.settingsDatabaseSection, style: theme.textTheme.titleLarge),
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

            Text(l.settingsTaxSection(year), style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            _TaxParamsEditor(params: params, year: year),
          ],
        ),
      ),
    );
  }
}

class _TaxParamsEditor extends ConsumerStatefulWidget {
  final TaxParam? params;
  final int year;

  const _TaxParamsEditor({required this.params, required this.year});

  @override
  ConsumerState<_TaxParamsEditor> createState() => _TaxParamsEditorState();
}

class _TaxParamsEditorState extends ConsumerState<_TaxParamsEditor> {
  final _formKey = GlobalKey<FormState>();
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
      text: p == null ? '' : (-p.zelfstandigenaftrek / 100).toStringAsFixed(2),
    );
    _starters = TextEditingController(
      text: p == null ? '' : (-p.startersaftrek / 100).toStringAsFixed(2),
    );
    _mkbPct = TextEditingController(
      text: p == null
          ? ''
          : (p.mkbWinstvrijstellingPct * 100).toStringAsFixed(1),
    );
    _b1Rate = TextEditingController(
      text: p == null ? '' : (p.bracket1Rate * 100).toStringAsFixed(2),
    );
    _b1Thresh = TextEditingController(
      text: p == null ? '' : (p.bracket1Threshold / 100).toStringAsFixed(2),
    );
    _b2Rate = TextEditingController(
      text: p == null ? '' : (p.bracket2Rate * 100).toStringAsFixed(2),
    );
    _b2Thresh = TextEditingController(
      text: p == null ? '' : (p.bracket2Threshold / 100).toStringAsFixed(2),
    );
    _b3Rate = TextEditingController(
      text: p == null ? '' : (p.bracket3Rate * 100).toStringAsFixed(2),
    );
    _algHeff = TextEditingController(
      text: p == null ? '' : (p.algHeffingskortingMax / 100).toStringAsFixed(2),
    );
    _arbeids = TextEditingController(
      text: p == null ? '' : (p.arbeidskortingMax / 100).toStringAsFixed(2),
    );
    _zvwRate = TextEditingController(
      text: p == null ? '' : (p.zvwRate * 100).toStringAsFixed(2),
    );
    _zvwMax = TextEditingController(
      text: p == null ? '' : (p.zvwMax / 100).toStringAsFixed(2),
    );
    _mileageRate = TextEditingController(
      text: p == null ? '' : p.mileageRatePerKm.toStringAsFixed(2),
    );
    _korThresh = TextEditingController(
      text: p == null ? '' : (p.korThreshold / 100).toStringAsFixed(2),
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
    if (!_formKey.currentState!.validate()) return;
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
        mixedCostsThreshold: Value(p?.mixedCostsThreshold ?? 0),
        mixedCosts80Pct: Value(p?.mixedCosts80Pct ?? 0.0),
        jaarruimtePct: Value(p?.jaarruimtePct ?? 0.0),
        jaarruimteMax: Value(p?.jaarruimteMax ?? 0),
        aowFranchise: Value(p?.aowFranchise ?? 0),
        reserveringsruimteMax: Value(p?.reserveringsruimteMax ?? 0),
        factorAMultiplier: Value(p?.factorAMultiplier ?? 0.0),
        kiaLowerThreshold: Value(p?.kiaLowerThreshold ?? 0),
        kiaUpperThreshold: Value(p?.kiaUpperThreshold ?? 0),
        kiaFlatThreshold: Value(p?.kiaFlatThreshold ?? 0),
        kiaRate: Value(p?.kiaRate ?? 0.0),
        kiaFlatAmount: Value(p?.kiaFlatAmount ?? 0),
        mileageRatePerKm: Value(
          double.tryParse(_mileageRate.text.replaceAll(',', '.')) ??
              p?.mileageRatePerKm ??
              0.0,
        ),
        korThreshold: Value(_euros(_korThresh)),
        ossThreshold: Value(p?.ossThreshold ?? 0),
        belastingrentePct: Value(p?.belastingrentePct ?? 0.0),
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.settingsTaxRates, style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          _row2(
            _field(l, l.settingsTaxZelfs, _zelfs),
            _field(l, l.settingsTaxStarters, _starters),
          ),
          _row2(
            _field(l, l.settingsTaxMkb, _mkbPct),
            _field(l, l.settingsTaxMileage, _mileageRate),
          ),
          const SizedBox(height: 16),
          Text(l.settingsTaxBrackets, style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          _row2(
            _field(l, l.settingsTaxB1Rate, _b1Rate),
            _field(l, l.settingsTaxB1Thresh, _b1Thresh),
          ),
          _row2(
            _field(l, l.settingsTaxB2Rate, _b2Rate),
            _field(l, l.settingsTaxB2Thresh, _b2Thresh),
          ),
          _row2(_field(l, l.settingsTaxB3Rate, _b3Rate), const SizedBox()),
          const SizedBox(height: 16),
          Text(l.settingsTaxKortingen, style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          _row2(
            _field(l, l.settingsTaxAlgHeff, _algHeff),
            _field(l, l.settingsTaxArbeids, _arbeids),
          ),
          _row2(
            _field(l, l.settingsTaxZvwRate, _zvwRate),
            _field(l, l.settingsTaxZvwMax, _zvwMax),
          ),
          const SizedBox(height: 16),
          Text(l.settingsTaxKor, style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          _row2(
            _field(l, l.settingsTaxKorThresh, _korThresh),
            const SizedBox(),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _save,
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            icon: const Icon(Icons.save_outlined, size: 18),
            label: Text(l.settingsTaxSaveParams),
          ),
        ],
      ),
    );
  }

  Widget _field(
    AppLocalizations l,
    String label,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: '$label *'),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (s) {
        final v = s?.trim() ?? '';
        if (v.isEmpty || double.tryParse(v.replaceAll(',', '.')) == null) {
          return l.settingsTaxValidateField;
        }
        return null;
      },
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
