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
    final expenses = ref.watch(expensesProvider(year)).valueOrNull ?? [];
    final assets = ref.watch(assetsProvider(year)).valueOrNull ?? [];

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
          final mileage = TaxService.mileageAllowance(
            estimate.businessKm,
            rules,
          );
          final depreciation = AssetService.totalDepreciation(assets, year);
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
                    l.plTaxUrenBanner(
                      AppFormat.hours(estimate.totalHours),
                      '${rules.urencriterium}',
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
                  if (e.key != ExpenseCategory.foodAndRepresentation)
                    ValueRow.cents(e.key.label(l), -e.value),
                if (food > 0)
                  ValueRow.cents(
                    l.plTaxFoodLimited(
                      ExpenseCategory.foodAndRepresentation.label(l),
                      AppFormat.cents(food),
                    ),
                    -TaxService.gemengdeKostenDeductible(food, rules),
                    help: l.plTaxFoodLimitedHelp(
                      AppFormat.percent(rules.gemengdeKostenPct, 0),
                      AppFormat.cents(rules.gemengdeKostenDrempel),
                    ),
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
                    help: l.plTaxDesinvesteringHelp,
                  ),
                if (r.carPrivateUse > 0)
                  ValueRow.cents(
                    l.plTaxCarPrivateUse,
                    r.carPrivateUse,
                    help: l.plTaxCarPrivateUseHelp,
                  ),
                if (r.reserveReleased > 0)
                  ValueRow.cents(
                    l.plTaxReserveReleased,
                    r.reserveReleased,
                    help: l.plTaxReserveReleasedHelp,
                  ),
                const SizedBox(height: AppSpacing.field),
                ValueRow.cents(l.plTaxGrossProfit, r.grossProfit, bold: true),
                const Divider(),
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
                const Divider(),
                SectionLabel(
                  l.plTaxDeductionsSection,
                  help: l.plTaxDeductionsSectionHelp,
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
                  ValueRow.cents(l.plTaxSo, -r.soAftrek, help: l.plTaxSoHelp),
                if (r.meewerkaftrek > 0)
                  ValueRow.cents(
                    l.plTaxMeewerk,
                    -r.meewerkaftrek,
                    help: l.plTaxMeewerkHelp,
                  ),
                if (r.disabilityStartersaftrek > 0)
                  ValueRow.cents(
                    l.plTaxDisabilityStarters,
                    -r.disabilityStartersaftrek,
                    help: l.plTaxDisabilityStartersHelp,
                  ),
                if (r.stakingsaftrek > 0)
                  ValueRow.cents(
                    l.plTaxStakings,
                    -r.stakingsaftrek,
                    help: l.plTaxStakingsHelp,
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
                const Divider(),
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
                ValueRow.cents(
                  l.plTaxNetProfit,
                  r.netProfitAfterTax,
                  bold: true,
                ),
                const SizedBox(height: AppSpacing.field),
                Text(
                  l.plTaxEffectiveRate(
                    AppFormat.percent(r.effectiveTaxRate / 10000, 1),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.section),
                _YearInputs(year: year),
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
            FormRow(
              children: [
                _WholeNumberField(
                  key: ValueKey('partner_$year'),
                  label: l.inputPartnerHours,
                  help: l.inputPartnerHoursHelp,
                  value: i?.partnerHours ?? 0,
                  onChanged: (v) =>
                      save(TaxYearInputsCompanion(partnerHours: Value(v))),
                ),
                AmountField(
                  key: ValueKey('unrealised_$year'),
                  label: l.inputUnrealisedZelfs,
                  help: l.inputUnrealisedZelfsHelp,
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
              help: l.inputSoVerklaringHelp,
            ),
            if (i?.hasSoVerklaring ?? false)
              HelpCheckbox(
                value: i?.soStarter ?? false,
                onChanged: (v) =>
                    save(TaxYearInputsCompanion(soStarter: Value(v))),
                title: l.inputSoStarter,
                help: l.inputSoStarterHelp,
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
                help: l.inputStakingsUsedBeforeHelp,
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
              help: l.inputDisabilityBenefitHelp,
            ),
            if (i?.disabilityBenefit ?? false) ...[
              const SizedBox(height: AppSpacing.field),
              _WholeNumberField(
                key: ValueKey('disability_$year'),
                label: l.inputDisabilityUsed,
                help: l.inputDisabilityUsedHelp,
                value: i?.disabilityStartersUsed ?? 0,
                max: 3,
                onChanged: (v) => save(
                  TaxYearInputsCompanion(disabilityStartersUsed: Value(v)),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

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
