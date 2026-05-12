import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';

class InvoicesScreen extends ConsumerStatefulWidget {
  const InvoicesScreen({super.key});

  @override
  ConsumerState<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends ConsumerState<InvoicesScreen> {
  String _statusFilter = 'all';
  final _searchCtrl = TextEditingController();

  static bool _isOverdue(Invoice inv) =>
      inv.status == 'Sent' && inv.dueDate.isBefore(DateTime.now());

  List<Invoice> _filter(
    List<Invoice> all,
    Map<int, String> clientMap,
    AppLocalizations l,
  ) {
    var result = all;
    if (_statusFilter != 'all') {
      result = result.where((i) {
        if (_statusFilter == 'overdue') return _isOverdue(i);
        return i.status == _statusFilter;
      }).toList();
    }
    final q = _searchCtrl.text.toLowerCase().trim();
    if (q.isNotEmpty) {
      result = result.where((i) {
        final clientName = clientMap[i.clientId]?.toLowerCase() ?? '';
        return i.invoiceNumber.toLowerCase().contains(q) ||
            clientName.contains(q);
      }).toList();
    }
    return result;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final invsAsync = ref.watch(invoicesStreamProvider(year));
    final clientMap = <int, String>{
      for (final c in ref.watch(clientsStreamProvider).valueOrNull ?? [])
        c.id: c.name,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(l.invoicesTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: l.invoicesNewTooltip,
            onPressed: () => context.push('/invoices/new'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSearch(l),
          _buildStatusFilters(l),
          const Divider(height: 1),
          Expanded(
            child: invsAsync.when(
              data: (all) {
                final visible = _filter(all, clientMap, l);
                if (visible.isEmpty) {
                  return Center(child: Text(l.invoicesNone));
                }
                return ListView.builder(
                  itemCount: visible.length,
                  itemBuilder: (_, i) => _InvoiceTile(
                    invoice: visible[i],
                    clientName: clientMap[visible[i].clientId] ?? '-',
                    onTap: () => context.push('/invoices/${visible[i].id}'),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch(AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: TextField(
        controller: _searchCtrl,
        decoration: InputDecoration(
          isDense: true,
          hintText: l.labelSearch,
          prefixIcon: const Icon(Icons.search, size: 18),
          suffixIcon: _searchCtrl.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  onPressed: () {
                    _searchCtrl.clear();
                    setState(() {});
                  },
                )
              : null,
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildStatusFilters(AppLocalizations l) {
    final statuses = [
      ('all', l.invoicesFilterAll),
      ('Draft', l.invoiceStatusConcept),
      ('Sent', l.invoiceStatusSent),
      ('Paid', l.invoiceStatusPaid),
      ('Cancelled', l.invoiceStatusCancelled),
      ('Refunded', l.invoiceStatusRefunded),
      ('overdue', l.invoicesFilterOverdue),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
      child: Row(
        children: statuses
            .map(
              (s) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: FilterChip(
                  label: Text(s.$2),
                  selected: _statusFilter == s.$1,
                  onSelected: (_) => setState(() => _statusFilter = s.$1),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _InvoiceTile extends StatelessWidget {
  final Invoice invoice;
  final String clientName;
  final VoidCallback onTap;

  const _InvoiceTile({
    required this.invoice,
    required this.clientName,
    required this.onTap,
  });

  bool get _isOverdue =>
      invoice.status == 'Sent' && invoice.dueDate.isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final overdue = _isOverdue;
    final outline = theme.colorScheme.outline;
    final (statusLabel, statusColor) = overdue
        ? (l.invoiceStatusOverdue, AppColors.red)
        : switch (invoice.status) {
            'Draft' => (l.invoiceStatusConcept, outline),
            'Sent' => (l.invoiceStatusSent, AppColors.action),
            'Paid' => (l.invoiceStatusPaid, AppColors.income),
            'Cancelled' => (l.invoiceStatusCancelled, outline),
            'Refunded' => (l.invoiceStatusRefunded, outline),
            _ => (invoice.status, outline),
          };

    return InkWell(
      onTap: onTap,
      child: Container(
        color: overdue ? AppColors.red.withValues(alpha: 0.04) : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    invoice.invoiceNumber,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  AppFormat.cents(invoice.totalInclVat),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    clientName,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: statusColor, width: 0.5),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(fontSize: 10, color: statusColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              AppFormat.date(invoice.invoiceDate),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
