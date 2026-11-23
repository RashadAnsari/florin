import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// A validation error that belongs to the form as a whole rather than to one
/// field, such as a total that is too high. It shows inline when the form is
/// validated and blocks the save like any field error.
class FormErrorText extends StatelessWidget {
  final String? Function() validator;

  const FormErrorText({super.key, required this.validator});

  @override
  Widget build(BuildContext context) => FormField<void>(
    validator: (_) => validator(),
    builder: (state) => state.hasError
        ? Padding(
            padding: const EdgeInsets.only(top: AppSpacing.tight),
            child: Text(
              state.errorText!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          )
        : const SizedBox.shrink(),
  );
}
