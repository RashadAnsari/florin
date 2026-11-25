import 'dart:io';

import 'package:flutter/material.dart';
import '../../services/receipt_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../app.dart' show localeProvider, kSupportedLocales;
import '../../constants/prefs_keys.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/csv_export_service.dart';
import '../../services/db_location_service.dart';
import '../../services/tax_rules/tax_year_rules.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/async_body.dart';
import '../../widgets/business_profile_form.dart';
import '../../widgets/buttons.dart';
import '../../widgets/feedback.dart';
import '../../widgets/help.dart';
import '../../widgets/value_row.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _exportRunning = false;

  Future<void> _moveDb() async {
    final l = AppLocalizations.of(context)!;
    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: l.dbLocationChooseFolderDialog,
    );
    if (dir == null || !mounted) return;
    String? path;
    final ok = await guardSave(context, () async {
      path = await DbLocationService.copyTo(
        ref.read(databaseProvider),
        dir,
        ref.read(receiptServiceProvider).store,
      );
    });
    if (ok && mounted) {
      await ref.read(dbPathNotifierProvider).setPath(path!);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.settingsMoved(path!))));
      }
    }
  }

  Future<void> _exportCsv() async {
    final l = AppLocalizations.of(context)!;
    final year = ref.read(fiscalYearProvider);
    setState(() => _exportRunning = true);
    try {
      final dir = await CsvExportService(ref.read(databaseProvider)).exportYear(
        year,
        dialogTitle: l.csvExportChooseFolderDialog,
        periods: ref.read(vatYearProvider(year)).requireValue,
        quarters: [
          for (var q = 1; q <= 4; q++)
            ref
                .read(
                  vatPeriodProvider((
                    year: year,
                    kind: VatFilingPeriod.quarterly,
                    number: q,
                  )),
                )
                .requireValue,
        ],
        incomeTax: ref.read(taxEstimateProvider(year)).valueOrNull?.result,
        balance: ref.read(balanceSheetProvider(year)).valueOrNull,
        receipts: ref.read(receiptServiceProvider).store,
      );
      if (dir != null && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.settingsExported(dir))));
      }
    } catch (e) {
      if (mounted) showSaveError(context, e);
    } finally {
      if (mounted) setState(() => _exportRunning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final dbPath = ref.watch(dbPathNotifierProvider).path;
    final year = ref.watch(fiscalYearProvider);
    final rules = ref.watch(taxRulesProvider(year));
    // Keeps the figures the export writes loaded; the button waits for them.
    final figures = [
      ref.watch(vatYearProvider(year)),
      for (var q = 1; q <= 4; q++)
        ref.watch(
          vatPeriodProvider((
            year: year,
            kind: VatFilingPeriod.quarterly,
            number: q,
          )),
        ),
      ref.watch(taxEstimateProvider(year)),
      ref.watch(balanceSheetProvider(year)),
    ];
    final figuresReady = figures.every((f) => f.hasValue);
    final locale = ref.watch(localeProvider);
    final sectionTitle = theme.textTheme.titleLarge;

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsTitle)),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelWithHelp(
              l.settingsLanguageSection,
              help: l.settingsLanguageSectionHelp,
              style: sectionTitle,
            ),
            const SizedBox(height: AppSpacing.field),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'nl', label: Text(l.settingsLanguageNl)),
                ButtonSegment(value: 'en', label: Text(l.settingsLanguageEn)),
              ],
              selected: {locale.languageCode},
              onSelectionChanged: (selection) {
                final next = kSupportedLocales.firstWhere(
                  (loc) => loc.languageCode == selection.first,
                );
                ref.read(localeProvider.notifier).state = next;
                ref
                    .read(sharedPreferencesProvider)
                    .setString(PrefsKeys.appLocale, next.languageCode);
              },
            ),
            const SizedBox(height: AppSpacing.settingsSection),
            Text(l.settingsBusinessSection, style: sectionTitle),
            const SizedBox(height: AppSpacing.group),
            AsyncBody(
              value: ref.watch(businessProfileProvider),
              builder: (profile) =>
                  _ProfileEditor(key: ValueKey(profile), profile: profile),
            ),
            const SizedBox(height: AppSpacing.settingsSection),
            Text(l.settingsDatabaseSection, style: sectionTitle),
            const SizedBox(height: AppSpacing.field),
            Text(
              l.settingsDatabaseLocation(dbPath ?? ''),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.heading),
            OutlinedButton.icon(
              onPressed: _moveDb,
              icon: const Icon(Icons.drive_file_move_outlined),
              label: Text(l.settingsMoveDatabase),
            ),
            const SizedBox(height: AppSpacing.settingsSection),
            LabelWithHelp(
              l.settingsReceiptsSection,
              help: l.settingsReceiptsSectionHelp,
              style: sectionTitle,
            ),
            const SizedBox(height: AppSpacing.field),
            const _ReceiptsSettings(),
            const SizedBox(height: AppSpacing.settingsSection),
            Text(l.settingsExportSection, style: sectionTitle),
            const SizedBox(height: AppSpacing.heading),
            Text(l.settingsExportDescription(year)),
            const SizedBox(height: AppSpacing.field),
            OutlinedButton.icon(
              onPressed: _exportRunning || !figuresReady ? null : _exportCsv,
              icon: const Icon(Icons.download_outlined),
              label: Text(
                _exportRunning
                    ? l.settingsExportRunning
                    : l.settingsExportButton(year),
              ),
            ),
            const SizedBox(height: AppSpacing.settingsSection),
            Text(l.settingsTaxSection(year), style: sectionTitle),
            const SizedBox(height: AppSpacing.heading),
            _RulesSummary(rules),
          ],
        ),
      ),
    );
  }
}

