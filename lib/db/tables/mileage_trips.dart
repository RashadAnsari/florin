import 'package:drift/drift.dart';

class MileageTrips extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get vehicleMakeModel => text()();
  TextColumn get vehicleLicensePlate => text()();
  TextColumn get departureAddress => text()();
  TextColumn get arrivalAddress => text()();
  IntColumn get odometerStart => integer()();
  IntColumn get odometerEnd => integer()();
  IntColumn get distanceKm => integer()();
  TextColumn get tripType => text().withDefault(const Constant('Business'))();
  TextColumn get purpose => text()();
  BoolColumn get routeDeviation =>
      boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  IntColumn get fiscalYear => integer()();
}
