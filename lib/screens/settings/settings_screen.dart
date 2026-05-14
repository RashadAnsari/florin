import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../app.dart' show localeProvider, kSupportedLocales;
import '../../providers/providers.dart';
import '../../services/csv_export_service.dart';
import '../../services/db_location_service.dart';
import '../../services/tax_service.dart';
import '../../services/vat_service.dart';
import '../../constants/prefs_keys.dart';
import '../../widgets/amount_field.dart';

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
    _name = TextEditingController(
      text: prefs.getString(PrefsKeys.businessName) ?? '',
    );
    _vat = TextEditingController(
      text: prefs.getString(PrefsKeys.businessVatNumber) ?? '',
    );
    _kvk = TextEditingController(
      text: prefs.getString(PrefsKeys.businessKvk) ?? '',
    );
    _address = TextEditingController(
      text: prefs.getString(PrefsKeys.businessAddress) ?? '',
    );
    _iban = TextEditingController(
      text: prefs.getString(PrefsKeys.businessIban) ?? '',
    );
    _isStarter = prefs.getBool(PrefsKeys.isStarter) ?? false;
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
    await prefs.setString(PrefsKeys.businessName, _name.text.trim());
    await prefs.setString(PrefsKeys.businessVatNumber, _vat.text.trim());
    await prefs.setString(PrefsKeys.businessKvk, _kvk.text.trim());
    await prefs.setString(PrefsKeys.businessAddress, _address.text.trim());
    await prefs.setString(PrefsKeys.businessIban, _iban.text.trim());
    await prefs.setBool(PrefsKeys.isStarter, _isStarter);
  }

  Future<void> _moveDb() async {
    final l = AppLocalizations.of(context)!;
    final service = DbLocationService(ref.read(sharedPreferencesProvider));
    final result = await service.pickAndSetLocation(
      dialogTitle: l.dbLocationChooseFolderDialog,
    );
    if (result != null && mounted) {
      await ref.read(dbPathNotifierProvider).setPath(result);
    }
  }

  Future<void> _exportCsv() async {
    final l = AppLocalizations.of(context)!;
    final year = ref.read(fiscalYearProvider);
    final db = ref.read(databaseProvider);
    setState(() => _exportRunning = true);
    try {
      final dir = await CsvExportService(
        db,
      ).exportYear(year, dialogTitle: l.csvExportChooseFolderDialog);
      if (dir != null && mounted) {
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
                    subtitle: Text(l.firstLaunchStartersSubtitle),
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
            _TaxParamsEditor(key: ValueKey(year), params: params, year: year),
          ],
        ),
      ),
    );
  }
}

class _TaxParamsEditor extends ConsumerStatefulWidget {
  final TaxParam? params;
  final int year;

  const _TaxParamsEditor({super.key, required this.params, required this.year});

  @override
  ConsumerState<_TaxParamsEditor> createState() => _TaxParamsEditorState();
}

class _TaxParamsEditorState extends ConsumerState<_TaxParamsEditor> {
  final _formKey = GlobalKey<FormState>();
  late int _zelfs;
  late int _starters;
  late TextEditingController _mkbPct;
  late TextEditingController _b1Rate;
  late int _b1Thresh;
  late TextEditingController _b2Rate;
  late int _b2Thresh;
  late TextEditingController _b3Rate;
  late int _algHeff;
  late int _arbeids;
  late TextEditingController _zvwRate;
  late int _zvwMax;
  late TextEditingController _mileageRate;
  late int _korThresh;
  late TextEditingController _urenThresh;
  late int _kiaLowerThresh;
  late int _kiaUpperThresh;
  late int _kiaFlatThresh;
  late TextEditingController _kiaRate;
  late int _kiaFlatAmount;
  late TextEditingController _kiaDecreaseRate;

