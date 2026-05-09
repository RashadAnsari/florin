import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'theme/app_theme.dart';
import 'providers/providers.dart';
import 'screens/first_launch/first_launch_screen.dart';
import 'screens/shell_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/invoices/invoices_screen.dart';
import 'screens/clients/clients_screen.dart';
import 'screens/expenses/expenses_screen.dart';
import 'screens/vat_return/vat_return_screen.dart';
import 'screens/pl_tax/pl_tax_screen.dart';
import 'screens/hours/hours_screen.dart';
import 'screens/mileage/mileage_screen.dart';
import 'screens/assets/assets_screen.dart';
import 'screens/pension/pension_screen.dart';
import 'screens/settings/settings_screen.dart';

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
        final hasDb = notifier.path != null;
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
            ),
            GoRoute(path: '/clients', builder: (c, s) => const ClientsScreen()),
            GoRoute(
              path: '/expenses',
              builder: (c, s) => const ExpensesScreen(),
            ),
            GoRoute(path: '/vat', builder: (c, s) => const VatReturnScreen()),
            GoRoute(path: '/tax', builder: (c, s) => const PlTaxScreen()),
            GoRoute(path: '/hours', builder: (c, s) => const HoursScreen()),
            GoRoute(path: '/mileage', builder: (c, s) => const MileageScreen()),
            GoRoute(path: '/assets', builder: (c, s) => const AssetsScreen()),
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
    return MaterialApp.router(
      title: 'Florin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: _router,
    );
  }
}
