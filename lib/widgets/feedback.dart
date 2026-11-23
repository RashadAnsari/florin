import 'dart:io';

import 'package:drift/native.dart' show SqliteException;
// The database runs in a background isolate, which wraps every error in a
// DriftRemoteException; only this library exposes it.
// ignore: experimental_member_use
import 'package:drift/remote.dart' show DriftRemoteException;
import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';

/// The messenger of the whole app, so errors no screen caught can still be
/// shown.
final rootMessengerKey = GlobalKey<ScaffoldMessengerState>();

/// What went wrong, in words the user can act on. Database constraint
/// failures and file errors get their own message; anything else shows its
/// own text.
String describeError(Object error, AppLocalizations l) {
  final cause = error is DriftRemoteException ? error.remoteCause : error;
  if (cause is SqliteException) {
    // SQLite extended result codes: https://sqlite.org/rescode.html
    switch (cause.extendedResultCode) {
      case 2067 || 1555:
        return l.errorDuplicate;
      case 787:
        return l.errorInUse;
    }
    switch (cause.resultCode) {
      case 5 || 6:
        return l.errorBusy;
      case 8:
        return l.errorReadOnly;
      case 11 || 26:
        return l.errorCorrupt;
      case 13:
        return l.errorDiskFull;
      case 14:
        return l.errorCannotOpen;
    }
  }
  if (cause is FileSystemException) {
    return l.errorFile(
      cause.path ?? '',
      cause.osError?.message ?? cause.message,
    );
  }
  return '$cause';
}

/// Reports a failed save or delete. Validation errors stay inline instead.
void showSaveError(BuildContext context, Object error) {
  final l = AppLocalizations.of(context)!;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(l.genericSaveError(describeError(error, l)))),
  );
}

/// Shows an error that reached no screen, such as a failed background task.
void showUnhandledError(Object error) {
  final messenger = rootMessengerKey.currentState;
  final context = rootMessengerKey.currentContext;
  if (messenger == null || context == null) return;
  final l = AppLocalizations.of(context);
  if (l == null) return;
  messenger.showSnackBar(
    SnackBar(content: Text(l.genericUnhandledError(describeError(error, l)))),
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
