import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';
import 'choice_chips.dart';

/// Quarter 1 to 4 as chips. With [allowAll], an extra chip selects null.
class QuarterChips extends StatelessWidget {
  final int? selected;
  final ValueChanged<int?> onSelected;
  final bool allowAll;

  const QuarterChips({
    super.key,
    required this.selected,
    required this.onSelected,
    this.allowAll = true,
  });

  @override
  Widget build(BuildContext context) => ChoiceChips<int?>(
    selected: selected,
    onSelected: onSelected,
    options: [
      if (allowAll) (null, AppLocalizations.of(context)!.labelAll),
      for (var q = 1; q <= 4; q++) (q, 'Q$q'),
    ],
  );
}
