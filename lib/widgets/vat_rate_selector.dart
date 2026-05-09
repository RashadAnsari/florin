import 'package:flutter/material.dart';

const kVatRates = ['21%', '9%', '0%', '0% EU Reverse Charge', 'Exempt'];

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
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(labelText: label ?? 'VAT Rate'),
      items: kVatRates
          .map((r) => DropdownMenuItem(value: r, child: Text(r)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
