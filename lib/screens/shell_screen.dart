import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../providers/providers.dart';
import '../theme/app_theme.dart';
import '../widgets/help.dart';
import '../constants/prefs_keys.dart';
import '../services/tax_rules/tax_year_rules.dart';

class ShellScreen extends ConsumerWidget {
  final Widget child;

  const ShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = GoRouterState.of(context).uri.path;
    return Scaffold(
      body: Row(
        children: [
          _NavPanel(currentPath: currentPath),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _NavItem {
  final String Function(AppLocalizations l) label;
  final IconData icon;
  final String route;
  const _NavItem(this.label, this.icon, this.route);
}

List<_NavItem> _buildMainItems() => [
  _NavItem((l) => l.navDashboard, Icons.dashboard_outlined, '/dashboard'),
  _NavItem((l) => l.navInvoices, Icons.receipt_long_outlined, '/invoices'),
  _NavItem((l) => l.navClients, Icons.people_outlined, '/clients'),
  _NavItem((l) => l.navExpenses, Icons.payment_outlined, '/expenses'),
  _NavItem((l) => l.navVatReturn, Icons.account_balance_outlined, '/vat'),
  _NavItem((l) => l.navPlTax, Icons.bar_chart_outlined, '/tax'),
  _NavItem((l) => l.navHours, Icons.timer_outlined, '/hours'),
  _NavItem((l) => l.navMileage, Icons.directions_car_outlined, '/mileage'),
  _NavItem((l) => l.navAssets, Icons.computer_outlined, '/assets'),
  _NavItem((l) => l.navPension, Icons.savings_outlined, '/pension'),
];

class _NavPanel extends ConsumerWidget {
  final String currentPath;
  const _NavPanel({required this.currentPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final muted = context.colors.secondaryLabel;
    final dividerColor = context.colors.separator;
    final year = ref.watch(fiscalYearProvider);
    final mainItems = _buildMainItems();

    return Container(
      width: 220,
      color: context.colors.sidebar,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Text(
              l.appTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider(color: dividerColor, height: 1),
          const SizedBox(height: AppSpacing.tight),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: mainItems
                  .map(
                    (item) => _NavTile(
                      label: item.label(l),
                      icon: item.icon,
                      route: item.route,
                      isSelected: currentPath.startsWith(item.route),
                    ),
                  )
                  .toList(),
            ),
          ),
          Divider(color: dividerColor, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 15, color: muted),
                const SizedBox(width: AppSpacing.heading),
                Text(
                  l.navYear,
                  style: theme.textTheme.bodyMedium?.copyWith(color: muted),
                ),
                const SizedBox(width: AppSpacing.tight),
                DropdownButton<int>(
                  value: year,
                  style: theme.textTheme.bodyMedium,
                  underline: const SizedBox(),
                  items: [
                    for (final y in supportedYears)
                      DropdownMenuItem(value: y, child: Text('$y')),
                  ],
                  onChanged: (y) {
                    if (y == null) return;
                    ref.read(fiscalYearProvider.notifier).state = y;
                    ref
                        .read(sharedPreferencesProvider)
                        .setInt(PrefsKeys.fiscalYear, y);
                    final segments = currentPath
                        .split('/')
                        .where((s) => s.isNotEmpty)
                        .toList();
                    if (segments.length > 1) {
                      context.go('/${segments.first}');
                    }
                  },
                ),
              ],
            ),
          ),
          _NavTile(
            label: l.navSettings,
            icon: Icons.settings_outlined,
            route: '/settings',
            isSelected: currentPath.startsWith('/settings'),
          ),
          const SizedBox(height: AppSpacing.field),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;
  final bool isSelected;
  const _NavTile({
    required this.label,
    required this.icon,
    required this.route,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.primary;
    final defaultColor = theme.colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => context.go(route),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: isSelected
              ? BoxDecoration(
                  color: selectedColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? selectedColor
                    : context.colors.secondaryLabel,
              ),
              const SizedBox(width: AppSpacing.field),
              Expanded(
                child: EllipsisText(
                  label,
                  style: TextStyle(
                    color: isSelected ? selectedColor : defaultColor,
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
