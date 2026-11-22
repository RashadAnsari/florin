import 'package:flutter/material.dart';
import '../services/tax_rules/tax_year_rules.dart';
import '../theme/app_theme.dart';
import 'help.dart';

/// A read-only field that opens a date picker. By default only dates in a
/// supported tax year can be picked, so no record lands in a hidden year.
class DateField extends StatelessWidget {
  final String label;
  final String help;
  final bool required;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final FormFieldValidator<String>? validator;

  const DateField({
    super.key,
    required this.label,
    required this.help,
    required this.value,
    this.required = false,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.validator,
  });

  static DateTime _clamp(DateTime d, DateTime first, DateTime last) =>
      d.isBefore(first) ? first : (d.isAfter(last) ? last : d);

  @override
  Widget build(BuildContext context) => TextFormField(
    key: ValueKey(value),
    initialValue: value == null ? '' : AppFormat.date(value!),
    readOnly: true,
    strutStyle: StrutStyle.disabled,
    decoration: fieldDecoration(
      label: label,
      help: help,
      required: required,
      suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
    ),
    validator: validator,
    onTap: () async {
      final picked = await showDatePicker(
        context: context,
        initialDate: _clamp(
          value ?? DateTime.now(),
          firstDate ?? DateTime(supportedYears.first),
          lastDate ?? DateTime(supportedYears.last, 12, 31),
        ),
        firstDate: firstDate ?? DateTime(supportedYears.first),
        lastDate: lastDate ?? DateTime(supportedYears.last, 12, 31),
      );
      if (picked != null) onChanged(picked);
    },
  );
}
