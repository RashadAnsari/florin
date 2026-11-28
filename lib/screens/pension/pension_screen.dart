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
import '../../widgets/notice_banner.dart';
import '../../widgets/value_row.dart';

class PensionScreen extends ConsumerWidget {
  const PensionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final rules = ref.watch(taxRulesProvider(year));
    final estimate = ref.watch(taxEstimateProvider(year)).valueOrNull;
    final employed =
        ref.watch(taxYearInputsProvider(year)).valueOrNull?.employed ?? false;

    return Scaffold(
      appBar: AppBar(title: Text(l.pensionTitle)),
      body: AsyncBody(
        value: ref.watch(pensionProvider(year)),
        builder: (entry) {
          final room = PensionService.calculate(rules, entry);
          final deductible = PensionService.deductiblePremium(rules, entry);
          final aovMonths = PensionService.aovMonthsPaid(year, DateTime.now());
          // Pension built up with an employer lowers the room (art. 3.127
          // lid 4); without either figure Florin cannot subtract it.
          final buildUpMissing =
              employed &&
              (entry?.factorA ?? 0) == 0 &&
              (entry?.pensionPremiumsPriorYear ?? 0) == 0;
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
                if (buildUpMissing) ...[
                  NoticeBanner(
                    l.pensionBuildUpMissingNotice,
                    tone: NoticeTone.warning,
                  ),
                  const SizedBox(height: AppSpacing.group),
                ],
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
                      label: l.pensionPremiumsPriorYear,
                      help: l.pensionPremiumsPriorYearHelp,
                      key: ValueKey('wtp_premiums_$year'),
                      initialValueCents: entry?.pensionPremiumsPriorYear ?? 0,
                      onChanged: (v) => save(
                        PensionEntriesCompanion(
                          pensionPremiumsPriorYear: Value(v == 0 ? null : v),
                        ),
                      ),
                    ),
                    AmountField(
                      label: l.pensionReserveringsruimteLabel,
                      help: l.pensionReserveringsruimteLabelHelp(
                        AppFormat.euros(rules.reserveringsruimteMax),
                      ),
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
                  PensionService.countedIncome(rules, entry),
                  help: l.pensionCountedIncomeHelp(
                    AppFormat.euros(rules.premiegrondslagMaxIncome),
                  ),
                ),
                ValueRow.cents(
                  l.pensionAowFranchise,
                  -rules.aowFranchise,
                  help: l.pensionAowFranchiseHelp,
                ),
                ValueRow.cents(
                  l.pensionPremiegrondslag,
                  room.premiegrondslag,
                  bold: true,
                  help: l.pensionPremiegrondslagHelp(
                    AppFormat.euros(rules.premiegrondslagMaxIncome),
                  ),
                ),
                ValueRow.cents(
                  l.pensionJaarruimteMax(AppFormat.cents(rules.jaarruimteMax)),
                  room.jaarruimte,
                  help: l.pensionJaarruimteHelp(
                    AppFormat.percentLabel(rules.jaarruimtePct),
                  ),
                ),
                ValueRow.cents(
                  l.pensionReserveringsruimte,
                  room.reserveringsruimte,
                  help: l.pensionReserveringsruimteLabelHelp(
                    AppFormat.euros(rules.reserveringsruimteMax),
                  ),
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
                ValueRow.cents(
                  l.pensionDeductible,
                  deductible,
                  help: l.pensionDeductibleHelp,
                ),
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
                      AppFormat.cents(
                        PensionService.aovPremiumPaid(entry, aovMonths),
                      ),
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
