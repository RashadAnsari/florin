import 'package:drift/drift.dart';

/// Facts for one year that the bookkeeping does not show.
class TaxYearInputs extends Table {
  IntColumn get year => integer()();

  /// Hours the fiscal partner worked in the business unpaid or for less than
  /// the pay the rules allow (meewerkaftrek).
  IntColumn get partnerHours => integer().withDefault(const Constant(0))();
  BoolColumn get hasSoVerklaring =>
      boolean().withDefault(const Constant(false))();

  /// Not an ondernemer in one of the previous years the rules name and at
  /// most the S&O-verklaringen they allow in that period (art. 3.77 lid 2).
  BoolColumn get soStarter => boolean().withDefault(const Constant(false))();

  /// The whole business stopped this year (stakingsaftrek).
  BoolColumn get businessCeased =>
      boolean().withDefault(const Constant(false))();
  IntColumn get stakingsaftrekUsedBefore =>
      integer().withDefault(const Constant(0))();

  /// A disability benefit this year (startersaftrek bij arbeidsongeschiktheid).
  BoolColumn get disabilityBenefit =>
      boolean().withDefault(const Constant(false))();

  /// Years in the previous ones the rules name in which this startersaftrek
  /// was used, up to the number of its amounts, which means none is left.
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

  /// Not an ondernemer in one or more of the previous years the rules name,
  /// which lifts the time condition of the urencriterium (art. 3.6 lid 1 b)
  /// and is a condition of the startersaftrek bij arbeidsongeschiktheid
  /// (art. 3.78a lid 1).
  BoolColumn get notOndernemerBefore =>
      boolean().withDefault(const Constant(false))();

  /// Eligible for the startersaftrek this year: [notOndernemerBefore] and
  /// the zelfstandigenaftrek applied at most the times the rules allow in
  /// those years (art. 3.76 lid 3). Kept false while [notOndernemerBefore]
  /// is off.
  BoolColumn get isStarter => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {year};
}
