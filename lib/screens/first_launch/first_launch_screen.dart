import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import '../../widgets/feedback.dart';
import '../../widgets/help.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/daos/business_profile_dao.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/db_location_service.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/business_profile_form.dart';
import '../../widgets/buttons.dart';

class FirstLaunchScreen extends ConsumerStatefulWidget {
  const FirstLaunchScreen({super.key});

  @override
  ConsumerState<FirstLaunchScreen> createState() => _FirstLaunchScreenState();
}

class _FirstLaunchScreenState extends ConsumerState<FirstLaunchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fields = BusinessProfileFields();
  String? _directory;

  /// The folder used when the user picks none, shown once known.
  String? _defaultDirectory;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    DbLocationService.defaultPath().then(
      (path) {
        if (mounted) setState(() => _defaultDirectory = p.dirname(path));
      },
      // Without the path the screen names the folder in words instead; the
      // database still goes there when the user starts.
      onError: (Object _) {},
    );
  }

  @override
  void dispose() {
    _fields.dispose();
    super.dispose();
  }

  Future<void> _pickFolder() async {
    final l = AppLocalizations.of(context)!;
    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: l.dbLocationChooseFolderDialog,
    );
    if (dir == null) return;
    final existing = DbLocationService.pathIn(dir);
    if (File(existing).existsSync() && mounted) {
      await guardSave(
        context,
        () => ref.read(dbPathNotifierProvider).setPath(existing),
      );
      return;
    }
    setState(() => _directory = dir);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final path = _directory == null
          ? await DbLocationService.defaultPath()
          : DbLocationService.pathIn(_directory!);
      final db = AppDatabase.open(path);
      try {
        await BusinessProfileDao(db).save(_fields.toCompanion());
      } finally {
        await db.close();
      }
      await ref.read(dbPathNotifierProvider).setPath(path);
    } catch (e) {
      if (mounted) {
        setState(
          () => _error = AppLocalizations.of(context)!.firstLaunchSaveError(
            describeError(e, AppLocalizations.of(context)!),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 560,
          child: Card(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.settingsSection),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.firstLaunchWelcome,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.heading),
                    Text(l.firstLaunchSubtitle, style: muted),
                    const SizedBox(height: AppSpacing.dashboardSection),
                    Text(
                      l.firstLaunchDbSection,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.tight),
                    Text(l.firstLaunchDbDescription, style: muted),
                    const SizedBox(height: AppSpacing.heading),
                    Row(
                      children: [
                        Expanded(
                          child: EllipsisText(
                            _directory ??
                                (_defaultDirectory == null
                                    ? l.firstLaunchDbDefaultFolder
                                    : l.firstLaunchDbDefault(
                                        _defaultDirectory!,
                                      )),
                            style: muted,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.heading),
                        OutlinedButton.icon(
                          onPressed: _pickFolder,
                          icon: const Icon(Icons.folder_open_outlined),
                          label: Text(l.firstLaunchChooseFolder),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.section),
                    Text(
                      l.settingsBusinessSection,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.field),
                    BusinessProfileForm(
                      fields: _fields,
                      rules: ref.watch(
                        taxRulesProvider(ref.watch(fiscalYearProvider)),
                      ),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: AppSpacing.field),
                      Text(
                        _error!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.section),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: l.firstLaunchGetStarted,
                        icon: Icons.arrow_forward,
                        onPressed: _saving ? null : _save,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
