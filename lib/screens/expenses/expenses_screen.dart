import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/amount_field.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/vat_rate_selector.dart';

// Internal category IDs (stored in DB — do NOT change these values).
const kExpenseCategoryIds = [
  'office',
  'travel',
  'meals',
  'software',
  'hardware',
  'marketing',
  'professional',
  'phone',
  'insurance',
  'training',
  'other',
];

// Legacy Dutch strings stored in existing databases.
const kExpenseCategoriesLegacy = [
  'Kantoor & benodigdheden',
  'Reizen & verblijf',
  'Maaltijden & entertainment',
  'Software & abonnementen',
  'Hardware & apparatuur',
  'Marketing & reclame',
  'Professionele diensten',
  'Telefoon & internet',
  'Verzekering',
  'Training & opleiding',
  'Overig',
];

// Keep kExpenseCategories as alias for compatibility.
const kExpenseCategories = kExpenseCategoriesLegacy;

/// Returns a map from stored category value → localized display label.
Map<String, String> expenseCategoryLabels(AppLocalizations l) => {
  kExpenseCategoriesLegacy[0]: l.expenseCatOffice,
  kExpenseCategoriesLegacy[1]: l.expenseCatTravel,
  kExpenseCategoriesLegacy[2]: l.expenseCatMeals,
  kExpenseCategoriesLegacy[3]: l.expenseCatSoftware,
  kExpenseCategoriesLegacy[4]: l.expenseCatHardware,
  kExpenseCategoriesLegacy[5]: l.expenseCatMarketing,
  kExpenseCategoriesLegacy[6]: l.expenseCatProfessional,
  kExpenseCategoriesLegacy[7]: l.expenseCatPhone,
  kExpenseCategoriesLegacy[8]: l.expenseCatInsurance,
  kExpenseCategoriesLegacy[9]: l.expenseCatTraining,
  kExpenseCategoriesLegacy[10]: l.expenseCatOther,
};

