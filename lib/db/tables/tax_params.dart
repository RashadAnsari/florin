import 'package:drift/drift.dart';

class TaxParams extends Table {
  IntColumn get year => integer()();
  IntColumn get zelfstandigenaftrek => integer()();
  IntColumn get startersaftrek => integer()();
  RealColumn get mkbWinstvrijstellingPct => real()();
  RealColumn get bracket1Rate => real()();
  IntColumn get bracket1Threshold => integer()();
  RealColumn get bracket2Rate => real()();
  IntColumn get bracket2Threshold => integer()();
  RealColumn get bracket3Rate => real()();
  IntColumn get algHeffingskortingMax => integer()();
  IntColumn get arbeidskortingMax => integer()();
  RealColumn get zvwRate => real()();
  IntColumn get zvwMax => integer()();
  IntColumn get mixedCostsThreshold => integer()();
  RealColumn get mixedCosts80Pct => real()();
  RealColumn get jaarruimtePct => real()();
  IntColumn get jaarruimteMax => integer()();
  IntColumn get aowFranchise => integer()();
  IntColumn get reserveringsruimteMax => integer()();
  RealColumn get factorAMultiplier => real()();
  IntColumn get kiaLowerThreshold => integer()();
  IntColumn get kiaUpperThreshold => integer()();
  IntColumn get kiaFlatThreshold => integer()();
  RealColumn get kiaRate => real()();
  IntColumn get kiaFlatAmount => integer()();
  RealColumn get kiaDecreaseRate =>
      real().withDefault(const Constant(0.0756))();
  IntColumn get urencriteriumThreshold =>
      integer().withDefault(const Constant(1225))();
  RealColumn get mileageRatePerKm => real()();
  IntColumn get korThreshold => integer()();
  IntColumn get ossThreshold => integer()();
  RealColumn get belastingrentePct => real()();

  @override
  Set<Column> get primaryKey => {year};
}
