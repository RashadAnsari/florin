import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';

/// Reports a failed save or delete. Validation errors stay inline instead.
void showSaveError(BuildContext context, Object error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(AppLocalizations.of(context)!.genericSaveError('$error')),
    ),
  );
}

/// Runs [action] and reports a failure. Returns whether it succeeded.
Future<bool> guardSave(
  BuildContext context,
  Future<void> Function() action,
) async {
  try {
    await action();
    return true;
  } catch (e) {
    if (context.mounted) showSaveError(context, e);
    return false;
  }
}
