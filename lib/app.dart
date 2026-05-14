import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import 'package:florin/db/database.dart';
import 'theme/app_theme.dart';
import 'providers/providers.dart';
import 'screens/first_launch/first_launch_screen.dart';
import 'screens/shell_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/invoices/invoices_screen.dart';
import 'screens/invoices/invoice_detail_panel.dart';
import 'screens/clients/clients_screen.dart';
import 'screens/expenses/expenses_screen.dart';
import 'screens/vat_return/vat_return_screen.dart';
import 'screens/pl_tax/pl_tax_screen.dart';
import 'screens/hours/hours_screen.dart';
import 'screens/mileage/mileage_screen.dart';
import 'screens/assets/assets_screen.dart';
import 'screens/pension/pension_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'constants/prefs_keys.dart';

/// Supported locales.
const kSupportedLocales = [Locale('nl'), Locale('en')];

/// Active locale provider — persisted in shared_preferences.
final localeProvider = StateProvider<Locale>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  final tag = prefs.getString(PrefsKeys.appLocale);
  if (tag != null) {
    try {
      return kSupportedLocales.firstWhere((l) => l.languageCode == tag);
    } catch (_) {}
  }
  return const Locale('nl'); // default Dutch
});

class FlorinApp extends ConsumerStatefulWidget {
  const FlorinApp({super.key});

  @override
  ConsumerState<FlorinApp> createState() => _FlorinAppState();
}

class _FlorinAppState extends ConsumerState<FlorinApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(dbPathNotifierProvider);
    _router = GoRouter(
      refreshListenable: notifier,
      initialLocation: '/dashboard',
      redirect: (context, state) {
        final path = notifier.path;
        final hasDb = path != null && File(path).existsSync();
        final isSetup = state.matchedLocation == '/setup';
        if (!hasDb && !isSetup) return '/setup';
        if (hasDb && isSetup) return '/dashboard';
        return null;
      },
      routes: [
        GoRoute(path: '/setup', builder: (c, s) => const FirstLaunchScreen()),
        ShellRoute(
          builder: (c, s, child) => ShellScreen(child: child),
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (c, s) => const DashboardScreen(),
            ),
            GoRoute(
              path: '/invoices',
              builder: (c, s) => const InvoicesScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (c, s) => Scaffold(
                    body: InvoiceDetailPanel(
                      onBack: () => c.pop(),
                      onCreated: (id) => c.go('/invoices/$id'),
                    ),
                  ),
                ),
                GoRoute(
                  path: ':id',
                  redirect: (c, s) =>
                      int.tryParse(s.pathParameters['id'] ?? '') == null
                      ? '/invoices'
                      : null,
                  builder: (c, s) => Scaffold(
                    body: InvoiceDetailPanel(
                      invoiceId: int.parse(s.pathParameters['id']!),
                      onBack: () => c.pop(),
                    ),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: '/clients',
              builder: (c, s) => const ClientsScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (c, s) => const ClientDetailPage(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (c, s) =>
                      ClientDetailPage(client: s.extra as Client?),
                ),
              ],
            ),
            GoRoute(
              path: '/expenses',
              builder: (c, s) => const ExpensesScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (c, s) => const ExpenseDetailPage(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (c, s) =>
                      ExpenseDetailPage(expense: s.extra as Expense?),
                ),
              ],
            ),
            GoRoute(path: '/vat', builder: (c, s) => const VatReturnScreen()),
            GoRoute(path: '/tax', builder: (c, s) => const PlTaxScreen()),
            GoRoute(
              path: '/hours',
              builder: (c, s) => const HoursScreen(),
              routes: [
                GoRoute(path: 'new', builder: (c, s) => const HourDetailPage()),
                GoRoute(
                  path: ':id',
                  builder: (c, s) =>
                      HourDetailPage(entry: s.extra as HourEntry?),
                ),
              ],
            ),
            GoRoute(
              path: '/mileage',
              builder: (c, s) => const MileageScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (c, s) => const MileageDetailPage(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (c, s) =>
                      MileageDetailPage(trip: s.extra as MileageTrip?),
                ),
              ],
            ),
            GoRoute(
              path: '/assets',
              builder: (c, s) => const AssetsScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (c, s) => const AssetDetailPage(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (c, s) =>
                      AssetDetailPage(asset: s.extra as FixedAsset?),
                ),
              ],
            ),
            GoRoute(path: '/pension', builder: (c, s) => const PensionScreen()),
            GoRoute(
              path: '/settings',
              builder: (c, s) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    return MaterialApp.router(
      title: 'Florin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      locale: locale,
      supportedLocales: kSupportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _router,
    );
  }
}
