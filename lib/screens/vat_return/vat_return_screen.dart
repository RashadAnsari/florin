import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../widgets/help.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/domain.dart';
import '../../services/kor_service.dart';
import '../../services/vat_service.dart';
import '../../widgets/notice_banner.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/async_body.dart';
import '../../widgets/deadline_badge.dart';
import '../../widgets/feedback.dart';
import '../../widgets/choice_chips.dart';
import '../../widgets/enum_dropdown.dart';
import '../../l10n/labels.dart';
import '../../widgets/value_row.dart';

class VatReturnScreen extends ConsumerStatefulWidget {
  const VatReturnScreen({super.key});

  @override
  ConsumerState<VatReturnScreen> createState() => _VatReturnScreenState();
}

class _VatReturnScreenState extends ConsumerState<VatReturnScreen> {
  /// The month or quarter shown; the kind follows the year's filing period.
  int? _number;

  Future<void> _setStatus(
    VatPeriod period,
    VatReturn? current, {
    bool? filed,
    bool? paid,
  }) => guardSave(
    context,
    () => ref
        .read(vatReturnDaoProvider)
        .save(
          VatReturnsCompanion(
            year: Value(period.year),
            kind: Value(period.kind),
            number: Value(period.number),
            filed: Value(filed ?? current?.filed ?? false),
            paid: Value(paid ?? current?.paid ?? false),
          ),
        ),
  );

  /// Marking a return filed keeps its own figures and settles the earlier
  /// corrections it carries; unmarking forgets what was kept.
  Future<void> _setFiled(
    VatPeriod period,
    VatReturn? current,
    VatReturnResult? result,
    bool filed,
  ) async {
    final own = ref.read(vatOwnPeriodProvider(period)).valueOrNull;
    if (filed && (own == null || result == null)) return;
    await guardSave(
      context,
      () => ref
          .read(vatFiledFiguresDaoProvider)
          .setFiled(
            period,
            filed: filed,
            paid: current?.paid ?? false,
            figures: own?.rubrieken ?? const {},
            carried: result?.carriedFrom ?? const {},
          ),
    );
  }

  /// The user filed a suppletie for [period]: its figures now count as
  /// filed.
  Future<void> _settle(VatPeriod period) async {
    final own = ref.read(vatOwnPeriodProvider(period)).valueOrNull;
    if (own == null) return;
    await guardSave(
      context,
      () => ref.read(vatFiledFiguresDaoProvider).settle(period, own.rubrieken),
    );
  }

