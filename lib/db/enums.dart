// Stored by name through `textEnum`. Renaming or removing a value changes
// stored data and needs a schema migration.

enum InvoiceType { invoice, creditNote }

enum InvoiceStatus { draft, sent, paid }

/// How BTW applies to a whole invoice. Decides the rubriek in the return.
enum VatTreatment {
  /// Dutch BTW per line (rubrieken 1a, 1b, 1e).
  standard,

  /// Binnenlandse verleggingsregeling: the Dutch customer pays (rubriek 1e).
  reverseChargeNl,

  /// Services to a business in another EU country, BTW verlegd (rubriek 3b).
  euServices,

  /// Intracommunautaire levering of goods at 0% (rubriek 3b).
  euGoods,

  /// Export of goods outside the EU at 0% (rubriek 3a).
  exportOutsideEu,

  /// Services to a business outside the EU, taxed where the customer is
  /// (Wet OB 1968 art. 6 lid 1). Not reported in the Dutch return.
  servicesOutsideEu,

  /// Exempt under the kleineondernemersregeling (Wet OB 1968 art. 25a): no
  /// BTW and no mention of it on the invoice.
  kor,
}

/// BTW rate on an invoice line or expense (Wet OB 1968 art. 9 and 11).
enum VatRate {
  high(0.21),
  low(0.09),
  zero(0),
  exempt(0);

  final double rate;

  const VatRate(this.rate);

  int vatOn(int amountExclVat) => (amountExclVat * rate).round();
}

enum ExpenseCategory {
  office,
  travel,
  foodAndRepresentation,
  software,
  hardware,
  marketing,
  professionalServices,
  phoneAndInternet,
  insurance,
  training,
  other,
}

enum TripType { business, commute, private }

enum WorkType { billable, nonBillable, administrative, wbso, other }

enum WetDbaRisk { low, medium, high }

enum AssetKind { general, car }

/// Milieu-investeringsaftrek category (Wet IB 2001 art. 3.42a lid 3).
enum MiaCategory { one, two, three }

/// Zero-emission drive, which lowers the private-use addition for a car
/// (Wet IB 2001 art. 3.20 lid 2). Hydrogen and integrated solar have no cap.
enum ZeroEmission { none, battery, hydrogenOrSolar }

/// Who accounts for the BTW on a purchase. Shifted BTW is reported by the
/// buyer and deducted again (rubrieken 2a, 4a, 4b and 5b).
enum PurchaseVat { domestic, reverseChargeNl, fromEu, fromOutsideEu }