  @override
  void initState() {
    super.initState();
    final p = widget.params;
    _zelfs = p == null ? 0 : -p.zelfstandigenaftrek;
    _starters = p == null ? 0 : -p.startersaftrek;
    _mkbPct = TextEditingController(
      text: p == null
          ? ''
          : (p.mkbWinstvrijstellingPct * 100).toStringAsFixed(1),
    );
    _b1Rate = TextEditingController(
      text: p == null ? '' : (p.bracket1Rate * 100).toStringAsFixed(2),
    );
    _b1Thresh = p?.bracket1Threshold ?? 0;
    _b2Rate = TextEditingController(
      text: p == null ? '' : (p.bracket2Rate * 100).toStringAsFixed(2),
    );
    _b2Thresh = p?.bracket2Threshold ?? 0;
    _b3Rate = TextEditingController(
      text: p == null ? '' : (p.bracket3Rate * 100).toStringAsFixed(2),
    );
    _algHeff = p?.algHeffingskortingMax ?? 0;
    _arbeids = p?.arbeidskortingMax ?? 0;
    _zvwRate = TextEditingController(
      text: p == null ? '' : (p.zvwRate * 100).toStringAsFixed(2),
    );
    _zvwMax = p?.zvwMax ?? 0;
    _mileageRate = TextEditingController(
      text: p == null ? '' : p.mileageRatePerKm.toStringAsFixed(2),
    );
    _korThresh = p?.korThreshold ?? 0;
    _urenThresh = TextEditingController(
      text:
          (p?.urencriteriumThreshold ??
                  TaxService.urencriteriumThreshold.toInt())
              .toString(),
    );
    _kiaLowerThresh = p?.kiaLowerThreshold ?? 0;
    _kiaUpperThresh = p?.kiaUpperThreshold ?? 0;
    _kiaFlatThresh = p?.kiaFlatThreshold ?? 0;
    _kiaRate = TextEditingController(
      text: p == null ? '' : (p.kiaRate * 100).toStringAsFixed(2),
    );
    _kiaFlatAmount = p?.kiaFlatAmount ?? 0;
    _kiaDecreaseRate = TextEditingController(
      text: p == null ? '' : (p.kiaDecreaseRate * 100).toStringAsFixed(4),
    );
  }

