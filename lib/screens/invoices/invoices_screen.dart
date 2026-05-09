import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import 'invoice_detail_panel.dart';

class InvoicesScreen extends ConsumerStatefulWidget {
  const InvoicesScreen({super.key});

  @override
  ConsumerState<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends ConsumerState<InvoicesScreen> {
  int? _selectedId;
  bool _isNew = false;
  String _statusFilter = 'Alle';
  final _searchCtrl = TextEditingController();

  static bool _isOverdue(Invoice inv) =>
      inv.status != 'Paid' && inv.dueDate.isBefore(DateTime.now());

  List<Invoice> _filter(List<Invoice> all, Map<int, String> clientMap) {
    var result = all;
    if (_statusFilter != 'Alle') {
      result = result.where((i) {
        if (_statusFilter == 'Verlopen') return _isOverdue(i);
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
    final year = ref.watch(fiscalYearProvider);
    final invsAsync = ref.watch(invoicesStreamProvider(year));
    final clientMap = <int, String>{
      for (final c in ref.watch(clientsStreamProvider).valueOrNull ?? [])
        c.id: c.name,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Facturen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Nieuwe factuur',
            onPressed: () => setState(() {
              _selectedId = null;
              _isNew = true;
            }),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: 320,
            child: Column(
              children: [
                _buildSearch(),
                _buildStatusFilters(),
                const Divider(height: 1),
                Expanded(
                  child: invsAsync.when(
                    data: (all) {
                      final visible = _filter(all, clientMap);
                      if (visible.isEmpty) {
                        return const Center(child: Text('Geen facturen'));
                      }
                      return ListView.builder(
                        itemCount: visible.length,
                        itemBuilder: (_, i) => _InvoiceTile(
                          invoice: visible[i],
                          clientName: clientMap[visible[i].clientId] ?? '—',
                          isSelected: _selectedId == visible[i].id,
                          onTap: () => setState(() {
                            _selectedId = visible[i].id;
                            _isNew = false;
                          }),
                        ),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('$e')),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: (_isNew || _selectedId != null)
                ? InvoiceDetailPanel(
                    key: ValueKey(_isNew ? 'new' : '$_selectedId'),
                    invoiceId: _isNew ? null : _selectedId,
                    onCreated: (id) => setState(() {
                      _selectedId = id;
                      _isNew = false;
                    }),
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.receipt_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Selecteer een factuur of maak een nieuwe aan',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: TextField(
        controller: _searchCtrl,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Zoeken…',
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

  Widget _buildStatusFilters() {
    const statuses = ['Alle', 'Draft', 'Sent', 'Paid', 'Verlopen'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
      child: Row(
        children: statuses
            .map(
              (s) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: FilterChip(
                  label: Text(s),
                  selected: _statusFilter == s,
                  onSelected: (_) => setState(() => _statusFilter = s),
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
  final bool isSelected;
  final VoidCallback onTap;

  const _InvoiceTile({
    required this.invoice,
    required this.clientName,
    required this.isSelected,
    required this.onTap,
  });

  bool get _isOverdue =>
      invoice.status != 'Paid' && invoice.dueDate.isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final overdue = _isOverdue;
    final (statusLabel, statusColor) = overdue
        ? ('Verlopen', AppColors.red)
        : switch (invoice.status) {
            'Draft' => ('Concept', Colors.grey),
            'Sent' => ('Verzonden', AppColors.action),
            'Paid' => ('Betaald', AppColors.income),
            _ => (invoice.status, Colors.grey),
          };

    return InkWell(
      onTap: onTap,
      child: Container(
        color: overdue
            ? AppColors.red.withValues(alpha: 0.04)
            : isSelected
            ? theme.colorScheme.secondaryContainer
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
