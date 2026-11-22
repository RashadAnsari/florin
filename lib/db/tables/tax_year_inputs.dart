import 'package:drift/drift.dart';

/// Facts for one year that the bookkeeping does not show.
class TaxYearInputs extends Table {
  IntColumn get year => integer()();

  /// Hours the fiscal partner worked in the business unpaid or for less than
  /// € 5.000 (meewerkaftrek).
  IntColumn get partnerHours => integer().withDefault(const Constant(0))();
  BoolColumn get hasSoVerklaring =>
      boolean().withDefault(const Constant(false))();

  /// Not an ondernemer in one of the five previous years and at most two
  /// S&O-verklaringen in that period (art. 3.77 lid 2).
  BoolColumn get soStarter => boolean().withDefault(const Constant(false))();

  /// The whole business stopped this year (stakingsaftrek).
  BoolColumn get businessCeased =>
      boolean().withDefault(const Constant(false))();
  IntColumn get stakingsaftrekUsedBefore =>
      integer().withDefault(const Constant(0))();

  /// A disability benefit this year (startersaftrek bij arbeidsongeschiktheid).
  BoolColumn get disabilityBenefit =>
      boolean().withDefault(const Constant(false))();

  /// Years in the previous five this startersaftrek was used: 0 to 3.
  IntColumn get disabilityStartersUsed =>
      integer().withDefault(const Constant(0))();

  /// Niet-gerealiseerde zelfstandigenaftrek from earlier years.
  IntColumn get unrealisedZelfstandigenaftrek =>
      integer().withDefault(const Constant(0))();

  /// Box 1 losses from earlier years still to offset.
  IntColumn get lossCarryForward => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {year};
}