  @override
  void dispose() {
    for (final c in [
      _mkbPct,
      _b1Rate,
      _b2Rate,
      _b3Rate,
      _zvwRate,
      _mileageRate,
      _urenThresh,
      _kiaRate,
      _kiaDecreaseRate,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  double _pct(TextEditingController c) =>
      (double.tryParse(c.text.replaceAll(',', '.')) ?? 0) / 100;
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final dao = ref.read(taxParamsDaoProvider);
    final p = widget.params;
    await dao.upsert(
      TaxParamsCompanion(
        year: Value(widget.year),
        zelfstandigenaftrek: Value(-_zelfs),
        startersaftrek: Value(-_starters),
        mkbWinstvrijstellingPct: Value(_pct(_mkbPct)),
        bracket1Rate: Value(_pct(_b1Rate)),
        bracket1Threshold: Value(_b1Thresh),
        bracket2Rate: Value(_pct(_b2Rate)),
        bracket2Threshold: Value(_b2Thresh),
        bracket3Rate: Value(_pct(_b3Rate)),
        algHeffingskortingMax: Value(_algHeff),
        arbeidskortingMax: Value(_arbeids),
        zvwRate: Value(_pct(_zvwRate)),
        zvwMax: Value(_zvwMax),
        mixedCostsThreshold: Value(p?.mixedCostsThreshold ?? 0),
        mixedCosts80Pct: Value(p?.mixedCosts80Pct ?? 0.0),
        jaarruimtePct: Value(p?.jaarruimtePct ?? 0.0),
        jaarruimteMax: Value(p?.jaarruimteMax ?? 0),
        aowFranchise: Value(p?.aowFranchise ?? 0),
        reserveringsruimteMax: Value(p?.reserveringsruimteMax ?? 0),
        factorAMultiplier: Value(p?.factorAMultiplier ?? 0.0),
        urencriteriumThreshold: Value(
          int.tryParse(_urenThresh.text) ??
              TaxService.urencriteriumThreshold.toInt(),
        ),
        kiaLowerThreshold: Value(_kiaLowerThresh),
        kiaUpperThreshold: Value(_kiaUpperThresh),
        kiaFlatThreshold: Value(_kiaFlatThresh),
        kiaRate: Value(_pct(_kiaRate)),
        kiaFlatAmount: Value(_kiaFlatAmount),
        kiaDecreaseRate: Value(_pct(_kiaDecreaseRate)),
        mileageRatePerKm: Value(
          double.tryParse(_mileageRate.text.replaceAll(',', '.')) ??
              p?.mileageRatePerKm ??
              0.0,
        ),
        korThreshold: Value(_korThresh),
        ossThreshold: Value(p?.ossThreshold ?? 0),
        belastingrentePct: Value(p?.belastingrentePct ?? 0.0),
      ),
    );
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
            _amountField(l, l.settingsTaxZelfs, _zelfs, (v) => _zelfs = v),
            _amountField(
              l,
              l.settingsTaxStarters,
              _starters,
              (v) => _starters = v,
            ),
          ),
          _row2(
            _field(l, l.settingsTaxMkb, _mkbPct),
            _field(l, l.settingsTaxMileage, _mileageRate),
          ),
          _row2(
            _field(l, l.settingsTaxUrencriterium, _urenThresh),
            const SizedBox(),
          ),
          const SizedBox(height: 16),
          Text(l.settingsTaxBrackets, style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          _row2(
            _field(l, l.settingsTaxB1Rate, _b1Rate),
            _amountField(
              l,
              l.settingsTaxB1Thresh,
              _b1Thresh,
              (v) => _b1Thresh = v,
            ),
          ),
          _row2(
            _field(l, l.settingsTaxB2Rate, _b2Rate),
            _amountField(
              l,
              l.settingsTaxB2Thresh,
              _b2Thresh,
              (v) => _b2Thresh = v,
            ),
          ),
          _row2(_field(l, l.settingsTaxB3Rate, _b3Rate), const SizedBox()),
          const SizedBox(height: 16),
          Text(l.settingsTaxKortingen, style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          _row2(
            _amountField(
              l,
              l.settingsTaxAlgHeff,
              _algHeff,
              (v) => _algHeff = v,
            ),
            _amountField(
              l,
              l.settingsTaxArbeids,
              _arbeids,
              (v) => _arbeids = v,
            ),
          ),
          _row2(
            _field(l, l.settingsTaxZvwRate, _zvwRate),
            _amountField(l, l.settingsTaxZvwMax, _zvwMax, (v) => _zvwMax = v),
          ),
          const SizedBox(height: 16),
          Text(l.settingsTaxKia, style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          _row2(
            _amountField(
              l,
              l.settingsTaxKiaLowerThresh,
              _kiaLowerThresh,
              (v) => _kiaLowerThresh = v,
            ),
            _amountField(
              l,
              l.settingsTaxKiaUpperThresh,
              _kiaUpperThresh,
              (v) => _kiaUpperThresh = v,
            ),
          ),
          _row2(
            _amountField(
              l,
              l.settingsTaxKiaFlatThresh,
              _kiaFlatThresh,
              (v) => _kiaFlatThresh = v,
            ),
            _amountField(
              l,
              l.settingsTaxKiaFlatAmount,
              _kiaFlatAmount,
              (v) => _kiaFlatAmount = v,
            ),
          ),
          _row2(
            _field(l, l.settingsTaxKiaRate, _kiaRate),
            _field(l, l.settingsTaxKiaDecreaseRate, _kiaDecreaseRate),
          ),
          const SizedBox(height: 16),
          Text(l.settingsTaxKor, style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          _row2(
            _amountField(
              l,
              l.settingsTaxKorThresh,
              _korThresh,
              (v) => _korThresh = v,
            ),
            const SizedBox(),
          ),
          const SizedBox(height: 24),
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

  Widget _amountField(
    AppLocalizations l,
    String label,
    int value,
    ValueChanged<int> onChanged,
  ) {
    return AmountField(
      key: ValueKey('${widget.year}_$label'),
      label: '$label *',
      initialValueCents: value,
      required: true,
      validatorMessage: l.settingsTaxValidateField,
      onChanged: onChanged,
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
