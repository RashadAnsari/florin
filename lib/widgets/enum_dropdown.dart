import 'package:flutter/material.dart';
import 'help.dart';

/// A dropdown over enum values with localized labels.
class EnumDropdown<T extends Enum> extends StatelessWidget {
  final String label;
  final String help;
  final bool required;
  final T? value;
  final List<T> values;
  final String Function(T value) labelOf;
  final ValueChanged<T>? onChanged;
  final String? requiredMessage;

  const EnumDropdown({
    super.key,
    required this.label,
    required this.help,
    required this.value,
    this.required = false,
    required this.values,
    required this.labelOf,
    required this.onChanged,
    this.requiredMessage,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
    key: ValueKey(value),
    initialValue: value,
    isExpanded: true,
    decoration: fieldDecoration(label: label, help: help, required: required),
    items: [
      for (final v in values)
        DropdownMenuItem(value: v, child: EllipsisText(labelOf(v))),
    ],
    onChanged: onChanged == null
        ? null
        : (v) {
            if (v != null) onChanged!(v);
          },
    validator: requiredMessage == null
        ? null
        : (v) => v == null ? requiredMessage : null,
  );
}
