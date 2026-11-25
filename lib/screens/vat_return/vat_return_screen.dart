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
import '../../widgets/quarter_chips.dart';
import '../../widgets/value_row.dart';

class VatReturnScreen extends ConsumerStatefulWidget {
  const VatReturnScreen({super.key});

  @override
  ConsumerState<VatReturnScreen> createState() => _VatReturnScreenState();
}

class _VatReturnScreenState extends ConsumerState<VatReturnScreen> {
  int _quarter = quarterOf(DateTime.now());

  Future<void> _setStatus(
    int year,
    VatReturn? current, {
    bool? filed,
    bool? paid,
  }) => guardSave(
    context,
    () => ref
        .read(vatReturnDaoProvider)
        .save(
          VatReturnsCompanion(
            year: Value(year),
            quarter: Value(_quarter),
            filed: Value(filed ?? current?.filed ?? false),
            paid: Value(paid ?? current?.paid ?? false),
          ),
        ),
  );

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final year = ref.watch(fiscalYearProvider);
    final result = ref.watch(
      vatQuarterProvider((year: year, quarter: _quarter)),
    );
    final status = ref
        .watch(vatReturnsProvider(year))
        .valueOrNull
        ?.where((v) => v.quarter == _quarter)
        .firstOrNull;
    final deadline = VatService.filingDeadline(year, _quarter);
    final rules = ref.watch(taxRulesProvider(year));
    final kor = ref.watch(korStatusProvider).valueOrNull ?? KorStatus.none;
    final korCovered = kor.coversQuarter(year, _quarter);
    final korExceeded = kor.exceededOn[year];
    // Until the figures load, a return is due: the cautious answer.
    final duty = result.valueOrNull?.duty ?? ReturnDuty.regular;

    return Scaffold(
      appBar: AppBar(title: Text(l.vatReturnTitle)),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                QuarterChips(
                  selected: _quarter,
                  allowAll: false,
                  onSelected: (q) => setState(() => _quarter = q!),
                ),
                const Spacer(),
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
            ] else if (kor.touchesQuarter(year, _quarter)) ...[
              const SizedBox(height: AppSpacing.group),
              NoticeBanner(
                korCovered ? l.vatReturnKorNotice : l.vatReturnKorPartNotice,
              ),
            ] else if (result.valueOrNull?.isEmpty ?? false) ...[
              const SizedBox(height: AppSpacing.group),
              NoticeBanner(l.vatReturnNilNotice),
            ],
            if (korExceeded != null && quarterOf(korExceeded) == _quarter) ...[
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
                        AppFormat.date(VatService.icpDeadline(year, _quarter)),
                        AppFormat.euros(rules.icpQuarterlyGoodsMax),
                        rules.icpGoodsLookbackQuarters,
                      ),
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.heading),
                    for (final inv in r.icpInvoices)
                      ValueRow.cents(inv.invoiceNumber, inv.signedExclVat),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.section),
            SectionLabel(l.vatReturnStatusSection),
            const SizedBox(height: AppSpacing.heading),
            HelpCheckbox(
              value: status?.filed ?? false,
              onChanged: (v) => _setStatus(year, status, filed: v),
              title: l.vatReturnFiled,
              help: l.vatReturnFiledHelp,
            ),
            HelpCheckbox(
              value: status?.paid ?? false,
              onChanged: (v) => _setStatus(year, status, paid: v),
              title: l.vatReturnPaid,
              help: l.vatReturnPaidHelp,
            ),
          ],
        ),
      ),
    );
  }
}
