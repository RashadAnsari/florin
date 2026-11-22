import 'package:flutter/material.dart';
import 'help.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../theme/app_spacing.dart';
import 'buttons.dart';

/// A detail or form page: a header with back, title, actions, delete and
/// save, a divider, and a scrollable body with screen padding.
class DetailScaffold extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final VoidCallback? onDelete;
  final VoidCallback? onSave;
  final bool showSave;
  final Widget body;

  const DetailScaffold({
    super.key,
    required this.title,
    required this.body,
    this.onBack,
    this.actions = const [],
    this.onDelete,
    this.onSave,
    this.showSave = true,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.group,
              AppSpacing.tight,
              AppSpacing.heading,
              AppSpacing.tight,
            ),
            child: Row(
              children: [
                if (onBack != null)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).backButtonTooltip,
                    onPressed: onBack,
                  ),
                Expanded(
                  child: EllipsisText(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                for (final a in actions) ...[
                  a,
                  const SizedBox(width: AppSpacing.heading),
                ],
                if (onDelete != null)
                  DeleteIconButton(
                    tooltip: l.actionDelete,
                    onPressed: onDelete,
                  ),
                if (showSave) ...[
                  const SizedBox(width: AppSpacing.heading),
                  PrimaryButton(label: l.actionSave, onPressed: onSave),
                ],
                const SizedBox(width: AppSpacing.heading),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
