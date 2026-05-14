import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/tax_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/amount_field.dart';
import '../expenses/expenses_screen.dart' show expenseCategoryLabels;

class PlTaxScreen extends ConsumerStatefulWidget {
  const PlTaxScreen({super.key});

  @override
  ConsumerState<PlTaxScreen> createState() => _PlTaxScreenState();
}

class _PlTaxScreenState extends ConsumerState<PlTaxScreen> {
  int? _algHeffingOverride;
  int? _arbeidskortingOverride;
  bool _claimZelfs = true;
  bool _claimStarters = false;
  final _service = const TaxService();

  @override
  void initState() {
    super.initState();
    final prefs = ref.read(sharedPreferencesProvider);
    _claimStarters = prefs.getBool('is_starter') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final year = ref.watch(fiscalYearProvider);
    final invoicesAsync = ref.watch(invoicesStreamProvider(year));
    final expensesAsync = ref.watch(expensesStreamProvider(year));
    final hoursAsync = ref.watch(hourEntriesStreamProvider(year));
    final mileageAsync = ref.watch(mileageTripsStreamProvider(year));
    final assetsAsync = ref.watch(assetsStreamProvider(year));
    final paramsAsync = ref.watch(taxParamsStreamProvider(year));
    final pensionAsync = ref.watch(pensionStreamProvider(year));

    final invoices = invoicesAsync.valueOrNull ?? [];
    final expenses = expensesAsync.valueOrNull ?? [];
    final hours = hoursAsync.valueOrNull ?? [];
    final mileage = mileageAsync.valueOrNull ?? [];
    final assets = assetsAsync.valueOrNull ?? [];
    final pension = pensionAsync.valueOrNull;
    final params = paramsAsync.valueOrNull;
    final isLoading =
        invoicesAsync.isLoading ||
        expensesAsync.isLoading ||
        hoursAsync.isLoading ||
        mileageAsync.isLoading ||
        assetsAsync.isLoading ||
        paramsAsync.isLoading ||
        pensionAsync.isLoading;
    final loadError = invoicesAsync.hasError
        ? invoicesAsync.error
        : expensesAsync.hasError
        ? expensesAsync.error
        : hoursAsync.hasError
        ? hoursAsync.error
        : mileageAsync.hasError
        ? mileageAsync.error
        : assetsAsync.hasError
        ? assetsAsync.error
        : paramsAsync.hasError
        ? paramsAsync.error
        : pensionAsync.hasError
        ? pensionAsync.error
        : null;

    Widget body;
    if (loadError != null) {
      body = Center(child: Text(l.plTaxLoadError('$loadError')));
    } else if (isLoading || params == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = _content(
        context: context,
        l: l,
        theme: theme,
        year: year,
        invoices: invoices,
        expenses: expenses,
        hours: hours,
        mileage: mileage,
        assets: assets,
        pension: pension,
        params: params,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.plTaxTitle)),
      body: body,
    );
  }

  Widget _content({
    required BuildContext context,
    required AppLocalizations l,
    required ThemeData theme,
    required int year,
    required List<Invoice> invoices,
    required List<Expense> expenses,
    required List<HourEntry> hours,
    required List<MileageTrip> mileage,
    required List<FixedAsset> assets,
    required PensionEntry? pension,
    required TaxParam params,
  }) {
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
    final kiaDeduction = _service.computeKia(params, kiaTotal);
    final lijrente = pension?.plannedContribution ?? 0;

    final totalHours = hours.fold<double>(0.0, (s, h) => s + h.hours);
    final yearDone = year < DateTime.now().year;
    final urenOk = totalHours >= params.urencriteriumThreshold;
    final claimZelfs = _claimZelfs && (urenOk || !yearDone);

    final algHeffing = _algHeffingOverride ?? params.algHeffingskortingMax;
    final arbeids = _arbeidskortingOverride ?? params.arbeidskortingMax;

    final result = _service.calculate(
      params: params,
      grossRevenue: grossRevenue,
      creditNotes: creditNotes,
      totalDeductibleExpenses: totalDeductible,
      totalDepreciation: totalDepreciation,
      carMileageAllowance: mileageAllowance,
      kiaDeduction: kiaDeduction,
      claimZelfstandigenaftrek: claimZelfs,
      claimStartersaftrek: _claimStarters,
      wbsoDeduction: 0,
      algHeffingskorting: algHeffing,
      arbeidskorting: arbeids,
      lijrenteDeduction: lijrente,
    );

    final expByCategory = <String, int>{};
    for (final e in expenses) {
      expByCategory[e.category] =
          (expByCategory[e.category] ?? 0) + e.deductibleAmount;
    }

    final catLabels = expenseCategoryLabels(l);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!urenOk)
            _banner(
              l.plTaxUrenBanner(
                totalHours.toStringAsFixed(1),
                yearDone
                    ? l.plTaxUrenBannerSuffixDone
                    : l.plTaxUrenBannerSuffixPending,
              ),
              yearDone ? theme.colorScheme.error : AppColors.expense,
              context,
            ),

          _head(l.plTaxRevenuSection, context),
          _plLine(l.plTaxGrossRevenue, result.grossRevenue),
          if (result.creditNotes > 0)
            _plLine(l.plTaxCreditNotes, -result.creditNotes),
          _plLine(l.plTaxNetRevenue, result.netRevenue, bold: true),
          const SizedBox(height: 12),

          _head(l.plTaxCostsSection, context),
          ...expByCategory.entries.map(
            (e) => _plLine(catLabels[e.key] ?? e.key, -e.value),
          ),
          if (mileageAllowance > 0)
            _plLine(
              l.plTaxMileageAllowance(
                businessKm,
                params.mileageRatePerKm.toStringAsFixed(2),
              ),
              -mileageAllowance,
            ),
          if (totalDepreciation > 0)
            _plLine(l.plTaxDepreciation, -totalDepreciation),
          _plLine(l.plTaxTotalCosts, -result.totalExpenses, bold: true),
          const SizedBox(height: 12),
          _plLine(l.plTaxGrossProfit, result.grossProfit, bold: true),
          const Divider(),

          _head(l.plTaxDeductionsSection, context),
          _plLine(
            l.plTaxZelfstandigenaftrek(year),
            result.zelfstandigenaftrekApplied,
            muted: !claimZelfs,
          ),
          if (_claimStarters)
            _plLine(l.plTaxStartersaftrek, result.startersaftrekApplied),
          _plLine(
            l.plTaxMkb(
              (params.mkbWinstvrijstellingPct * 100).toStringAsFixed(1),
            ),
            -result.mkbDeduction,
          ),
          if (kiaDeduction > 0) _plLine(l.plTaxKia, -kiaDeduction),
          if (lijrente > 0) _plLine(l.plTaxLijrente, -lijrente),
          _plLine(l.plTaxTaxableProfit, result.taxableProfit, bold: true),
          const Divider(),

          _head(l.plTaxBox1Section, context),
          _plLine(
            l.plTaxBracket1((params.bracket1Rate * 100).toStringAsFixed(2)),
            result.bracket1Tax,
          ),
          if (result.bracket2Tax > 0)
            _plLine(
              l.plTaxBracket2((params.bracket2Rate * 100).toStringAsFixed(2)),
              result.bracket2Tax,
            ),
          if (result.bracket3Tax > 0)
            _plLine(
              l.plTaxBracket3((params.bracket3Rate * 100).toStringAsFixed(2)),
              result.bracket3Tax,
            ),
          const SizedBox(height: 8),
          _kortingRow(
            l.plTaxAlgHeffing,
            algHeffing,
            params.algHeffingskortingMax,
            (v) => setState(() => _algHeffingOverride = v),
            context,
          ),
          _kortingRow(
            l.plTaxArbeidskorting,
            arbeids,
            params.arbeidskortingMax,
            (v) => setState(() => _arbeidskortingOverride = v),
            context,
          ),
          _plLine(l.plTaxInkomsten, result.box1Tax, bold: true),
          _plLine(
            l.plTaxZvw((params.zvwRate * 100).toStringAsFixed(2)),
            result.zvwContribution,
          ),
          const Divider(),
          _plLine(l.plTaxTotalTax, result.totalTax, bold: true),
          _plLine(l.plTaxNetProfit, result.netProfitAfterTax, bold: true),
          const SizedBox(height: 12),
          Text(
            l.plTaxEffectiveRate(
              (result.effectiveTaxRate / 100).toStringAsFixed(1),
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),

          _head(l.plTaxSettingsSection, context),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: _claimZelfs,
            onChanged: (v) => setState(() => _claimZelfs = v ?? true),
            title: Text(l.plTaxClaimZelfs),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
          CheckboxListTile(
            value: _claimStarters,
            onChanged: (v) => setState(() => _claimStarters = v ?? false),
            title: Text(l.plTaxClaimStarters),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        ],
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

  Widget _plLine(
    String label,
    int cents, {
    bool bold = false,
    bool muted = false,
  }) {
    final theme = Theme.of(context);
    final color = muted
        ? theme.colorScheme.outline
        : cents < 0
        ? theme.colorScheme.error
        : null;
    final ts = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: bold ? FontWeight.w700 : null,
      color: color,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: ts)),
          Text(
            cents < 0 ? '(${AppFormat.cents(-cents)})' : AppFormat.cents(cents),
            style: ts,
          ),
        ],
      ),
    );
  }

  Widget _kortingRow(
    String label,
    int current,
    int max,
    ValueChanged<int> onChanged,
    BuildContext context,
  ) {
    final l = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l.plTaxDeduct(label),
              style: const TextStyle(color: AppColors.income),
            ),
          ),
          Flexible(
            flex: 2,
            child: AmountField(
              key: ValueKey(label),
              initialValueCents: current,
              label: '',
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              l.plTaxMax(AppFormat.cents(max)),
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _banner(String msg, Color color, BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.warning_amber, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            msg,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: color),
          ),
        ),
      ],
    ),
  );
}
