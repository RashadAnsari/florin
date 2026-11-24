import 'package:drift/drift.dart' show Value;
import '../../services/tax_rules/tax_year_rules.dart';
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
import '../../widgets/validators.dart';
import '../../services/formats.dart';
import '../../widgets/list_scaffold.dart';
import '../../widgets/urencriterium_progress.dart';

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
      controls: UrencriteriumProgress(
        totalHours: list.fold(0.0, (s, e) => s + e.hours),
        billableHours: list
            .where((e) => e.billable)
            .fold<double>(0.0, (s, e) => s + e.hours),
        target: rules.urencriterium,
        yearOver: year < DateTime.now().year,
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
        trailing: Text('${AppFormat.hours(e.hours)} ${l.hoursUnitShort}'),
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

  /// The rules of the entry's year; its date lies in a supported year.
  TaxYearRules get _rules => ref.read(taxRulesProvider(_date.year));
  late final _description = TextEditingController(
    text: widget.entry?.description,
  );
  late final _hoursField = TextEditingController(
    text: widget.entry == null ? '' : AppFormat.hours(widget.entry!.hours),
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
              hours: Value(parseDecimal(_hoursField.text)!),
              clientProject: Value(optionalText(_clientProject.text)),
              notes: Value(optionalText(_notes.text)),
            ),
          ),
    );
    if (saved && mounted) context.pop();
  }

  /// Hours already logged on the chosen day in other entries.
  double get _loggedThatDay =>
      (ref.read(hourEntriesProvider(_date.year)).valueOrNull ??
              const <HourEntry>[])
          .where(
            (e) =>
                e.id != widget.entry?.id &&
                e.date.year == _date.year &&
                e.date.month == _date.month &&
                e.date.day == _date.day,
          )
          .fold(0.0, (s, e) => s + e.hours);

  String? _dayTotalError(String? v, AppLocalizations l) {
    final logged = _loggedThatDay;
    final left = 24 - logged;
    return Validate.decimal(
      v,
      l.hoursValidateDayTotal(AppFormat.hours(logged), AppFormat.hours(left)),
      max: left,
    );
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.hoursDeleteTitle,
      message: l.hoursDeleteMessage(widget.entry!.description),
      isDestructive: true,
      confirmLabel: l.actionDelete,
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
                  validator: (v) =>
                      Validate.decimal(v, l.hoursValidateHours, max: 24) ??
                      _dayTotalError(v, l),
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
                  Validate.required(v, l.hoursValidateDescription),
            ),
            const SizedBox(height: AppSpacing.field),
            EnumDropdown(
              label: l.hoursFieldWorkType,
              help: l.hoursFieldWorkTypeHelp(_rules.soMinHours),
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
