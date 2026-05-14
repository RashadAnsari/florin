import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/tax_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/confirmation_dialog.dart';

const _kWorkTypes = [
  'Billable',
  'Non-billable',
  'Administrative',
  'WBSO',
  'Other',
];

bool _isBillableWorkType(String workType) => workType == 'Billable';

bool _isWbsoWorkType(String workType) => workType == 'WBSO';

String _workTypeLabel(AppLocalizations l, String workType) =>
    switch (workType) {
      'Billable' => l.workTypeBillable,
      'Non-billable' => l.workTypeNonBillable,
      'Administrative' => l.workTypeAdministrative,
      'WBSO' => l.workTypeWbso,
      'Other' => l.workTypeOther,
      _ => l.workTypeOther,
    };

class HoursScreen extends ConsumerWidget {
  const HoursScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final entriesAsync = ref.watch(hourEntriesStreamProvider(year));
    final entries = entriesAsync.valueOrNull ?? [];
    final params = ref.watch(taxParamsStreamProvider(year)).valueOrNull;
    final totalHours = entries.fold<double>(0.0, (s, e) => s + e.hours);
    final billableHours = entries
        .where((e) => e.billable)
        .fold<double>(0.0, (s, e) => s + e.hours);
    final target =
        (params?.urencriteriumThreshold ?? TaxService.urencriteriumThreshold)
            .toDouble();
    final progress = (totalHours / target).clamp(0.0, 1.0);
    final yearDone = year < DateTime.now().year;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.hoursTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: l.hoursNewEntry,
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
          const Divider(height: 1),
          Expanded(
            child: entriesAsync.when(
              data: (all) => _EntryList(
                entries: all,
                onTap: (e) => context.push('/hours/${e.id}', extra: e),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(l.genericLoadError('$e'))),
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
        final detail = e.clientProject != null && e.clientProject!.isNotEmpty
            ? '${_workTypeLabel(l, e.workType)}, ${e.clientProject}'
            : _workTypeLabel(l, e.workType);
        return ListTile(
          title: Text(
            e.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppFormat.date(e.date),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
          isThreeLine: true,
          dense: true,
          visualDensity: VisualDensity.compact,
          trailing: Text(
            '${e.hours.toStringAsFixed(1)} ${l.hoursUnitShort}',
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
  final VoidCallback? onBack;
  final VoidCallback onSaved;
  final VoidCallback onDeleted;

  const _EntryForm({
    required this.entry,
    required this.year,
    required this.onBack,
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
    _workType = e == null
        ? 'Billable'
        : _kWorkTypes.contains(e.workType)
        ? e.workType
        : 'Other';
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
      billable: Value(_isBillableWorkType(_workType)),
      clientProject: Value(
        _clientProject.text.trim().isEmpty ? null : _clientProject.text.trim(),
      ),
      isWbso: Value(_isWbsoWorkType(_workType)),
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
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.hoursDeleteTitle,
      message: l.hoursDeleteMessage(widget.entry!.description),
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref.read(hourDaoProvider).deleteEntry(widget.entry!.id);
    if (mounted) widget.onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isNew = widget.entry == null;

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
                  isNew ? l.hoursNewEntry : _description.text,
                  style: theme.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isNew)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: l.actionDelete,
                  color: theme.colorScheme.error,
                  onPressed: _delete,
                ),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined, size: 18),
                label: Text(l.actionSave),
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          key: ValueKey(_date.toString()),
                          initialValue: AppFormat.date(_date),
                          readOnly: true,
                          strutStyle: StrutStyle.disabled,
                          decoration: InputDecoration(
                            labelText: l.hoursFieldDate,
                          ),
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate: _date,
                              firstDate: DateTime(widget.year, 1, 1),
                              lastDate: DateTime(widget.year, 12, 31),
                            );
                            if (d != null) setState(() => _date = d);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _hours,
                          decoration: InputDecoration(
                            labelText: l.hoursFieldHours,
                            suffixText: l.hoursUnitShort,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (v) {
                            final h = double.tryParse(
                              (v ?? '').replaceAll(',', '.'),
                            );
                            if (h == null || h <= 0) {
                              return l.hoursValidateHours;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _description,
                    decoration: InputDecoration(
                      labelText: l.hoursFieldDescription,
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l.hoursValidateDescription
                        : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _workType,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: l.hoursFieldWorkType,
                    ),
                    validator: (v) =>
                        v == null ? l.hoursValidateWorkType : null,
                    items: _kWorkTypes
                        .map(
                          (t) => DropdownMenuItem(
                            value: t,
                            child: Text(_workTypeLabel(l, t)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _workType = v ?? _workType),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _clientProject,
                    decoration: InputDecoration(
                      labelText: l.hoursFieldClientProject,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notes,
                    decoration: InputDecoration(labelText: l.hoursFieldNotes),
                    maxLines: 2,
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

class HourDetailPage extends ConsumerWidget {
  final HourEntry? entry;

  const HourDetailPage({super.key, this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = ref.watch(fiscalYearProvider);
    return Scaffold(
      body: _EntryForm(
        entry: entry,
        year: entry?.fiscalYear ?? year,
        onBack: () => context.pop(),
        onSaved: () => context.pop(),
        onDeleted: () => context.pop(),
      ),
    );
  }
}
