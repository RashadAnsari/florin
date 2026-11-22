import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'async_body.dart';

/// A list screen: app bar with an add action, optional controls, a divider
/// and the list.
class ListScaffold<T> extends StatelessWidget {
  final String title;
  final String addTooltip;
  final VoidCallback onAdd;
  final Widget? controls;
  final AsyncValue<List<T>> items;
  final String emptyText;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const ListScaffold({
    super.key,
    required this.title,
    required this.addTooltip,
    required this.onAdd,
    required this.items,
    required this.emptyText,
    required this.itemBuilder,
    this.controls,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: addTooltip,
          onPressed: onAdd,
        ),
        const SizedBox(width: AppSpacing.heading),
      ],
    ),
    body: Column(
      children: [
        ?controls,
        const Divider(height: 1),
        Expanded(
          child: AsyncBody(
            value: items,
            builder: (list) => list.isEmpty
                ? Center(child: Text(emptyText))
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (c, i) => itemBuilder(c, list[i]),
                  ),
          ),
        ),
      ],
    ),
  );
}
