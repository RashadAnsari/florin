import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import 'tone_badge.dart';

String formatHours(double h) => h.toStringAsFixed(1);

/// Hours logged against the urencriterium (Wet IB 2001 art. 3.6).
class UrencriteriumProgress extends StatelessWidget {
  final double totalHours;
  final double? billableHours;
  final int target;
  final bool yearOver;

  const UrencriteriumProgress({
    super.key,
    required this.totalHours,
    this.billableHours,
    required this.target,
    required this.yearOver,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final ok = totalHours >= target;
    final color = ok
        ? context.colors.income
        : yearOver
        ? context.colors.danger
        : theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l.hoursProgress(formatHours(totalHours), '$target'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            if (billableHours != null) ...[
              const SizedBox(width: AppSpacing.group),
              Text(
                l.hoursBillable(formatHours(billableHours!)),
                style: theme.textTheme.bodySmall,
              ),
            ],
            const Spacer(),
            ToneBadge(
              label: ok
                  ? l.hoursUrencriteriumOk
                  : l.hoursUrencriteriumLeft(formatHours(target - totalHours)),
              color: color,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.heading),
        LinearProgressIndicator(
          value: (totalHours / target).clamp(0.0, 1.0),
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
          color: color,
          backgroundColor: color.withValues(alpha: 0.15),
        ),
      ],
    );
  }
}
