import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../services/formats.dart';
import '../../widgets/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../l10n/labels.dart';
import '../../providers/providers.dart';
import '../../services/asset_service.dart';
import '../../services/domain.dart';
import '../../services/tax_service.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/amount_field.dart';
import '../../widgets/async_body.dart';
import '../../widgets/feedback.dart';
import '../../widgets/form_row.dart';
import '../../widgets/help.dart';
import '../../widgets/notice_banner.dart';
import '../../widgets/value_row.dart';

class PlTaxScreen extends ConsumerWidget {
  const PlTaxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    // The rows below follow the estimate: the KOR applied, as it counts.
    final expenses =
        ref.watch(effectiveExpensesProvider(year)).valueOrNull ?? [];
    final assets = ref.watch(assetsInUseProvider(year)).valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(l.plTaxTitle)),
      body: AsyncBody(
        value: ref.watch(taxEstimateProvider(year)),
        builder: (estimate) {
          final r = estimate.result;
          final rules = estimate.rules;
          final byCategory = <ExpenseCategory, int>{};
          for (final e in expenses) {
            byCategory[e.category] =
                (byCategory[e.category] ?? 0) + e.deductibleAmount;
          }
          final food = TaxService.gemengdeKosten(expenses);
          final courseTravel = TaxService.courseTravel(expenses);
          final barred = TaxService.barredCosts(expenses);
          final mileage = TaxService.mileageAllowance(
            estimate.businessKm,
            rules,
          );
          final depreciation = AssetService.totalDepreciation(
            assets,
            year,
            rules,
          );
          final d = r.investmentDeduction;

          return SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NoticeBanner(l.plTaxEstimateNotice),
                const SizedBox(height: AppSpacing.group),
                if (!estimate.meetsUrencriterium) ...[
                  NoticeBanner(
                    estimate.totalHours >= rules.urencriterium
                        ? l.plTaxUrenJobBanner(
                            AppFormat.hours(estimate.totalHours),
                            estimate.timeTestHours!,
                          )
                        : l.plTaxUrenBanner(
                            AppFormat.hours(estimate.totalHours),
                            AppFormat.number(rules.urencriterium.toDouble()),
                            estimate.yearOver
                                ? l.plTaxUrenBannerSuffixDone
                                : l.plTaxUrenBannerSuffixPending,
                          ),
                    tone: estimate.yearOver
                        ? NoticeTone.error
                        : NoticeTone.warning,
                  ),
                  const SizedBox(height: AppSpacing.group),
                ],
                SectionLabel(l.plTaxRevenuSection),
                ValueRow.cents(l.plTaxGrossRevenue, r.grossRevenue),
                if (r.creditNotes > 0)
                  ValueRow.cents(l.plTaxCreditNotes, -r.creditNotes),
                ValueRow.cents(l.plTaxNetRevenue, r.netRevenue, bold: true),
                const SizedBox(height: AppSpacing.field),
                SectionLabel(l.plTaxCostsSection),
                for (final e in byCategory.entries)
                  if (e.key != ExpenseCategory.foodAndRepresentation &&
                      e.key != ExpenseCategory.courseTravel &&
                      !e.key.barredForIncomeTax)
                    ValueRow.cents(e.key.label(l), -e.value),
                if (food > 0)
                  ValueRow.cents(
                    l.plTaxFoodLimited(
                      ExpenseCategory.foodAndRepresentation.label(l),
                      AppFormat.cents(food),
                    ),
                    -TaxService.gemengdeKostenDeductible(food, rules),
                    help: l.plTaxFoodLimitedHelp(
                      AppFormat.percentLabel(rules.gemengdeKostenPct),
                      AppFormat.cents(rules.gemengdeKostenDrempel),
                    ),
                  ),
                if (courseTravel > 0)
                  ValueRow.cents(
                    l.plTaxFoodLimited(
                      ExpenseCategory.courseTravel.label(l),
                      AppFormat.cents(courseTravel),
                    ),
                    -TaxService.courseTravelDeductible(courseTravel, rules),
                    help: l.plTaxCourseTravelHelp(
                      AppFormat.cents(rules.courseTravelMax),
                    ),
                  ),
                if (barred > 0)
                  ValueRow.cents(
                    l.plTaxBarredCosts(AppFormat.cents(barred)),
                    0,
                    muted: true,
                    help: l.plTaxBarredCostsHelp,
                  ),
                if (mileage > 0)
                  ValueRow.cents(
                    l.plTaxMileageAllowance(
                      estimate.businessKm,
                      AppFormat.cents(rules.mileageCentsPerKm),
                    ),
                    -mileage,
                    help: l.plTaxMileageAllowanceHelp,
                  ),
                if (depreciation > 0)
                  ValueRow.cents(
                    l.plTaxDepreciation,
                    -depreciation,
                    help: l.plTaxDepreciationHelp,
                  ),
                ValueRow.cents(l.plTaxTotalCosts, -r.totalCosts, bold: true),
                if (r.disposalResult != 0)
                  ValueRow.cents(
                    l.plTaxDisposalResult,
                    r.disposalResult,
                    help: l.plTaxDisposalResultHelp,
                  ),
                if (r.desinvesteringsbijtelling > 0)
                  ValueRow.cents(
                    l.plTaxDesinvestering,
                    r.desinvesteringsbijtelling,
                    help: l.plTaxDesinvesteringHelp(rules.desinvesteringYears),
                  ),
                if (r.carPrivateUse > 0)
                  ValueRow.cents(
                    l.plTaxCarPrivateUse,
                    r.carPrivateUse,
                    help: l.plTaxCarPrivateUseHelp(
                      rules.carOldAfterYears,
                      rules.carPrivateKmLimit,
                    ),
                  ),
                if (r.reserveReleased > 0)
                  ValueRow.cents(
                    l.plTaxReserveReleased,
                    r.reserveReleased,
                    help: l.plTaxReserveReleasedHelp(
                      rules.reinvestmentReserveYears,
                    ),
                  ),
                const SizedBox(height: AppSpacing.field),
                ValueRow.cents(l.plTaxGrossProfit, r.grossProfit, bold: true),
                const SizedBox(height: AppSpacing.field),
                SectionLabel(
                  l.plTaxInvestmentSection,
                  help: l.plTaxInvestmentSectionHelp,
                ),
                ValueRow.cents(l.plTaxKia, -d.kia, help: l.plTaxKiaHelp),
                if (d.eia > 0)
                  ValueRow.cents(l.plTaxEia, -d.eia, help: l.plTaxEiaHelp),
                if (d.mia > 0)
                  ValueRow.cents(l.plTaxMia, -d.mia, help: l.plTaxMiaHelp),
                ValueRow.cents(
                  l.plTaxProfit,
                  r.profit,
                  bold: true,
                  help: l.plTaxProfitHelp,
                ),
                const SizedBox(height: AppSpacing.field),
                SectionLabel(
                  l.plTaxDeductionsSection,
                  help: l.plTaxDeductionsSectionHelp(rules.urencriterium),
                ),
                ValueRow.cents(
                  l.plTaxZelfstandigenaftrek(year),
                  -r.zelfstandigenaftrek,
                  muted: r.zelfstandigenaftrek == 0,
                  help: l.plTaxZelfstandigenaftrekHelp,
                ),
                if (r.startersaftrek > 0)
                  ValueRow.cents(
                    l.plTaxStartersaftrek,
                    -r.startersaftrek,
                    help: l.plTaxStartersaftrekHelp,
                  ),
                if (r.unrealisedZelfstandigenaftrek > 0)
                  ValueRow.cents(
                    l.plTaxUnrealisedZelfs,
                    -r.unrealisedZelfstandigenaftrek,
                    help: l.plTaxUnrealisedZelfsHelp,
                  ),
                if (r.soAftrek > 0)
                  ValueRow.cents(
                    l.plTaxSo,
                    -r.soAftrek,
                    help: l.plTaxSoHelp(rules.soMinHours),
                  ),
                if (r.meewerkaftrek > 0)
                  ValueRow.cents(
                    l.plTaxMeewerk,
                    -r.meewerkaftrek,
                    help: l.plTaxMeewerkHelp(
                      rules.meewerkaftrek.first.$1,
                      AppFormat.euros(rules.meewerkMaxPartnerPay),
                    ),
                  ),
                if (r.disabilityStartersaftrek > 0)
                  ValueRow.cents(
                    l.plTaxDisabilityStarters,
                    -r.disabilityStartersaftrek,
                    help: l.plTaxDisabilityStartersHelp(
                      rules.reducedUrencriterium,
                    ),
                  ),
                if (r.stakingsaftrek > 0)
                  ValueRow.cents(
                    l.plTaxStakings,
                    -r.stakingsaftrek,
                    help: l.plTaxStakingsHelp(
                      AppFormat.euros(rules.stakingsaftrekMax),
                    ),
                  ),
                ValueRow.cents(
                  l.plTaxMkb(AppFormat.percent(rules.mkbWinstvrijstelling, 1)),
                  -r.mkbWinstvrijstelling,
                  help: l.plTaxMkbHelp,
                ),
                ValueRow.cents(
                  l.plTaxBelastbareWinst,
                  r.belastbareWinst,
                  bold: true,
                  help: l.plTaxBelastbareWinstHelp,
                ),
                if (r.wages > 0)
                  ValueRow.cents(l.plTaxWages, r.wages, help: l.plTaxWagesHelp),
                if (r.lijfrenteDeduction > 0)
                  ValueRow.cents(
                    l.plTaxLijrente,
                    -r.lijfrenteDeduction,
                    help: l.plTaxLijrenteHelp,
                  ),
                if (r.aovDeduction > 0)
                  ValueRow.cents(
                    l.plTaxAov,
                    -r.aovDeduction,
                    help: l.plTaxAovHelp,
                  ),
                if (r.lossOffset > 0)
                  ValueRow.cents(
                    l.plTaxLossOffset,
                    -r.lossOffset,
                    help: l.plTaxLossOffsetHelp,
                  ),
                ValueRow.cents(
                  l.plTaxTaxableProfit,
                  r.taxableIncome,
                  bold: true,
                  help: l.plTaxTaxableProfitHelp,
                ),
                const SizedBox(height: AppSpacing.field),
                SectionLabel(l.plTaxBox1Section, help: l.plTaxBox1SectionHelp),
                for (var i = 0; i < r.bracketTax.length; i++)
                  if (i == 0 || r.bracketTax[i] > 0)
                    ValueRow.cents(
                      l.plTaxBracket(
                        i + 1,
                        AppFormat.percent(rules.box1Brackets[i].rate),
                      ),
                      r.bracketTax[i],
                    ),
                if (r.tariefaanpassing > 0)
                  ValueRow.cents(
                    l.plTaxTariefaanpassing,
                    r.tariefaanpassing,
                    help: l.plTaxTariefaanpassingHelp,
                  ),
                ValueRow.cents(
                  l.plTaxAlgHeffing,
                  -r.algemeneHeffingskorting,
                  help: l.plTaxAlgHeffingHelp,
                ),
                ValueRow.cents(
                  l.plTaxArbeidskorting,
                  -r.arbeidskorting,
                  help: l.plTaxArbeidskortingHelp,
                ),
                ValueRow.cents(l.plTaxInkomsten, r.box1Tax, bold: true),
                ValueRow.cents(
                  l.plTaxZvw(AppFormat.percent(rules.zvwRate)),
                  r.zvwContribution,
                  help: l.plTaxZvwHelp,
                ),
                const Divider(),
                ValueRow.cents(l.plTaxTotalTax, r.totalTax, bold: true),
                if (r.wageTaxWithheld > 0) ...[
                  ValueRow.cents(
                    l.plTaxWageTaxWithheld,
                    -r.wageTaxWithheld,
                    help: l.plTaxWageTaxWithheldHelp,
                  ),
                  ValueRow.cents(
                    r.taxToPay < 0 ? l.plTaxRefund : l.plTaxToPay,
                    r.taxToPay.abs(),
                    bold: true,
                    help: l.plTaxToPayHelp,
                  ),
                ],
                ValueRow.cents(
                  l.plTaxNetProfit,
                  r.netProfitAfterTax,
                  bold: true,
                  help: l.plTaxNetProfitHelp,
                ),
                const SizedBox(height: AppSpacing.field),
                Text(
                  l.plTaxEffectiveRate(
                    AppFormat.percent(r.effectiveTaxRate / 10000, 1),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.section),
                SectionLabel(
                  l.plTaxProvisionalSection,
                  help: l.plTaxProvisionalSectionHelp,
                ),
                ValueRow.cents(
                  l.plTaxProvisionalProfit,
                  r.belastbareWinst,
                  help: l.plTaxProvisionalProfitHelp,
                ),
                ValueRow.cents(
                  l.plTaxProvisionalIncome,
                  r.incomeBox1,
                  help: l.plTaxProvisionalIncomeHelp,
                ),
                ValueRow.cents(
                  l.plTaxProvisionalTax,
                  r.taxToPay,
                  help: l.plTaxProvisionalTaxHelp,
                ),
                const SizedBox(height: AppSpacing.heading),
                Text(
                  l.plTaxProvisionalDeadline(
                    year,
                    AppFormat.date(rules.provisionalAssessmentDeadline),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.section),
                _YearInputs(year: year),
                const SizedBox(height: AppSpacing.section),
                _BalanceSheetSection(
                  year: year,
                  profit: estimate.comparableProfit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Facts for the year that the bookkeeping cannot show.
class _YearInputs extends ConsumerWidget {
  final int year;

  const _YearInputs({required this.year});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final rules = ref.watch(taxRulesProvider(year));
    return AsyncBody(
      value: ref.watch(taxYearInputsProvider(year)),
      builder: (i) {
        Future<void> save(TaxYearInputsCompanion change) => guardSave(
          context,
          () => ref
              .read(taxYearInputsDaoProvider)
              .save(change.copyWith(year: Value(year))),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionLabel(
              l.plTaxInputsSection(year),
              help: l.plTaxInputsSectionHelp,
            ),
            const SizedBox(height: AppSpacing.heading),
            HelpCheckbox(
              value: i?.notOndernemerBefore ?? false,
              // Turning it off clears the startersaftrek, which needs it: a
              // hidden option may not stay set.
              onChanged: (v) => save(
                v
                    ? const TaxYearInputsCompanion(
                        notOndernemerBefore: Value(true),
                      )
                    : const TaxYearInputsCompanion(
                        notOndernemerBefore: Value(false),
                        isStarter: Value(false),
                      ),
              ),
              title: l.inputNotOndernemerBefore(rules.starterLookbackYears),
              help: l.inputNotOndernemerBeforeHelp,
            ),
            if (i?.notOndernemerBefore ?? false)
              HelpCheckbox(
                value: i?.isStarter ?? false,
                onChanged: (v) =>
                    save(TaxYearInputsCompanion(isStarter: Value(v))),
                title: l.inputStarter(rules.starterMaxZelfstandigenaftrek),
                help: l.inputStarterHelp(AppFormat.euros(rules.startersaftrek)),
              ),
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                _WholeNumberField(
                  key: ValueKey('partner_$year'),
                  label: l.inputPartnerHours,
                  help: l.inputPartnerHoursHelp(
                    AppFormat.euros(rules.meewerkMaxPartnerPay),
                    rules.meewerkaftrek.first.$1,
                  ),
                  value: i?.partnerHours ?? 0,
                  onChanged: (v) =>
                      save(TaxYearInputsCompanion(partnerHours: Value(v))),
                ),
                AmountField(
                  key: ValueKey('partnerPay_$year'),
                  label: l.inputPartnerPay,
                  help: l.inputPartnerPayHelp(
                    AppFormat.euros(rules.meewerkMaxPartnerPay),
                  ),
                  initialValueCents: i?.partnerPay ?? 0,
                  onChanged: (v) =>
                      save(TaxYearInputsCompanion(partnerPay: Value(v))),
                ),
                AmountField(
                  key: ValueKey('unrealised_$year'),
                  label: l.inputUnrealisedZelfs,
                  help: l.inputUnrealisedZelfsHelp(
                    rules.unrealisedZelfstandigenaftrekYears,
                  ),
                  initialValueCents: i?.unrealisedZelfstandigenaftrek ?? 0,
                  onChanged: (v) => save(
                    TaxYearInputsCompanion(
                      unrealisedZelfstandigenaftrek: Value(v),
                    ),
                  ),
                ),
                AmountField(
                  key: ValueKey('losses_$year'),
                  label: l.inputLossCarryForward,
                  help: l.inputLossCarryForwardHelp,
                  initialValueCents: i?.lossCarryForward ?? 0,
                  onChanged: (v) =>
                      save(TaxYearInputsCompanion(lossCarryForward: Value(v))),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            HelpCheckbox(
              value: i?.hasSoVerklaring ?? false,
              onChanged: (v) =>
                  save(TaxYearInputsCompanion(hasSoVerklaring: Value(v))),
              title: l.inputSoVerklaring,
              help: l.inputSoVerklaringHelp(rules.soMinHours),
            ),
            if (i?.hasSoVerklaring ?? false)
              HelpCheckbox(
                value: i?.soStarter ?? false,
                onChanged: (v) =>
                    save(TaxYearInputsCompanion(soStarter: Value(v))),
                title: l.inputSoStarter,
                help: l.inputSoStarterHelp(
                  rules.starterLookbackYears,
                  rules.soStarterMaxYears,
                ),
              ),
            HelpCheckbox(
              value: i?.businessCeased ?? false,
              onChanged: (v) =>
                  save(TaxYearInputsCompanion(businessCeased: Value(v))),
              title: l.inputBusinessCeased,
              help: l.inputBusinessCeasedHelp,
            ),
            if (i?.businessCeased ?? false) ...[
              const SizedBox(height: AppSpacing.field),
              AmountField(
                key: ValueKey('stakings_$year'),
                label: l.inputStakingsUsedBefore,
                help: l.inputStakingsUsedBeforeHelp(
                  AppFormat.euros(rules.stakingsaftrekMax),
                ),
                initialValueCents: i?.stakingsaftrekUsedBefore ?? 0,
                onChanged: (v) => save(
                  TaxYearInputsCompanion(stakingsaftrekUsedBefore: Value(v)),
                ),
              ),
              const SizedBox(height: AppSpacing.field),
            ],
            HelpCheckbox(
              value: i?.disabilityBenefit ?? false,
              onChanged: (v) =>
                  save(TaxYearInputsCompanion(disabilityBenefit: Value(v))),
              title: l.inputDisabilityBenefit,
              help: l.inputDisabilityBenefitHelp(
                rules.reducedUrencriterium,
                rules.urencriterium,
              ),
            ),
            if (i?.disabilityBenefit ?? false) ...[
              const SizedBox(height: AppSpacing.field),
              _WholeNumberField(
                key: ValueKey('disability_$year'),
                label: l.inputDisabilityUsed(rules.starterLookbackYears),
                help: l.inputDisabilityUsedHelp(
                  rules.starterLookbackYears,
                  rules.disabilityStartersaftrek.length,
                ),
                value: i?.disabilityStartersUsed ?? 0,
                max: rules.disabilityStartersaftrek.length,
                onChanged: (v) => save(
                  TaxYearInputsCompanion(disabilityStartersUsed: Value(v)),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.section),
            SectionLabel(
              l.plTaxEmploymentSection(year),
              help: l.plTaxEmploymentSectionHelp,
            ),
            const SizedBox(height: AppSpacing.heading),
            HelpCheckbox(
              value: i?.employed ?? false,
              // Turning the job off clears its figures: a hidden option
              // may not stay set.
              onChanged: (v) => save(
                v
                    ? const TaxYearInputsCompanion(employed: Value(true))
                    : const TaxYearInputsCompanion(
                        employed: Value(false),
                        wages: Value(0),
                        wageTaxWithheld: Value(0),
                        zvwWages: Value(0),
                      ),
              ),
              title: l.inputEmployed,
              help: l.inputEmployedHelp,
            ),
            if (i?.employed ?? false) ...[
              const SizedBox(height: AppSpacing.field),
              FormRow(
                children: [
                  AmountField(
                    key: ValueKey('wages_$year'),
                    label: l.inputWages,
                    help: l.inputWagesHelp,
                    initialValueCents: i!.wages,
                    onChanged: (v) =>
                        save(TaxYearInputsCompanion(wages: Value(v))),
                  ),
                  AmountField(
                    key: ValueKey('withheld_$year'),
                    label: l.inputWageTaxWithheld,
                    help: l.inputWageTaxWithheldHelp,
                    initialValueCents: i.wageTaxWithheld,
                    onChanged: (v) =>
                        save(TaxYearInputsCompanion(wageTaxWithheld: Value(v))),
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.field),
            // The time test counts other work too, so the hours are asked
            // with or without a job (art. 3.6 lid 1 a).
            FormRow(
              children: [
                if (i?.employed ?? false)
                  AmountField(
                    key: ValueKey('zvw_wages_$year'),
                    label: l.inputZvwWages,
                    help: l.inputZvwWagesHelp,
                    initialValueCents: i!.zvwWages,
                    onChanged: (v) =>
                        save(TaxYearInputsCompanion(zvwWages: Value(v))),
                  ),
                _WholeNumberField(
                  key: ValueKey('job_hours_$year'),
                  label: l.inputEmploymentHours,
                  help: l.inputEmploymentHoursHelp(rules.starterLookbackYears),
                  value: i?.employmentHours ?? 0,
                  max: _hoursInYear,
                  onChanged: (v) =>
                      save(TaxYearInputsCompanion(employmentHours: Value(v))),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// The most hours a year can hold: 366 days of 24 hours.
const _hoursInYear = 366 * 24;

/// A whole-number field saved when it loses focus.
class _WholeNumberField extends StatefulWidget {
  final String label;
  final String help;
  final int value;
  final int? max;
  final ValueChanged<int> onChanged;

  const _WholeNumberField({
    super.key,
    required this.label,
    required this.help,
    required this.value,
    required this.onChanged,
    this.max,
  });

  @override
  State<_WholeNumberField> createState() => _WholeNumberFieldState();
}

class _WholeNumberFieldState extends State<_WholeNumberField> {
  late final _controller = TextEditingController(text: '${widget.value}');
  late final _focus = FocusNode()..addListener(_commit);

  String? _error(AppLocalizations l) => Validate.wholeNumber(
    _controller.text,
    l.inputWholeNumber(widget.max ?? 9999),
    max: widget.max,
  );

  int? get _parsed => _error(AppLocalizations.of(context)!) == null
      ? parseWholeNumber(_controller.text)
      : null;

  void _commit() {
    if (!_focus.hasFocus && _parsed != null) widget.onChanged(_parsed!);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return TextFormField(
      controller: _controller,
      focusNode: _focus,
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: fieldDecoration(label: widget.label, help: widget.help),
      validator: (_) => _error(l),
    );
  }
}

/// The business on 31 December and the equity comparison of the income tax
/// return (vraag 19), from the records and the year's inputs.
class _BalanceSheetSection extends ConsumerWidget {
  final int year;

  /// The estimate's profit before investeringsaftrek, to compare with.
  final int profit;

  const _BalanceSheetSection({required this.year, required this.profit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final inputs = ref.watch(taxYearInputsProvider(year)).valueOrNull;
    Future<void> save(TaxYearInputsCompanion change) => guardSave(
      context,
      () => ref
          .read(taxYearInputsDaoProvider)
          .save(change.copyWith(year: Value(year))),
    );
    Widget field(
      String key,
      String label,
      String help,
      int value,
      TaxYearInputsCompanion Function(int) change,
    ) => AmountField(
      key: ValueKey('${key}_$year'),
      label: label,
      help: help,
      initialValueCents: value,
      onChanged: (v) => save(change(v)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(l.balanceSection(year), help: l.balanceSectionHelp),
        const SizedBox(height: AppSpacing.heading),
        NoticeBanner(l.balancePaperNotice),
        const SizedBox(height: AppSpacing.field),
        FormRow(
          children: [
            field(
              'bank',
              l.balanceBank,
              l.balanceBankHelp,
              inputs?.bankBalance ?? 0,
              (v) => TaxYearInputsCompanion(bankBalance: Value(v)),
            ),
            field(
              'cash',
              l.balanceCash,
              l.balanceCashHelp,
              inputs?.cashBalance ?? 0,
              (v) => TaxYearInputsCompanion(cashBalance: Value(v)),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.field),
        FormRow(
          children: [
            field(
              'unpaid',
              l.balanceUnpaidPurchases,
              l.balanceUnpaidPurchasesHelp,
              inputs?.unpaidPurchases ?? 0,
              (v) => TaxYearInputsCompanion(unpaidPurchases: Value(v)),
            ),
            field(
              'loans',
              l.balanceLoans,
              l.balanceLoansHelp,
              inputs?.longTermLoans ?? 0,
              (v) => TaxYearInputsCompanion(longTermLoans: Value(v)),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.field),
        FormRow(
          children: [
            field(
              'equityStart',
              l.balanceEquityStart,
              l.balanceEquityStartHelp,
              inputs?.equityStart ?? 0,
              (v) => TaxYearInputsCompanion(equityStart: Value(v)),
            ),
            field(
              'withdrawals',
              l.balanceWithdrawals,
              l.balanceWithdrawalsHelp,
              inputs?.privateWithdrawals ?? 0,
              (v) => TaxYearInputsCompanion(privateWithdrawals: Value(v)),
            ),
            field(
              'deposits',
              l.balanceDeposits,
              l.balanceDepositsHelp,
              inputs?.privateDeposits ?? 0,
              (v) => TaxYearInputsCompanion(privateDeposits: Value(v)),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.field),
        AsyncBody(
          value: ref.watch(balanceSheetProvider(year)),
          builder: (b) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueRow.cents(l.balanceFixedAssets, b.fixedAssets),
              ValueRow.cents(
                l.balanceReceivables,
                b.receivables + b.vatReceivable,
                help: l.balanceReceivablesHelp,
              ),
              ValueRow.cents(l.balanceLiquid, b.bank + b.cash),
              ValueRow.cents(l.balanceTotalAssets, b.totalAssets, bold: true),
              ValueRow.cents(
                l.balanceShortTermDebts,
                -b.shortTermDebts,
                help: l.balanceShortTermDebtsHelp,
              ),
              ValueRow.cents(l.balanceLongTermDebts, -b.longTermLoans),
              const Divider(),
              ValueRow.cents(
                l.balanceEquityEnd,
                b.equityEnd,
                bold: true,
                help: l.balanceEquityEndHelp,
              ),
              ValueRow.cents(
                l.balanceEquityProfit,
                b.equityProfit,
                bold: true,
                help: l.balanceEquityProfitHelp,
              ),
              ValueRow.cents(
                l.balanceEstimateProfit,
                profit,
                help: l.balanceEstimateProfitHelp,
              ),
              if (b.equityProfit != profit) ...[
                const SizedBox(height: AppSpacing.heading),
                NoticeBanner(
                  l.balanceDifferenceNotice(
                    AppFormat.cents(b.equityProfit - profit),
                  ),
                  tone: NoticeTone.warning,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
