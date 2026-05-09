import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../db/database.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';

const _kTripTypes = ['Business', 'Commute', 'Private'];

class MileageScreen extends ConsumerStatefulWidget {
  const MileageScreen({super.key});

  @override
  ConsumerState<MileageScreen> createState() => _MileageScreenState();
}

class _MileageScreenState extends ConsumerState<MileageScreen> {
  MileageTrip? _selected;
  bool _isNew = false;

  @override
  Widget build(BuildContext context) {
    final year = ref.watch(fiscalYearProvider);
    final trips = ref.watch(mileageTripsStreamProvider(year)).valueOrNull ?? [];
    final paramsAsync = ref.watch(taxParamsStreamProvider(year));
    final params = paramsAsync.valueOrNull;

    final businessKm = trips
        .where((t) => t.tripType == 'Business')
        .fold<int>(0, (s, t) => s + t.distanceKm);
    final totalKm = trips.fold<int>(0, (s, t) => s + t.distanceKm);
    final allowance = params != null
        ? (businessKm * params.mileageRatePerKm * 100).round()
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kilometerregistratie'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() {
              _selected = null;
              _isNew = true;
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          _SummaryBar(
            businessKm: businessKm,
            totalKm: totalKm,
            allowance: allowance,
            ratePerKm: params?.mileageRatePerKm ?? 0.23,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 320,
                  child: _TripList(
                    trips: trips,
                    selected: _selected,
                    onTap: (t) => setState(() {
                      _selected = t;
                      _isNew = false;
                    }),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: (_isNew || _selected != null)
                      ? _TripForm(
                          key: ValueKey(_isNew ? 'new' : _selected!.id),
                          trip: _isNew ? null : _selected,
                          year: year,
                          onSaved: () => setState(() {
                            _selected = null;
                            _isNew = false;
                          }),
                          onDeleted: () => setState(() {
                            _selected = null;
                            _isNew = false;
                          }),
                        )
                      : const Center(
                          child: Text('Selecteer een rit of klik +'),
                        ),
                ),
              ],
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      child: Row(
        children: [
          _stat('Zakelijk', '$businessKm km', theme),
          const SizedBox(width: 32),
          _stat('Totaal', '$totalKm km', theme),
          const SizedBox(width: 32),
          _stat(
            'Aftrek (€${ratePerKm.toStringAsFixed(2)}/km)',
            AppFormat.cents(allowance),
            theme,
            valueColor: Colors.green,
          ),
        ],
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
  final MileageTrip? selected;
  final ValueChanged<MileageTrip> onTap;

  const _TripList({
    required this.trips,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return const Center(child: Text('Geen ritten geregistreerd'));
    }
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, i) {
        final t = trips[i];
        return ListTile(
          selected: selected?.id == t.id,
          selectedTileColor: Theme.of(
            context,
          ).colorScheme.primaryContainer.withValues(alpha: 0.3),
          title: Text(
            '${t.departureAddress} → ${t.arrivalAddress}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${AppFormat.date(t.date)}  ·  ${t.tripType}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Text(
            '${t.distanceKm} km',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: t.tripType == 'Business' ? Colors.green : null,
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
  final VoidCallback onSaved;
  final VoidCallback onDeleted;

  const _TripForm({
    super.key,
    required this.trip,
    required this.year,
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
    _date = t?.date ?? DateTime.now();
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
    _tripType = t?.tripType ?? 'Business';
    _routeDeviation = t?.routeDeviation ?? false;
    _distanceKm = t?.distanceKm ?? 0;
    _odoStart.addListener(_computeDistance);
    _odoEnd.addListener(_computeDistance);
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
    if (end > start) setState(() => _distanceKm = end - start);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final start = int.tryParse(_odoStart.text) ?? 0;
    final end = int.tryParse(_odoEnd.text) ?? 0;
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
      distanceKm: Value((end - start).clamp(0, 99999)),
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
    final dao = ref.read(mileageDaoProvider);
    await dao.deleteTrip(widget.trip!.id);
    widget.onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    final start = int.tryParse(_odoStart.text) ?? 0;
    final end = int.tryParse(_odoEnd.text) ?? 0;
    final odometerError = end > 0 && start > 0 && end < start;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.trip == null ? 'Nieuwe rit' : 'Bewerk rit',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(widget.year, 1, 1),
                    lastDate: DateTime(widget.year, 12, 31),
                  );
                  if (d != null) setState(() => _date = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Datum'),
                  child: Text(AppFormat.date(_date)),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _makeModel,
                      decoration: const InputDecoration(
                        labelText: 'Merk/model',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _plate,
                      decoration: const InputDecoration(labelText: 'Kenteken'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _from,
                decoration: const InputDecoration(labelText: 'Vertrekadres'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Verplicht' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _to,
                decoration: const InputDecoration(labelText: 'Aankomstadres'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Verplicht' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _odoStart,
                      decoration: const InputDecoration(
                        labelText: 'Km-stand begin',
                        suffixText: 'km',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _computeDistance(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _odoEnd,
                      decoration: InputDecoration(
                        labelText: 'Km-stand eind',
                        suffixText: 'km',
                        errorText: odometerError ? 'Eind < begin' : null,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _computeDistance(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Text(
                        'Afstand',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '$_distanceKm km',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                decoration: const InputDecoration(labelText: 'Type rit'),
                items: _kTripTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _tripType = v ?? _tripType),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _purpose,
                decoration: const InputDecoration(labelText: 'Doel'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Verplicht' : null,
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _routeDeviation,
                onChanged: (v) =>
                    setState(() => _routeDeviation = v ?? _routeDeviation),
                title: const Text('Omrijden'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notes,
                decoration: const InputDecoration(
                  labelText: 'Notities (optioneel)',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  FilledButton(onPressed: _save, child: const Text('Opslaan')),
                  if (widget.trip != null) ...[
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _delete,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Verwijderen'),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
