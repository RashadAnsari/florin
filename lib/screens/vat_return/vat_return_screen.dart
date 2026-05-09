import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../services/vat_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/deadline_badge.dart';

class VatReturnScreen extends ConsumerStatefulWidget {
  const VatReturnScreen({super.key});

  @override
  ConsumerState<VatReturnScreen> createState() => _VatReturnScreenState();
}

class _VatReturnScreenState extends ConsumerState<VatReturnScreen> {
  String _quarter = _currentQuarter();
  final _service = const VatService();

  static String _currentQuarter() =>
      'Q${((DateTime.now().month - 1) ~/ 3) + 1}';

  String _prefKey(int year, String field) =>
      'vat_${year}_${_quarter.toLowerCase()}_$field';

  @override
  Widget build(BuildContext context) {
    final year = ref.watch(fiscalYearProvider);
    final invoices = ref.watch(invoicesStreamProvider(year)).valueOrNull ?? [];
    final expenses = ref.watch(expensesStreamProvider(year)).valueOrNull ?? [];
    final paramsAsync = ref.watch(taxParamsStreamProvider(year));
    final prefs = ref.read(sharedPreferencesProvider);

    final params = paramsAsync.valueOrNull;
    final result = params != null
        ? _service.calculateQuarter(
            allYearInvoices: invoices,
            allYearExpenses: expenses,
            fiscalYear: year,
            quarter: _quarter,
            params: params,
          )
        : null;

    final deadline = _service.filingDeadline(year, _quarter);
    final filed = prefs.getBool(_prefKey(year, 'filed')) ?? false;
    final paid = prefs.getBool(_prefKey(year, 'paid')) ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('BTW-aangifte')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ...['Q1', 'Q2', 'Q3', 'Q4'].map(
                    (q) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(q),
                        selected: _quarter == q,
                        onSelected: (_) => setState(() => _quarter = q),
                      ),
                    ),
                  ),
                  const Spacer(),
                  DeadlineBadge(deadline: deadline, filed: filed),
                ],
              ),
              const SizedBox(height: 24),

              if (result == null) ...[
                const Center(child: CircularProgressIndicator()),
              ] else ...[
                if (result.korRisk)
                  _banner(
                    'KOR-drempel bereikt (${AppFormat.cents(result.ytdRevenue)}'
                    ' van ${AppFormat.cents(params!.korThreshold)}) — '
                    'factureer BTW vanaf volgende transactie.',
                    AppColors.red,
                    context,
                  ),

                _sectionTitle('Omzet', context),
                _row(
                  '1a  Leveringen/diensten belast met 21%',
                  AppFormat.cents(result.revenue21),
                ),
                _row(
                  '1b  Leveringen/diensten belast met 9%',
                  AppFormat.cents(result.revenue9),
                ),
                _row(
                  '1c  Leveringen/diensten belast met 0% (export)',
                  AppFormat.cents(result.revenue0),
                ),
                _row(
                  '3a  Leveringen naar EU-ondernemers (ICP/RC)',
                  AppFormat.cents(result.reverseChargeRevenue),
                ),
                const SizedBox(height: 16),

                _sectionTitle('BTW-berekening', context),
                _row(
                  '5a  BTW over omzet',
                  AppFormat.cents(result.outputVatTotal),
                  bold: true,
                ),
                _row(
                  '5b  Voorbelasting (terug te vragen)',
                  AppFormat.cents(result.inputVatReclaimable),
                ),
                const Divider(height: 24),
                _row(
                  result.netVatDue >= 0
                      ? 'Te betalen BTW'
                      : 'Terug te ontvangen BTW',
                  AppFormat.cents(result.netVatDue.abs()),
                  bold: true,
                  color: result.netVatDue >= 0
                      ? AppColors.red
                      : AppColors.income,
                ),
                const SizedBox(height: 24),

                if (result.icpInvoices.isNotEmpty) ...[
                  _sectionTitle('ICP-opgaaf', context),
                  Text(
                    'Deadline gelijk aan BTW-aangifte: ${AppFormat.date(deadline)}.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  ...result.icpInvoices.map(
                    (inv) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            inv.invoiceNumber,
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                          const SizedBox(width: 24),
                          Text(AppFormat.cents(inv.totalExclVat)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                _sectionTitle('Afhandelstatus', context),
                CheckboxListTile(
                  value: filed,
                  onChanged: (v) async {
                    await prefs.setBool(_prefKey(year, 'filed'), v ?? false);
                    setState(() {});
                  },
                  title: const Text('Aangifte ingediend'),
                  contentPadding: EdgeInsets.zero,
                ),
                CheckboxListTile(
                  value: paid,
                  onChanged: (v) async {
                    await prefs.setBool(_prefKey(year, 'paid'), v ?? false);
                    setState(() {});
                  },
                  title: const Text('BTW betaald'),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),
                Text(
                  'YTD omzet: ${AppFormat.cents(result.ytdRevenue)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String t, BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      t,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
    ),
  );

  Widget _row(String label, String value, {bool bold = false, Color? color}) {
    final style = bold
        ? TextStyle(fontWeight: FontWeight.w700, color: color)
        : TextStyle(color: color);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }

  Widget _banner(String msg, Color color, BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.warning_amber, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(msg, style: TextStyle(color: color, fontSize: 13)),
        ),
      ],
    ),
  );
}
