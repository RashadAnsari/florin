import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/providers.dart';
import '../theme/app_theme.dart';

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
  final String label;
  final IconData icon;
  final String route;
  const _NavItem(this.label, this.icon, this.route);
}

const _mainItems = [
  _NavItem('Dashboard', Icons.dashboard_outlined, '/dashboard'),
  _NavItem('Invoices', Icons.receipt_long_outlined, '/invoices'),
  _NavItem('Clients', Icons.people_outlined, '/clients'),
  _NavItem('Expenses', Icons.payment_outlined, '/expenses'),
  _NavItem('VAT Return', Icons.account_balance_outlined, '/vat'),
  _NavItem('P&L & Tax', Icons.bar_chart_outlined, '/tax'),
  _NavItem('Hours', Icons.timer_outlined, '/hours'),
  _NavItem('Mileage', Icons.directions_car_outlined, '/mileage'),
  _NavItem('Assets', Icons.computer_outlined, '/assets'),
  _NavItem('Pension', Icons.savings_outlined, '/pension'),
];

class _NavPanel extends ConsumerWidget {
  final String currentPath;
  const _NavPanel({required this.currentPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primary = Theme.of(context).colorScheme.primary;
    final year = ref.watch(fiscalYearProvider);

    return Container(
      width: 220,
      color: primary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Florin', style: AppTheme.wordmark),
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 4),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: _mainItems
                  .map(
                    (item) => _NavTile(
                      item: item,
                      isSelected: currentPath.startsWith(item.route),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: Colors.white70,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Year:',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(width: 4),
                DropdownButton<int>(
                  value: year,
                  dropdownColor: primary,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  underline: const SizedBox(),
                  items: List.generate(5, (i) => DateTime.now().year - 1 + i)
                      .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                      .toList(),
                  onChanged: (y) async {
                    if (y == null) return;
                    ref.read(fiscalYearProvider.notifier).state = y;
                    await ref
                        .read(sharedPreferencesProvider)
                        .setInt('fiscal_year', y);
                  },
                ),
              ],
            ),
          ),
          _NavTile(
            item: const _NavItem(
              'Settings',
              Icons.settings_outlined,
              '/settings',
            ),
            isSelected: currentPath.startsWith('/settings'),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  const _NavTile({required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => context.go(item.route),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 20,
                color: isSelected ? Colors.white : Colors.white70,
              ),
              const SizedBox(width: 12),
              Text(
                item.label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
