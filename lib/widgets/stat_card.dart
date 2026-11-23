import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import 'help.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String? help;
  final String value;
  final String? delta;
  final Color? deltaColor;
  final Widget? trailing;

  const StatCard({
    super.key,
    required this.label,
    this.help,
    required this.value,
    this.delta,
    this.deltaColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.section),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: LabelWithHelp(
                    label,
                    help: help,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                // ignore: use_null_aware_elements
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: AppSpacing.heading),
            // An amount stays on one line; it shrinks rather than wraps.
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                value,
                maxLines: 1,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (delta != null) ...[
              const SizedBox(height: AppSpacing.tight),
              Text(
                delta!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: deltaColor ?? theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
