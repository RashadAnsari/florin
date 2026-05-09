import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../services/tax_service.dart';
import '../../services/vat_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stat_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final grossRevenue = invoices
        .where((i) => i.invoiceType == 'Invoice' && i.status != 'Draft')
        .fold<int>(0, (s, i) => s + i.totalExclVat);
    final creditNotes = invoices
        .where((i) => i.invoiceType == 'CreditNote' && i.status != 'Draft')
        .fold<int>(0, (s, i) => s + i.totalExclVat);
    final netRevenue = grossRevenue - creditNotes;

    // Unpaid invoices
    final unpaidCount = invoices
        .where((i) => i.invoiceType == 'Invoice' && i.status == 'Sent')
        .length;
    final unpaidAmount = invoices
        .where((i) => i.invoiceType == 'Invoice' && i.status == 'Sent')
        .fold<int>(0, (s, i) => s + i.totalInclVat);

    // Expenses
    final totalExpenses = expenses.fold<int>(
      0,
      (s, e) => s + e.deductibleAmount,
    );

    // Hours
    final totalHours = hours.fold<double>(0.0, (s, h) => s + h.hours);
    const hoursTarget = 1225.0;
    final hoursProgress = (totalHours / hoursTarget).clamp(0.0, 1.0);
    final yearDone = year < DateTime.now().year;
    final urenOk = totalHours >= hoursTarget;

    // Tax estimate
    final businessKm = mileage
        .where((m) => m.tripType == 'Business')
        .fold<int>(0, (s, m) => s + m.distanceKm);
    final mileageAllowance = params != null
        ? (businessKm * params.mileageRatePerKm * 100).round()
        : 0;
    final totalDepreciation = assets.fold<int>(0, (s, a) {
      if (a.disposalDate != null) return s;
      final yrs = (year - a.purchaseDate.year).clamp(0, a.usefulLifeYears);
      if (yrs >= a.usefulLifeYears) return s;
      return s +
          taxService.computeAnnualDepreciation(
            costExclVat: a.costExclVat,
            usefulLifeYears: a.usefulLifeYears,
            businessUsePct: a.businessUsePct,
          );
    });
    final kiaTotal = assets
        .where((a) => a.kiaEligible && a.fiscalYear == year)
        .fold<int>(0, (s, a) => s + a.costExclVat);
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
    final currentQ = 'Q${((DateTime.now().month - 1) ~/ 3) + 1}';

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
      appBar: AppBar(title: Text('Dashboard $year')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI row
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: 220,
                  child: StatCard(
                    label: 'Netto omzet',
                    value: AppFormat.cents(netRevenue),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: StatCard(
                    label: 'Kosten (aftrekbaar)',
                    value: AppFormat.cents(totalExpenses),
                  ),
                ),
                if (taxResult != null)
                  SizedBox(
                    width: 220,
                    child: StatCard(
                      label: 'Geschatte belasting',
                      value: AppFormat.cents(taxResult.totalTax),
                      delta:
                          'Effectief ${(taxResult.effectiveTaxRate / 100).toStringAsFixed(1)}%',
                    ),
                  ),
                if (taxResult != null)
                  SizedBox(
                    width: 220,
                    child: StatCard(
                      label: 'Netto winst na belasting',
                      value: AppFormat.cents(taxResult.netProfitAfterTax),
                      deltaColor: taxResult.netProfitAfterTax >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                if (unpaidCount > 0)
                  SizedBox(
                    width: 220,
                    child: StatCard(
                      label: 'Openstaande facturen',
                      value: AppFormat.cents(unpaidAmount),
                      delta: '$unpaidCount factuur/facturen',
                      deltaColor: Colors.orange,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 32),

            // Hours progress
            Text(
              'Urencriterium',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${totalHours.toStringAsFixed(1)} / ${hoursTarget.toStringAsFixed(0)} uur',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: urenOk
                        ? Colors.green
                        : yearDone
                        ? Colors.red
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
                          ? Colors.green
                          : yearDone
                          ? Colors.red
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // VAT deadlines
            Text(
              'BTW-deadlines',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: ['Q1', 'Q2', 'Q3', 'Q4'].map((q) {
                final dl = vatService.filingDeadline(year, q);
                final isCurrent = q == currentQ;
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
              'Maandelijkse omzet',
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
    final prefs = ref.read(sharedPreferencesProvider);
    final filed =
        prefs.getBool('vat_${year}_${quarter.toLowerCase()}_filed') ?? false;

    final theme = Theme.of(context);
    final now = DateTime.now();
    final daysLeft = deadline.difference(now).inDays;
    final overdue = now.isAfter(deadline) && !filed;
    final urgent = !filed && daysLeft <= 14 && daysLeft >= 0;

    Color chipColor;
    if (filed) {
      chipColor = Colors.green;
    } else if (overdue) {
      chipColor = Colors.red;
    } else if (urgent) {
      chipColor = Colors.orange;
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
            const Text(
              'ingediend',
              style: TextStyle(color: Colors.green, fontSize: 11),
            )
          else if (overdue)
            const Text(
              'te laat',
              style: TextStyle(color: Colors.red, fontSize: 11),
            )
          else
            Text(
              '$daysLeft d',
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
                    ).replaceAll('€ ', '').split(',').first,
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
