import 'package:drift/drift.dart';

class FixedAssets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fiscalYear => integer()();
  TextColumn get assetName => text()();
  IntColumn get costExclVat => integer()();
  DateTimeColumn get purchaseDate => dateTime()();
  RealColumn get businessUsePct => real().withDefault(const Constant(1.0))();
  IntColumn get usefulLifeYears => integer()();
  BoolColumn get kiaEligible => boolean().withDefault(const Constant(false))();
  BoolColumn get eiaOrMia => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get disposalDate => dateTime().nullable()();
  IntColumn get disposalProceeds => integer().nullable()();
}
