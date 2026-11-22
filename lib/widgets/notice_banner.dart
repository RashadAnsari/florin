import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

enum NoticeTone { info, warning, error }

/// A bordered message box for warnings and legal notes.
class NoticeBanner extends StatelessWidget {
  final String message;
  final NoticeTone tone;

  const NoticeBanner(this.message, {super.key, this.tone = NoticeTone.info});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (color, icon) = switch (tone) {
      NoticeTone.info => (theme.colorScheme.primary, Icons.info_outline),
      NoticeTone.warning => (context.colors.warning, Icons.warning_amber),
      NoticeTone.error => (theme.colorScheme.error, Icons.error_outline),
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.field),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: AppSpacing.heading),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
