import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/db_location_service.dart';

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
  String? _customPath; // only set if user explicitly picks a folder
  bool _saving = false;

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
    final service = DbLocationService(ref.read(sharedPreferencesProvider));
    final path = await service.pickAndSetLocation();
    if (path != null) setState(() => _customPath = path);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString('business_name', _name.text.trim());
      await prefs.setString('business_vat_number', _vat.text.trim());
      await prefs.setString('business_kvk', _kvk.text.trim());
      await prefs.setString('business_address', _address.text.trim());
      await prefs.setString('business_iban', _iban.text.trim());
      await prefs.setBool('is_starter', _isStarter);

      // Use custom path if chosen, else the default already set by ensurePath()
      final service = DbLocationService(prefs);
      final path = _customPath ?? await service.ensurePath();

      final db = AppDatabase.connect(path);
      await db.seedIfEmpty();
      await db.close();

      await ref.read(dbPathNotifierProvider).setPath(path);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      'Welcome to Florin',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Set up your bookkeeping workspace.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Database location
                    Text(
                      'Database location (optioneel)',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Standaard: Application Support. Kies een andere map voor iCloud / Google Drive sync.',
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
                              _customPath ?? 'Application Support (standaard)',
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
                          label: const Text('Choose folder'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Business identity
                    Text(
                      'Business identity',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'Business name *',
                      ),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _vat,
                            decoration: const InputDecoration(
                              labelText: 'VAT number (BTW-ID)',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _kvk,
                            decoration: const InputDecoration(
                              labelText: 'KVK number',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _address,
                      decoration: const InputDecoration(
                        labelText: 'Business address',
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _iban,
                      decoration: const InputDecoration(labelText: 'IBAN'),
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      value: _isStarter,
                      onChanged: (v) => setState(() => _isStarter = v ?? false),
                      title: const Text('Eligible for startersaftrek'),
                      subtitle: const Text(
                        'First 3 years of business — €2,123 additional deduction',
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _saving ? null : _save,
                        child: _saving
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Get started'),
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
