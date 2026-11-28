import 'package:drift/drift.dart' show Value;
import '../theme/app_theme.dart';
import '../services/tax_rules/tax_year_rules.dart';
import 'package:flutter/material.dart';
import 'help.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../db/database.dart';
import '../services/formats.dart';
import '../services/kor_service.dart';
import '../theme/app_spacing.dart';
import 'date_field.dart';
import 'form_row.dart';
import 'validators.dart';
import 'value_row.dart';

/// The values behind [BusinessProfileForm].
class BusinessProfileFields {
  final TextEditingController name;
  final TextEditingController vatNumber;
  final TextEditingController kvkNumber;
  final TextEditingController address;
  final TextEditingController iban;
  DateTime? korStart;
  DateTime? korEnd;

  BusinessProfileFields([BusinessProfile? p])
    : name = TextEditingController(text: p?.name),
      vatNumber = TextEditingController(text: p?.vatNumber),
      kvkNumber = TextEditingController(text: p?.kvkNumber),
      address = TextEditingController(text: p?.address),
      iban = TextEditingController(text: p?.iban),
      korStart = p?.korStart,
      korEnd = p?.korEnd;

  BusinessProfilesCompanion toCompanion() => BusinessProfilesCompanion(
    id: const Value(1),
    name: Value(name.text.trim()),
    vatNumber: Value(normalizeId(vatNumber.text)),
    kvkNumber: Value(normalizeId(kvkNumber.text)),
    address: Value(address.text.trim()),
    iban: Value(normalizeId(iban.text)),
    korStart: Value(korStart),
    korEnd: Value(korStart == null ? null : korEnd),
  );

  void dispose() {
    for (final c in [name, vatNumber, kvkNumber, address, iban]) {
      c.dispose();
    }
  }
}

/// The seller details printed on every invoice. Place inside a [Form].
class BusinessProfileForm extends StatefulWidget {
  final BusinessProfileFields fields;

  /// The rules of the selected year, for the figures the help texts name.
  final TaxYearRules rules;

  /// The KOR as the records show it, for the years a new start is blocked.
  final KorStatus kor;

  const BusinessProfileForm({
    super.key,
    required this.fields,
    required this.rules,
    this.kor = KorStatus.none,
  });

  @override
  State<BusinessProfileForm> createState() => _BusinessProfileFormState();
}

class _BusinessProfileFormState extends State<BusinessProfileForm> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final f = widget.fields;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: f.name,
          decoration: fieldDecoration(
            label: l.settingsBusinessName,
            help: l.settingsBusinessNameHelp,
            required: true,
          ),
          validator: (v) => Validate.required(v, l.settingsValidateName),
        ),
        const SizedBox(height: AppSpacing.field),
        FormRow(
          children: [
            TextFormField(
              controller: f.vatNumber,
              decoration: fieldDecoration(
                label: l.settingsVatNumber,
                help: l.settingsVatNumberHelp,
                required: true,
              ),
              validator: (v) => Validate.requiredFormat(
                v,
                empty: l.settingsValidateVat,
                valid: isValidDutchVatNumber,
                invalid: l.settingsValidateVatFormat,
              ),
            ),
            TextFormField(
              controller: f.kvkNumber,
              decoration: fieldDecoration(
                label: l.settingsKvkNumber,
                help: l.settingsKvkNumberHelp,
                required: true,
              ),
              validator: (v) => Validate.requiredFormat(
                v,
                empty: l.settingsValidateKvk,
                valid: isValidKvkNumber,
                invalid: l.settingsValidateKvkFormat,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.field),
        TextFormField(
          controller: f.address,
          decoration: fieldDecoration(
            label: l.settingsBusinessAddress,
            help: l.settingsBusinessAddressHelp,
            required: true,
          ),
          minLines: 3,
          maxLines: 4,
          validator: (v) => Validate.required(v, l.settingsValidateAddress),
        ),
        const SizedBox(height: AppSpacing.field),
        TextFormField(
          controller: f.iban,
          decoration: fieldDecoration(
            label: l.settingsIban,
            help: l.settingsIbanHelp,
            required: true,
          ),
          validator: (v) => Validate.requiredFormat(
            v,
            empty: l.settingsValidateIban,
            valid: isValidIban,
            invalid: l.settingsValidateIbanFormat,
          ),
        ),
        const SizedBox(height: AppSpacing.group),
        SectionLabel(
          l.settingsKorSection,
          help: l.settingsKorSectionHelp(
            AppFormat.euros(widget.rules.korThreshold),
          ),
        ),
        const SizedBox(height: AppSpacing.heading),
        FormRow(
          children: [
            // The KOR may have started before the years Florin supports.
            DateField(
              label: l.settingsKorStart,
              help: l.settingsKorStartHelp(
                AppFormat.euros(widget.rules.korThreshold),
              ),
              value: f.korStart,
              firstDate: DateTime(2000),
              onChanged: (d) => setState(() => f.korStart = d),
              validator: (_) {
                final start = f.korStart;
                if (start == null) return null;
                if (start.day != 1) return l.settingsValidateKorStart;
                final until = widget.kor.startBlockedUntil(start);
                return until == null
                    ? null
                    : l.settingsValidateKorStartBlocked(AppFormat.date(until));
              },
            ),
            if (f.korStart == null)
              const SizedBox.shrink()
            else
              DateField(
                label: l.settingsKorEnd,
                help: l.settingsKorEndHelp,
                value: f.korEnd,
                firstDate: DateTime(2000),
                onChanged: (d) => setState(() => f.korEnd = d),
                validator: (_) {
                  final end = f.korEnd;
                  if (end == null) return null;
                  if (!end.isAfter(f.korStart!)) {
                    return l.settingsValidateKorEndBeforeStart;
                  }
                  return end.day != 1 ? l.settingsValidateKorEndDay : null;
                },
              ),
          ],
        ),
        if (f.korStart != null) ...[
          const SizedBox(height: AppSpacing.tight),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              onPressed: () => setState(() {
                f.korStart = null;
                f.korEnd = null;
              }),
              icon: const Icon(Icons.clear, size: 16),
              label: Text(l.settingsKorClear),
            ),
          ),
        ],
      ],
    );
  }
}