const _kQuarters = ['Q1', 'Q2', 'Q3', 'Q4'];

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  Expense? _selected;
  bool _isNew = false;
  String? _qFilter;
  String? _catFilter;

  List<Expense> _filter(List<Expense> all) {
    return all.where((e) {
      if (_qFilter != null && e.quarter != _qFilter) return false;
      if (_catFilter != null && e.category != _catFilter) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final year = ref.watch(fiscalYearProvider);
    final expsAsync = ref.watch(expensesStreamProvider(year));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.expensesTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: AppLocalizations.of(context)!.expensesNewTooltip,
            onPressed: () => setState(() {
              _selected = null;
              _isNew = true;
            }),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: 300,
            child: Column(
              children: [
                _Filters(
                  qFilter: _qFilter,
                  catFilter: _catFilter,
                  onQChanged: (q) => setState(() => _qFilter = q),
                  onCatChanged: (c) => setState(() => _catFilter = c),
                ),
                const Divider(height: 1),
                Expanded(
                  child: expsAsync.when(
                    data: (all) {
                      final visible = _filter(all);
                      if (visible.isEmpty) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)!.expensesNone,
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: visible.length,
                        itemBuilder: (_, i) => _ExpenseTile(
                          expense: visible[i],
                          isSelected: _selected?.id == visible[i].id,
                          onTap: () => setState(() {
                            _selected = visible[i];
                            _isNew = false;
                          }),
                        ),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('$e')),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: (_isNew || _selected != null)
                ? _ExpenseForm(
                    key: ValueKey(_isNew ? 'new' : '${_selected!.id}'),
                    expense: _isNew ? null : _selected,
                    fiscalYear: year,
                    onSaved: (e) => setState(() {
                      _selected = e;
                      _isNew = false;
                    }),
                    onDeleted: () => setState(() {
                      _selected = null;
                      _isNew = false;
                    }),
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.expensesSelectOrNew,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  final String? qFilter;
  final String? catFilter;
  final ValueChanged<String?> onQChanged;
  final ValueChanged<String?> onCatChanged;

  const _Filters({
    required this.qFilter,
    required this.catFilter,
    required this.onQChanged,
    required this.onCatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 4,
            children: [
              FilterChip(
                label: Text(AppLocalizations.of(context)!.labelAll),
                selected: qFilter == null,
                onSelected: (_) => onQChanged(null),
              ),
              ..._kQuarters.map(
                (q) => FilterChip(
                  label: Text(q),
                  selected: qFilter == q,
                  onSelected: (_) => onQChanged(qFilter == q ? null : q),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<String?>(
            initialValue: catFilter,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.labelCategory,
              isDense: true,
            ),
            items: [
              const DropdownMenuItem(value: null, child: Text('Alle')),
              ...() {
                final l = AppLocalizations.of(context)!;
                final labels = expenseCategoryLabels(l);
                return kExpenseCategories
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(labels[c] ?? c),
                      ),
                    )
                    .toList();
              }(),
            ],
            onChanged: onCatChanged,
          ),
        ],
      ),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  final Expense expense;
  final bool isSelected;
  final VoidCallback onTap;

  const _ExpenseTile({
    required this.expense,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? theme.colorScheme.secondaryContainer : null,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    expense.supplier,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  AppFormat.cents(expense.totalInclVat),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  AppFormat.date(expense.date),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    expense.category,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (expense.receiptAttached)
                  Icon(
                    Icons.attach_file,
                    size: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseForm extends ConsumerStatefulWidget {
  final Expense? expense;
  final int fiscalYear;
  final void Function(Expense) onSaved;
  final VoidCallback onDeleted;

  const _ExpenseForm({
    super.key,
    required this.expense,
    required this.fiscalYear,
    required this.onSaved,
    required this.onDeleted,
  });

  @override
  ConsumerState<_ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends ConsumerState<_ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _supplier;
  late final TextEditingController _description;
  late final TextEditingController _paidFrom;
  late final TextEditingController _paymentRef;
  late final TextEditingController _notes;

  DateTime _date = DateTime.now();
  String _category = kExpenseCategories.first;
  String _vatRate = '21%';
  int _amountExclVat = 0;
  int _vatAmount = 0;
  int _totalInclVat = 0;
  double _businessUsePct = 1.0;
  int _deductibleAmount = 0;
  bool _vatReclaimable = true;
  int _vatToReclaim = 0;
  bool _isMixedCost = false;
  bool _receiptAttached = false;

  @override
  void initState() {
    super.initState();
    final e = widget.expense;
    _supplier = TextEditingController(text: e?.supplier ?? '');
    _description = TextEditingController(text: e?.description ?? '');
    _paidFrom = TextEditingController(text: e?.paidFrom ?? '');
    _paymentRef = TextEditingController(text: e?.paymentReference ?? '');
    _notes = TextEditingController(text: e?.notes ?? '');
    if (e != null) {
      _date = e.date;
      _category = e.category;
      _vatRate = e.vatRate;
      _amountExclVat = e.amountExclVat;
      _vatAmount = e.vatAmount;
      _totalInclVat = e.totalInclVat;
      _businessUsePct = e.businessUsePct;
      _deductibleAmount = e.deductibleAmount;
      _vatReclaimable = e.vatReclaimable;
      _vatToReclaim = e.vatToReclaim;
      _isMixedCost = e.isMixedCost;
      _receiptAttached = e.receiptAttached;
    }
  }

  @override
  void dispose() {
    _supplier.dispose();
    _description.dispose();
    _paidFrom.dispose();
    _paymentRef.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _compute() {
    final rate = parseVatRate(_vatRate);
    final vat = (_amountExclVat * rate).round();
    final total = _amountExclVat + vat;
    final deductible = (_amountExclVat * _businessUsePct).round();
    final vatReclaim = _vatReclaimable ? (vat * _businessUsePct).round() : 0;
    setState(() {
      _vatAmount = vat;
      _totalInclVat = total;
      _deductibleAmount = deductible;
      _vatToReclaim = vatReclaim;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final dao = ref.read(expenseDaoProvider);
    final orig = widget.expense;
    String? n(String s) => s.trim().isEmpty ? null : s.trim();
    final companion = ExpensesCompanion(
      id: orig != null ? Value(orig.id) : const Value.absent(),
      date: Value(_date),
      supplier: Value(_supplier.text.trim()),
      description: Value(_description.text.trim()),
      category: Value(_category),
      receiptAttached: Value(_receiptAttached),
      amountExclVat: Value(_amountExclVat),
      vatRate: Value(_vatRate),
      vatAmount: Value(_vatAmount),
      totalInclVat: Value(_totalInclVat),
      businessUsePct: Value(_businessUsePct),
      deductibleAmount: Value(_deductibleAmount),
      vatReclaimable: Value(_vatReclaimable),
      vatToReclaim: Value(_vatToReclaim),
      isMixedCost: Value(_isMixedCost),
      notes: Value(n(_notes.text)),
      paidFrom: Value(n(_paidFrom.text)),
      paymentReference: Value(n(_paymentRef.text)),
      fiscalYear: Value(widget.fiscalYear),
      quarter: Value(AppFormat.quarter(_date)),
    );
    if (orig == null) {
      final id = await dao.insertExpense(companion);
      final all = await dao.getByYear(widget.fiscalYear);
      final created = all.firstWhere((e) => e.id == id);
      if (mounted) {
        widget.onSaved(created);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.expensesCreated),
          ),
        );
      }
    } else {
      await dao.saveExpense(companion);
      final all = await dao.getByYear(widget.fiscalYear);
      final updated = all.firstWhere((e) => e.id == orig.id);
      if (mounted) {
        widget.onSaved(updated);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.expensesSaved)),
        );
      }
    }
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.expensesDeleteTitle,
      message: l.expensesDeleteMessage,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref.read(expenseDaoProvider).deleteExpense(widget.expense!.id);
    if (mounted) widget.onDeleted();
  }

  bool get _showBuaWarning =>
      _category == 'Maaltijden & entertainment' && _amountExclVat > 22700;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNew = widget.expense == null;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  isNew
                      ? AppLocalizations.of(context)!.expensesNewHeader
                      : _supplier.text,
                  style: theme.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isNew)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: AppLocalizations.of(context)!.actionDelete,
                  onPressed: _delete,
                ),
              FilledButton(
                onPressed: _save,
                child: Text(AppLocalizations.of(context)!.actionSave),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_showBuaWarning) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.expense.withValues(alpha: 0.08),
                          border: Border.all(color: AppColors.expense),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: AppColors.expense,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                )!.expensesBuaWarning,
                                style: const TextStyle(
                                  color: AppColors.expense,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: _date,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2040),
                              );
                              if (d != null) setState(() => _date = d);
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                )!.labelDate,
                              ),
                              child: Text(AppFormat.date(_date)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            initialValue: _category,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.labelCategory,
                            ),
                            items: kExpenseCategories.map((c) {
                              final l = AppLocalizations.of(context)!;
                              final labels = expenseCategoryLabels(l);
                              return DropdownMenuItem(
                                value: c,
                                child: Text(labels[c] ?? c),
                              );
                            }).toList(),
                            onChanged: (v) => setState(() => _category = v!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _supplier,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.expensesFieldSupplier,
                            ),
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? AppLocalizations.of(context)!.labelRequired
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _description,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.expensesFieldDescription,
                            ),
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? AppLocalizations.of(context)!.labelRequired
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AmountField(
                            initialValueCents: _amountExclVat,
                            label: AppLocalizations.of(
                              context,
                            )!.expensesFieldAmountExcl,
                            required: true,
                            onChanged: (v) {
                              _amountExclVat = v;
                              _compute();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: VatRateSelector(
                            value: _vatRate,
                            onChanged: (v) {
                              if (v != null) {
                                _vatRate = v;
                                _compute();
                              }
                            },
                            label: AppLocalizations.of(
                              context,
                            )!.expensesFieldVatRate,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AmountField(
                            initialValueCents: _vatAmount,
                            label: AppLocalizations.of(
                              context,
                            )!.expensesFieldVat,
                            readOnly: true,
                            onChanged: (_) {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AmountField(
                            initialValueCents: _totalInclVat,
                            label: AppLocalizations.of(
                              context,
                            )!.expensesFieldTotalIncl,
                            readOnly: true,
                            onChanged: (_) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.expensesBusinessUse,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.expensesBusinessUsePct(
                                  (_businessUsePct * 100).round(),
                                ),
                                style: theme.textTheme.bodySmall,
                              ),
                              Slider(
                                value: _businessUsePct,
                                onChanged: (v) {
                                  _businessUsePct = v;
                                  _compute();
                                },
                                divisions: 20,
                                label: '${(_businessUsePct * 100).round()}%',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.expensesDeductible,
                              style: theme.textTheme.bodySmall,
                            ),
                            Text(
                              AppFormat.cents(_deductibleAmount),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            CheckboxListTile(
                              value: _vatReclaimable,
                              onChanged: (v) {
                                _vatReclaimable = v ?? true;
                                _compute();
                              },
                              title: Text(
                                AppLocalizations.of(
                                  context,
                                )!.expensesReclaimVat,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            Text(
                              AppLocalizations.of(context)!.expensesVatBack(
                                AppFormat.cents(_vatToReclaim),
                              ),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CheckboxListTile(
                          value: _isMixedCost,
                          onChanged: (v) =>
                              setState(() => _isMixedCost = v ?? false),
                          title: Text(
                            AppLocalizations.of(context)!.expensesMixedCosts,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        const SizedBox(width: 24),
                        CheckboxListTile(
                          value: _receiptAttached,
                          onChanged: (v) =>
                              setState(() => _receiptAttached = v ?? false),
                          title: Text(
                            AppLocalizations.of(
                              context,
                            )!.expensesReceiptAttached,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _paidFrom,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.expensesFieldPaidFrom,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _paymentRef,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.expensesFieldPaymentRef,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notes,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.labelNotes,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
