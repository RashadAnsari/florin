import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';

const _kWorkTypes = [
  'Billable',
  'Non-billable',
  'Administrative',
  'WBSO',
  'Other',
];

class HoursScreen extends ConsumerStatefulWidget {
  const HoursScreen({super.key});

  @override
  ConsumerState<HoursScreen> createState() => _HoursScreenState();
}

class _HoursScreenState extends ConsumerState<HoursScreen> {
  HourEntry? _selected;
  bool _isNew = false;

  @override
  Widget build(BuildContext context) {
    final year = ref.watch(fiscalYearProvider);
    final entries =
        ref.watch(hourEntriesStreamProvider(year)).valueOrNull ?? [];
    final totalHours = entries.fold<double>(0.0, (s, e) => s + e.hours);
    final billableHours = entries
        .where((e) => e.billable)
        .fold<double>(0.0, (s, e) => s + e.hours);
    const target = 1225.0;
    final progress = (totalHours / target).clamp(0.0, 1.0);
    final yearDone = year < DateTime.now().year;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Urenregistratie'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() {
              _selected = null;
              _isNew = true;
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          _SummaryBar(
            totalHours: totalHours,
            billableHours: billableHours,
            progress: progress,
            target: target,
            yearDone: yearDone,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 320,
                  child: _EntryList(
                    entries: entries,
                    selected: _selected,
                    onTap: (e) => setState(() {
                      _selected = e;
                      _isNew = false;
                    }),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: (_isNew || _selected != null)
                      ? _EntryForm(
                          key: ValueKey(_isNew ? 'new' : _selected!.id),
                          entry: _isNew ? null : _selected,
                          year: year,
                          onSaved: () => setState(() {
                            _selected = null;
                            _isNew = false;
                          }),
                          onDeleted: () => setState(() {
                            _selected = null;
                            _isNew = false;
                          }),
                        )
                      : const Center(
                          child: Text('Selecteer een invoer of klik +'),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryBar extends StatelessWidget {
  final double totalHours;
  final double billableHours;
  final double progress;
  final double target;
  final bool yearDone;

  const _SummaryBar({
    required this.totalHours,
    required this.billableHours,
    required this.progress,
    required this.target,
    required this.yearDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ok = totalHours >= target;
    final color = ok
        ? Colors.green
        : yearDone
        ? Colors.red
        : theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${totalHours.toStringAsFixed(1)} / ${target.toStringAsFixed(0)} uur',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Facturabel: ${billableHours.toStringAsFixed(1)} uur',
                style: theme.textTheme.bodySmall,
              ),
              const Spacer(),
              if (ok)
                Chip(
                  label: const Text('Urencriterium OK'),
                  backgroundColor: Colors.green.withValues(alpha: 0.15),
                  labelStyle: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                  padding: EdgeInsets.zero,
                )
              else
                Chip(
                  label: Text(
                    '${(target - totalHours).toStringAsFixed(1)} uur te gaan',
                  ),
                  backgroundColor: color.withValues(alpha: 0.1),
                  labelStyle: TextStyle(color: color, fontSize: 12),
                  padding: EdgeInsets.zero,
                ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              color: color,
              backgroundColor: color.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryList extends StatelessWidget {
  final List<HourEntry> entries;
  final HourEntry? selected;
  final ValueChanged<HourEntry> onTap;

  const _EntryList({
    required this.entries,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(child: Text('Geen uren geregistreerd'));
    }
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, i) {
        final e = entries[i];
        return ListTile(
          selected: selected?.id == e.id,
          selectedTileColor: Theme.of(
            context,
          ).colorScheme.primaryContainer.withValues(alpha: 0.3),
          title: Text(
            e.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${AppFormat.date(e.date)}  ·  ${e.workType}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Text(
            '${e.hours.toStringAsFixed(1)}u',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: e.billable ? Colors.green : null,
            ),
          ),
          onTap: () => onTap(e),
        );
      },
    );
  }
}

class _EntryForm extends ConsumerStatefulWidget {
  final HourEntry? entry;
  final int year;
  final VoidCallback onSaved;
  final VoidCallback onDeleted;

  const _EntryForm({
    super.key,
    required this.entry,
    required this.year,
    required this.onSaved,
    required this.onDeleted,
  });

  @override
  ConsumerState<_EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends ConsumerState<_EntryForm> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date;
  late TextEditingController _description;
  late TextEditingController _hours;
  late TextEditingController _clientProject;
  late TextEditingController _notes;
  late String _workType;
  late bool _billable;
  late bool _isWbso;

  @override
  void initState() {
    super.initState();
    final e = widget.entry;
    _date = e?.date ?? DateTime.now();
    _description = TextEditingController(text: e?.description ?? '');
    _hours = TextEditingController(
      text: e != null ? e.hours.toStringAsFixed(1).replaceAll('.', ',') : '',
    );
    _clientProject = TextEditingController(text: e?.clientProject ?? '');
    _notes = TextEditingController(text: e?.notes ?? '');
    _workType = e?.workType ?? 'Billable';
    _billable = e?.billable ?? true;
    _isWbso = e?.isWbso ?? false;
  }

  @override
  void dispose() {
    _description.dispose();
    _hours.dispose();
    _clientProject.dispose();
    _notes.dispose();
    super.dispose();
  }

  double get _parsedHours =>
      double.tryParse(_hours.text.replaceAll(',', '.')) ?? 0.0;

  int _weekNumber(DateTime d) {
    final startOfYear = DateTime(d.year, 1, 1);
    final dayOfYear = d.difference(startOfYear).inDays;
    return (dayOfYear / 7).ceil() + 1;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final dao = ref.read(hourDaoProvider);
    final companion = HourEntriesCompanion(
      id: widget.entry != null ? Value(widget.entry!.id) : const Value.absent(),
      date: Value(_date),
      description: Value(_description.text.trim()),
      workType: Value(_workType),
      hours: Value(_parsedHours),
      billable: Value(_billable),
      clientProject: Value(
        _clientProject.text.trim().isEmpty ? null : _clientProject.text.trim(),
      ),
      isWbso: Value(_isWbso),
      notes: Value(_notes.text.trim().isEmpty ? null : _notes.text.trim()),
      fiscalYear: Value(widget.year),
      weekNumber: Value(_weekNumber(_date)),
    );
    if (widget.entry == null) {
      await dao.insertEntry(companion);
    } else {
      await dao.saveEntry(companion);
    }
    widget.onSaved();
  }

  Future<void> _delete() async {
    final dao = ref.read(hourDaoProvider);
    await dao.deleteEntry(widget.entry!.id);
    widget.onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.entry == null ? 'Nieuwe invoer' : 'Bewerk invoer',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(widget.year, 1, 1),
                          lastDate: DateTime(widget.year, 12, 31),
                        );
                        if (d != null) setState(() => _date = d);
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: 'Datum'),
                        child: Text(AppFormat.date(_date)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      controller: _hours,
                      decoration: const InputDecoration(
                        labelText: 'Uren',
                        suffixText: 'u',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (v) {
                        final h = double.tryParse(
                          (v ?? '').replaceAll(',', '.'),
                        );
                        if (h == null || h <= 0) return 'Vul uren in';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _description,
                decoration: const InputDecoration(labelText: 'Omschrijving'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Verplicht' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _workType,
                decoration: const InputDecoration(labelText: 'Type werk'),
                items: _kWorkTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() {
                  _workType = v ?? _workType;
                  if (_workType == 'Billable') _billable = true;
                  if (_workType != 'Billable') _billable = false;
                }),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _clientProject,
                decoration: const InputDecoration(
                  labelText: 'Klant / project (optioneel)',
                ),
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _billable,
                onChanged: (v) => setState(() => _billable = v ?? _billable),
                title: const Text('Facturabel'),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                value: _isWbso,
                onChanged: (v) => setState(() => _isWbso = v ?? _isWbso),
                title: const Text('WBSO'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notes,
                decoration: const InputDecoration(
                  labelText: 'Notities (optioneel)',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  FilledButton(onPressed: _save, child: const Text('Opslaan')),
                  if (widget.entry != null) ...[
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _delete,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Verwijderen'),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
