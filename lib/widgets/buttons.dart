import 'package:flutter/material.dart';

/// The primary save or submit action.
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.save_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

/// A destructive delete action shown as an icon.
class DeleteIconButton extends StatelessWidget {
  final String tooltip;
  final VoidCallback? onPressed;

  const DeleteIconButton({
    super.key,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    icon: const Icon(Icons.delete_outline),
    tooltip: tooltip,
    color: Theme.of(context).colorScheme.error,
    onPressed: onPressed,
  );
}
