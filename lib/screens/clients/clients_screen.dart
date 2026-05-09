import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/confirmation_dialog.dart';

const _kRiskOptions = ['Low', 'Medium', 'High'];

final _allClientsProvider = StreamProvider.autoDispose<List<Client>>((ref) {
  return ref.watch(clientDaoProvider).watchAll();
});

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  Client? _selected;
  bool _isNew = false;
  bool _showInactive = false;

  Map<int, int> _revenueMap(AsyncValue<List<Invoice>> inv) {
    final result = <int, int>{};
    for (final i in inv.valueOrNull ?? []) {
      if (i.status != 'Draft') {
        result[i.clientId] = (result[i.clientId] ?? 0) + i.totalInclVat as int;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final allAsync = ref.watch(_allClientsProvider);
    final year = ref.watch(fiscalYearProvider);
    final invAsync = ref.watch(invoicesStreamProvider(year));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Klanten'),
        actions: [
          IconButton(
            icon: Icon(_showInactive ? Icons.visibility_off : Icons.visibility),
            tooltip: _showInactive ? 'Verberg inactief' : 'Toon inactief',
            onPressed: () => setState(() => _showInactive = !_showInactive),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Nieuwe klant',
            onPressed: () => setState(() {
              _selected = null;
              _isNew = true;
            }),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: 300,
            child: allAsync.when(
              data: (all) {
                final revenue = _revenueMap(invAsync);
                final visible = _showInactive
                    ? all
                    : all.where((c) => c.isActive).toList();
                if (visible.isEmpty) {
                  return const Center(child: Text('Geen klanten'));
                }
                return ListView.builder(
                  itemCount: visible.length,
                  itemBuilder: (_, i) => _ClientTile(
                    client: visible[i],
                    revenueYtd: revenue[visible[i].id] ?? 0,
                    isSelected: _selected?.id == visible[i].id,
                    onTap: () => setState(() {
                      _selected = visible[i];
                      _isNew = false;
                    }),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: (_isNew || _selected != null)
                ? _ClientForm(
                    key: ValueKey(_isNew ? 'new' : '${_selected!.id}'),
                    client: _isNew ? null : _selected,
                    onSaved: (c) => setState(() {
                      _selected = c;
                      _isNew = false;
                    }),
                    onDeleted: () => setState(() {
                      _selected = null;
                      _isNew = false;
                    }),
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Selecteer een klant of maak een nieuwe aan',
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
}

class _ClientTile extends StatelessWidget {
  final Client client;
  final int revenueYtd;
  final bool isSelected;
  final VoidCallback onTap;

  const _ClientTile({
    required this.client,
    required this.revenueYtd,
    required this.isSelected,
    required this.onTap,
  });

  Color _riskColor(String level) => switch (level) {
    'High' => Colors.red,
    'Medium' => Colors.orange,
    _ => Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final risk = client.wetDbaRiskLevel;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? theme.colorScheme.secondaryContainer : null,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                      color: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Inactief',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
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
                    risk,
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

  const _ClientForm({
    super.key,
    required this.client,
    required this.onSaved,
    required this.onDeleted,
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
      address: Value(n(_address.text)),
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Klant aangemaakt')));
      }
    } else {
      await dao.saveClient(companion);
      final updated = await dao.getById(orig.id);
      if (mounted && updated != null) {
        widget.onSaved(updated);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Klant opgeslagen')));
      }
    }
  }

  Future<void> _delete() async {
    final confirmed = await showConfirmationDialog(
      context,
      title: 'Klant verwijderen',
      message: 'Weet je zeker dat je "${_name.text}" wilt verwijderen?',
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref.read(clientDaoProvider).deleteClient(widget.client!.id);
    if (mounted) widget.onDeleted();
  }

  Future<void> _checkVies() async {
    final vat = _vatNumber.text.trim();
    if (vat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Voer eerst een BTW-nummer in')),
      );
      return;
    }
    final country = _country.text.trim().toUpperCase();
    final uri = Uri.parse(
      'https://ec.europa.eu/taxation_customs/vies/vatResponse.html'
      '?memberStateCode=$country&number=$vat',
    );
    if (await canLaunchUrl(uri)) await launchUrl(uri);
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
              Expanded(
                child: Text(
                  isNew ? 'Nieuwe klant' : _name.text,
                  style: theme.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isNew)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Verwijderen',
                  onPressed: _delete,
                ),
              FilledButton(onPressed: _save, child: const Text('Opslaan')),
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (highRisk) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.08),
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.warning_amber,
                              color: Colors.red,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Hoog Wet DBA-risico: zorg voor een geldige overeenkomst van opdracht.',
                                style: TextStyle(
                                  color: Colors.red,
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
                      decoration: const InputDecoration(labelText: 'Naam *'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Verplicht' : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: TextFormField(
                            controller: _country,
                            decoration: const InputDecoration(
                              labelText: 'Land',
                            ),
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 2,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _vatNumber,
                            decoration: const InputDecoration(
                              labelText: 'BTW-nummer',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: _checkVies,
                          child: const Text('VIES'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _kvkNumber,
                            decoration: const InputDecoration(
                              labelText: 'KVK-nummer',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _address,
                      decoration: const InputDecoration(labelText: 'Adres'),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _contactPerson,
                            decoration: const InputDecoration(
                              labelText: 'Contactpersoon',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _email,
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _phone,
                            decoration: const InputDecoration(
                              labelText: 'Telefoon',
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Wet DBA', style: theme.textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _riskLevel,
                            decoration: const InputDecoration(
                              labelText: 'Risiconiveau',
                            ),
                            items: _kRiskOptions
                                .map(
                                  (r) => DropdownMenuItem(
                                    value: r,
                                    child: Text(r),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) => setState(() => _riskLevel = v!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CheckboxListTile(
                            value: _contractSigned,
                            onChanged: (v) =>
                                setState(() => _contractSigned = v ?? false),
                            title: const Text('Contract getekend'),
                            contentPadding: EdgeInsets.zero,
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
                                    DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2040),
                              );
                              if (d != null) {
                                setState(() => _contractExpiry = d);
                              }
                            },
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Vervaldatum contract',
                              ),
                              child: Text(
                                _contractExpiry != null
                                    ? AppFormat.date(_contractExpiry!)
                                    : '—',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      value: _isActive,
                      onChanged: (v) => setState(() => _isActive = v ?? true),
                      title: const Text('Actief'),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notes,
                      decoration: const InputDecoration(
                        labelText: 'Opmerkingen',
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
