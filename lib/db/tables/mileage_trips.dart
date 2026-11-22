import 'package:drift/drift.dart';
import '../enums.dart';
import 'fixed_assets.dart';

@TableIndex(name: 'mileage_trips_date', columns: {#date})
class MileageTrips extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();

  /// The business car driven, or null for a private vehicle.
  IntColumn get carAssetId => integer().nullable().references(
    FixedAssets,
    #id,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get vehicleMakeModel => text()();
  TextColumn get vehicleLicensePlate => text()();
  TextColumn get departureAddress => text()();
  TextColumn get arrivalAddress => text()();
  IntColumn get odometerStart => integer()();
  IntColumn get odometerEnd => integer()();
  TextColumn get tripType => textEnum<TripType>()();
  TextColumn get purpose => text()();
  BoolColumn get routeDeviation =>
      boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
}
