import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
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
  int? _loadedPensionYear;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final paramsAsync = ref.watch(taxParamsStreamProvider(year));
    final pensionAsync = ref.watch(pensionStreamProvider(year));
    final invoicesAsync = ref.watch(invoicesStreamProvider(year));
    final expensesAsync = ref.watch(expensesStreamProvider(year));
    final assetsAsync = ref.watch(assetsStreamProvider(year));
    final hoursAsync = ref.watch(hourEntriesStreamProvider(year));
    final mileageAsync = ref.watch(mileageTripsStreamProvider(year));

    final invoices = invoicesAsync.valueOrNull ?? [];
    final expenses = expensesAsync.valueOrNull ?? [];
    final assets = assetsAsync.valueOrNull ?? [];
    final hours = hoursAsync.valueOrNull ?? [];
    final mileage = mileageAsync.valueOrNull ?? [];
    final loadError = paramsAsync.hasError
        ? paramsAsync.error
        : pensionAsync.hasError
        ? pensionAsync.error
        : invoicesAsync.hasError
        ? invoicesAsync.error
        : expensesAsync.hasError
        ? expensesAsync.error
        : assetsAsync.hasError
        ? assetsAsync.error
        : hoursAsync.hasError
        ? hoursAsync.error
        : mileageAsync.hasError
        ? mileageAsync.error
        : null;
    final isLoading =
        paramsAsync.isLoading ||
        pensionAsync.isLoading ||
        invoicesAsync.isLoading ||
        expensesAsync.isLoading ||
        assetsAsync.isLoading ||
        hoursAsync.isLoading ||
        mileageAsync.isLoading;

    final params = paramsAsync.valueOrNull;
    if (loadError != null) {
      return Scaffold(
        appBar: AppBar(title: Text(l.pensionTitle)),
        body: Center(child: Text(l.pensionLoadError('$loadError'))),
      );
    }
    if (isLoading || params == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l.pensionTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final pension = pensionAsync.valueOrNull;

    if (_loadedPensionYear != year) {
      _factorA = pension?.factorA ?? 0.0;
      _unusedPriorYears = pension?.unusedPriorYearsSpace ?? 0;
      _loadedPensionYear = year;
    }

    final grossRevenue = TaxService.computeGrossRevenue(invoices);
    final creditNotes = TaxService.computeCreditNotes(invoices);
    final totalDeductible = TaxService.computeDeductibleExpenses(expenses);
    final businessKm = TaxService.computeBusinessKm(mileage);
    final mileageAllowance = TaxService.computeMileageAllowance(
      businessKm,
      params.mileageRatePerKm,
    );
    final totalDepreciation = TaxService.computeTotalDepreciation(assets, year);
    final kiaTotal = TaxService.computeKiaTotal(assets, year);
    final kiaDeduction = _taxService.computeKia(params, kiaTotal);
    final totalHours = hours.fold<double>(0.0, (s, h) => s + h.hours);
    final urenOk = totalHours >= params.urencriteriumThreshold;

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
      appBar: AppBar(title: Text(l.pensionTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _head(l.pensionJaarruimte, context),
            _row(
              l.pensionTaxableProfit,
              AppFormat.cents(taxResult.taxableProfit),
            ),
            _row(l.pensionAowFranchise, AppFormat.cents(params.aowFranchise)),
            _row(
              l.pensionPensioengrondslag,
              AppFormat.cents(jaarruimteResult.pensioengrondslag),
              bold: true,
            ),
            const SizedBox(height: 8),
            _row(
              l.pensionJaarruimte30,
              AppFormat.cents(jaarruimteResult.jaarruimte),
            ),
            _row(
              l.pensionJaarruimteMax(AppFormat.cents(params.jaarruimteMax)),
              AppFormat.cents(jaarruimteResult.jaarruimteCapped),
              bold: true,
            ),
            const SizedBox(height: 8),
            _row(
              l.pensionReserveringsruimte,
              AppFormat.cents(jaarruimteResult.reserveringsruimte),
            ),
            _row(
              l.pensionTotalBudget,
              AppFormat.cents(jaarruimteResult.totalBudget),
              bold: true,
              valueColor: AppColors.income,
            ),
            _row(
              l.pensionEstimatedTaxSaving,
              AppFormat.cents(jaarruimteResult.estimatedTaxSaving),
              valueColor: AppColors.income,
            ),
            const Divider(height: 32),

            _head(l.pensionInputSection, context),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AmountField(
                    key: ValueKey('factor_a_$year'),
                    label: l.pensionFactorA,
                    initialValueCents: (_factorA * 100).round(),
                    helperText: l.pensionFactorAHelper,
                    onChanged: (v) {
                      setState(() => _factorA = v / 100);
                      _savePensionInputs();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AmountField(
                    key: const ValueKey('reserveringsruimte'),
                    label: l.pensionReserveringsruimteLabel,
                    initialValueCents: _unusedPriorYears,
                    helperText: ' ',
                    onChanged: (v) {
                      setState(() => _unusedPriorYears = v);
                      _savePensionInputs();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _head(l.pensionPlannedSection, context),
            const SizedBox(height: 8),
            AmountField(
              key: ValueKey('lijfrente_$year'),
              label: l.pensionLijfrente,
              initialValueCents: pension?.plannedContribution ?? 0,
              helperText: l.pensionLijfrenteHelper,
              onChanged: (v) => _savePlannedContribution(v),
            ),
            const SizedBox(height: 24),

            _head(l.pensionAovSection, context),
            const SizedBox(height: 8),
            _AovSection(pension: pension, year: year),
          ],
        ),
      ),
    );
  }

  Future<void> _savePensionInputs() async {
    final year = ref.read(fiscalYearProvider);
    final dao = ref.read(taxParamsDaoProvider);
    final pension = await dao.getPensionByYear(year);
    await dao.upsertPension(
      PensionEntriesCompanion(
        fiscalYear: Value(year),
        factorA: Value(_factorA),
        unusedPriorYearsSpace: Value(_unusedPriorYears),
        plannedContribution: Value(pension?.plannedContribution ?? 0),
        aovInsured: Value(pension?.aovInsured ?? false),
        monthlyAovPremium: Value(pension?.monthlyAovPremium ?? 0),
        notes: Value(pension?.notes),
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
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: bold ? FontWeight.w700 : null,
      color: valueColor,
    );
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
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          value: _insured,
          onChanged: (v) {
            setState(() => _insured = v ?? _insured);
            _save();
          },
          title: Text(l.pensionAovInsured),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
        if (_insured) ...[
          const SizedBox(height: 12),
          AmountField(
            key: ValueKey('aov_premium_${widget.year}'),
            label: l.pensionMonthlyPremium,
            initialValueCents: _monthlyPremium,
            helperText: l.pensionAnnualPremium(
              AppFormat.cents(_monthlyPremium * 12),
            ),
            onChanged: (v) {
              setState(() => _monthlyPremium = v);
              _save();
            },
          ),
        ],
      ],
    );
  }
}
