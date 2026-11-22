import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../widgets/help.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/pension_service.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/amount_field.dart';
import '../../widgets/async_body.dart';
import '../../widgets/feedback.dart';
import '../../widgets/form_row.dart';
import '../../widgets/value_row.dart';

class PensionScreen extends ConsumerWidget {
  const PensionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final rules = ref.watch(taxRulesProvider(year));
    final estimate = ref.watch(taxEstimateProvider(year)).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: Text(l.pensionTitle)),
      body: AsyncBody(
        value: ref.watch(pensionProvider(year)),
        builder: (entry) {
          final room = PensionService.calculate(rules, entry);
          final deductible = PensionService.deductiblePremium(rules, entry);
          final income = estimate?.result.taxableIncome;
          final saving = income == null
              ? 0
              : rules.box1Tax(income + deductible) - rules.box1Tax(income);

          Future<void> save(PensionEntriesCompanion change) => guardSave(
            context,
            () => ref
                .read(pensionDaoProvider)
                .save(change.copyWith(year: Value(year))),
          );

          return SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionLabel(l.pensionInputSection),
                const SizedBox(height: AppSpacing.heading),
                FormRow(
                  children: [
                    AmountField(
                      key: ValueKey('income_$year'),
                      label: l.pensionPriorYearIncome(year - 1),
                      help: l.pensionPriorYearIncomeHelp,
                      initialValueCents: entry?.priorYearIncome ?? 0,
                      onChanged: (v) => save(
                        PensionEntriesCompanion(priorYearIncome: Value(v)),
                      ),
                    ),
                    AmountField(
                      label: l.pensionFactorA,
                      help: l.pensionFactorAHelp,
                      key: ValueKey('factor_a_$year'),
                      initialValueCents: entry?.factorA ?? 0,
                      onChanged: (v) =>
                          save(PensionEntriesCompanion(factorA: Value(v))),
                    ),
                    AmountField(
                      label: l.pensionReserveringsruimteLabel,
                      help: l.pensionReserveringsruimteLabelHelp,
                      key: ValueKey('reservering_$year'),
                      initialValueCents: entry?.reserveringsruimte ?? 0,
                      onChanged: (v) => save(
                        PensionEntriesCompanion(reserveringsruimte: Value(v)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.section),
                SectionLabel(l.pensionJaarruimte),
                ValueRow.cents(
                  l.pensionPriorYearIncome(year - 1),
                  entry?.priorYearIncome ?? 0,
                ),
                ValueRow.cents(
                  l.pensionAowFranchise,
                  -rules.aowFranchise,
                  help: l.pensionAowFranchiseHelp,
                ),
                ValueRow.cents(
                  l.pensionPensioengrondslag,
                  room.premiegrondslag,
                  bold: true,
                  help: l.pensionPensioengrondslagHelp,
                ),
                ValueRow.cents(
                  l.pensionJaarruimteMax(AppFormat.cents(rules.jaarruimteMax)),
                  room.jaarruimte,
                  help: l.pensionJaarruimteHelp,
                ),
                ValueRow.cents(
                  l.pensionReserveringsruimte,
                  room.reserveringsruimte,
                  help: l.pensionReserveringsruimteLabelHelp,
                ),
                ValueRow.cents(
                  l.pensionTotalBudget,
                  room.totalRoom,
                  bold: true,
                  color: context.colors.income,
                ),
                const SizedBox(height: AppSpacing.section),
                SectionLabel(l.pensionPlannedSection),
                const SizedBox(height: AppSpacing.heading),
                AmountField(
                  label: l.pensionLijfrente,
                  help: l.pensionLijfrenteHelp,
                  key: ValueKey('lijfrente_$year'),
                  initialValueCents: entry?.plannedContribution ?? 0,
                  onChanged: (v) => save(
                    PensionEntriesCompanion(plannedContribution: Value(v)),
                  ),
                ),
                const SizedBox(height: AppSpacing.field),
                ValueRow.cents(l.pensionDeductible, deductible),
                ValueRow.cents(
                  l.pensionEstimatedTaxSaving,
                  saving,
                  help: l.pensionEstimatedTaxSavingHelp,
                  color: context.colors.income,
                ),
                const SizedBox(height: AppSpacing.section),
                SectionLabel(l.pensionAovSection),
                const SizedBox(height: AppSpacing.heading),
                HelpCheckbox(
                  value: entry?.aovInsured ?? false,
                  onChanged: (v) =>
                      save(PensionEntriesCompanion(aovInsured: Value(v))),
                  title: l.pensionAovInsured,
                  help: l.pensionAovInsuredHelp,
                  subtitle: l.pensionAovHelper,
                ),
                if (entry?.aovInsured ?? false) ...[
                  const SizedBox(height: AppSpacing.field),
                  AmountField(
                    label: l.pensionMonthlyPremium,
                    help: l.pensionMonthlyPremiumHelp,
                    key: ValueKey('aov_$year'),
                    initialValueCents: entry!.monthlyAovPremium,
                    helperText: l.pensionAnnualPremium(
                      AppFormat.cents(entry.monthlyAovPremium * 12),
                    ),
                    onChanged: (v) => save(
                      PensionEntriesCompanion(monthlyAovPremium: Value(v)),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
