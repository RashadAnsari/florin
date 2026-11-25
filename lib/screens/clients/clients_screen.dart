import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../widgets/value_row.dart';
import '../../widgets/help.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../l10n/labels.dart';
import '../../providers/providers.dart';
import '../../services/domain.dart';
import '../../services/formats.dart';
import '../../widgets/validators.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons.dart';
import '../../widgets/choice_chips.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/date_field.dart';
import '../../widgets/detail_scaffold.dart';
import '../../widgets/enum_dropdown.dart';
import '../../widgets/feedback.dart';
import '../../widgets/form_row.dart';
import '../../widgets/list_scaffold.dart';
import '../../widgets/notice_banner.dart';
import '../../widgets/tone_badge.dart';

enum _ClientFilter { all, active, inactive }

Color _riskColor(BuildContext context, WetDbaRisk risk) => switch (risk) {
  WetDbaRisk.high => context.colors.danger,
  WetDbaRisk.medium => context.colors.warning,
  WetDbaRisk.low => context.colors.income,
};

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  _ClientFilter _filter = _ClientFilter.all;
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final paid = <int, int>{};
    for (final i
        in ref.watch(invoicesProvider(year)).valueOrNull ?? const <Invoice>[]) {
      if (i.status == InvoiceStatus.paid) {
        paid[i.clientId] = (paid[i.clientId] ?? 0) + i.totalInclVat;
      }
    }
    final q = _search.text.toLowerCase().trim();
    final clients = ref
        .watch(clientsProvider)
        .whenData(
          (all) => all
              .where(
                (c) =>
                    switch (_filter) {
                      _ClientFilter.all => true,
                      _ClientFilter.active => c.isActive,
                      _ClientFilter.inactive => !c.isActive,
                    } &&
                    (q.isEmpty || c.name.toLowerCase().contains(q)),
              )
              .toList(),
        );

    return ListScaffold<Client>(
      title: l.clientsTitle,
      addTooltip: l.clientsNewTooltip,
      onAdd: () => context.push('/clients/new'),
      items: clients,
      emptyText: l.clientsNone,
      controls: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(
            controller: _search,
            hint: l.labelSearch,
            help: l.clientsSearchHelp,
            onChanged: () => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.heading),
          ChoiceChips(
            selected: _filter,
            onSelected: (f) => setState(() => _filter = f),
            options: [
              (_ClientFilter.all, l.clientsFilterAll),
              (_ClientFilter.active, l.clientsFilterActive),
              (_ClientFilter.inactive, l.clientsFilterInactive),
            ],
          ),
        ],
      ),
      itemBuilder: (context, c) => ListTile(
        title: EllipsisText(c.name),
        subtitle: EllipsisText(
          l.clientsPaidInYear(year, AppFormat.cents(paid[c.id] ?? 0)),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!c.isActive) ...[
              ToneBadge(
                label: l.clientsInactive,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(width: AppSpacing.tight),
            ],
            c.isMerchantOfRecord
                ? ToneBadge(
                    label: l.clientsBadgeMerchantOfRecord,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : c.isConsumer
                ? ToneBadge(
                    label: l.clientsBadgeConsumer,
                    color: Theme.of(context).colorScheme.outline,
                  )
                : ToneBadge(
                    label: l.clientsDbaBadge(c.wetDbaRisk.label(l)),
                    color: _riskColor(context, c.wetDbaRisk),
                  ),
          ],
        ),
        onTap: () => context.push('/clients/${c.id}', extra: c),
      ),
    );
  }
}

class ClientDetailPage extends ConsumerStatefulWidget {
  final Client? client;

  const ClientDetailPage({super.key, this.client});

