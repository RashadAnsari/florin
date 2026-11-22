import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import 'help.dart';

/// A single-choice row of chips.
class ChoiceChips<T> extends StatelessWidget {
  final T selected;
  final List<(T, String)> options;
  final ValueChanged<T> onSelected;

  const ChoiceChips({
    super.key,
    required this.selected,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSpacing.tight,
    runSpacing: AppSpacing.tight,
    children: [
      for (final (value, label) in options)
        ChoiceChip(
          label: Text(label),
          selected: selected == value,
          onSelected: (_) => onSelected(value),
        ),
    ],
  );
}

/// A search box that reports every change.
class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String help;
  final VoidCallback onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.help,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: const Icon(Icons.search, size: 18),
      suffixIcon: controller.text.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(right: 8),
              child: HelpIcon(help),
            )
          : IconButton(
              icon: const Icon(Icons.clear, size: 16),
              onPressed: () {
                controller.clear();
                onChanged();
              },
            ),
      suffixIconConstraints: const BoxConstraints(minWidth: 32),
    ),
    onChanged: (_) => onChanged(),
  );
}
