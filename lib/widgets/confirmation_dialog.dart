import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';

/// Asks before an action that cannot be undone. The confirm button is named
/// after the action, such as Delete or Send.
Future<bool> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String? cancelLabel,
  bool isDestructive = false,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (ctx) {
          final l = AppLocalizations.of(ctx)!;
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(cancelLabel ?? l.actionCancel),
              ),
              FilledButton(
                style: isDestructive
                    ? FilledButton.styleFrom(
                        backgroundColor: Theme.of(ctx).colorScheme.error,
                      )
                    : null,
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(confirmLabel),
              ),
            ],
          );
        },
      ) ??
      false;
}
