import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../services/vat_service.dart';
import '../theme/app_theme.dart';
import 'tone_badge.dart';

class DeadlineBadge extends StatelessWidget {
  final DateTime deadline;
  final bool filed;

  /// The KOR covers the whole period, so no regular return is due.
  final bool korCovered;

  const DeadlineBadge({
    super.key,
    required this.deadline,
    this.filed = false,
    this.korCovered = false,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (korCovered) {
      return ToneBadge(label: l.deadlineBadgeKor, color: context.colors.income);
    }
    if (filed) {
      return ToneBadge(
        label: l.deadlineBadgeFiled,
        color: context.colors.income,
      );
    }
    final days = deadline.difference(DateTime.now()).inDays;
    if (days < 0) {
      return ToneBadge(
        label: l.deadlineBadgeOverdue,
        color: context.colors.danger,
      );
    }
    return ToneBadge(
      label: l.deadlineBadgeDays(days),
      color: days <= VatService.urgentDeadlineDays
          ? context.colors.vat
          : context.colors.income,
    );
  }
}
