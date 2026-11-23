import 'package:flutter/material.dart';
import '../../widgets/help.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../l10n/labels.dart';
import '../../providers/providers.dart';
import '../../services/domain.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/choice_chips.dart';
import '../../widgets/invoice_status_badge.dart';
import '../../widgets/list_scaffold.dart';

/// Status filter: an [InvoiceStatus], `overdue`, or null for all.
typedef _Filter = Object?;

const _overdue = #overdue;

class InvoicesScreen extends ConsumerStatefulWidget {
  const InvoicesScreen({super.key});

  @override
  ConsumerState<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends ConsumerState<InvoicesScreen> {
  _Filter _filter;
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool _matches(Invoice i, Map<int, String> clients) {
    final status = switch (_filter) {
      null => true,
      _overdue => i.isOverdue,
      _ => i.status == _filter,
    };
    final q = _search.text.toLowerCase().trim();
    return status &&
        (q.isEmpty ||
            i.invoiceNumber.toLowerCase().contains(q) ||
            (clients[i.clientId] ?? '').toLowerCase().contains(q));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final clients = {
      for (final c in ref.watch(clientsProvider).valueOrNull ?? <Client>[])
        c.id: c.name,
    };
    final invoices = ref
        .watch(invoicesProvider(year))
        .whenData((all) => all.where((i) => _matches(i, clients)).toList());

    return ListScaffold<Invoice>(
      title: l.invoicesTitle,
      addTooltip: l.invoicesNewTooltip,
      onAdd: () => context.push('/invoices/new'),
      items: invoices,
      emptyText: l.invoicesNone,
      controls: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(
            controller: _search,
            hint: l.labelSearch,
            help: l.invoicesSearchHelp,
            onChanged: () => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.heading),
          ChoiceChips<_Filter>(
            selected: _filter,
            onSelected: (f) => setState(() => _filter = f),
            options: [
              (null, l.invoicesFilterAll),
              for (final s in InvoiceStatus.values) (s, s.label(l)),
              (_overdue, l.invoicesFilterOverdue),
            ],
          ),
        ],
      ),
      itemBuilder: (context, inv) => ListTile(
        title: EllipsisText(clients[inv.clientId] ?? ''),
        subtitle: EllipsisText(
          '${inv.invoiceNumber}  ${AppFormat.date(inv.invoiceDate)}'
          '${inv.isCreditNote ? '  ${inv.invoiceType.label(l)}' : ''}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InvoiceStatusBadge(inv),
            const SizedBox(width: AppSpacing.field),
            Text(AppFormat.cents(inv.signedInclVat)),
          ],
        ),
        onTap: () => context.push('/invoices/${inv.id}'),
      ),
    );
  }
}
