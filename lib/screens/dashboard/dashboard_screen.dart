import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/domain.dart';
import '../../services/tax_service.dart';
import '../../services/vat_service.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../services/kor_service.dart';
import '../../widgets/help.dart';
import '../../widgets/kor_progress.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/urencriterium_progress.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final year = ref.watch(fiscalYearProvider);
    final invoices = ref.watch(invoicesProvider(year)).valueOrNull ?? [];
    final hours = ref.watch(hourEntriesProvider(year)).valueOrNull ?? [];
    final rules = ref.watch(taxRulesProvider(year));
    final estimate = ref.watch(taxEstimateProvider(year)).valueOrNull;
    final kor = ref.watch(korStatusProvider).valueOrNull ?? KorStatus.none;
    final korTurnover = kor.turnover[year] ?? 0;
    // Shown to those who take part, and to those whose turnover allows it.
    final showKor = kor.participates || korTurnover <= rules.korThreshold;
    final filed = {
      for (final v in ref.watch(vatReturnsProvider(year)).valueOrNull ?? [])
        if (v.filed) v.quarter,
    };

    final unpaid = invoices.where(
      (i) =>
          i.invoiceType == InvoiceType.invoice &&
          i.status == InvoiceStatus.sent,
    );
    final monthly = List.filled(12, 0);
    for (final i in invoices) {
      if (!i.isIssued) continue;
      monthly[i.invoiceDate.month - 1] += i.signedExclVat;
    }
    final r = estimate?.result;

    Widget card(Widget child) => Expanded(child: child);
    final cards = <Widget>[
      card(
        StatCard(
          label: l.dashboardNetRevenue,
          value: AppFormat.cents(
            TaxService.grossRevenue(invoices) -
                TaxService.creditNotes(invoices),
          ),
        ),
      ),
      if (r != null) ...[
        card(
          StatCard(
            label: l.dashboardDeductibleCosts,
            help: l.dashboardDeductibleCostsHelp,
            value: AppFormat.cents(r.totalCosts),
          ),
        ),
        card(
          StatCard(
            label: l.dashboardEstimatedTax,
            help: l.dashboardEstimatedTaxHelp,
            value: AppFormat.cents(r.totalTax),
            delta: l.dashboardEffectiveRate(
              AppFormat.percent(r.effectiveTaxRate / 10000, 1),
            ),
          ),
        ),
        card(
          StatCard(
            label: l.dashboardNetProfitAfterTax,
            help: l.dashboardNetProfitAfterTaxHelp,
            value: AppFormat.cents(r.netProfitAfterTax),
          ),
        ),
      ],
      if (unpaid.isNotEmpty)
        card(
          StatCard(
            label: l.dashboardOutstandingInvoices,
            value: AppFormat.cents(
              unpaid.fold(0, (s, i) => s + i.totalInclVat),
            ),
            delta: l.dashboardInvoiceCount(unpaid.length),
            deltaColor: context.colors.warning,
          ),
        ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.dashboardTitle(year))),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    if (i > 0) const SizedBox(width: AppSpacing.group),
                    cards[i],
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.dashboardSection),
            LabelWithHelp(
              l.dashboardUrencriterium,
              help: l.dashboardUrencriteriumHelp,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.heading),
            UrencriteriumProgress(
              totalHours: hours.fold(0.0, (s, h) => s + h.hours),
              target: rules.urencriterium,
              yearOver: year < DateTime.now().year,
            ),
            if (showKor) ...[
              const SizedBox(height: AppSpacing.dashboardSection),
              LabelWithHelp(
                l.dashboardKor,
                help: l.dashboardKorHelp,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.heading),
              KorProgress(
                turnover: korTurnover,
                limit: rules.korThreshold,
                exceededOn: kor.exceededOn[year],
              ),
            ],
            const SizedBox(height: AppSpacing.dashboardSection),
            Text(l.dashboardBtwDeadlines, style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.heading),
            Wrap(
              spacing: AppSpacing.field,
              runSpacing: AppSpacing.heading,
              children: [
                for (var q = 1; q <= 4; q++)
                  _DeadlineTile(
                    quarter: q,
                    deadline: VatService.filingDeadline(year, q),
                    filed: filed.contains(q),
                    // Until the figures load, a return is due: the cautious
                    // answer.
                    duty:
                        ref
                            .watch(vatQuarterProvider((year: year, quarter: q)))
                            .valueOrNull
                            ?.duty ??
                        ReturnDuty.regular,
                    isCurrent:
                        year == DateTime.now().year &&
                        q == quarterOf(DateTime.now()),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.dashboardSection),
            Text(l.dashboardMonthlyRevenue, style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.field),
            SizedBox(height: 160, child: _MonthlyBarChart(values: monthly)),
          ],
        ),
      ),
    );
  }
}

class _DeadlineTile extends StatelessWidget {
  final int quarter;
  final DateTime deadline;
  final bool filed;
  final bool isCurrent;
  final ReturnDuty duty;

  const _DeadlineTile({
    required this.quarter,
    required this.deadline,
    required this.filed,
    required this.isCurrent,
    required this.duty,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final daysLeft = deadline.difference(DateTime.now()).inDays;
    final noReturn = duty == ReturnDuty.none;
    final overdue = daysLeft < 0 && !filed && !noReturn;
    final color = filed || noReturn
        ? context.colors.income
        : overdue
        ? context.colors.danger
        : daysLeft <= VatService.urgentDeadlineDays ||
              duty == ReturnDuty.incidental
        ? context.colors.vat
        : theme.colorScheme.outline;
    final small = theme.textTheme.labelSmall?.copyWith(color: color);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.field,
        vertical: AppSpacing.heading,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: isCurrent ? color : color.withValues(alpha: 0.4),
        ),
        borderRadius: BorderRadius.circular(8),
        color: isCurrent ? color.withValues(alpha: 0.08) : null,
      ),
      child: Column(
        children: [
          Text(
            'Q$quarter',
            style: TextStyle(fontWeight: FontWeight.w700, color: color),
          ),
          Text(AppFormat.date(deadline), style: theme.textTheme.bodySmall),
          Text(
            noReturn
                ? l.deadlineStatusKor
                : filed
                ? l.deadlineStatusFiled
                : overdue
                ? l.deadlineStatusOverdue
                : duty == ReturnDuty.incidental
                ? l.deadlineStatusIncidental
                : l.deadlineDaysLeft(daysLeft),
            style: small,
          ),
        ],
      ),
    );
  }
}

class _MonthlyBarChart extends StatelessWidget {
  final List<int> values;

  const _MonthlyBarChart({required this.values});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final month = DateFormat('MMMMM', locale);
    final compact = NumberFormat.compact(locale: locale);
    final max = values.fold(0, (m, v) => v > m ? v : m);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < 12; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.tileRow,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (values[i] > 0)
                    Text(
                      compact.format(values[i] / 100),
                      style: theme.textTheme.labelSmall,
                    ),
                  const SizedBox(height: AppSpacing.tileRow),
                  Flexible(
                    child: FractionallySizedBox(
                      heightFactor: max > 0
                          ? (values[i] / max).clamp(0.02, 1.0)
                          : 0.02,
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
                  const SizedBox(height: AppSpacing.tight),
                  Text(
                    month.format(DateTime(2000, i + 1)),
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
