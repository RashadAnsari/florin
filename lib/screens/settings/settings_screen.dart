import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../db/database.dart';
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Instellingen opgeslagen')));
    }
  }

  Future<void> _moveDb() async {
    final service = DbLocationService(ref.read(sharedPreferencesProvider));
    final result = await service.pickAndSetLocation();
    if (result != null && mounted) {
      await ref.read(dbPathNotifierProvider).setPath(result);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Database verplaatst naar $result')),
      );
    }
  }

  Future<void> _exportCsv() async {
    final year = ref.read(fiscalYearProvider);
    final db = ref.read(databaseProvider);
    setState(() => _exportRunning = true);
    try {
      final dir = await CsvExportService(db).exportYear(year);
      if (dir != null && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Geëxporteerd naar $dir')));
      }
    } finally {
      if (mounted) setState(() => _exportRunning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dbPath = ref.watch(dbPathNotifierProvider).path;
    final year = ref.watch(fiscalYearProvider);
    final paramsAsync = ref.watch(taxParamsStreamProvider(year));
    final params = paramsAsync.valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Instellingen')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Business identity ──────────────────────────────────────────
              Text('Bedrijfsgegevens', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Bedrijfsnaam'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _vat,
                      decoration: const InputDecoration(
                        labelText: 'BTW-nummer',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _kvk,
                      decoration: const InputDecoration(
                        labelText: 'KVK-nummer',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _address,
                decoration: const InputDecoration(labelText: 'Bedrijfsadres'),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _iban,
                decoration: const InputDecoration(labelText: 'IBAN'),
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                value: _isStarter,
                onChanged: (v) => setState(() => _isStarter = v ?? false),
                title: const Text('Recht op startersaftrek'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: _save, child: const Text('Opslaan')),
              const SizedBox(height: 40),

              // ── Database ─────────────────────────────────────────────────
              Text('Database', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(
                'Locatie: ${dbPath ?? 'Niet ingesteld'}',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _moveDb,
                icon: const Icon(Icons.drive_file_move_outlined),
                label: const Text('Database verplaatsen…'),
              ),
              const SizedBox(height: 40),

              // ── CSV export ───────────────────────────────────────────────
              Text('Exporteren', style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                'Exporteer alle gegevens van $year naar CSV-bestanden.',
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
                      ? 'Bezig met exporteren…'
                      : 'Exporteer $year als CSV',
                ),
              ),
              const SizedBox(height: 40),

              // ── Tax parameters ───────────────────────────────────────────
              Text(
                'Belastingparameters $year',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (params == null)
                Text(
                  'Geen parameters gevonden voor $year. Start de app opnieuw na het aanmaken van een database.',
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Belastingparameters opgeslagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tarieven & schijven', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        _row2(
          _field('Zelfstandigenaftrek (€)', _zelfs),
          _field('Startersaftrek (€)', _starters),
        ),
        _row2(
          _field('MKB-winstvrijstelling (%)', _mkbPct),
          _field('Kilometervergoeding (€/km)', _mileageRate),
        ),
        const SizedBox(height: 16),
        Text('Schijven inkomstenbelasting', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        _row2(
          _field('Schijf 1 tarief (%)', _b1Rate),
          _field('Schijf 1 grens (€)', _b1Thresh),
        ),
        _row2(
          _field('Schijf 2 tarief (%)', _b2Rate),
          _field('Schijf 2 grens (€)', _b2Thresh),
        ),
        _row2(_field('Schijf 3 tarief (%)', _b3Rate), const SizedBox()),
        const SizedBox(height: 16),
        Text('Kortingen & ZVW', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        _row2(
          _field('Alg. heffingskorting max (€)', _algHeff),
          _field('Arbeidskorting max (€)', _arbeids),
        ),
        _row2(
          _field('ZVW tarief (%)', _zvwRate),
          _field('ZVW max (€)', _zvwMax),
        ),
        const SizedBox(height: 16),
        Text('KOR drempel', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        SizedBox(width: 280, child: _field('KOR drempel (€)', _korThresh)),
        const SizedBox(height: 20),
        FilledButton(onPressed: _save, child: const Text('Parameters opslaan')),
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
