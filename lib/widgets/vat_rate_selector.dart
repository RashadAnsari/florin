import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';

const kVatRates = ['21%', '9%', '0%', '0% EU Reverse Charge', 'Exempt'];

String vatRateLabel(AppLocalizations l, String rate) => switch (rate) {
  '21%' => l.vatRate21,
  '9%' => l.vatRate9,
  '0%' => l.vatRate0,
  '0% EU Reverse Charge' => l.vatRateEuReverseCharge,
  'Exempt' => l.vatRateExempt,
  _ => rate,
};

double parseVatRate(String rate) => switch (rate) {
  '21%' => 0.21,
  '9%' => 0.09,
  _ => 0.0,
};

class VatRateSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;
  final String? label;

  const VatRateSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label ?? l.vatRateSelectorLabel),
      items: kVatRates
          .map(
            (r) => DropdownMenuItem(value: r, child: Text(vatRateLabel(l, r))),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
