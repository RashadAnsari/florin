import 'package:drift/drift.dart' show Value;
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
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/date_field.dart';
import '../../widgets/detail_scaffold.dart';
import '../../widgets/enum_dropdown.dart';
import '../../widgets/feedback.dart';
import '../../widgets/form_row.dart';
import '../../widgets/list_scaffold.dart';
import '../../widgets/urencriterium_progress.dart';

double? _parseHours(String s) => double.tryParse(s.replaceAll(',', '.'));

class HoursScreen extends ConsumerWidget {
  const HoursScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final entries = ref.watch(hourEntriesProvider(year));
    final rules = ref.watch(taxRulesProvider(year));
    final list = entries.valueOrNull ?? const <HourEntry>[];

    return ListScaffold<HourEntry>(
      title: l.hoursTitle,
      addTooltip: l.hoursNewEntry,
      onAdd: () => context.push('/hours/new'),
      items: entries,
      emptyText: l.hoursNone,
      controls: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.section,
          vertical: AppSpacing.field,
        ),
        child: UrencriteriumProgress(
          totalHours: list.fold(0.0, (s, e) => s + e.hours),
          billableHours: list
              .where((e) => e.billable)
              .fold<double>(0.0, (s, e) => s + e.hours),
          target: rules.urencriterium,
          yearOver: year < DateTime.now().year,
        ),
      ),
      itemBuilder: (context, e) => ListTile(
        title: EllipsisText(e.description),
        subtitle: EllipsisText(
          [
            AppFormat.date(e.date),
            e.workType.label(l),
            if (e.clientProject != null) e.clientProject!,
          ].join('  '),
        ),
        trailing: Text(
          '${formatHours(e.hours)} ${l.hoursUnitShort}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: e.billable ? context.colors.income : null,
          ),
        ),
        onTap: () => context.push('/hours/${e.id}', extra: e),
      ),
    );
  }
}

class HourDetailPage extends ConsumerStatefulWidget {
  final HourEntry? entry;

  const HourDetailPage({super.key, this.entry});

  @override
  ConsumerState<HourDetailPage> createState() => _HourDetailPageState();
}

class _HourDetailPageState extends ConsumerState<HourDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date =
      widget.entry?.date ?? todayIn(ref.read(fiscalYearProvider));
  late WorkType _workType = widget.entry?.workType ?? WorkType.billable;
  late final _description = TextEditingController(
    text: widget.entry?.description,
  );
  late final _hoursField = TextEditingController(
    text: widget.entry == null
        ? ''
        : formatHours(widget.entry!.hours).replaceAll('.', ','),
  );
  late final _clientProject = TextEditingController(
    text: widget.entry?.clientProject,
  );
  late final _notes = TextEditingController(text: widget.entry?.notes);

  @override
  void dispose() {
    for (final c in [_description, _hoursField, _clientProject, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    String? n(String s) => s.trim().isEmpty ? null : s.trim();
    final saved = await guardSave(
      context,
      () => ref
          .read(hourDaoProvider)
          .save(
            HourEntriesCompanion(
              id: widget.entry == null
                  ? const Value.absent()
                  : Value(widget.entry!.id),
              date: Value(_date),
              description: Value(_description.text.trim()),
              workType: Value(_workType),
              hours: Value(_parseHours(_hoursField.text)!),
              clientProject: Value(n(_clientProject.text)),
              notes: Value(n(_notes.text)),
            ),
          ),
    );
    if (saved && mounted) context.pop();
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
    final deleted = await guardSave(
      context,
      () => ref.read(hourDaoProvider).remove(widget.entry!),
    );
    if (deleted && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return DetailScaffold(
      title: widget.entry == null ? l.hoursNewEntry : widget.entry!.description,
      onBack: () => context.pop(),
      onDelete: widget.entry == null ? null : _delete,
      onSave: _save,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            FormRow(
              children: [
                DateField(
                  label: l.hoursFieldDate,
                  help: l.hoursFieldDateHelp,
                  value: _date,
                  onChanged: (d) => setState(() => _date = d),
                  required: true,
                ),
                TextFormField(
                  controller: _hoursField,
                  decoration: fieldDecoration(
                    label: l.hoursFieldHours,
                    help: l.hoursFieldHoursHelp,
                    required: true,
                    suffixText: l.hoursUnitShort,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (v) {
                    final h = _parseHours(v ?? '');
                    return h == null || h <= 0 || h > 24
                        ? l.hoursValidateHours
                        : null;
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _description,
              decoration: fieldDecoration(
                label: l.hoursFieldDescription,
                help: l.hoursFieldDescriptionHelp,
                required: true,
              ),
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? l.hoursValidateDescription : null,
            ),
            const SizedBox(height: AppSpacing.field),
            EnumDropdown(
              label: l.hoursFieldWorkType,
              help: l.hoursFieldWorkTypeHelp,
              value: _workType,
              values: WorkType.values,
              labelOf: (t) => t.label(l),
              onChanged: (t) => setState(() => _workType = t),
              required: true,
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _clientProject,
              decoration: fieldDecoration(
                label: l.hoursFieldClientProject,
                help: l.hoursFieldClientProjectHelp,
              ),
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _notes,
              decoration: fieldDecoration(
                label: l.hoursFieldNotes,
                help: l.hoursFieldNotesHelp,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
