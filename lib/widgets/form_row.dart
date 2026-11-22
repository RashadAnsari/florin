import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// Form fields side by side with the standard gap. [flex] sets each
/// field's share, defaulting to equal widths.
class FormRow extends StatelessWidget {
  final List<Widget> children;
  final List<int>? flex;

  const FormRow({super.key, required this.children, this.flex});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var i = 0; i < children.length; i++) ...[
        if (i > 0) const SizedBox(width: AppSpacing.field),
        Expanded(flex: flex?[i] ?? 1, child: children[i]),
      ],
    ],
  );
}
