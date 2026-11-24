import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'target_progress.dart';

/// Hours logged against the urencriterium (Wet IB 2001 art. 3.6).
class UrencriteriumProgress extends StatelessWidget {
  final double totalHours;
  final double? billableHours;
  final int target;

  /// Hours in employment the business hours must exceed, or null when that
  /// condition does not apply (art. 3.6 lid 1 a).
  final int? jobHours;
  final bool yearOver;

  const UrencriteriumProgress({
    super.key,
    required this.totalHours,
    this.billableHours,
    required this.target,
    this.jobHours,
    required this.yearOver,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final enoughHours = totalHours >= target;
    final moreThanJob = jobHours == null || totalHours > jobHours!;
    final ok = enoughHours && moreThanJob;
    final color = ok
        ? context.colors.income
        : yearOver
        ? context.colors.danger
        : theme.colorScheme.primary;

    return TargetProgress(
      value: l.hoursProgress(AppFormat.hours(totalHours), '$target'),
      note: billableHours == null
          ? null
          : l.hoursBillable(AppFormat.hours(billableHours!)),
      badge: ok
          ? l.hoursUrencriteriumOk
          : enoughHours
          ? l.hoursUrencriteriumJob(jobHours!)
          : l.hoursUrencriteriumLeft(AppFormat.hours(target - totalHours)),
      fraction: totalHours / target,
      color: color,
    );
  }
}
