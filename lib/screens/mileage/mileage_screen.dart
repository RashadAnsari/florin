import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../services/tax_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/confirmation_dialog.dart';

const _kTripTypes = ['Business', 'Commute', 'Private'];

DateTime _defaultDateForYear(int year) {
  final now = DateTime.now();
  return now.year == year ? now : DateTime(year, 1, 1);
}

DateTime _clampDateToYear(DateTime date, int year) {
  final first = DateTime(year, 1, 1);
  final last = DateTime(year, 12, 31);
  if (date.isBefore(first)) return first;
  if (date.isAfter(last)) return last;
  return date;
}

String _tripTypeLabel(AppLocalizations l, String tripType) =>
    switch (tripType) {
      'Business' => l.tripTypeBusiness,
      'Commute' => l.tripTypeCommute,
      'Private' => l.tripTypePrivate,
      _ => l.tripTypeBusiness,
    };

class MileageScreen extends ConsumerWidget {
  const MileageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final year = ref.watch(fiscalYearProvider);
    final tripsAsync = ref.watch(mileageTripsStreamProvider(year));
    final trips = tripsAsync.valueOrNull ?? [];
    final paramsAsync = ref.watch(taxParamsStreamProvider(year));
    final params = paramsAsync.valueOrNull;

    final businessKm = trips
        .where((t) => t.tripType == 'Business')
        .fold<int>(0, (s, t) => s + t.distanceKm);
    final totalKm = trips.fold<int>(0, (s, t) => s + t.distanceKm);
    final allowance = params != null
        ? TaxService.computeMileageAllowance(
            businessKm,
            params.mileageRatePerKm,
          )
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.mileageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: l.mileageNewTrip,
            onPressed: () => context.push('/mileage/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          _SummaryBar(
            businessKm: businessKm,
            totalKm: totalKm,
            allowance: allowance,
            ratePerKm:
                params?.mileageRatePerKm ?? TaxService.defaultMileageRatePerKm,
          ),
          const Divider(height: 1),
          Expanded(
            child: tripsAsync.when(
              data: (all) => _TripList(
                trips: all,
                onTap: (t) => context.push('/mileage/${t.id}', extra: t),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(l.genericLoadError('$e'))),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryBar extends StatelessWidget {
  final int businessKm;
  final int totalKm;
  final int allowance;
  final double ratePerKm;

  const _SummaryBar({
    required this.businessKm,
    required this.totalKm,
    required this.allowance,
    required this.ratePerKm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _stat(l.mileageBusiness, '$businessKm ${l.mileageUnitKm}', theme),
              const SizedBox(width: 32),
              _stat(l.mileageTotal, '$totalKm ${l.mileageUnitKm}', theme),
              const SizedBox(width: 32),
              _stat(
                l.mileageAllowance(ratePerKm.toStringAsFixed(2)),
                AppFormat.cents(allowance),
                theme,
                valueColor: AppColors.income,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(
    String label,
    String value,
    ThemeData theme, {
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _TripList extends StatelessWidget {
  final List<MileageTrip> trips;
  final ValueChanged<MileageTrip> onTap;

  const _TripList({required this.trips, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (trips.isEmpty) {
      return Center(child: Text(l.mileageNone));
    }
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, i) {
        final t = trips[i];
        final detail =
            '${AppFormat.date(t.date)}, ${_tripTypeLabel(l, t.tripType)}';
        return ListTile(
          title: Text(
            '${t.departureAddress}, ${t.arrivalAddress}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(detail, style: Theme.of(context).textTheme.bodySmall),
              if (t.purpose.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  t.purpose,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ],
          ),
          isThreeLine: t.purpose.isNotEmpty,
          dense: true,
          visualDensity: VisualDensity.compact,
          trailing: Text(
            '${t.distanceKm} ${l.mileageUnitKm}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: t.tripType == 'Business' ? AppColors.income : null,
            ),
          ),
          onTap: () => onTap(t),
        );
      },
    );
  }
}

class _TripForm extends ConsumerStatefulWidget {
  final MileageTrip? trip;
  final int year;
  final VoidCallback? onBack;
  final VoidCallback onSaved;
  final VoidCallback onDeleted;

  const _TripForm({
    required this.trip,
    required this.year,
    required this.onBack,
    required this.onSaved,
    required this.onDeleted,
  });

  @override
  ConsumerState<_TripForm> createState() => _TripFormState();
}

class _TripFormState extends ConsumerState<_TripForm> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date;
  late TextEditingController _makeModel;
  late TextEditingController _plate;
  late TextEditingController _from;
  late TextEditingController _to;
  late TextEditingController _odoStart;
  late TextEditingController _odoEnd;
  late TextEditingController _purpose;
  late TextEditingController _notes;
  late String _tripType;
  late bool _routeDeviation;
  int _distanceKm = 0;

  @override
  void initState() {
    super.initState();
    final t = widget.trip;
    _date = t?.date ?? _defaultDateForYear(widget.year);
    _makeModel = TextEditingController(text: t?.vehicleMakeModel ?? '');
    _plate = TextEditingController(text: t?.vehicleLicensePlate ?? '');
    _from = TextEditingController(text: t?.departureAddress ?? '');
    _to = TextEditingController(text: t?.arrivalAddress ?? '');
    _odoStart = TextEditingController(
      text: t != null ? t.odometerStart.toString() : '',
    );
    _odoEnd = TextEditingController(
      text: t != null ? t.odometerEnd.toString() : '',
    );
    _purpose = TextEditingController(text: t?.purpose ?? '');
    _notes = TextEditingController(text: t?.notes ?? '');
    _tripType = t == null
        ? 'Business'
        : _kTripTypes.contains(t.tripType)
        ? t.tripType
        : 'Business';
    _routeDeviation = t?.routeDeviation ?? false;
    _distanceKm = t?.distanceKm ?? 0;
  }

  @override
  void dispose() {
    _makeModel.dispose();
    _plate.dispose();
    _from.dispose();
    _to.dispose();
    _odoStart.dispose();
    _odoEnd.dispose();
    _purpose.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _computeDistance() {
    final start = int.tryParse(_odoStart.text) ?? 0;
    final end = int.tryParse(_odoEnd.text) ?? 0;
    final distance = end > start ? end - start : 0;
    if (distance != _distanceKm) setState(() => _distanceKm = distance);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final start = int.parse(_odoStart.text.trim());
    final end = int.parse(_odoEnd.text.trim());
    final dao = ref.read(mileageDaoProvider);
    final companion = MileageTripsCompanion(
      id: widget.trip != null ? Value(widget.trip!.id) : const Value.absent(),
      date: Value(_date),
      vehicleMakeModel: Value(_makeModel.text.trim()),
      vehicleLicensePlate: Value(_plate.text.trim()),
      departureAddress: Value(_from.text.trim()),
      arrivalAddress: Value(_to.text.trim()),
      odometerStart: Value(start),
      odometerEnd: Value(end),
      distanceKm: Value(end - start),
      tripType: Value(_tripType),
      purpose: Value(_purpose.text.trim()),
      routeDeviation: Value(_routeDeviation),
      notes: Value(_notes.text.trim().isEmpty ? null : _notes.text.trim()),
      fiscalYear: Value(widget.year),
    );
    if (widget.trip == null) {
      await dao.insertTrip(companion);
    } else {
      await dao.saveTrip(companion);
    }
    widget.onSaved();
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context)!;
    final tripLabel = widget.trip!.purpose.trim().isNotEmpty
        ? widget.trip!.purpose
        : '${widget.trip!.departureAddress}, ${widget.trip!.arrivalAddress}';
    final confirmed = await showConfirmationDialog(
      context,
      title: l.mileageDeleteTitle,
      message: l.mileageDeleteMessage(tripLabel),
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref.read(mileageDaoProvider).deleteTrip(widget.trip!.id);
    if (mounted) widget.onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isNew = widget.trip == null;

    String? validatePositiveInt(String? value, String message) {
      final parsed = int.tryParse(value?.trim() ?? '');
      if (parsed == null || parsed < 0) return message;
      return null;
    }

    String? validateOdometerEnd(String? value) {
      final parsed = int.tryParse(value?.trim() ?? '');
      if (parsed == null || parsed < 0) return l.mileageValidateOdoEnd;
      final start = int.tryParse(_odoStart.text.trim());
      if (start != null && parsed <= start) return l.mileageFieldOdoError;
      return null;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
          child: Row(
            children: [
              if (widget.onBack != null)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onBack,
                ),
              Expanded(
                child: Text(
                  isNew ? l.mileageNewTrip : _purpose.text,
                  style: theme.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isNew)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: l.actionDelete,
                  color: theme.colorScheme.error,
                  onPressed: _delete,
                ),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined, size: 18),
                label: Text(l.actionSave),
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    key: ValueKey(_date.toString()),
                    initialValue: AppFormat.date(_date),
                    readOnly: true,
                    strutStyle: StrutStyle.disabled,
                    decoration: InputDecoration(labelText: l.mileageFieldDate),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _clampDateToYear(_date, widget.year),
                        firstDate: DateTime(widget.year, 1, 1),
                        lastDate: DateTime(widget.year, 12, 31),
                      );
                      if (d != null) setState(() => _date = d);
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _makeModel,
                          decoration: InputDecoration(
                            labelText: l.mileageFieldMakeModel,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? l.mileageValidateMakeModel
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _plate,
                          decoration: InputDecoration(
                            labelText: l.mileageFieldPlate,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? l.mileageValidatePlate
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _from,
                    decoration: InputDecoration(labelText: l.mileageFieldFrom),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l.mileageValidateFrom
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _to,
                    decoration: InputDecoration(labelText: l.mileageFieldTo),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l.mileageValidateTo
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _odoStart,
                          decoration: InputDecoration(
                            labelText: l.mileageFieldOdoStart,
                            suffixText: l.mileageUnitKm,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) =>
                              validatePositiveInt(v, l.mileageValidateOdoStart),
                          onChanged: (_) => _computeDistance(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _odoEnd,
                          decoration: InputDecoration(
                            labelText: l.mileageFieldOdoEnd,
                            suffixText: l.mileageUnitKm,
                          ),
                          keyboardType: TextInputType.number,
                          validator: validateOdometerEnd,
                          onChanged: (_) => _computeDistance(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        children: [
                          Text(
                            l.mileageFieldDistance,
                            style: theme.textTheme.bodySmall,
                          ),
                          Text(
                            '$_distanceKm ${l.mileageUnitKm}',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _tripType,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: l.mileageFieldTripType,
                    ),
                    validator: (v) =>
                        v == null ? l.mileageValidateTripType : null,
                    items: _kTripTypes
                        .map(
                          (t) => DropdownMenuItem(
                            value: t,
                            child: Text(_tripTypeLabel(l, t)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _tripType = v ?? _tripType),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _purpose,
                    decoration: InputDecoration(
                      labelText: l.mileageFieldPurpose,
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l.mileageValidatePurpose
                        : null,
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    value: _routeDeviation,
                    onChanged: (v) =>
                        setState(() => _routeDeviation = v ?? _routeDeviation),
                    title: Text(l.mileageFieldRouteDeviation),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notes,
                    decoration: InputDecoration(labelText: l.mileageFieldNotes),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MileageDetailPage extends ConsumerWidget {
  final MileageTrip? trip;

  const MileageDetailPage({super.key, this.trip});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = ref.watch(fiscalYearProvider);
    return Scaffold(
      body: _TripForm(
        trip: trip,
        year: trip?.fiscalYear ?? year,
        onBack: () => context.pop(),
        onSaved: () => context.pop(),
        onDeleted: () => context.pop(),
      ),
    );
  }
}
