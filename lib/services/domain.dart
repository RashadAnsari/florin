import '../db/database.dart';

/// Today if it falls in [year], otherwise the nearest day of that year.
DateTime todayIn(int year) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  if (today.year < year) return DateTime(year);
  if (today.year > year) return DateTime(year, 12, 31);
  return today;
}

/// Calendar quarter 1 to 4 of [date].
int quarterOf(DateTime date) => (date.month - 1) ~/ 3 + 1;

extension InvoiceDomain on Invoice {
  /// Issued invoices count for revenue and BTW; drafts do not.
  bool get isIssued => status != InvoiceStatus.draft;

  DateTime get dueDate => invoiceDate.add(Duration(days: paymentTermDays));

  bool get isOverdue =>
      status == InvoiceStatus.sent && dueDate.isBefore(DateTime.now());
}

extension VatTreatmentDomain on VatTreatment {
  /// Whether the invoice must show the customer's BTW number: Wet OB 1968
  /// art. 35a lid 1 d for reverse charge, and the Belastingdienst's extra
  /// invoice requirements for EU goods and services (`docs/legal.md`).
  bool get needsCustomerVatNumber =>
      this == VatTreatment.reverseChargeNl ||
      this == VatTreatment.euServices ||
      this == VatTreatment.euGoods;
}

extension MileageTripDomain on MileageTrip {
  int get distanceKm => odometerEnd - odometerStart;
}

extension HourEntryDomain on HourEntry {
  bool get billable => workType == WorkType.billable;
}
