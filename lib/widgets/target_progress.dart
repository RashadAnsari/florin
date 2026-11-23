import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import 'tone_badge.dart';

/// A figure measured against a target: the figure, an optional note, a
/// status badge and a bar. The colour comes with the badge's words, so it
/// never carries meaning alone.
class TargetProgress extends StatelessWidget {
  final String value;
  final String? note;
  final String badge;
  final double fraction;
  final Color color;

  const TargetProgress({
    super.key,
    required this.value,
    this.note,
    required this.badge,
    required this.fraction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            if (note != null) ...[
              const SizedBox(width: AppSpacing.group),
              Text(note!, style: theme.textTheme.bodySmall),
            ],
            const Spacer(),
            ToneBadge(label: badge, color: color),
          ],
        ),
        const SizedBox(height: AppSpacing.heading),
        LinearProgressIndicator(
          value: fraction.clamp(0.0, 1.0),
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
          color: color,
          backgroundColor: color.withValues(alpha: 0.15),
        ),
      ],
    );
  }
}
