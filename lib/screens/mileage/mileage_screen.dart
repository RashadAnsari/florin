import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../widgets/help.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../l10n/labels.dart';
import '../../providers/providers.dart';
import '../../services/domain.dart';
import '../../services/tax_service.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/car_picker.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/date_field.dart';
import '../../widgets/detail_scaffold.dart';
import '../../widgets/enum_dropdown.dart';
import '../../widgets/feedback.dart';
import '../../widgets/form_row.dart';
import '../../widgets/validators.dart';
import '../../services/formats.dart';
import '../../widgets/list_scaffold.dart';
import '../../widgets/summary_bar.dart';

class MileageScreen extends ConsumerWidget {
  const MileageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final trips = ref.watch(mileageTripsProvider(year));
    final rules = ref.watch(taxRulesProvider(year));
    final list = trips.valueOrNull ?? const <MileageTrip>[];
    final businessKm = TaxService.businessKm(list);

    return ListScaffold<MileageTrip>(
      title: l.mileageTitle,
      addTooltip: l.mileageNewTrip,
      onAdd: () => context.push('/mileage/new'),
      items: trips,
      emptyText: l.mileageNone,
      controls: SummaryBar([
        SummaryStat(l.mileageBusiness, '$businessKm ${l.mileageUnitKm}'),
        SummaryStat(
          l.mileageTotal,
          '${list.fold(0, (s, t) => s + t.distanceKm)} ${l.mileageUnitKm}',
        ),
        SummaryStat(
          l.mileageAllowance(AppFormat.cents(rules.mileageCentsPerKm)),
          AppFormat.cents(TaxService.mileageAllowance(businessKm, rules)),
          color: context.colors.income,
        ),
      ]),
      itemBuilder: (context, t) => ListTile(
        title: EllipsisText(
          '${t.departureAddress.split('\n').first}, '
          '${t.arrivalAddress.split('\n').first}',
        ),
        subtitle: EllipsisText(
          '${AppFormat.date(t.date)}  ${t.tripType.label(l)}  ${t.purpose}',
        ),
        trailing: Text(
          '${t.distanceKm} ${l.mileageUnitKm}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: t.tripType == TripType.business
                ? context.colors.income
                : null,
          ),
        ),
        onTap: () => context.push('/mileage/${t.id}', extra: t),
      ),
    );
  }
}

class MileageDetailPage extends ConsumerStatefulWidget {
  final MileageTrip? trip;

  const MileageDetailPage({super.key, this.trip});

  @override
  ConsumerState<MileageDetailPage> createState() => _MileageDetailPageState();
}

