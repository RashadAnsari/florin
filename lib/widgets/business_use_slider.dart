import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';
import 'help.dart';

/// Business use share from 0 to 100% in steps of 5%.
class BusinessUseSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const BusinessUseSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final pct = (value * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            LabelWithHelp(
              l.expensesBusinessUse,
              help: l.expensesBusinessUseHelp,
              style: theme.textTheme.titleSmall,
            ),
            const Spacer(),
            Text(
              l.expensesBusinessUsePct(pct),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          divisions: 20,
          label: '$pct%',
          onChanged: onChanged,
        ),
      ],
    );
  }
}
