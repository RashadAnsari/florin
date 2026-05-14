import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/db_location_service.dart';
import '../../constants/prefs_keys.dart';
import '../../services/vat_service.dart';

class FirstLaunchScreen extends ConsumerStatefulWidget {
  const FirstLaunchScreen({super.key});

  @override
  ConsumerState<FirstLaunchScreen> createState() => _FirstLaunchScreenState();
}

class _FirstLaunchScreenState extends ConsumerState<FirstLaunchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _vat = TextEditingController();
  final _kvk = TextEditingController();
  final _address = TextEditingController();
  final _iban = TextEditingController();
  bool _isStarter = false;
  String? _customPath;
  bool _saving = false;
  String? _saveError;

  @override
  void dispose() {
    _name.dispose();
    _vat.dispose();
    _kvk.dispose();
    _address.dispose();
    _iban.dispose();
    super.dispose();
  }

  Future<void> _pickFolder() async {
    final l = AppLocalizations.of(context)!;
    final service = DbLocationService(ref.read(sharedPreferencesProvider));
    final path = await service.pickAndSetLocation(
      dialogTitle: l.dbLocationChooseFolderDialog,
    );
    if (path != null) setState(() => _customPath = path);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _saveError = null;
    });
    try {
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString(PrefsKeys.businessName, _name.text.trim());
      await prefs.setString(PrefsKeys.businessVatNumber, _vat.text.trim());
      await prefs.setString(PrefsKeys.businessKvk, _kvk.text.trim());
      await prefs.setString(PrefsKeys.businessAddress, _address.text.trim());
      await prefs.setString(PrefsKeys.businessIban, _iban.text.trim());
      await prefs.setBool(PrefsKeys.isStarter, _isStarter);

      final service = DbLocationService(prefs);
      final path = _customPath ?? await service.ensurePath();

      final db = AppDatabase.connect(path);
      await db.seedIfEmpty();
      await db.close();

      await ref.read(dbPathNotifierProvider).setPath(path);
    } catch (e) {
      if (mounted) {
        setState(() {
          _saveError = AppLocalizations.of(context)!.firstLaunchSaveError('$e');
        });
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 520,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.firstLaunchWelcome,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l.firstLaunchSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),

                    Text(
                      l.firstLaunchDbSection,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l.firstLaunchDbDescription,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.colorScheme.outline,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _customPath ?? l.firstLaunchDbDefault,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: _customPath != null
                                    ? theme.colorScheme.onSurface
                                    : theme.colorScheme.onSurfaceVariant,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton.icon(
                          onPressed: _pickFolder,
                          icon: const Icon(Icons.folder_open_outlined),
                          label: Text(l.firstLaunchChooseFolder),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Text(
                      l.settingsBusinessSection,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                        labelText: '${l.settingsBusinessName} *',
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l.settingsValidateName
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _vat,
                            decoration: InputDecoration(
                              labelText: '${l.settingsVatNumber} *',
                            ),
                            validator: (s) {
                              final v = s?.trim() ?? '';
                              if (v.isEmpty) return l.settingsValidateVat;
                              if (!isValidDutchVatNumber(v)) {
                                return l.settingsValidateVatFormat;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _kvk,
                            decoration: InputDecoration(
                              labelText: '${l.settingsKvkNumber} *',
                            ),
                            validator: (s) {
                              final v = s?.trim() ?? '';
                              if (v.isEmpty) return l.settingsValidateKvk;
                              if (!isValidKvkNumber(v)) {
                                return l.settingsValidateKvkFormat;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _address,
                      decoration: InputDecoration(
                        labelText: '${l.settingsBusinessAddress} *',
                      ),
                      maxLines: 4,
                      minLines: 3,
                      validator: (s) => (s == null || s.trim().isEmpty)
                          ? l.settingsValidateAddress
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _iban,
                      decoration: InputDecoration(
                        labelText: '${l.settingsIban} *',
                      ),
                      validator: (s) {
                        final v = s?.trim() ?? '';
                        if (v.isEmpty) return l.settingsValidateIban;
                        if (!isValidIban(v)) {
                          return l.settingsValidateIbanFormat;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      value: _isStarter,
                      onChanged: (v) => setState(() => _isStarter = v ?? false),
                      title: Text(l.settingsStartersaftrek),
                      subtitle: Text(l.firstLaunchStartersSubtitle),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (_saveError != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _saveError!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: theme.colorScheme.primaryContainer,
                          foregroundColor: theme.colorScheme.onPrimaryContainer,
                        ),
                        onPressed: _saving ? null : _save,
                        icon: _saving
                            ? SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              )
                            : const Icon(Icons.arrow_forward),
                        label: Text(l.firstLaunchGetStarted),
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