  Future<void> _setKind(int year, VatFilingPeriod kind) async {
    final saved = await guardSave(
      context,
      () => ref
          .read(taxYearInputsDaoProvider)
          .save(
            TaxYearInputsCompanion(
              year: Value(year),
              vatFilingPeriod: Value(kind),
            ),
          ),
    );
    if (saved && mounted) setState(() => _number = null);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final year = ref.watch(fiscalYearProvider);
    // Until the year's choice loads, quarters: the regular period.
    final kind =
        ref.watch(vatFilingPeriodProvider(year)).valueOrNull ??
        VatFilingPeriod.quarterly;
    final period = _number != null && _number! <= kind.periodsPerYear
        ? (year: year, kind: kind, number: _number!)
        : vatPeriodOf(todayIn(year), kind);
    final result = ref.watch(vatPeriodProvider(period));
    final status = ref
        .watch(vatReturnsProvider(year))
        .valueOrNull
        ?.where((v) => v.kind == kind && v.number == period.number)
        .firstOrNull;
    final deadline = VatService.filingDeadline(period);
    final rules = ref.watch(taxRulesProvider(year));
    final kor = ref.watch(korStatusProvider).valueOrNull ?? KorStatus.none;
    final korCovered = kor.covers(period.first, period.last);
    final korExceeded = kor.exceededOn[year];
    // Until the figures load, a return is due: the cautious answer.
    final duty = result.valueOrNull?.duty ?? ReturnDuty.regular;
    final yearlyIssue =
        kind == VatFilingPeriod.yearly &&
        result.hasValue &&
        VatService.yearlyFilingIssue(result.requireValue, rules);

    return Scaffold(
      appBar: AppBar(title: Text(l.vatReturnTitle)),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EnumDropdown<VatFilingPeriod>(
              label: l.vatReturnFilingPeriod,
              help: l.vatReturnFilingPeriodHelp(
                AppFormat.euros(rules.yearlyFilingMaxVat),
                AppFormat.euros(rules.yearlyFilingMaxEu),
              ),
              value: kind,
              values: VatFilingPeriod.values,
              labelOf: (k) => k.label(l),
              onChanged: (k) => _setKind(year, k),
              required: true,
            ),
            if (yearlyIssue) ...[
              const SizedBox(height: AppSpacing.field),
              NoticeBanner(
                l.vatReturnYearlyNotAllowed(
                  AppFormat.euros(rules.yearlyFilingMaxVat),
                  AppFormat.euros(rules.yearlyFilingMaxEu),
                ),
                tone: NoticeTone.warning,
              ),
            ],
            const SizedBox(height: AppSpacing.field),
            Row(
              children: [
                if (kind != VatFilingPeriod.yearly)
                  Expanded(
                    child: ChoiceChips<int>(
                      selected: period.number,
                      onSelected: (n) => setState(() => _number = n),
                      options: [
                        for (final p in vatPeriodsOf(year, kind))
                          (p.number, p.label(l)),
                      ],
                    ),
                  )
                else
                  Expanded(child: Text(period.label(l))),
                const SizedBox(width: AppSpacing.field),
                DeadlineBadge(
                  deadline: deadline,
                  filed: status?.filed ?? false,
                  duty: duty,
                ),
              ],
            ),
            if (korCovered && duty == ReturnDuty.incidental) ...[
              const SizedBox(height: AppSpacing.group),
              NoticeBanner(
                l.vatReturnKorIncidentalNotice,
                tone: NoticeTone.warning,
              ),
            ] else if (kor.touches(period.first, period.last)) ...[
              const SizedBox(height: AppSpacing.group),
              NoticeBanner(
                korCovered ? l.vatReturnKorNotice : l.vatReturnKorPartNotice,
              ),
            ] else if (result.valueOrNull?.isEmpty ?? false) ...[
              const SizedBox(height: AppSpacing.group),
              NoticeBanner(l.vatReturnNilNotice),
            ],
            if (korExceeded != null && period.contains(korExceeded)) ...[
              const SizedBox(height: AppSpacing.group),
              NoticeBanner(
                l.vatReturnKorExceeded(
                  AppFormat.date(korExceeded),
                  AppFormat.cents(rules.korThreshold),
                ),
                tone: NoticeTone.warning,
              ),
            ],
            const SizedBox(height: AppSpacing.section),
            AsyncBody(
              value: result,
              builder: (r) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionLabel(l.vatReturnRevenueSection),
                  ValueRow(
                    label: l.vatRow1a(
                      AppFormat.percentLabel(rules.vatRates[VatRate.high]!),
                    ),
                    help: l.vatRow1aHelp(
                      AppFormat.percentLabel(rules.vatRates[VatRate.high]!),
                    ),
                    value: AppFormat.cents(r.revenue1a),
                  ),
                  ValueRow(
                    label: l.vatRow1b(
                      AppFormat.percentLabel(rules.vatRates[VatRate.low]!),
                    ),
                    help: l.vatRow1bHelp(
                      AppFormat.percentLabel(rules.vatRates[VatRate.low]!),
                    ),
                    value: AppFormat.cents(r.revenue1b),
                  ),
                  ValueRow(
                    label: l.vatRow1e,
                    help: l.vatRow1eHelp,
                    value: AppFormat.cents(r.revenue1e),
                  ),
                  if (r.vat1d > 0)
                    ValueRow(
                      label: l.vatRow1d,
                      help: l.vatRow1dHelp(
                        AppFormat.percentLabel(rules.btwPrivateCarRate),
                        AppFormat.percentLabel(rules.btwPrivateCarReducedRate),
                      ),
                      value: AppFormat.cents(r.vat1d),
                    ),
                  ValueRow(
                    label: l.vatRow3a,
                    help: l.vatRow3aHelp,
                    value: AppFormat.cents(r.revenue3a),
                  ),
                  ValueRow(
                    label: l.vatRow3b,
                    help: l.vatRow3bHelp,
                    value: AppFormat.cents(r.revenue3b),
                  ),
                  if (r.revenueKorExempt != 0)
                    ValueRow(
                      label: l.vatRowKorExempt,
                      help: l.vatRowKorExemptHelp,
                      value: AppFormat.cents(r.revenueKorExempt),
                    ),
                  if (r.revenueOutsideReturn != 0)
                    ValueRow(
                      label: l.vatRowOutsideReturn,
                      help: l.vatRowOutsideReturnHelp,
                      value: AppFormat.cents(r.revenueOutsideReturn),
                    ),
                  if (r.base2a != 0 || r.base4a != 0 || r.base4b != 0) ...[
                    const SizedBox(height: AppSpacing.group),
                    SectionLabel(
                      l.vatReturnShiftedSection,
                      help: l.vatReturnShiftedSectionHelp,
                    ),
                    ValueRow(
                      label: l.vatRow2a,
                      help: l.vatRow2aHelp,
                      value: l.vatBaseAndVat(
                        AppFormat.cents(r.base2a),
                        AppFormat.cents(r.vat2a),
                      ),
                    ),
                    ValueRow(
                      label: l.vatRow4a,
                      help: l.vatRow4aHelp,
                      value: l.vatBaseAndVat(
                        AppFormat.cents(r.base4a),
                        AppFormat.cents(r.vat4a),
                      ),
                    ),
                    ValueRow(
                      label: l.vatRow4b,
                      help: l.vatRow4bHelp,
                      value: l.vatBaseAndVat(
                        AppFormat.cents(r.base4b),
                        AppFormat.cents(r.vat4b),
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.group),
                  SectionLabel(l.vatReturnCalculationSection),
                  ValueRow(
                    label: l.vatRow5a,
                    help: l.vatRow5aHelp,
                    value: AppFormat.cents(r.outputVat5a),
                    bold: true,
                  ),
                  ValueRow(
                    label: l.vatRow5b,
                    help: l.vatRow5bHelp,
                    value: AppFormat.cents(r.inputVat5b),
                  ),
                  const Divider(height: AppSpacing.section),
                  ValueRow(
                    label: r.netVat >= 0 ? l.vatReturnDue : l.vatReturnRefund,
                    value: AppFormat.cents(r.netVat.abs()),
                    bold: true,
                    color: r.netVat >= 0
                        ? theme.colorScheme.error
                        : context.colors.income,
                  ),
                  if (r.vatRevisionTotal > 0) ...[
                    const SizedBox(height: AppSpacing.section),
                    SectionLabel(
                      l.vatReturnRevisionSection,
                      help: l.vatReturnRevisionSectionHelp(
                        rules.vatRevisionYears,
                        AppFormat.percentLabel(rules.vatRevisionMinShift),
                        AppFormat.euros(rules.korRevisionMin),
                      ),
                    ),
                    for (final e in r.vatRevision.entries)
                      ValueRow.cents(e.key.assetName, e.value),
                    ValueRow.cents(
                      l.vatReturnRevisionTotal,
                      r.vatRevisionTotal,
                      bold: true,
                    ),
                    const SizedBox(height: AppSpacing.heading),
                    NoticeBanner(
                      l.vatReturnRevisionNotice,
                      tone: NoticeTone.warning,
                    ),
                  ],
                  if (r.icpInvoices.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.section),
                    SectionLabel(
                      l.vatReturnIcpSection,
                      help: l.vatReturnIcpSectionHelp,
                    ),
                    Text(
                      l.vatReturnIcpNote(
                        AppFormat.date(
                          VatService.icpDeadline(year, quarterOf(period.last)),
                        ),
                        AppFormat.euros(rules.icpQuarterlyGoodsMax),
                        rules.icpGoodsLookbackQuarters,
                      ),
                      style: theme.textTheme.bodySmall,
                    ),
                    if (VatService.icpMonthlyDue(
                      ref.watch(allInvoicesProvider).valueOrNull ?? const [],
                      kor,
                      year,
                      quarterOf(period.last),
                      rules,
                    )) ...[
                      const SizedBox(height: AppSpacing.heading),
                      NoticeBanner(
                        l.vatReturnIcpMonthlyNotice(
                          AppFormat.euros(rules.icpQuarterlyGoodsMax),
                          rules.icpGoodsLookbackQuarters,
                        ),
                        tone: NoticeTone.warning,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.heading),
                    for (final inv in r.icpInvoices)
                      ValueRow.cents(inv.invoiceNumber, inv.signedExclVat),
                  ],
                ],
              ),
            ),
            if (result.valueOrNull case final r?
                when r.changedSinceFiled.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.section),
              _CorrectionSection(
                change: r.changedSinceFiled,
                fitsNext: VatService.fitsNextReturn(r.changedSinceFiled, rules),
                onSettled: () => _settle(period),
              ),
            ],
            if (result.valueOrNull case final r?
                when r.carriedCorrections.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.section),
              SectionLabel(
                l.vatReturnCarriedSection,
                help: l.vatReturnCarriedSectionHelp(
                  AppFormat.euros(rules.correctionNextReturnMax),
                ),
              ),
              Text(
                l.vatReturnCarriedFrom(
                  r.carriedFrom.keys.map((p) => p.label(l)).join(', '),
                ),
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.heading),
              for (final e in r.carriedCorrections.entries)
                ValueRow(
                  label: l.vatReturnRubriek(e.key),
                  value: l.vatBaseAndVat(
                    AppFormat.cents(e.value.$1),
                    AppFormat.cents(e.value.$2),
                  ),
                ),
            ],
            const SizedBox(height: AppSpacing.section),
            SectionLabel(l.vatReturnStatusSection),
            const SizedBox(height: AppSpacing.heading),
            HelpCheckbox(
              value: status?.filed ?? false,
              // Filing keeps the figures, so it waits for them.
              onChanged: result.hasValue
                  ? (v) => _setFiled(period, status, result.valueOrNull, v)
                  : null,
              title: l.vatReturnFiled,
              help: l.vatReturnFiledHelp,
            ),
            HelpCheckbox(
              value: status?.paid ?? false,
              onChanged: (v) => _setStatus(period, status, paid: v),
              title: l.vatReturnPaid,
              help: l.vatReturnPaidHelp,
            ),
          ],
        ),
      ),
    );
  }
}

