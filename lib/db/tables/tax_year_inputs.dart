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

  /// Also working as an employee this year. The fields below are kept at 0
  /// while this is off.
  BoolColumn get employed => boolean().withDefault(const Constant(false))();

  /// Loon from every jaaropgaaf of the year, in cents.
  IntColumn get wages => integer().withDefault(const Constant(0))();

  /// Loonheffing the employers withheld, a voorheffing (art. 9.2 lid 1 a).
  IntColumn get wageTaxWithheld => integer().withDefault(const Constant(0))();

  /// Loon Zorgverzekeringswet, on which the employers paid the
  /// werkgeversheffing; it lowers the maximum bijdrage-inkomen (Zvw art. 43
  /// lid 5).
  IntColumn get zvwWages => integer().withDefault(const Constant(0))();

  /// Hours worked as an employee in the year, for the urencriterium's
  /// condition that most working time goes to the business (art. 3.6 lid 1 a).
  IntColumn get employmentHours => integer().withDefault(const Constant(0))();

  /// Not an ondernemer in one or more of the five previous years, which
  /// lifts that condition (art. 3.6 lid 1 b).
  BoolColumn get notOndernemerBefore =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {year};
}
