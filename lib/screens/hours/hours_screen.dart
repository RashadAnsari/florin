import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
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

class HoursScreen extends ConsumerWidget {
  const HoursScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
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
        title: Text(l.hoursTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/hours/new'),
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
            child: _EntryList(
              entries: entries,
              onTap: (e) => context.push('/hours/${e.id}', extra: e),
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
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final ok = totalHours >= target;
    final color = ok
        ? AppColors.income
        : yearDone
        ? AppColors.red
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
                l.hoursProgress(
                  totalHours.toStringAsFixed(1),
                  target.toStringAsFixed(0),
                ),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                l.hoursBillable(billableHours.toStringAsFixed(1)),
                style: theme.textTheme.bodySmall,
              ),
              const Spacer(),
              if (ok)
                Chip(
                  label: Text(l.hoursUrencriteriumOk),
                  backgroundColor: AppColors.income.withValues(alpha: 0.15),
                  labelStyle: const TextStyle(
                    color: AppColors.income,
                    fontSize: 12,
                  ),
                  padding: EdgeInsets.zero,
                )
              else
                Chip(
                  label: Text(
                    l.hoursUrencriteriumLeft(
                      (target - totalHours).toStringAsFixed(1),
                    ),
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
  final ValueChanged<HourEntry> onTap;

  const _EntryList({required this.entries, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (entries.isEmpty) {
      return Center(child: Text(l.hoursNone));
    }
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, i) {
        final e = entries[i];
        return ListTile(
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
              color: e.billable ? AppColors.income : null,
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
    final l = AppLocalizations.of(context)!;
    final Map<String, String> workTypeLabels = {
      'Billable': l.workTypeBillable,
      'Non-billable': l.workTypeNonBillable,
      'Administrative': l.workTypeAdministrative,
      'WBSO': l.workTypeWbso,
      'Other': l.workTypeOther,
    };

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
                widget.entry == null ? l.hoursNewEntry : l.hoursEditEntry,
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
                        decoration: InputDecoration(
                          labelText: l.hoursFieldDate,
                        ),
                        child: Text(AppFormat.date(_date)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      controller: _hours,
                      decoration: InputDecoration(
                        labelText: l.hoursFieldHours,
                        suffixText: 'u',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (v) {
                        final h = double.tryParse(
                          (v ?? '').replaceAll(',', '.'),
                        );
                        if (h == null || h <= 0) return l.hoursValidateHours;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _description,
                decoration: InputDecoration(labelText: l.hoursFieldDescription),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l.hoursValidateDescription
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _workType,
                decoration: InputDecoration(labelText: l.hoursFieldWorkType),
                items: _kWorkTypes
                    .map(
                      (t) => DropdownMenuItem(
                        value: t,
                        child: Text(workTypeLabels[t] ?? t),
                      ),
                    )
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
                decoration: InputDecoration(
                  labelText: l.hoursFieldClientProject,
                ),
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _billable,
                onChanged: (v) => setState(() => _billable = v ?? _billable),
                title: Text(l.hoursFieldBillable),
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
                decoration: InputDecoration(labelText: l.hoursFieldNotes),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  FilledButton.icon(
                    onPressed: _save,
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onPrimaryContainer,
                    ),
                    icon: const Icon(Icons.save_outlined, size: 18),
                    label: Text(l.actionSave),
                  ),
                  if (widget.entry != null) ...[
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: l.actionDelete,
                      color: Theme.of(context).colorScheme.error,
                      onPressed: _delete,
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

class HourDetailPage extends ConsumerWidget {
  final HourEntry? entry;

  const HourDetailPage({super.key, this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(entry == null ? l.hoursNewEntry : l.hoursEditEntry),
      ),
      body: _EntryForm(
        entry: entry,
        year: entry?.fiscalYear ?? year,
        onSaved: () => context.pop(),
        onDeleted: () => context.pop(),
      ),
    );
  }
}
