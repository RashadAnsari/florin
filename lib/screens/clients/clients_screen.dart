import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../services/vat_service.dart';
import '../../widgets/confirmation_dialog.dart';

final _allClientsProvider = StreamProvider.autoDispose<List<Client>>((ref) {
  return ref.watch(clientDaoProvider).watchAll();
});

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  String _clientFilter = 'all';
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Map<int, int> _revenueMap(AsyncValue<List<Invoice>> inv) {
    final result = <int, int>{};
    for (final i in inv.valueOrNull ?? []) {
      if (i.status != 'Draft') {
        result[i.clientId] = (result[i.clientId] ?? 0) + i.totalInclVat as int;
      }
    }
    return result;
  }

  List<Client> _filter(List<Client> all) {
    var result = switch (_clientFilter) {
      'active' => all.where((c) => c.isActive).toList(),
      'inactive' => all.where((c) => !c.isActive).toList(),
      _ => all,
    };
    final q = _searchCtrl.text.toLowerCase().trim();
    if (q.isNotEmpty) {
      result = result.where((c) => c.name.toLowerCase().contains(q)).toList();
    }
    return result;
  }

  Widget _buildFilters(AppLocalizations l) {
    final filters = [
      ('all', l.clientsFilterAll),
      ('active', l.clientsFilterActive),
      ('inactive', l.clientsFilterInactive),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
      child: Row(
        children: filters
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: FilterChip(
                  label: Text(f.$2),
                  selected: _clientFilter == f.$1,
                  onSelected: (_) => setState(() => _clientFilter = f.$1),
                ),
              ),
            )
            .toList(),
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

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final allAsync = ref.watch(_allClientsProvider);
    final year = ref.watch(fiscalYearProvider);
    final invAsync = ref.watch(invoicesStreamProvider(year));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.clientsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: l.clientsNewTooltip,
            onPressed: () => context.push('/clients/new'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSearch(l),
          _buildFilters(l),
          const Divider(height: 1),
          Expanded(
            child: allAsync.when(
              data: (all) {
                final revenue = _revenueMap(invAsync);
                final visible = _filter(all);
                if (visible.isEmpty) {
                  return Center(child: Text(l.clientsNone));
                }
                return ListView.builder(
                  itemCount: visible.length,
                  itemBuilder: (_, i) => _ClientTile(
                    client: visible[i],
                    revenueYtd: revenue[visible[i].id] ?? 0,
                    onTap: () => context.push(
                      '/clients/${visible[i].id}',
                      extra: visible[i],
                    ),
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
}

class _ClientTile extends StatelessWidget {
  final Client client;
  final int revenueYtd;
  final VoidCallback onTap;

  const _ClientTile({
    required this.client,
    required this.revenueYtd,
    required this.onTap,
  });

  Color _riskColor(String level) => switch (level) {
    'High' => AppColors.red,
    'Medium' => AppColors.expense,
    _ => AppColors.income,
  };

  String _riskLabel(BuildContext context, String level) {
    final l = AppLocalizations.of(context)!;
    return switch (level) {
      'High' => l.clientsRiskHigh,
      'Medium' => l.clientsRiskMedium,
      _ => l.clientsRiskLow,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final risk = client.wetDbaRiskLevel;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    client.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!client.isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      l.clientsInactive,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  AppFormat.cents(revenueYtd),
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _riskColor(risk).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _riskColor(risk), width: 0.5),
                  ),
                  child: Text(
                    _riskLabel(context, risk),
                    style: TextStyle(fontSize: 10, color: _riskColor(risk)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientForm extends ConsumerStatefulWidget {
  final Client? client;
  final void Function(Client) onSaved;
  final VoidCallback onDeleted;
  final VoidCallback? onBack;

  const _ClientForm({
    required this.client,
    required this.onSaved,
    required this.onDeleted,
    this.onBack,
  });

  @override
  ConsumerState<_ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends ConsumerState<_ClientForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _country;
  late final TextEditingController _vatNumber;
  late final TextEditingController _kvkNumber;
  late final TextEditingController _address;
  late final TextEditingController _contactPerson;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _notes;
  String _riskLevel = 'Low';
  bool _contractSigned = false;
  DateTime? _contractExpiry;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    final c = widget.client;
    _name = TextEditingController(text: c?.name ?? '');
    _country = TextEditingController(text: c?.country ?? 'NL');
    _vatNumber = TextEditingController(text: c?.vatNumber ?? '');
    _kvkNumber = TextEditingController(text: c?.kvkNumber ?? '');
    _address = TextEditingController(text: c?.address ?? '');
    _contactPerson = TextEditingController(text: c?.contactPerson ?? '');
    _email = TextEditingController(text: c?.email ?? '');
    _phone = TextEditingController(text: c?.phone ?? '');
    _notes = TextEditingController(text: c?.notes ?? '');
    if (c != null) {
      _riskLevel = c.wetDbaRiskLevel;
      _contractSigned = c.contractSigned;
      _contractExpiry = c.contractExpiry;
      _isActive = c.isActive;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _country.dispose();
    _vatNumber.dispose();
    _kvkNumber.dispose();
    _address.dispose();
    _contactPerson.dispose();
    _email.dispose();
    _phone.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final dao = ref.read(clientDaoProvider);
    final orig = widget.client;
    String? n(String s) => s.trim().isEmpty ? null : s.trim();
    final companion = ClientsCompanion(
      id: orig != null ? Value(orig.id) : const Value.absent(),
      name: Value(_name.text.trim()),
      country: Value(
        _country.text.trim().isEmpty
            ? 'NL'
            : _country.text.trim().toUpperCase(),
      ),
      vatNumber: Value(n(_vatNumber.text)),
      kvkNumber: Value(n(_kvkNumber.text)),
      address: Value(_address.text.trim()),
      contactPerson: Value(n(_contactPerson.text)),
      email: Value(n(_email.text)),
      phone: Value(n(_phone.text)),
      wetDbaRiskLevel: Value(_riskLevel),
      contractSigned: Value(_contractSigned),
      contractExpiry: Value(_contractExpiry),
      notes: Value(n(_notes.text)),
      isActive: Value(_isActive),
    );
    if (orig == null) {
      final id = await dao.insertClient(companion);
      final created = await dao.getById(id);
      if (mounted && created != null) {
        widget.onSaved(created);
      }
    } else {
      await dao.saveClient(companion);
      final updated = await dao.getById(orig.id);
      if (mounted && updated != null) {
        widget.onSaved(updated);
      }
    }
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context)!;
    final hasInvoices = await ref
        .read(invoiceDaoProvider)
        .clientHasInvoices(widget.client!.id);
    if (!mounted) return;
    if (hasInvoices) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l.clientsDeleteBlockedTitle),
          content: Text(l.clientsDeleteBlockedMessage(_name.text)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    final confirmed = await showConfirmationDialog(
      context,
      title: l.clientsDeleteTitle,
      message: l.clientsDeleteMessage(_name.text),
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref.read(clientDaoProvider).deleteClient(widget.client!.id);
    if (mounted) widget.onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNew = widget.client == null;
    final highRisk = _riskLevel == 'High';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
          child: Row(
            children: [
              if (widget.onBack != null)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onBack,
                ),
              Expanded(
                child: Text(
                  isNew
                      ? AppLocalizations.of(context)!.clientsNewHeader
                      : _name.text,
                  style: theme.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isNew)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: AppLocalizations.of(context)!.actionDelete,
                  color: theme.colorScheme.error,
                  onPressed: _delete,
                ),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined, size: 18),
                label: Text(AppLocalizations.of(context)!.actionSave),
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (highRisk) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.red.withValues(alpha: 0.08),
                        border: Border.all(color: AppColors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber,
                            color: AppColors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!.clientsHighRiskWarning,
                              style: const TextStyle(
                                color: AppColors.red,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.clientsFieldName,
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? AppLocalizations.of(context)!.clientsValidateName
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: TextFormField(
                          controller: _country,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.clientsFieldCountry,
                            counterText: '',
                          ),
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            TextInputFormatter.withFunction(
                              (old, next) => next.copyWith(
                                text: next.text.toUpperCase(),
                                selection: next.selection,
                              ),
                            ),
                          ],
                          maxLength: 2,
                          validator: (v) {
                            final s = v?.trim() ?? '';
                            if (s.isEmpty) return null;
                            if (s.length != 2 ||
                                !RegExp(r'^[A-Z]{2}$').hasMatch(s)) {
                              return AppLocalizations.of(
                                context,
                              )!.clientsValidateCountry;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _vatNumber,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.clientsFieldVat,
                          ),
                          validator: (v) {
                            final s = v?.trim() ?? '';
                            if (s.isEmpty) return null;
                            if (!RegExp(
                              r'^[A-Z]{2}.{2,}$',
                            ).hasMatch(s.toUpperCase())) {
                              return AppLocalizations.of(
                                context,
                              )!.clientsValidateVat;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _kvkNumber,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.clientsFieldKvk,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            final s = v?.trim() ?? '';
                            if (s.isEmpty) return null;
                            if (!isValidKvkNumber(s)) {
                              return AppLocalizations.of(
                                context,
                              )!.clientsValidateKvk;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _address,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        context,
                      )!.clientsFieldAddress,
                    ),
                    maxLines: 4,
                    minLines: 3,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? AppLocalizations.of(context)!.clientsValidateAddress
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _contactPerson,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.clientsFieldContact,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.clientsFieldEmail,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            final s = v?.trim() ?? '';
                            if (s.isEmpty) return null;
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s)) {
                              return AppLocalizations.of(
                                context,
                              )!.clientsValidateEmail;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _phone,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.clientsFieldPhone,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (v) {
                            final s = v?.trim() ?? '';
                            if (s.isEmpty) return null;
                            if (!RegExp(
                              r'^[+\d][\d\s\-().]{4,}$',
                            ).hasMatch(s)) {
                              return AppLocalizations.of(
                                context,
                              )!.clientsValidatePhone;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.clientsWetDba,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _riskLevel,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.clientsRiskLevel,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'Low',
                              child: Text(
                                AppLocalizations.of(context)!.clientsRiskLow,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Medium',
                              child: Text(
                                AppLocalizations.of(context)!.clientsRiskMedium,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'High',
                              child: Text(
                                AppLocalizations.of(context)!.clientsRiskHigh,
                              ),
                            ),
                          ],
                          onChanged: (v) => setState(() => _riskLevel = v!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate:
                                  _contractExpiry ??
                                  DateTime.now().add(const Duration(days: 365)),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2040),
                            );
                            if (d != null) {
                              setState(() => _contractExpiry = d);
                            }
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.clientsContractExpiry,
                            ),
                            child: Text(
                              _contractExpiry != null
                                  ? AppFormat.date(_contractExpiry!)
                                  : '-',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  CheckboxListTile(
                    value: _contractSigned,
                    onChanged: (v) =>
                        setState(() => _contractSigned = v ?? false),
                    title: Text(
                      AppLocalizations.of(context)!.clientsContractSigned,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    value: _isActive,
                    onChanged: (v) => setState(() => _isActive = v ?? true),
                    title: Text(
                      AppLocalizations.of(context)!.clientsFieldActive,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notes,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        context,
                      )!.clientsFieldNotes,
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ClientDetailPage extends ConsumerWidget {
  final Client? client;

  const ClientDetailPage({super.key, this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _ClientForm(
        client: client,
        onBack: () => context.pop(),
        onSaved: (_) => context.pop(),
        onDeleted: () => context.pop(),
      ),
    );
  }
}
