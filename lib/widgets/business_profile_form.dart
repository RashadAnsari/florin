import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'help.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../db/database.dart';
import '../services/vat_service.dart';
import '../theme/app_spacing.dart';
import 'form_row.dart';

/// The values behind [BusinessProfileForm].
class BusinessProfileFields {
  final TextEditingController name;
  final TextEditingController vatNumber;
  final TextEditingController kvkNumber;
  final TextEditingController address;
  final TextEditingController iban;
  bool isStarter;

  BusinessProfileFields([BusinessProfile? p])
    : name = TextEditingController(text: p?.name),
      vatNumber = TextEditingController(text: p?.vatNumber),
      kvkNumber = TextEditingController(text: p?.kvkNumber),
      address = TextEditingController(text: p?.address),
      iban = TextEditingController(text: p?.iban),
      isStarter = p?.isStarter ?? false;

  BusinessProfilesCompanion toCompanion() => BusinessProfilesCompanion(
    id: const Value(1),
    name: Value(name.text.trim()),
    vatNumber: Value(vatNumber.text.replaceAll(' ', '').toUpperCase()),
    kvkNumber: Value(kvkNumber.text.replaceAll(' ', '')),
    address: Value(address.text.trim()),
    iban: Value(iban.text.replaceAll(' ', '').toUpperCase()),
    isStarter: Value(isStarter),
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

  const BusinessProfileForm({super.key, required this.fields});

  @override
  State<BusinessProfileForm> createState() => _BusinessProfileFormState();
}

class _BusinessProfileFormState extends State<BusinessProfileForm> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final f = widget.fields;
    String? check(
      String? v,
      String empty,
      bool Function(String) valid,
      String bad,
    ) {
      final s = (v ?? '').trim();
      if (s.isEmpty) return empty;
      return valid(s) ? null : bad;
    }

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
          validator: (v) =>
              (v ?? '').trim().isEmpty ? l.settingsValidateName : null,
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
              validator: (v) => check(
                v,
                l.settingsValidateVat,
                isValidDutchVatNumber,
                l.settingsValidateVatFormat,
              ),
            ),
            TextFormField(
              controller: f.kvkNumber,
              decoration: fieldDecoration(
                label: l.settingsKvkNumber,
                help: l.settingsKvkNumberHelp,
                required: true,
              ),
              validator: (v) => check(
                v,
                l.settingsValidateKvk,
                isValidKvkNumber,
                l.settingsValidateKvkFormat,
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
          validator: (v) =>
              (v ?? '').trim().isEmpty ? l.settingsValidateAddress : null,
        ),
        const SizedBox(height: AppSpacing.field),
        TextFormField(
          controller: f.iban,
          decoration: fieldDecoration(
            label: l.settingsIban,
            help: l.settingsIbanHelp,
            required: true,
          ),
          validator: (v) => check(
            v,
            l.settingsValidateIban,
            isValidIban,
            l.settingsValidateIbanFormat,
          ),
        ),
        const SizedBox(height: AppSpacing.field),
        HelpCheckbox(
          value: f.isStarter,
          onChanged: (v) => setState(() => f.isStarter = v),
          title: l.settingsStartersaftrek,
          help: l.settingsStartersaftrekHelp,
          subtitle: l.firstLaunchStartersSubtitle,
        ),
      ],
    );
  }
}
