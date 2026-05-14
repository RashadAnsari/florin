import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../services/tax_service.dart';
import '../../services/vat_service.dart';
import '../../theme/app_theme.dart';
import '../../constants/prefs_keys.dart';
import '../../widgets/stat_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final invoices = ref.watch(invoicesStreamProvider(year)).valueOrNull ?? [];
    final expenses = ref.watch(expensesStreamProvider(year)).valueOrNull ?? [];
    final hours = ref.watch(hourEntriesStreamProvider(year)).valueOrNull ?? [];
    final mileage =
        ref.watch(mileageTripsStreamProvider(year)).valueOrNull ?? [];
    final assets = ref.watch(assetsStreamProvider(year)).valueOrNull ?? [];
    final params = ref.watch(taxParamsStreamProvider(year)).valueOrNull;
    final pension = ref.watch(pensionStreamProvider(year)).valueOrNull;

    final taxService = const TaxService();
    final vatService = const VatService();

    // Revenue
    final grossRevenue = TaxService.computeGrossRevenue(invoices);
    final creditNotes = TaxService.computeCreditNotes(invoices);
    final netRevenue = grossRevenue - creditNotes;

    // Unpaid invoices
    final unpaidCount = invoices
        .where((i) => i.invoiceType == 'Invoice' && i.status == 'Sent')
        .length;
    final unpaidAmount = invoices
        .where((i) => i.invoiceType == 'Invoice' && i.status == 'Sent')
        .fold<int>(0, (s, i) => s + i.totalInclVat);

    // Expenses
    final totalExpenses = TaxService.computeDeductibleExpenses(expenses);

    // Hours
    final totalHours = hours.fold<double>(0.0, (s, h) => s + h.hours);
    final hoursTarget =
        (params?.urencriteriumThreshold ?? TaxService.urencriteriumThreshold)
            .toDouble();
    final hoursProgress = (totalHours / hoursTarget).clamp(0.0, 1.0);
    final yearDone = year < DateTime.now().year;
    final urenOk = totalHours >= hoursTarget;

    // Tax estimate
    final businessKm = TaxService.computeBusinessKm(mileage);
    final mileageAllowance = params != null
        ? TaxService.computeMileageAllowance(
            businessKm,
            params.mileageRatePerKm,
          )
        : 0;
    final totalDepreciation = TaxService.computeTotalDepreciation(assets, year);
    final kiaTotal = TaxService.computeKiaTotal(assets, year);
    final kiaDeduction = params != null
        ? taxService.computeKia(params, kiaTotal)
        : 0;

    TaxResult? taxResult;
    if (params != null) {
      taxResult = taxService.calculate(
        params: params,
        grossRevenue: grossRevenue,
        creditNotes: creditNotes,
        totalDeductibleExpenses: totalExpenses,
        totalDepreciation: totalDepreciation,
        carMileageAllowance: mileageAllowance,
        kiaDeduction: kiaDeduction,
        claimZelfstandigenaftrek: urenOk || !yearDone,
        claimStartersaftrek: false,
        wbsoDeduction: 0,
        algHeffingskorting: params.algHeffingskortingMax,
        arbeidskorting: params.arbeidskortingMax,
        lijrenteDeduction: pension?.plannedContribution ?? 0,
      );
    }

    // VAT deadlines
    final now = DateTime.now();
    final currentQ = year == now.year ? 'Q${((now.month - 1) ~/ 3) + 1}' : null;

    // Monthly revenue chart data
    final monthlyRevenue = List<int>.filled(12, 0);
    for (final inv in invoices) {
      if (inv.invoiceType == 'Invoice' && inv.status != 'Draft') {
        monthlyRevenue[inv.invoiceDate.month - 1] += inv.totalExclVat;
      }
    }
    final maxMonthly = monthlyRevenue.isEmpty
        ? 1
        : monthlyRevenue.reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(title: Text(l.dashboardTitle(year))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI row
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: StatCard(
                      label: l.dashboardNetRevenue,
                      value: AppFormat.cents(netRevenue),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatCard(
                      label: l.dashboardDeductibleCosts,
                      value: AppFormat.cents(totalExpenses),
                    ),
                  ),
                  if (taxResult != null) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        label: l.dashboardEstimatedTax,
                        value: AppFormat.cents(taxResult.totalTax),
                        delta: l.dashboardEffectiveRate(
                          (taxResult.effectiveTaxRate / 100).toStringAsFixed(1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        label: l.dashboardNetProfitAfterTax,
                        value: AppFormat.cents(taxResult.netProfitAfterTax),
                        deltaColor: taxResult.netProfitAfterTax >= 0
                            ? AppColors.income
                            : AppColors.red,
                      ),
                    ),
                  ],
                  if (unpaidCount > 0) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        label: l.dashboardOutstandingInvoices,
                        value: AppFormat.cents(unpaidAmount),
                        delta: l.dashboardInvoiceCount(unpaidCount),
                        deltaColor: AppColors.expense,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Hours progress
            Text(
              l.dashboardUrencriterium,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  l.dashboardHoursProgress(
                    totalHours.toStringAsFixed(1),
                    hoursTarget.toStringAsFixed(0),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: urenOk
                        ? AppColors.income
                        : yearDone
                        ? AppColors.red
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: hoursProgress,
                      minHeight: 8,
                      color: urenOk
                          ? AppColors.income
                          : yearDone
                          ? AppColors.red
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // VAT deadlines
            Text(
              l.dashboardBtwDeadlines,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: ['Q1', 'Q2', 'Q3', 'Q4'].map((q) {
                final dl = vatService.filingDeadline(year, q);
                final isCurrent = currentQ != null && q == currentQ;
                return _DeadlineChip(
                  quarter: q,
                  deadline: dl,
                  isCurrent: isCurrent,
                  year: year,
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Monthly revenue bar chart
            Text(
              l.dashboardMonthlyRevenue,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: _MonthlyBarChart(
                values: monthlyRevenue,
                maxValue: maxMonthly,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeadlineChip extends ConsumerWidget {
  final String quarter;
  final DateTime deadline;
  final bool isCurrent;
  final int year;

  const _DeadlineChip({
    required this.quarter,
    required this.deadline,
    required this.isCurrent,
    required this.year,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final prefs = ref.read(sharedPreferencesProvider);
    final filed = prefs.getBool(PrefsKeys.vatFiled(year, quarter)) ?? false;

    final theme = Theme.of(context);
    final now = DateTime.now();
    final daysLeft = deadline.difference(now).inDays;
    final overdue = now.isAfter(deadline) && !filed;
    final urgent =
        !filed && daysLeft <= VatService.urgentDeadlineDays && daysLeft >= 0;

    Color chipColor;
    if (filed) {
      chipColor = AppColors.income;
    } else if (overdue) {
      chipColor = AppColors.red;
    } else if (urgent) {
      chipColor = AppColors.vat;
    } else {
      chipColor = theme.colorScheme.outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isCurrent ? chipColor : chipColor.withValues(alpha: 0.4),
        ),
        borderRadius: BorderRadius.circular(8),
        color: isCurrent ? chipColor.withValues(alpha: 0.08) : null,
      ),
      child: Column(
        children: [
          Text(
            quarter,
            style: TextStyle(fontWeight: FontWeight.w700, color: chipColor),
          ),
          Text(AppFormat.date(deadline), style: theme.textTheme.bodySmall),
          if (filed)
            Text(
              l.deadlineStatusFiled,
              style: const TextStyle(color: AppColors.income, fontSize: 11),
            )
          else if (overdue)
            Text(
              l.deadlineStatusOverdue,
              style: const TextStyle(color: AppColors.red, fontSize: 11),
            )
          else
            Text(
              l.deadlineDaysLeft(daysLeft),
              style: TextStyle(color: chipColor, fontSize: 11),
            ),
        ],
      ),
    );
  }
}

class _MonthlyBarChart extends StatelessWidget {
  final List<int> values;
  final int maxValue;

  const _MonthlyBarChart({required this.values, required this.maxValue});

  static const _months = [
    'J',
    'F',
    'M',
    'A',
    'M',
    'J',
    'J',
    'A',
    'S',
    'O',
    'N',
    'D',
  ];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(12, (i) {
        final ratio = maxValue > 0 ? values[i] / maxValue : 0.0;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (values[i] > 0)
                  Text(
                    AppFormat.cents(
                      values[i],
                    ).replaceAll('€ ', '').split(',').first,
                    style: const TextStyle(fontSize: 9),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 2),
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: ratio.clamp(0.02, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.7),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(_months[i], style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        );
      }),
    );
  }
}
