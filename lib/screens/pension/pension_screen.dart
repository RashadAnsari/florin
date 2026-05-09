import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/pension_service.dart';
import '../../services/tax_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/amount_field.dart';

class PensionScreen extends ConsumerStatefulWidget {
  const PensionScreen({super.key});

  @override
  ConsumerState<PensionScreen> createState() => _PensionScreenState();
}

class _PensionScreenState extends ConsumerState<PensionScreen> {
  final _taxService = const TaxService();
  final _pensionService = const PensionService();

  double _factorA = 0.0;
  int _unusedPriorYears = 0;

  @override
  Widget build(BuildContext context) {
    final year = ref.watch(fiscalYearProvider);
    final paramsAsync = ref.watch(taxParamsStreamProvider(year));
    final pensionAsync = ref.watch(pensionStreamProvider(year));
    final invoices = ref.watch(invoicesStreamProvider(year)).valueOrNull ?? [];
    final expenses = ref.watch(expensesStreamProvider(year)).valueOrNull ?? [];
    final assets = ref.watch(assetsStreamProvider(year)).valueOrNull ?? [];
    final hours = ref.watch(hourEntriesStreamProvider(year)).valueOrNull ?? [];
    final mileage =
        ref.watch(mileageTripsStreamProvider(year)).valueOrNull ?? [];

    final params = paramsAsync.valueOrNull;
    if (params == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final pension = pensionAsync.valueOrNull;

    if (pension != null && _factorA == 0.0 && pension.factorA > 0) {
      _factorA = pension.factorA;
      _unusedPriorYears = pension.unusedPriorYearsSpace;
    }

    final grossRevenue = invoices
        .where((i) => i.invoiceType == 'Invoice' && i.status != 'Draft')
        .fold<int>(0, (s, i) => s + i.totalExclVat);
    final creditNotes = invoices
        .where((i) => i.invoiceType == 'CreditNote' && i.status != 'Draft')
        .fold<int>(0, (s, i) => s + i.totalExclVat);
    final totalDeductible = expenses.fold<int>(
      0,
      (s, e) => s + e.deductibleAmount,
    );
    final businessKm = mileage
        .where((m) => m.tripType == 'Business')
        .fold<int>(0, (s, m) => s + m.distanceKm);
    final mileageAllowance = (businessKm * params.mileageRatePerKm * 100)
        .round();
    final totalDepreciation = assets.fold<int>(0, (s, a) {
      if (a.disposalDate != null) return s;
      final yrs = (year - a.purchaseDate.year).clamp(0, a.usefulLifeYears);
      if (yrs >= a.usefulLifeYears) return s;
      return s +
          _taxService.computeAnnualDepreciation(
            costExclVat: a.costExclVat,
            usefulLifeYears: a.usefulLifeYears,
            businessUsePct: a.businessUsePct,
          );
    });
    final kiaTotal = assets
        .where((a) => a.kiaEligible && a.fiscalYear == year)
        .fold<int>(0, (s, a) => s + a.costExclVat);
    final kiaDeduction = _taxService.computeKia(params, kiaTotal);
    final totalHours = hours.fold<double>(0.0, (s, h) => s + h.hours);
    final urenOk = totalHours >= 1225;

    final taxResult = _taxService.calculate(
      params: params,
      grossRevenue: grossRevenue,
      creditNotes: creditNotes,
      totalDeductibleExpenses: totalDeductible,
      totalDepreciation: totalDepreciation,
      carMileageAllowance: mileageAllowance,
      kiaDeduction: kiaDeduction,
      claimZelfstandigenaftrek: urenOk,
      claimStartersaftrek: false,
      wbsoDeduction: 0,
      algHeffingskorting: params.algHeffingskortingMax,
      arbeidskorting: params.arbeidskortingMax,
      lijrenteDeduction: pension?.plannedContribution ?? 0,
    );

    final marginalRate = taxResult.taxableProfit > params.bracket1Threshold
        ? params.bracket2Rate
        : params.bracket1Rate;

    final jaarruimteResult = _pensionService.calculate(
      params: params,
      taxableProfit: taxResult.taxableProfit,
      factorA: _factorA,
      unusedPriorYears: _unusedPriorYears,
      marginalRate: marginalRate,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Pensioen')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _head('JAARRUIMTEBEREKENING', context),
              _row(
                'Belastbare winst',
                AppFormat.cents(taxResult.taxableProfit),
              ),
              _row('AOW-franchise', AppFormat.cents(params.aowFranchise)),
              _row(
                'Pensioengrondslag',
                AppFormat.cents(jaarruimteResult.pensioengrondsdag),
                bold: true,
              ),
              const SizedBox(height: 8),
              _row(
                'Jaarruimte (30%)',
                AppFormat.cents(jaarruimteResult.jaarruimte),
              ),
              _row(
                'Jaarruimte (max ${AppFormat.cents(params.jaarruimteMax)})',
                AppFormat.cents(jaarruimteResult.jaarruimteCapped),
                bold: true,
              ),
              const SizedBox(height: 8),
              _row(
                'Reserveringsruimte',
                AppFormat.cents(jaarruimteResult.reserveringsruimte),
              ),
              _row(
                'Totaal beschikbaar',
                AppFormat.cents(jaarruimteResult.totalBudget),
                bold: true,
                valueColor: AppColors.income,
              ),
              _row(
                'Geschatte belastingbesparing',
                AppFormat.cents(jaarruimteResult.estimatedTaxSaving),
                valueColor: AppColors.income,
              ),
              const Divider(height: 32),

              _head('INVOER', context),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _factorA
                          .toStringAsFixed(2)
                          .replaceAll('.', ','),
                      decoration: const InputDecoration(
                        labelText: 'Factor A (euro\'s)',
                        helperText: 'Pensioenopbouw bij werkgever/BV',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (v) {
                        final d = double.tryParse(v.replaceAll(',', '.'));
                        if (d != null) setState(() => _factorA = d);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AmountField(
                      key: const ValueKey('reserveringsruimte'),
                      label: 'Reserveringsruimte (ongebruikte jaren)',
                      initialValueCents: _unusedPriorYears,
                      onChanged: (v) => setState(() => _unusedPriorYears = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _head('VOORGENOMEN INLEG', context),
              const SizedBox(height: 8),
              AmountField(
                key: ValueKey('lijfrente_$year'),
                label: 'Lijfrentepremie / AOV-premie',
                initialValueCents: pension?.plannedContribution ?? 0,
                helperText:
                    'Wordt als aftrekpost meegenomen in belastingberekening',
                onChanged: (v) => _savePlannedContribution(v),
              ),
              const SizedBox(height: 24),

              _head('AOV (ARBEIDSONGESCHIKTHEIDSVERZEKERING)', context),
              const SizedBox(height: 8),
              _AovSection(pension: pension, year: year),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _savePlannedContribution(int cents) async {
    final year = ref.read(fiscalYearProvider);
    final dao = ref.read(taxParamsDaoProvider);
    final pension = await dao.getPensionByYear(year);
    await dao.upsertPension(
      PensionEntriesCompanion(
        fiscalYear: Value(year),
        factorA: Value(_factorA),
        unusedPriorYearsSpace: Value(_unusedPriorYears),
        plannedContribution: Value(cents),
        aovInsured: Value(pension?.aovInsured ?? false),
        monthlyAovPremium: Value(pension?.monthlyAovPremium ?? 0),
        notes: Value(pension?.notes),
      ),
    );
  }

  Widget _head(String t, BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 4),
    child: Text(
      t,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        letterSpacing: 1.2,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    ),
  );

  Widget _row(
    String label,
    String value, {
    bool bold = false,
    Color? valueColor,
  }) {
    final style = bold
        ? TextStyle(fontWeight: FontWeight.w700, color: valueColor)
        : TextStyle(color: valueColor);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}

class _AovSection extends ConsumerStatefulWidget {
  final PensionEntry? pension;
  final int year;

  const _AovSection({required this.pension, required this.year});

  @override
  ConsumerState<_AovSection> createState() => _AovSectionState();
}

class _AovSectionState extends ConsumerState<_AovSection> {
  late bool _insured;
  late int _monthlyPremium;

  @override
  void initState() {
    super.initState();
    _insured = widget.pension?.aovInsured ?? false;
    _monthlyPremium = widget.pension?.monthlyAovPremium ?? 0;
  }

  Future<void> _save() async {
    final dao = ref.read(taxParamsDaoProvider);
    final pension = await dao.getPensionByYear(widget.year);
    await dao.upsertPension(
      PensionEntriesCompanion(
        fiscalYear: Value(widget.year),
        factorA: Value(pension?.factorA ?? 0.0),
        unusedPriorYearsSpace: Value(pension?.unusedPriorYearsSpace ?? 0),
        plannedContribution: Value(pension?.plannedContribution ?? 0),
        aovInsured: Value(_insured),
        monthlyAovPremium: Value(_monthlyPremium),
        notes: Value(pension?.notes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          value: _insured,
          onChanged: (v) {
            setState(() => _insured = v ?? _insured);
            _save();
          },
          title: const Text('AOV afgesloten'),
          contentPadding: EdgeInsets.zero,
        ),
        if (_insured) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: 280,
            child: AmountField(
              key: ValueKey('aov_premium_${widget.year}'),
              label: 'Maandelijkse premie',
              initialValueCents: _monthlyPremium,
              onChanged: (v) {
                setState(() => _monthlyPremium = v);
                _save();
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Jaarlijkse premie: ${AppFormat.cents(_monthlyPremium * 12)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
