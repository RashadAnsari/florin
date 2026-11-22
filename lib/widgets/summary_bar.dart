import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

class SummaryStat {
  final String label;
  final String value;
  final Color? color;

  const SummaryStat(this.label, this.value, {this.color});
}

/// A horizontal row of headline figures above a list.
class SummaryBar extends StatelessWidget {
  final List<SummaryStat> stats;

  const SummaryBar(this.stats, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.section,
        vertical: AppSpacing.field,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: AppSpacing.dashboardSection,
          runSpacing: AppSpacing.heading,
          children: [
            for (final s in stats)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.label, style: theme.textTheme.bodySmall),
                  Text(
                    s.value,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: s.color,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