/// The receipts folder: what it holds, a check of every file, and the trash.
class _ReceiptsSettings extends ConsumerStatefulWidget {
  const _ReceiptsSettings();

  @override
  ConsumerState<_ReceiptsSettings> createState() => _ReceiptsSettingsState();
}

class _ReceiptsSettingsState extends ConsumerState<_ReceiptsSettings> {
  bool _checking = false;

  /// The outcome of the last check, shown under the buttons.
  String? _result;
  bool _resultIsProblem = false;

  Future<void> _check() async {
    final l = AppLocalizations.of(context)!;
    setState(() => _checking = true);
    try {
      final service = ref.read(receiptServiceProvider);
      final problems = await service.problems();
      final count = (await service.dao.all()).length;
      if (!mounted) return;
      setState(() {
        _resultIsProblem = problems.isNotEmpty;
        _result = problems.isEmpty
            ? l.settingsReceiptsAllOk(count)
            : [
                l.settingsReceiptsProblems(problems.length),
                for (final (r, health) in problems)
                  '${r.originalName}: ${health == ReceiptHealth.missing ? l.settingsReceiptMissing : l.settingsReceiptChanged}',
              ].join('\n');
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _result = describeError(e, l);
          _resultIsProblem = true;
        });
      }
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  Future<void> _showFolder() async {
    final l = AppLocalizations.of(context)!;
    final folder = Directory(ref.read(receiptServiceProvider).store.folder);
    await guardSave(context, () async {
      await folder.create(recursive: true);
      if (!await launchUrl(Uri.directory(folder.path))) {
        throw FileSystemException(l.settingsReceiptsOpenFailed, folder.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final store = ref.watch(receiptServiceProvider).store;
    final receipts = ref.watch(allReceiptsProvider).valueOrNull ?? const [];
    final removed =
        (ref.watch(removedReceiptsProvider).valueOrNull ?? const []).length;
    final size = receipts.fold(0, (s, r) => s + r.sizeBytes);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.settingsReceiptsLocation(store.folder),
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.tight),
        Text(
          l.settingsReceiptsCount(receipts.length, AppFormat.fileSize(size)),
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.heading),
        Wrap(
          spacing: AppSpacing.field,
          runSpacing: AppSpacing.heading,
          children: [
            OutlinedButton.icon(
              onPressed: _showFolder,
              icon: const Icon(Icons.open_in_new, size: 16),
              label: Text(l.settingsReceiptsShowFolder),
            ),
            OutlinedButton.icon(
              onPressed: _checking ? null : _check,
              icon: const Icon(Icons.fact_check_outlined, size: 16),
              label: Text(
                _checking
                    ? l.settingsReceiptsChecking
                    : l.settingsReceiptsCheck,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => context.push('/settings/removed-receipts'),
              icon: const Icon(Icons.inventory_2_outlined, size: 16),
              label: Text(l.settingsRemovedReceipts(removed)),
            ),
          ],
        ),
        if (_result != null) ...[
          const SizedBox(height: AppSpacing.heading),
          Text(
            _result!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: _resultIsProblem
                  ? theme.colorScheme.error
                  : context.colors.income,
            ),
          ),
        ],
      ],
    );
  }
}

class _ProfileEditor extends ConsumerStatefulWidget {
  final BusinessProfile? profile;

  const _ProfileEditor({super.key, required this.profile});

  @override
  ConsumerState<_ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends ConsumerState<_ProfileEditor> {
  final _formKey = GlobalKey<FormState>();
  late final _fields = BusinessProfileFields(widget.profile);

  @override
  void dispose() {
    _fields.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    await guardSave(
      context,
      () => ref.read(businessProfileDaoProvider).save(_fields.toCompanion()),
    );
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BusinessProfileForm(
          fields: _fields,
          rules: ref.watch(taxRulesProvider(ref.watch(fiscalYearProvider))),
        ),
        const SizedBox(height: AppSpacing.group),
        PrimaryButton(
          label: AppLocalizations.of(context)!.actionSave,
          onPressed: _save,
        ),
      ],
    ),
  );
}

/// The verified statutory figures in use, read-only.
class _RulesSummary extends StatelessWidget {
  final TaxYearRules rules;

  const _RulesSummary(this.rules);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.settingsTaxVerified),
        const SizedBox(height: AppSpacing.field),
        for (var i = 0; i < rules.box1Brackets.length; i++)
          ValueRow(
            label: l.plTaxBracket(
              i + 1,
              AppFormat.percent(rules.box1Brackets[i].rate),
            ),
            value: rules.box1Brackets[i].upTo == null
                ? ''
                : l.settingsTaxUpTo(
                    AppFormat.cents(rules.box1Brackets[i].upTo!),
                  ),
          ),
        ValueRow(
          label: l.settingsTaxZelfs,
          value: AppFormat.cents(rules.zelfstandigenaftrek),
        ),
        ValueRow(
          label: l.settingsTaxStarters,
          value: AppFormat.cents(rules.startersaftrek),
        ),
        ValueRow(
          label: l.settingsTaxMkb,
          value: AppFormat.percent(rules.mkbWinstvrijstelling),
        ),
        ValueRow(
          label: l.settingsTaxUrencriterium,
          value: '${rules.urencriterium}',
        ),
        ValueRow(
          label: l.settingsTaxZvwRate,
          value: AppFormat.percent(rules.zvwRate),
        ),
        ValueRow(
          label: l.settingsTaxMileage,
          value: AppFormat.cents(rules.mileageCentsPerKm),
        ),
        ValueRow(
          label: l.settingsTaxKor,
          value: AppFormat.cents(rules.korThreshold),
        ),
      ],
    );
  }
}
