import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import 'help.dart';

/// A label with a right-aligned value, for summaries and calculations.
class ValueRow extends StatelessWidget {
  final String label;
  final String value;
  final String? help;
  final bool bold;
  final bool muted;
  final bool negative;
  final Color? color;

  const ValueRow({
    super.key,
    required this.label,
    required this.value,
    this.help,
    this.bold = false,
    this.muted = false,
    this.negative = false,
    this.color,
  });

  /// An amount in cents. Negative amounts show in brackets in the danger
  /// colour, as deductions.
  factory ValueRow.cents(
    String label,
    int cents, {
    String? help,
    bool bold = false,
    bool muted = false,
    Color? color,
  }) => ValueRow(
    label: label,
    value: cents < 0 ? '(${AppFormat.cents(-cents)})' : AppFormat.cents(cents),
    help: help,
    bold: bold,
    muted: muted,
    negative: cents < 0,
    color: color,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: bold ? FontWeight.w700 : null,
      color: muted
          ? context.colors.secondaryLabel
          : color ?? (negative ? context.colors.danger : null),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.tileRow),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: LabelWithHelp(label, help: help, style: style),
            ),
          ),
          const SizedBox(width: AppSpacing.field),
          Text(value, style: style),
        ],
      ),
    );
  }
}

/// A small label above a group of rows.
class SectionLabel extends StatelessWidget {
  final String text;
  final String? help;

  const SectionLabel(this.text, {super.key, this.help});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(
      top: AppSpacing.tight,
      bottom: AppSpacing.tight,
    ),
    child: LabelWithHelp(
      text,
      help: help,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        letterSpacing: 0.4,
        fontWeight: FontWeight.w600,
        color: context.colors.secondaryLabel,
      ),
    ),
  );
}