class _MileageDetailPageState extends ConsumerState<MileageDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date =
      widget.trip?.date ?? todayIn(ref.read(fiscalYearProvider));
  late TripType _tripType = widget.trip?.tripType ?? TripType.business;
  late int? _carAssetId = widget.trip?.carAssetId;
  late bool _routeDeviation = widget.trip?.routeDeviation ?? false;
  late final _makeModel = TextEditingController(
    text: widget.trip?.vehicleMakeModel,
  );
  late final _plate = TextEditingController(
    text: widget.trip?.vehicleLicensePlate,
  );
  late final _from = TextEditingController(text: widget.trip?.departureAddress);
  late final _to = TextEditingController(text: widget.trip?.arrivalAddress);
  late final _odoStart = TextEditingController(
    text: widget.trip?.odometerStart.toString(),
  );
  late final _odoEnd = TextEditingController(
    text: widget.trip?.odometerEnd.toString(),
  );
  late final _purpose = TextEditingController(text: widget.trip?.purpose);
  late final _notes = TextEditingController(text: widget.trip?.notes);

  int? get _start => parseWholeNumber(_odoStart.text);
  int? get _end => parseWholeNumber(_odoEnd.text);

  @override
  void dispose() {
    for (final c in [
      _makeModel,
      _plate,
      _from,
      _to,
      _odoStart,
      _odoEnd,
      _purpose,
      _notes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final saved = await guardSave(
      context,
      () => ref
          .read(mileageDaoProvider)
          .save(
            MileageTripsCompanion(
              id: widget.trip == null
                  ? const Value.absent()
                  : Value(widget.trip!.id),
              date: Value(_date),
              carAssetId: Value(_carAssetId),
              vehicleMakeModel: Value(_makeModel.text.trim()),
              vehicleLicensePlate: Value(_plate.text.trim()),
              departureAddress: Value(_from.text.trim()),
              arrivalAddress: Value(_to.text.trim()),
              odometerStart: Value(_start!),
              odometerEnd: Value(_end!),
              tripType: Value(_tripType),
              purpose: Value(_purpose.text.trim()),
              routeDeviation: Value(_routeDeviation),
              notes: Value(optionalText(_notes.text)),
            ),
          ),
    );
    if (saved && mounted) context.pop();
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context)!;
    final t = widget.trip!;
    final confirmed = await showConfirmationDialog(
      context,
      title: l.mileageDeleteTitle,
      message: l.mileageDeleteMessage(
        '${AppFormat.date(t.date)}, ${t.distanceKm} ${l.mileageUnitKm}',
      ),
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    final deleted = await guardSave(
      context,
      () => ref.read(mileageDaoProvider).remove(t),
    );
    if (deleted && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final start = _start;
    final end = _end;
    final distance = start != null && end != null && end > start
        ? end - start
        : 0;

    return DetailScaffold(
      title: widget.trip == null ? l.mileageNewTrip : widget.trip!.purpose,
      onBack: () => context.pop(),
      onDelete: widget.trip == null ? null : _delete,
      onSave: _save,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            FormRow(
              children: [
                DateField(
                  label: l.mileageFieldDate,
                  help: l.mileageFieldDateHelp,
                  value: _date,
                  onChanged: (d) => setState(() => _date = d),
                  required: true,
                ),
                EnumDropdown(
                  label: l.mileageFieldTripType,
                  help: l.mileageFieldTripTypeHelp,
                  value: _tripType,
                  values: TripType.values,
                  labelOf: (t) => t.label(l),
                  onChanged: (t) => setState(() => _tripType = t),
                  required: true,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            carPicker(
              l: l,
              assets: ref.watch(allAssetsProvider).valueOrNull ?? const [],
              value: _carAssetId,
              label: l.mileageFieldVehicle,
              help: l.mileageFieldVehicleHelp,
              noneLabel: l.mileagePrivateVehicle,
              onChanged: (v) => setState(() => _carAssetId = v),
            ),
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                TextFormField(
                  controller: _makeModel,
                  decoration: fieldDecoration(
                    label: l.mileageFieldMakeModel,
                    help: l.mileageFieldMakeModelHelp,
                    required: true,
                  ),
                  validator: (v) =>
                      Validate.required(v, l.mileageValidateMakeModel),
                ),
                TextFormField(
                  controller: _plate,
                  decoration: fieldDecoration(
                    label: l.mileageFieldPlate,
                    help: l.mileageFieldPlateHelp,
                    required: true,
                  ),
                  validator: (v) =>
                      Validate.required(v, l.mileageValidatePlate),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                TextFormField(
                  controller: _from,
                  decoration: fieldDecoration(
                    label: l.mileageFieldFrom,
                    help: l.mileageFieldFromHelp,
                    required: true,
                  ),
                  minLines: 3,
                  maxLines: 4,
                  validator: (v) => Validate.required(v, l.mileageValidateFrom),
                ),
                TextFormField(
                  controller: _to,
                  decoration: fieldDecoration(
                    label: l.mileageFieldTo,
                    help: l.mileageFieldToHelp,
                    required: true,
                  ),
                  minLines: 3,
                  maxLines: 4,
                  validator: (v) => Validate.required(v, l.mileageValidateTo),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            FormRow(
              children: [
                TextFormField(
                  controller: _odoStart,
                  decoration: fieldDecoration(
                    label: l.mileageFieldOdoStart,
                    help: l.mileageFieldOdoStartHelp,
                    required: true,
                    suffixText: l.mileageUnitKm,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  validator: (v) =>
                      Validate.wholeNumber(v, l.mileageValidateOdoStart),
                ),
                TextFormField(
                  controller: _odoEnd,
                  decoration: fieldDecoration(
                    label: l.mileageFieldOdoEnd,
                    help: l.mileageFieldOdoEndHelp,
                    required: true,
                    suffixText: l.mileageUnitKm,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  validator: (v) =>
                      Validate.wholeNumber(v, l.mileageValidateOdoEnd) ??
                      Validate.wholeNumber(
                        v,
                        l.mileageFieldOdoError,
                        min: (start ?? -1) + 1,
                      ),
                ),
                InputDecorator(
                  decoration: fieldDecoration(
                    label: l.mileageFieldDistance,
                    help: l.mileageFieldDistanceHelp,
                  ),
                  child: Text('$distance ${l.mileageUnitKm}'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _purpose,
              decoration: fieldDecoration(
                label: l.mileageFieldPurpose,
                help: l.mileageFieldPurposeHelp,
                required: true,
              ),
              validator: (v) => Validate.required(v, l.mileageValidatePurpose),
            ),
            const SizedBox(height: AppSpacing.field),
            HelpCheckbox(
              value: _routeDeviation,
              onChanged: (v) => setState(() => _routeDeviation = v),
              title: l.mileageFieldRouteDeviation,
              help: l.mileageFieldRouteDeviationHelp,
            ),
            const SizedBox(height: AppSpacing.field),
            TextFormField(
              controller: _notes,
              decoration: fieldDecoration(
                label: l.mileageFieldNotes,
                help: l.mileageFieldNotesHelp,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