/// How a filed return's records changed since it was filed, and what the
/// Belastingdienst asks for that change.
class _CorrectionSection extends ConsumerWidget {
  final Map<String, (int, int)> change;
  final bool fitsNext;
  final VoidCallback onSettled;

  const _CorrectionSection({
    required this.change,
    required this.fitsNext,
    required this.onSettled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final rules = ref.watch(taxRulesProvider(ref.watch(fiscalYearProvider)));
    final net = VatService.netVatOf(change);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(
          l.vatReturnChangedSection,
          help: l.vatReturnChangedSectionHelp,
        ),
        for (final e in change.entries)
          ValueRow(
            label: l.vatReturnRubriek(e.key),
            value: l.vatBaseAndVat(
              AppFormat.cents(e.value.$1),
              AppFormat.cents(e.value.$2),
            ),
          ),
        ValueRow.cents(l.vatReturnChangedNet, net, bold: true),
        const SizedBox(height: AppSpacing.heading),
        NoticeBanner(
          fitsNext
              ? l.vatReturnChangedNextNotice(
                  AppFormat.euros(rules.correctionNextReturnMax),
                )
              : l.vatReturnChangedSuppletieNotice(
                  AppFormat.euros(rules.correctionNextReturnMax),
                  rules.suppletieWeeks,
                  rules.correctionYears,
                ),
          tone: fitsNext ? NoticeTone.info : NoticeTone.warning,
        ),
        if (!fitsNext) ...[
          const SizedBox(height: AppSpacing.heading),
          OutlinedButton.icon(
            icon: const Icon(Icons.check, size: 16),
            label: Text(l.vatReturnSuppletieFiled),
            onPressed: onSettled,
          ),
        ],
      ],
    );
  }
}