  @override
  ConsumerState<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends ConsumerState<ClientDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.client?.name);
  late final _country = TextEditingController(
    text: widget.client?.country ?? 'NL',
  );
  late final _vatNumber = TextEditingController(text: widget.client?.vatNumber);
  late final _kvkNumber = TextEditingController(text: widget.client?.kvkNumber);
  late final _address = TextEditingController(text: widget.client?.address);
  late final _contactPerson = TextEditingController(
    text: widget.client?.contactPerson,
  );
  late final _email = TextEditingController(text: widget.client?.email);
  late final _phone = TextEditingController(text: widget.client?.phone);
  late final _notes = TextEditingController(text: widget.client?.notes);
  late WetDbaRisk _risk = widget.client?.wetDbaRisk ?? WetDbaRisk.low;
  late DateTime? _contractExpiry = widget.client?.contractExpiry;
  late bool _contractSigned = widget.client?.contractSigned ?? false;
  late bool _isActive = widget.client?.isActive ?? true;
  late bool _isMerchantOfRecord = widget.client?.isMerchantOfRecord ?? false;
  late bool _isConsumer = widget.client?.isConsumer ?? false;
  bool _referenced = false;

  /// A reseller is a business, so the option is off for a consumer: a
  /// hidden option may not stay set.
  bool get _merchant => !_isConsumer && _isMerchantOfRecord;

  @override
  void initState() {
    super.initState();
    final c = widget.client;
    if (c != null) {
      // When the check fails, deleting stays blocked: the cautious answer.
      ref
          .read(clientDaoProvider)
          .isReferenced(c.id)
          .then(
            (has) {
              if (mounted) setState(() => _referenced = has);
            },
            onError: (Object _) {
              if (mounted) setState(() => _referenced = true);
            },
          );
    }
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _country,
      _vatNumber,
      _kvkNumber,
      _address,
      _contactPerson,
      _email,
      _phone,
      _notes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final saved = await guardSave(
      context,
      () => ref
          .read(clientDaoProvider)
          .save(
            ClientsCompanion(
              id: widget.client == null
                  ? const Value.absent()
                  : Value(widget.client!.id),
              name: Value(_name.text.trim()),
              country: Value(normalizeId(_country.text)),
              vatNumber: Value(
                optionalText(_vatNumber.text) == null
                    ? null
                    : normalizeId(_vatNumber.text),
              ),
              kvkNumber: Value(
                optionalText(_kvkNumber.text) == null
                    ? null
                    : normalizeId(_kvkNumber.text),
              ),
              address: Value(_address.text.trim()),
              contactPerson: Value(optionalText(_contactPerson.text)),
              email: Value(optionalText(_email.text)),
              phone: Value(optionalText(_phone.text)),
              // A reseller has no working relationship to assess.
              wetDbaRisk: Value(_merchant ? WetDbaRisk.low : _risk),
              contractSigned: Value(!_merchant && _contractSigned),
              contractExpiry: Value(_merchant ? null : _contractExpiry),
              // A reseller is a business, so a consumer is never one.
              isMerchantOfRecord: Value(_merchant),
              isConsumer: Value(_isConsumer),
              notes: Value(optionalText(_notes.text)),
              isActive: Value(_isActive),
            ),
          ),
    );
    if (saved && mounted) context.pop();
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.clientsDeleteTitle,
      message: l.clientsDeleteMessage(widget.client!.name),
      isDestructive: true,
      confirmLabel: l.actionDelete,
    );
    if (!confirmed || !mounted) return;
    final deleted = await guardSave(
      context,
      () => ref.read(clientDaoProvider).remove(widget.client!),
    );
    if (deleted && mounted) context.pop();
  }

  /// A VAT number of a client in another member state starts with that
  /// state's code; Greece uses EL.
  String? _vatNumberError(String? v, AppLocalizations l) {
    final format = Validate.optional(v, isValidVatId, l.clientsValidateVat);
    if (format != null) return format;
    final vat = normalizeId(v ?? '');
    final country = normalizeId(_country.text);
    if (vat.isEmpty || !isEuCountry(country)) return null;
    final prefix = country == 'GR' ? 'EL' : country;
    return vat.startsWith(prefix) ? null : l.clientsValidateVatCountry(prefix);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return DetailScaffold(
      title: widget.client == null ? l.clientsNewHeader : widget.client!.name,
      onBack: () => context.pop(),
      actions: [
        if (widget.client != null && _referenced)
          DeleteIconButton(
            tooltip: l.clientsDeleteBlockedTooltip,
            onPressed: null,
          ),
      ],
      onDelete: widget.client == null || _referenced ? null : _delete,
      onSave: _save,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_merchant && _risk == WetDbaRisk.high) ...[
              NoticeBanner(l.clientsHighRiskWarning, tone: NoticeTone.error),
              const SizedBox(height: AppSpacing.group),
            ],
            TextFormField(
              controller: _name,
              decoration: fieldDecoration(
                label: l.clientsFieldName,
                help: l.clientsFieldNameHelp,
                required: true,
              ),
              validator: (v) => Validate.required(v, l.clientsValidateName),
            ),
            const SizedBox(height: AppSpacing.field),
            FormRow(
              flex: const [1, 3, 3],
              children: [
                TextFormField(
                  controller: _country,
                  decoration: fieldDecoration(
                    label: l.clientsFieldCountry,
                    help: l.clientsFieldCountryHelp,
                    required: true,
                    counterText: '',
                  ),
                  maxLength: 2,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                    TextInputFormatter.withFunction(
                      (old, next) =>
                          next.copyWith(text: next.text.toUpperCase()),
                    ),
                  ],
                  onChanged: (_) => setState(() {}),
                  validator: (v) => Validate.requiredFormat(
                    v,
                    empty: l.clientsValidateCountry,
                    valid: isValidCountryCode,
                    invalid: l.clientsValidateCountry,
                  ),
                ),
                TextFormField(
                  controller: _vatNumber,
                  decoration: fieldDecoration(
                    label: l.clientsFieldVat,
                    help: l.clientsFieldVatHelp,
                  ),
                  validator: (v) => _vatNumberError(v, l),
                ),
                TextFormField(
                  controller: _kvkNumber,
                  decoration: fieldDecoration(
                    label: l.clientsFieldKvk,
                    help: l.clientsFieldKvkHelp,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => Validate.optional(
                    v,
                    isValidKvkNumber,
                    l.clientsValidateKvk,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _address,
              decoration: fieldDecoration(
                label: l.clientsFieldAddress,
                help: l.clientsFieldAddressHelp,
                required: true,
              ),
              minLines: 3,
              maxLines: 4,
              validator: (v) => Validate.required(v, l.clientsValidateAddress),
            ),
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                TextFormField(
                  controller: _contactPerson,
                  decoration: fieldDecoration(
                    label: l.clientsFieldContact,
                    help: l.clientsFieldContactHelp,
                  ),
                ),
                TextFormField(
                  controller: _email,
                  decoration: fieldDecoration(
                    label: l.clientsFieldEmail,
                    help: l.clientsFieldEmailHelp,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => Validate.optional(
                    v,
                    isValidEmail,
                    l.clientsValidateEmail,
                  ),
                ),
                TextFormField(
                  controller: _phone,
                  decoration: fieldDecoration(
                    label: l.clientsFieldPhone,
                    help: l.clientsFieldPhoneHelp,
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) => Validate.optional(
                    v,
                    isValidPhone,
                    l.clientsValidatePhone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            HelpCheckbox(
              value: _isConsumer,
              onChanged: (v) => setState(() => _isConsumer = v),
              title: l.clientsConsumer,
              help: l.clientsConsumerHelp,
            ),
            if (!_isConsumer)
              HelpCheckbox(
                value: _isMerchantOfRecord,
                onChanged: (v) => setState(() => _isMerchantOfRecord = v),
                title: l.clientsMerchantOfRecord,
                help: l.clientsMerchantOfRecordHelp,
              ),
            if (!_merchant) ...[
              const SizedBox(height: AppSpacing.section),
              SectionLabel(l.clientsWetDba, help: l.clientsWetDbaHelp),
              const SizedBox(height: AppSpacing.heading),
              FormRow(
                children: [
                  EnumDropdown(
                    label: l.clientsRiskLevel,
                    help: l.clientsRiskLevelHelp,
                    value: _risk,
                    values: WetDbaRisk.values,
                    labelOf: (r) => r.label(l),
                    onChanged: (r) => setState(() => _risk = r),
                    required: true,
                  ),
                  DateField(
                    label: l.clientsContractExpiry,
                    help: l.clientsContractExpiryHelp,
                    value: _contractExpiry,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onChanged: (d) => setState(() => _contractExpiry = d),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.field),
              HelpCheckbox(
                value: _contractSigned,
                onChanged: (v) => setState(() => _contractSigned = v),
                title: l.clientsContractSigned,
                help: l.clientsContractSignedHelp,
              ),
              if (widget.client != null) _ClientRate(client: widget.client!),
            ],
            HelpCheckbox(
              value: _isActive,
              onChanged: (v) => setState(() => _isActive = v),
              title: l.clientsFieldActive,
              help: l.clientsFieldActiveHelp,
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _notes,
              decoration: fieldDecoration(
                label: l.clientsFieldNotes,
                help: l.clientsFieldNotesHelp,
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

/// The hours logged for [client] in the selected year against what it was
/// invoiced: an estimated hourly rate, a fact a Wet DBA assessment weighs.
class _ClientRate extends ConsumerWidget {
  final Client client;

  const _ClientRate({required this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final hours = ownHours(
      (ref.watch(hourEntriesProvider(year)).valueOrNull ?? const <HourEntry>[])
          .where((h) => h.clientId == client.id),
    );
    final invoiced =
        (ref.watch(invoicesProvider(year)).valueOrNull ?? const <Invoice>[])
            .where((i) => i.clientId == client.id && i.isIssued)
            .fold(0, (s, i) => s + i.signedExclVat);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.field),
        SectionLabel(
          l.clientsRateSection(year),
          help: l.clientsRateSectionHelp,
        ),
        ValueRow(
          label: l.clientsRateHours,
          value: '${AppFormat.hours(hours)} ${l.hoursUnitShort}',
        ),
        ValueRow.cents(l.clientsRateInvoiced, invoiced),
        ValueRow(
          label: l.clientsRateEstimate,
          help: l.clientsRateEstimateHelp,
          value: hours > 0
              ? AppFormat.cents((invoiced / hours).round())
              : l.clientsRateNoHours,
        ),
      ],
    );
  }
}
