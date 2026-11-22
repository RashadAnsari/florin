import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';

/// Shows a spinner while [value] loads, the error if it fails, and
/// [builder] with the data otherwise.
class AsyncBody<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) builder;

  const AsyncBody({super.key, required this.value, required this.builder});

  @override
  Widget build(BuildContext context) => value.when(
    data: builder,
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (e, _) => Center(
      child: Text(AppLocalizations.of(context)!.genericLoadError('$e')),
    ),
  );
}
