import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'target_progress.dart';

/// Turnover that counts for the kleineondernemersregeling against its limit.
class KorProgress extends StatelessWidget {
  final int turnover;
  final int limit;

  /// The date the turnover passed the limit, if it did.
  final DateTime? exceededOn;

  const KorProgress({
    super.key,
    required this.turnover,
    required this.limit,
    this.exceededOn,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final over = exceededOn != null;
    return TargetProgress(
      value: l.korProgress(AppFormat.cents(turnover), AppFormat.cents(limit)),
      badge: over
          ? l.korExceededBadge(AppFormat.date(exceededOn!))
          : l.korLeftBadge(AppFormat.cents(limit - turnover)),
      fraction: limit == 0 ? 1 : turnover / limit,
      color: over ? context.colors.danger : context.colors.income,
    );
  }
}
