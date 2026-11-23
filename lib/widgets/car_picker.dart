import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../db/database.dart';
import '../theme/app_theme.dart';
import 'help.dart';

/// Picks a business car, or none.
Widget carPicker({
  required AppLocalizations l,
  required List<FixedAsset> assets,
  required int? value,
  required String label,
  required String help,
  required String noneLabel,
  required ValueChanged<int?> onChanged,
}) {
  final cars = assets.where((a) => a.kind == AssetKind.car).toList();
  return Builder(
    builder: (context) => DropdownButtonFormField<int?>(
      style: fieldTextStyle(context),
      initialValue: cars.any((c) => c.id == value) ? value : null,
      isExpanded: true,
      decoration: fieldDecoration(label: label, help: help),
      items: [
        DropdownMenuItem(value: null, child: Text(noneLabel)),
        for (final c in cars)
          DropdownMenuItem(
            value: c.id,
            child: EllipsisText(
              '${c.assetName} (${AppFormat.date(c.purchaseDate)})',
            ),
          ),
      ],
      onChanged: onChanged,
    ),
  );
}
