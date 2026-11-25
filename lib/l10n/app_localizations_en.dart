// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Florin';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navInvoices => 'Invoices';

  @override
  String get navClients => 'Clients';

  @override
  String get navExpenses => 'Expenses';

  @override
  String get navVatReturn => 'VAT Return';

  @override
  String get navPlTax => 'P&L & Tax';

  @override
  String get navHours => 'Hours';

  @override
  String get navMileage => 'Mileage';

  @override
  String get navAssets => 'Assets';

  @override
  String get navPension => 'Pension';

  @override
  String get navSettings => 'Settings';

  @override
  String get navYear => 'Year:';

  @override
  String get actionSave => 'Save';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get labelDate => 'Date';

  @override
  String get labelNotes => 'Notes';

  @override
  String get labelCategory => 'Category';

  @override
  String get labelAll => 'All';

  @override
  String get labelSearch => 'Search…';

  @override
  String dashboardTitle(int year) {
    return 'Dashboard $year';
  }

  @override
  String get dashboardNetRevenue => 'Net revenue';

  @override
  String get dashboardDeductibleCosts => 'Costs (deductible)';

  @override
  String get dashboardEstimatedTax => 'Estimated tax';

  @override
  String dashboardEffectiveRate(String rate) {
    return 'Effective $rate%';
  }

  @override
  String get dashboardNetProfitAfterTax => 'Estimated net profit after tax';

  @override
  String get dashboardOutstandingInvoices => 'Outstanding invoices';

  @override
  String dashboardInvoiceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count invoices',
      one: '1 invoice',
    );
    return '$_temp0';
  }

  @override
  String get dashboardUrencriterium => 'Urencriterium';

  @override
  String get dashboardUrencriteriumHelp =>
      'The hours you worked for the business this year against the urencriterium. The zelfstandigenaftrek and most other deductions for business owners require it (Wet IB 2001 art. 3.76). All business hours count, not only billable ones. With a job, the business must also take more of your time than the job (art. 3.6).';

  @override
  String get dashboardBtwDeadlines => 'VAT deadlines';

  @override
  String get dashboardMonthlyRevenue => 'Monthly revenue';

  @override
  String get deadlineStatusFiled => 'filed';

  @override
  String get deadlineStatusOverdue => 'overdue';

  @override
  String deadlineDaysLeft(int days) {
    return '$days d';
  }

  @override
  String genericLoadError(String error) {
    return 'Could not load data: $error';
  }

  @override
  String get invoicesTitle => 'Invoices';

  @override
  String get invoicesNewTooltip => 'New invoice';

  @override
  String get invoicesNone => 'No invoices';

  @override
  String get invoicesNewHeader => 'New invoice';

  @override
  String get invoicesFilterAll => 'All';

  @override
  String get invoicesFilterOverdue => 'Overdue';

  @override
  String get invoiceStatusConcept => 'Draft';

  @override
  String get invoiceStatusSent => 'Sent';

  @override
  String get invoiceStatusPaid => 'Paid';

  @override
  String get invoiceStatusOverdue => 'Overdue';

  @override
  String get invoiceTypeInvoice => 'Invoice';

  @override
  String get invoiceTypeCreditNote => 'Credit note';

  @override
  String get invoiceFieldClient => 'Client';

  @override
  String get invoiceFieldNumber => 'Invoice number';

  @override
  String get invoiceFieldInvoiceDate => 'Invoice date';

  @override
  String get invoiceFieldSupplyDate => 'Supply date';

  @override
  String get invoiceFieldPaymentTerm => 'Term (days)';

  @override
  String get invoiceValidatePaymentTerm =>
      'Enter a whole number of days (e.g. 14 or 30)';

  @override
  String get invoiceFieldDueDate => 'Due date';

  @override
  String get invoiceFieldLines => 'Lines';

  @override
  String get invoiceFieldAddLine => 'Add line';

  @override
  String get invoiceFieldDescription => 'Description';

  @override
  String get invoiceFieldQuantity => 'Qty';

  @override
  String get invoiceFieldUnit => 'Unit';

  @override
  String get invoiceFieldPrice => 'Price (excl.)';

  @override
  String get invoiceFieldVat => 'VAT';

  @override
  String get invoiceValidateLineDescription => 'Enter a line description';

  @override
  String get invoiceValidateLineQuantity =>
      'Enter a quantity greater than zero';

  @override
  String get invoiceValidateLinePrice => 'Enter a valid unit price';

  @override
  String get invoiceSubtotal => 'Subtotal (excl. VAT)';

  @override
  String get invoiceTotalInclVat => 'Total (incl. VAT)';

  @override
  String get invoiceFieldRemarks => 'Remarks';

  @override
  String get invoiceActionSend => 'Send';

  @override
  String get invoiceActionMarkPaid => 'Paid';

  @override
  String get invoiceActionExportPdf => 'Export PDF';

  @override
  String get invoiceDeleteTitle => 'Delete invoice';

  @override
  String invoiceDeleteMessage(String number) {
    return 'Are you sure you want to delete invoice \"$number\"?';
  }

  @override
  String get invoiceValidateClient => 'Select a client for this invoice';

  @override
  String get invoiceValidateNumber =>
      'Enter a unique invoice number, e.g. F-2026-001';

  @override
  String get invoiceUnitHint => 'hrs';

  @override
  String get clientsTitle => 'Clients';

  @override
  String get clientsNewTooltip => 'New client';

  @override
  String get clientsNone => 'No clients';

  @override
  String get clientsNewHeader => 'New client';

  @override
  String get clientsFilterAll => 'All';

  @override
  String get clientsFilterActive => 'Active';

  @override
  String get clientsFilterInactive => 'Inactive';

  @override
  String get clientsInactive => 'Inactive';

  @override
  String clientsPaidInYear(int year, String amount) {
    return 'Paid in $year: $amount';
  }

  @override
  String clientsDbaBadge(String risk) {
    return 'Wet DBA: $risk';
  }

  @override
  String get clientsFieldName => 'Name';

  @override
  String get clientsValidateName => 'Enter the client\'s name';

  @override
  String get clientsFieldCountry => 'Country';

  @override
  String get clientsValidateCountry =>
      'Use a 2-letter country code (e.g. NL, DE, FR): it decides which VAT treatments an invoice to this client can use.';

  @override
  String get clientsFieldVat => 'VAT number';

  @override
  String get clientsValidateVat =>
      'Enter a valid EU VAT number, e.g. NL123456789B01 or DE123456789';

  @override
  String get clientsFieldKvk => 'KVK number';

  @override
  String get clientsValidateKvk => 'KVK number must be exactly 8 digits';

  @override
  String get clientsFieldAddress => 'Address';

  @override
  String get clientsValidateAddress => 'Enter the client\'s street address';

  @override
  String get clientsFieldContact => 'Contact person';

  @override
  String get clientsFieldEmail => 'E-mail';

  @override
  String get clientsValidateEmail =>
      'Enter a valid email address (e.g. name@company.nl)';

  @override
  String get clientsValidatePhone => 'Digits, spaces, + and dashes only';

  @override
  String get clientsFieldPhone => 'Phone';

  @override
  String get clientsFieldActive => 'Active';

  @override
  String get clientsFieldNotes => 'Notes';

  @override
  String get clientsWetDba => 'Wet DBA';

  @override
  String get clientsWetDbaHelp =>
      'How you judge this working relationship under the Wet DBA (Wet deregulering beoordeling arbeidsrelaties), with the contract that goes with it. Florin keeps your judgement and the contract date; it does not assess the relationship.';

  @override
  String get clientsRiskLevel => 'Risk level';

  @override
  String get clientsRiskLow => 'Low';

  @override
  String get clientsRiskMedium => 'Medium';

  @override
  String get clientsRiskHigh => 'High';

  @override
  String get clientsContractSigned => 'Contract signed';

  @override
  String get clientsContractExpiry => 'Contract expiry date';

  @override
  String get clientsHighRiskWarning =>
      'High Wet DBA risk in your own assessment: if the work is employment in law, the Belastingdienst treats it as such.';

  @override
  String get clientsDeleteTitle => 'Delete client';

  @override
  String clientsDeleteMessage(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get clientsDeleteBlockedTooltip =>
      'Client has invoices and cannot be deleted';

  @override
  String get expensesTitle => 'Expenses';

  @override
  String get expensesNewTooltip => 'New expense';

  @override
  String get expensesNone => 'No expenses';

  @override
  String get expensesNewHeader => 'New expense';

  @override
  String get expensesFieldSupplier => 'Supplier';

  @override
  String get expensesHintSupplier => 'e.g. Albert Heijn, Amazon, KPN';

  @override
  String get expensesValidateSupplier => 'Enter the supplier name';

  @override
  String get expensesFieldCategory => 'Category';

  @override
  String get expensesValidateCategory => 'Select a category for this expense';

  @override
  String get expensesFieldDescription => 'Description';

  @override
  String get expensesValidateDescription =>
      'Enter a description for this expense';

  @override
  String get expensesFieldAmountExcl => 'Amount (excl. VAT)';

  @override
  String get expensesValidateAmount =>
      'Enter the amount excluding VAT, above zero: it is the cost Florin deducts from your profit.';

  @override
  String get expensesFieldVatRate => 'VAT rate';

  @override
  String get expensesFieldVat => 'VAT';

  @override
  String get expensesFieldTotalIncl => 'Total (incl. VAT)';

  @override
  String get expensesFieldPaidFrom => 'Paid from';

  @override
  String get expensesHintPaidFrom => 'e.g. ING business account, Visa card';

  @override
  String get expensesFieldPaymentRef => 'Payment reference';

  @override
  String get expensesHintPaymentRef => 'e.g. INV-2026-0042, SEPA ref 123456';

  @override
  String get expensesBusinessUse => 'Business use';

  @override
  String expensesBusinessUsePct(int pct) {
    return '$pct% business';
  }

  @override
  String get expensesDeductible => 'Deductible';

  @override
  String get expensesReclaimVat => 'Reclaim VAT';

  @override
  String get expensesVatBack => 'VAT back';

  @override
  String get expensesDeleteTitle => 'Delete expense';

  @override
  String get expensesDeleteMessage =>
      'Are you sure you want to delete this expense?';

  @override
  String get expenseCatOffice => 'Office & supplies';

  @override
  String get expenseCatTravel => 'Travel & accommodation';

  @override
  String get expenseCatMeals => 'Food, drinks, representation and congresses';

  @override
  String get expenseCatSoftware => 'Software & subscriptions';

  @override
  String get expenseCatHardware => 'Hardware & equipment';

  @override
  String get expenseCatMarketing => 'Marketing & advertising';

  @override
  String get expenseCatProfessional => 'Professional services';

  @override
  String get expenseCatPhone => 'Phone & internet';

  @override
  String get expenseCatInsurance => 'Insurance';

  @override
  String get expenseCatTraining => 'Training & education';

  @override
  String get expenseCatCourseTravel =>
      'Travel and stay for courses and congresses';

  @override
  String get expenseCatClothingAndCare => 'Clothing and personal care';

  @override
  String get expenseCatHomePhoneLine => 'Phone line at home';

  @override
  String get expenseCatGeneralLiterature =>
      'Books other than professional literature';

  @override
  String get expenseCatFines => 'Fines';

  @override
  String get expenseCatOther => 'Other';

  @override
  String get hoursTitle => 'Hour registration';

  @override
  String get hoursNone => 'No hours registered';

  @override
  String hoursBillable(String hours) {
    return 'Billable: $hours hrs';
  }

  @override
  String get hoursUnitShort => 'hrs';

  @override
  String hoursProgress(String total, String target) {
    return '$total / $target hrs';
  }

  @override
  String get hoursUrencriteriumOk => 'Urencriterium OK';

  @override
  String hoursUrencriteriumLeft(String left) {
    return '$left hrs to go';
  }

  @override
  String hoursUrencriteriumJob(int hours) {
    return 'Not more than $hours hrs in employment';
  }

  @override
  String get hoursFieldDate => 'Date';

  @override
  String get hoursFieldHours => 'Hours';

  @override
  String get hoursFieldDescription => 'Description';

  @override
  String get hoursFieldWorkType => 'Work type';

  @override
  String get hoursFieldClientProject => 'Client / project';

  @override
  String get hoursFieldNotes => 'Notes';

  @override
  String get hoursNewEntry => 'New entry';

  @override
  String get hoursDeleteTitle => 'Delete hour entry';

  @override
  String hoursDeleteMessage(String description) {
    return 'Are you sure you want to delete \"$description\"?';
  }

  @override
  String get hoursValidateHours =>
      'Enter the hours worked: more than 0 and at most 24';

  @override
  String get hoursValidateDescription => 'Describe the work done';

  @override
  String get workTypeBillable => 'Billable';

  @override
  String get workTypeNonBillable => 'Non-billable';

  @override
  String get workTypeAdministrative => 'Administrative';

  @override
  String get workTypeWbso => 'WBSO';

  @override
  String get workTypeOther => 'Other';

  @override
  String get mileageTitle => 'Mileage registration';

  @override
  String get mileageNone => 'No trips registered';

  @override
  String get mileageBusiness => 'Business';

  @override
  String get mileageTotal => 'Total';

  @override
  String get mileageUnitKm => 'km';

  @override
  String mileageRoute(String from, String to) {
    return '$from to $to';
  }

  @override
  String mileageAllowance(String rate) {
    return 'Allowance ($rate / km)';
  }

  @override
  String get mileageFieldDate => 'Date';

  @override
  String get mileageFieldMakeModel => 'Make / model';

  @override
  String get mileageFieldPlate => 'Licence plate';

  @override
  String get mileageFieldFrom => 'Departure address';

  @override
  String get mileageFieldTo => 'Arrival address';

  @override
  String get mileageFieldOdoStart => 'Odometer start';

  @override
  String get mileageFieldOdoEnd => 'Odometer end';

  @override
  String get mileageFieldOdoError =>
      'End reading must be higher than start reading';

  @override
  String get mileageValidateMakeModel => 'Enter the vehicle make and model';

  @override
  String get mileageValidatePlate => 'Enter the vehicle licence plate';

  @override
  String get mileageValidateFrom => 'Enter the departure address';

  @override
  String get mileageValidateTo => 'Enter the arrival address';

  @override
  String get mileageValidateOdoStart => 'Enter the starting odometer reading';

  @override
  String get mileageValidateOdoEnd => 'Enter the ending odometer reading';

  @override
  String get mileageValidatePurpose => 'Describe the purpose of this trip';

  @override
  String get mileageFieldDistance => 'Distance';

  @override
  String get mileageFieldTripType => 'Trip type';

  @override
  String get mileageFieldPurpose => 'Purpose';

  @override
  String get mileageFieldRouteDeviation => 'Detour / non-direct route';

  @override
  String get mileageFieldNotes => 'Notes';

  @override
  String get mileageNewTrip => 'New trip';

  @override
  String get mileageDeleteTitle => 'Delete trip';

  @override
  String mileageDeleteMessage(String purpose) {
    return 'Are you sure you want to delete \"$purpose\"?';
  }

  @override
  String get tripTypeBusiness => 'Business';

  @override
  String get tripTypeCommute => 'Commute';

  @override
  String get tripTypePrivate => 'Private';

  @override
  String get assetsTitle => 'Fixed assets';

  @override
  String get assetsNone => 'No assets registered';

  @override
  String get assetsKiaInvestments => 'KIA investments';

  @override
  String get assetsKiaDeduction => 'KIA deduction';

  @override
  String get assetsDepreciationThisYear => 'Depreciation this year';

  @override
  String get assetsFieldName => 'Asset name';

  @override
  String get assetsFieldCost => 'Cost excl. VAT';

  @override
  String get assetsFieldPurchaseDate => 'Purchase date';

  @override
  String get assetsFieldUsefulLife => 'Useful life';

  @override
  String get assetsFieldUsefulLifeUnit => 'yrs';

  @override
  String assetsFieldUsefulLifeMin(int years, String pct) {
    return 'Enter at least $years years: depreciation is limited to $pct of the cost a year';
  }

  @override
  String get assetsValidateName => 'Enter the asset name';

  @override
  String get assetsValidateCost =>
      'Enter the cost excluding VAT, above zero: depreciation is calculated from it.';

  @override
  String get assetsFieldKia => 'KIA eligible';

  @override
  String get assetsKiaBadge => 'KIA';

  @override
  String get assetsSoldBadge => 'Sold';

  @override
  String assetsBookValueTooltip(int year) {
    return 'Book value at the end of $year';
  }

  @override
  String get assetsFieldNotes => 'Notes';

  @override
  String get assetsDisposal => 'Disposal';

  @override
  String get assetsFieldDisposalDate => 'Disposal date';

  @override
  String get assetsFieldDisposalProceeds => 'Proceeds excl. VAT';

  @override
  String get assetsClearDisposalDate => 'Clear disposal date';

  @override
  String get assetsDeleteTitle => 'Delete asset';

  @override
  String assetsDeleteMessage(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get assetsNewAsset => 'New asset';

  @override
  String assetsYears(int n) {
    return '$n yrs';
  }

  @override
  String get pensionTitle => 'Pension';

  @override
  String get pensionJaarruimte => 'Annual allowance calculation';

  @override
  String get pensionAowFranchise => 'AOW franchise';

  @override
  String get pensionPensioengrondslag => 'Pension base';

  @override
  String pensionJaarruimteMax(String max) {
    return 'Annual allowance (max $max)';
  }

  @override
  String get pensionReserveringsruimte => 'Unused annual allowance';

  @override
  String get pensionTotalBudget => 'Total available';

  @override
  String get pensionEstimatedTaxSaving => 'Estimated tax saving';

  @override
  String get pensionInputSection => 'Input';

  @override
  String get pensionFactorA => 'Factor A';

  @override
  String get pensionReserveringsruimteLabel => 'Reserveringsruimte';

  @override
  String get pensionPlannedSection => 'Planned contribution';

  @override
  String get pensionLijfrente => 'Annuity premium / AOV premium';

  @override
  String get pensionAovSection => 'AOV disability insurance';

  @override
  String get pensionAovInsured => 'AOV insured';

  @override
  String get pensionMonthlyPremium => 'Monthly premium';

  @override
  String pensionAnnualPremium(String amount) {
    return 'Annual premium: $amount';
  }

  @override
  String get vatReturnTitle => 'VAT return';

  @override
  String get vatReturnRevenueSection => 'Revenue';

  @override
  String get vatReturnCalculationSection => 'VAT calculation';

  @override
  String get vatReturnIcpSection => 'ICP report';

  @override
  String get vatReturnStatusSection => 'Processing status';

  @override
  String get vatReturnFiled => 'Return filed';

  @override
  String get vatReturnPaid => 'VAT paid';

  @override
  String get vatReturnDue => 'VAT due';

  @override
  String get vatReturnRefund => 'VAT refund';

  @override
  String vatRow1a(String rate) {
    return '1a  Supplies / services taxed at $rate';
  }

  @override
  String vatRow1b(String rate) {
    return '1b  Supplies / services taxed at $rate';
  }

  @override
  String get vatRow3a => '3a  Supplies to countries outside the EU (export)';

  @override
  String get vatRow5a => '5a  VAT on revenue';

  @override
  String get vatRow5b => '5b  Input tax (to reclaim)';

  @override
  String get plTaxTitle => 'P&L and estimated tax';

  @override
  String get plTaxRevenuSection => 'Revenue';

  @override
  String get plTaxGrossRevenue => 'Gross revenue (excl. VAT)';

  @override
  String get plTaxCreditNotes => 'Less: credit notes';

  @override
  String get plTaxNetRevenue => 'Net revenue';

  @override
  String get plTaxCostsSection => 'Costs';

  @override
  String plTaxMileageAllowance(int km, String rate) {
    return 'Business kilometres ($km km × $rate)';
  }

  @override
  String get plTaxDepreciation => 'Depreciation';

  @override
  String get plTaxTotalCosts => 'Total costs';

  @override
  String get plTaxGrossProfit => 'Gross profit';

  @override
  String get plTaxDeductionsSection => 'Entrepreneur deductions';

  @override
  String plTaxZelfstandigenaftrek(int year) {
    return 'Zelfstandigenaftrek $year';
  }

  @override
  String get plTaxStartersaftrek => 'Startersaftrek';

  @override
  String plTaxMkb(String pct) {
    return 'SME profit exemption ($pct%)';
  }

  @override
  String get plTaxKia => 'KIA deduction';

  @override
  String get plTaxLijrente => 'Annuity deduction';

  @override
  String get plTaxTaxableProfit => 'Taxable income';

  @override
  String get plTaxBox1Section => 'Income tax box 1, estimated';

  @override
  String get plTaxAlgHeffing => 'General tax credit';

  @override
  String get plTaxArbeidskorting => 'Labour tax credit';

  @override
  String get plTaxTariefaanpassing => 'Tariefaanpassing';

  @override
  String get plTaxTariefaanpassingHelp =>
      'The ondernemersaftrek and the mkb-winstvrijstelling lower your tax at most at the rate below the top bracket. For the part of them that falls in the top bracket, the difference is added back (Wet IB 2001 art. 2.10 lid 2).';

  @override
  String get plTaxInkomsten => 'Income tax';

  @override
  String plTaxZvw(String pct) {
    return 'ZVW contribution ($pct%)';
  }

  @override
  String get plTaxTotalTax => 'Estimated total tax';

  @override
  String get plTaxWageTaxWithheld => 'Loonheffing withheld';

  @override
  String get plTaxWageTaxWithheldHelp =>
      'The loonbelasting and premie volksverzekeringen your employers withheld, as you entered below. The return settles it against the tax above.';

  @override
  String get plTaxToPay => 'Estimated tax to pay';

  @override
  String get plTaxRefund => 'Estimated refund';

  @override
  String get plTaxToPayHelp =>
      'Estimated: the total tax minus the loonheffing withheld. Payments on a voorlopige aanslag are not subtracted.';

  @override
  String get plTaxNetProfit => 'Estimated net profit after tax';

  @override
  String get plTaxNetProfitHelp =>
      'Estimated: gross profit minus the tax the business adds. With wages, that is the total tax minus the tax on the wages alone.';

  @override
  String plTaxEffectiveRate(String rate) {
    return 'Effective rate on the profit: $rate%';
  }

  @override
  String get plTaxProvisionalSection =>
      'Voorlopige aanslag and toeslagen (estimated)';

  @override
  String get plTaxProvisionalSectionHelp =>
      'Estimated figures from your records for the income you give the Belastingdienst during the year: when you ask for or change a voorlopige aanslag, and when you estimate your income for toeslagen. They are estimates and include only what Florin holds.';

  @override
  String get plTaxProvisionalProfit => 'Estimated belastbare winst';

  @override
  String get plTaxProvisionalProfitHelp =>
      'The profit after the ondernemersaftrek and the mkb-winstvrijstelling, as estimated above. The Belastingdienst lets you deduct the ondernemersaftrek you are entitled to when you estimate your income for toeslagen.';

  @override
  String get plTaxProvisionalIncome => 'Estimated taxable income box 1';

  @override
  String get plTaxProvisionalIncomeHelp =>
      'For toeslagen the Belastingdienst uses your toetsingsinkomen: your verzamelinkomen, not your profit, plus that of a toeslagpartner. This figure is box 1 from your records only; income Florin does not hold, such as box 3, is not in it. The Belastingdienst advises estimating a little high, because too low an income can mean paying toeslag back.';

  @override
  String get plTaxProvisionalTax => 'Estimated tax to pay for the year';

  @override
  String get plTaxProvisionalTaxHelp =>
      'Box 1 tax and the Zvw contribution, minus loonheffing already withheld, as estimated above. A voorlopige aanslag spreads this over the year so the final assessment brings no large bill.';

  @override
  String plTaxProvisionalDeadline(int year, String date) {
    return 'You can ask for or change a voorlopige aanslag for $year until $date. With a letter asking you to file a return, the date in that letter or your uitstel applies; once you have filed the return, you can no longer.';
  }

  @override
  String plTaxUrenBanner(String hours, String target, String suffix) {
    return 'Urencriterium: $hours of $target hours logged$suffix.';
  }

  @override
  String get plTaxUrenBannerSuffixDone => ', so no zelfstandigenaftrek';

  @override
  String get plTaxUrenBannerSuffixPending =>
      '. Until you reach it, the estimate leaves out the zelfstandigenaftrek and the other deductions that need it';

  @override
  String plTaxUrenJobBanner(String hours, int jobHours) {
    return 'Urencriterium: $hours hours logged for the business, not more than the $jobHours hours in employment. The urencriterium needs more time in the business than in other work, so the estimate leaves out the zelfstandigenaftrek and the other deductions that need it.';
  }

  @override
  String get settingsLanguageSection => 'Language';

  @override
  String get settingsLanguageNl => 'Dutch';

  @override
  String get settingsLanguageEn => 'English';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsBusinessSection => 'Business details';

  @override
  String get settingsBusinessName => 'Business name';

  @override
  String get settingsVatNumber => 'VAT number';

  @override
  String get settingsKvkNumber => 'KVK number';

  @override
  String get settingsBusinessAddress => 'Business address';

  @override
  String get settingsIban => 'IBAN';

  @override
  String get settingsValidateName => 'Enter your business name';

  @override
  String get settingsValidateVat =>
      'Enter your VAT number, e.g. NL123456789B01.';

  @override
  String get settingsValidateVatFormat =>
      'Invalid VAT number. Format: NL + 9 digits + B + 2 digits, e.g. NL123456789B01.';

  @override
  String get settingsValidateKvk => 'Enter your KVK number.';

  @override
  String get settingsValidateKvkFormat =>
      'KVK number must be exactly 8 digits.';

  @override
  String get settingsValidateAddress => 'Enter your business address';

  @override
  String get settingsValidateIban =>
      'Enter your IBAN, e.g. NL91ABNA0417164300.';

  @override
  String get settingsValidateIbanFormat =>
      'Invalid IBAN format (e.g. NL91ABNA0417164300).';

  @override
  String get settingsDatabaseSection => 'Database';

  @override
  String settingsDatabaseLocation(String path) {
    return 'Location: $path';
  }

  @override
  String get settingsMoveDatabase =>
      'Copy database and receipts to another folder';

  @override
  String get settingsExportSection => 'Export';

  @override
  String settingsExportDescription(int year) {
    return 'Export all $year data to CSV files, with the VAT return of each quarter by rubriek in whole euros, the ICP list of each quarter and the estimated income tax of the year. Florin puts them in a new folder named after the export date, inside the folder you choose.';
  }

  @override
  String settingsExportButton(int year) {
    return 'Export $year as CSV';
  }

  @override
  String get settingsExportRunning => 'Exporting…';

  @override
  String settingsExported(String dir) {
    return 'CSV files exported to: $dir';
  }

  @override
  String settingsTaxSection(int year) {
    return 'Tax rules $year';
  }

  @override
  String get settingsTaxZelfs => 'Zelfstandigenaftrek';

  @override
  String get settingsTaxStarters => 'Startersaftrek';

  @override
  String get settingsTaxMkb => 'MKB-winstvrijstelling (%)';

  @override
  String get settingsTaxMileage => 'Mileage allowance per km';

  @override
  String get settingsTaxZvwRate => 'ZVW rate (%)';

  @override
  String get settingsTaxUrencriterium => 'Urencriterium (hours)';

  @override
  String get firstLaunchWelcome => 'Welcome to Florin';

  @override
  String get firstLaunchSubtitle => 'Set up your bookkeeping workspace.';

  @override
  String get firstLaunchDbSection => 'Database location';

  @override
  String get firstLaunchDbDescription =>
      'Default: the app data folder. Choose another folder to keep it in a synced folder. If that folder already holds a Florin database, Florin opens it.';

  @override
  String firstLaunchDbDefault(String path) {
    return '$path (default)';
  }

  @override
  String get firstLaunchDbDefaultFolder =>
      'The app\'s own data folder (default)';

  @override
  String get firstLaunchChooseFolder => 'Choose folder';

  @override
  String get firstLaunchGetStarted => 'Get started';

  @override
  String firstLaunchSaveError(String error) {
    return 'Could not finish setup: $error';
  }

  @override
  String get deadlineBadgeFiled => 'Filed';

  @override
  String get deadlineBadgeOverdue => 'Overdue';

  @override
  String deadlineBadgeDays(int days) {
    return '$days days';
  }

  @override
  String get vatRate0 => '0%';

  @override
  String get vatRateExempt => 'Exempt';

  @override
  String genericSaveError(String error) {
    return 'Could not save: $error';
  }

  @override
  String get dbLocationChooseFolderDialog =>
      'Choose folder to store Florin database';

  @override
  String get csvExportChooseFolderDialog => 'Choose export folder';

  @override
  String get invoiceSaveAsDialog => 'Save invoice as';

  @override
  String get amountNegativeError =>
      'Enter zero or more. A correction is its own record, such as a credit note.';

  @override
  String get vatTreatmentStandard => 'Dutch VAT';

  @override
  String get vatTreatmentReverseChargeNl =>
      'VAT reverse-charged to a Dutch business';

  @override
  String get vatTreatmentExportOutsideEu =>
      'Export of goods outside the EU (0%)';

  @override
  String get invoiceFieldVatTreatment => 'VAT treatment';

  @override
  String get invoiceValidateClientVat =>
      'This client has no VAT number. Add it to the client: this invoice must show it.';

  @override
  String get invoiceIssueTitle => 'Send invoice';

  @override
  String get invoiceIssueMessage =>
      'After sending, the invoice can no longer be changed or deleted. Corrections are made with a credit note.';

  @override
  String invoiceIssueRenumber(String number, String next) {
    return '$number does not follow the last invoice you issued in this series, so it is sent as $next: invoice numbers follow on without gaps (Wet OB 1968 art. 35a lid 1 b).';
  }

  @override
  String invoiceActionSendAs(String number) {
    return 'Send as $number';
  }

  @override
  String get invoiceActionCreditNote => 'Credit note';

  @override
  String get invoiceNewCreditNoteHeader => 'New credit note';

  @override
  String invoiceCorrects(String number) {
    return 'This credit note corrects invoice $number.';
  }

  @override
  String get invoiceVatTotal => 'VAT';

  @override
  String get invoiceRemoveLine => 'Remove line';

  @override
  String get invoiceLockedNotice =>
      'This invoice is issued, so it cannot be changed. To correct it, make a credit note that refers to it.';

  @override
  String get invoiceLockedCreditNotice =>
      'This credit note is issued, so it cannot be changed.';

  @override
  String expensesFoodNotice(String pct, String drempel) {
    return 'Food, drinks, representation, congresses, seminars and study trips are deductible for income tax at $pct, or as far as they exceed $drempel a year if that is more (Wet IB 2001 art. 3.15). VAT on food and drinks consumed in a restaurant, café or hotel cannot be reclaimed (Wet OB 1968 art. 15).';
  }

  @override
  String expensesCourseTravelNotice(String max) {
    return 'Travel and stay for courses, studies, congresses, seminars and study trips are deductible for income tax up to $max a year; the part above it is not, unless your work makes attending necessary (Wet IB 2001 art. 3.16). Florin keeps the limit, because it cannot tell that from your records.';
  }

  @override
  String get expensesBarredNotice =>
      'The law keeps this cost out of your profit, whatever the amount: fines (Wet IB 2001 art. 3.14), and clothing other than werkkleding, personal care, a phone line in your home and literature other than professional literature (art. 3.16). Florin records it but deducts nothing. Clothing counts as werkkleding when it is only fit to wear for your work or shows that it is meant only for it; record werkkleding under Other.';

  @override
  String plTaxFoodLimited(String category, String amount) {
    return '$category ($amount)';
  }

  @override
  String get plTaxBelastbareWinst => 'Taxable profit';

  @override
  String plTaxBracket(int n, String pct) {
    return 'Bracket $n ($pct%)';
  }

  @override
  String get plTaxEstimateNotice =>
      'This is an estimate for a business owner under the AOW age. Wages from employment count when you enter them below. Income of a partner, from other work, box 2 or box 3 is not included.';

  @override
  String settingsMoved(String path) {
    return 'Database copied to $path and now in use. The old file was kept.';
  }

  @override
  String get settingsTaxVerified =>
      'Florin uses these figures, checked against the Belastingdienst and the law. They cannot be edited.';

  @override
  String settingsTaxUpTo(String amount) {
    return 'up to $amount';
  }

  @override
  String pensionPriorYearIncome(int year) {
    return 'Income from work in $year';
  }

  @override
  String get pensionDeductible => 'Deductible this year';

  @override
  String get vatRow1e =>
      '1e  Supplies / services taxed at 0% or not taxed with you';

  @override
  String get vatRow3b => '3b  Supplies to or services in EU countries';

  @override
  String get vatTreatmentEuServices =>
      'Services to an EU business (VAT reverse-charged)';

  @override
  String get vatTreatmentEuGoods =>
      'Goods to an EU business (intra-Community supply, 0%)';

  @override
  String vatReturnIcpNote(String date, String amount, int quarters) {
    return 'Report these supplies in the ICP report over this quarter by $date. If you supplied goods to EU businesses for more than $amount in this quarter or in one of the $quarters quarters before it, you report goods per month instead (Wet OB 1968 art. 37a).';
  }

  @override
  String get assetsFieldResidualValue => 'Residual value';

  @override
  String get assetsValidateResidualValue =>
      'Enter the residual value, or 0 if the asset will have no value left';

  @override
  String get assetsValidateResidualAboveCost =>
      'The residual value cannot be higher than the cost';

  @override
  String get plTaxDisposalResult => 'Result on sold assets';

  @override
  String get plTaxAov => 'Disability insurance premiums';

  @override
  String get pensionAovHelper =>
      'Premiums for disability insurance are deducted in full in the tax estimate.';

  @override
  String get assetsFieldCostHelp =>
      'The purchase price without VAT. With any VAT you do not reclaim, it is the cost that depreciation and the investment deductions are based on.';

  @override
  String get assetsFieldDisposalDateHelp =>
      'The date you sold the asset or took it out of the business. Depreciation stops on this date.';

  @override
  String get assetsFieldDisposalProceedsHelp =>
      'What you received for the asset, without VAT, or its market value when you took it into private use. The difference with the book value is a gain or loss.';

  @override
  String assetsFieldKiaHelp(String min) {
    return 'Kleinschaligheidsinvesteringsaftrek: an extra deduction for business assets. Assets under $min do not count, and passenger cars and some other assets are excluded.';
  }

  @override
  String get assetsFieldNameHelp =>
      'A name you recognise the asset by, such as \"MacBook Pro 2026\".';

  @override
  String get assetsFieldNotesHelp =>
      'Anything you want to remember about this asset. Not used in calculations.';

  @override
  String get assetsFieldPurchaseDateHelp =>
      'The date you bought the asset. Depreciation starts on this date and the investment deductions apply to this year.';

  @override
  String get assetsFieldResidualValueHelp =>
      'What the asset will still be worth at the end of its useful life. Depreciation stops at this value.';

  @override
  String assetsFieldUsefulLifeHelp(int years, String pct) {
    return 'How many years you expect to use the asset. At least $years, because depreciation is limited to $pct of the cost a year.';
  }

  @override
  String get assetsVatSection => 'VAT on the purchase';

  @override
  String get assetsVatSectionHelp =>
      'The VAT on the purchase invoice. VAT you reclaim goes into the VAT return of the quarter of purchase; VAT you do not reclaim is part of the asset\'s cost.';

  @override
  String get assetsFieldVatRate => 'VAT rate';

  @override
  String assetsFieldVatRateHelp(String high, String low) {
    return 'The VAT rate on the purchase invoice: $high, $low, 0% or exempt. Choose 0% when no VAT was charged, such as on a purchase from a private seller.';
  }

  @override
  String get assetsValidateVatRate =>
      'Choose the VAT rate on the purchase invoice: the VAT in your return depends on it.';

  @override
  String get assetsFieldVatAmount => 'VAT amount';

  @override
  String get assetsFieldVatAmountHelp =>
      'The VAT on the purchase invoice. Florin has no tax rules for the year of purchase, so you enter the amount instead of a rate.';

  @override
  String get assetsFieldPurchaseVat => 'How the VAT was charged';

  @override
  String get assetsFieldPurchaseVatHelp =>
      'Dutch VAT when the supplier charged it. Shifted when the invoice says the VAT is reverse-charged to you, or the supplier is abroad: you then report and deduct the VAT yourself.';

  @override
  String get assetsReclaimVat => 'Reclaim this VAT';

  @override
  String get assetsReclaimVatHelp =>
      'Tick when you may deduct this VAT in your VAT return. You may for the business share used for work you charge VAT on: not while you take part in the KOR, and not for an asset used only for VAT-exempt work.';

  @override
  String get assetsValidateKorReclaim =>
      'You take part in the KOR on the purchase date, so you cannot reclaim this VAT. Untick Reclaim this VAT: the VAT is then part of the cost.';

  @override
  String get assetsKorNotice =>
      'You take part in the KOR on the purchase date. The VAT is not reclaimed; it is part of the cost that depreciation and the investment deductions are based on.';

  @override
  String get assetsFieldVat => 'VAT';

  @override
  String get assetsVatBack => 'VAT back';

  @override
  String get assetsCostForTax => 'Cost for income tax';

  @override
  String get assetsCostForTaxHelp =>
      'The price and any VAT you do not reclaim. Depreciation and the investment deductions are based on it.';

  @override
  String get assetsFieldSaleInvoice => 'Sale invoice';

  @override
  String get assetsFieldSaleInvoiceHelp =>
      'The invoice you issued in Florin for this sale only. Its amount is the proceeds and its VAT is in your VAT return; it does not count as revenue or for the KOR turnover. Choose none for a sale without an invoice in Florin or when you took the asset into private use.';

  @override
  String get assetsSaleInvoiceNone => 'No invoice in Florin';

  @override
  String get assetsProceedsFromInvoiceHelp =>
      'What the sale invoice and any credit note on it come to, without VAT. The difference with the book value is a gain or loss.';

  @override
  String get assetsFieldDisposalVatRate => 'VAT on the sale';

  @override
  String assetsFieldDisposalVatRateHelp(String high) {
    return 'The VAT you owe on the sale, or on taking the asset into private use, over the business share of the proceeds. It goes into the VAT return of that quarter. Usually $high; exempt only when you used the asset solely for VAT-exempt work and deducted no VAT on it.';
  }

  @override
  String get assetsValidateDisposalVatRate =>
      'Choose the VAT rate of the sale: the VAT in your return depends on it.';

  @override
  String get assetsSaleKorNotice =>
      'You take part in the KOR on the sale date, so there is no VAT on the sale.';

  @override
  String get clientsContractExpiryHelp =>
      'When the agreement with this client ends.';

  @override
  String get clientsContractSignedHelp =>
      'Tick when you and the client have signed a written agreement.';

  @override
  String get clientsFieldActiveHelp =>
      'Inactive clients stay in your records but are not offered on new invoices.';

  @override
  String get clientsFieldAddressHelp =>
      'The client\'s full business address. It is printed on every invoice.';

  @override
  String get clientsFieldContactHelp =>
      'The person you deal with at this client.';

  @override
  String get clientsFieldCountryHelp =>
      'The two-letter country code, such as NL or DE. It decides which VAT treatments an invoice to this client can use.';

  @override
  String get clientsFieldEmailHelp => 'The address you send invoices to.';

  @override
  String get clientsFieldKvkHelp =>
      'The client\'s 8-digit Chamber of Commerce number, if they have one.';

  @override
  String get clientsFieldNameHelp =>
      'The client\'s legal or registered trade name, as it should appear on invoices.';

  @override
  String get clientsFieldNotesHelp =>
      'Anything you want to remember about this client. Not printed on invoices.';

  @override
  String get clientsFieldPhoneHelp => 'A phone number for this client.';

  @override
  String get clientsFieldVatHelp =>
      'The client\'s VAT identification number. Required on invoices where the VAT is reverse-charged or that go to an EU business.';

  @override
  String get clientsRiskLevelHelp =>
      'Your own assessment of whether the work could be seen as employment under the Wet DBA. Used only to remind you.';

  @override
  String get expensesFieldAmountExclHelp =>
      'The amount on the receipt without VAT.';

  @override
  String get expensesFieldCategoryHelp =>
      'What kind of cost this is. Food, drinks, representation, congresses, seminars, excursions and study trips are only partly deductible (Wet IB 2001 art. 3.15), travel for courses and congresses only up to a yearly amount, and fines, ordinary clothing, personal care, a phone line at home and general literature not at all (art. 3.14 and 3.16), so each has its own category.';

  @override
  String get expensesFieldDescriptionHelp =>
      'What you bought, so you and the Belastingdienst can see the business purpose.';

  @override
  String get expensesFieldPaidFromHelp =>
      'The account or card you paid with, to match the expense with your bank statement.';

  @override
  String get expensesFieldPaymentRefHelp =>
      'The reference of the payment or invoice, to find it back later.';

  @override
  String get expensesFieldSupplierHelp =>
      'The business you bought from, as on the receipt.';

  @override
  String expensesFieldVatRateHelp(String high, String low) {
    return 'The VAT rate on the receipt: $high, $low, 0% or exempt.';
  }

  @override
  String expensesReclaimVatHelp(String amount) {
    return 'Tick when you may deduct this VAT in your VAT return. Not for food and drinks in a restaurant, for private use, or for gifts to someone who cannot deduct VAT when they total more than $amount for that person in a year (Besluit uitsluiting aftrek omzetbelasting 1968).';
  }

  @override
  String get hoursFieldClientProjectHelp =>
      'The client or project the hours were for.';

  @override
  String get hoursFieldDateHelp => 'The day you worked.';

  @override
  String get hoursFieldDescriptionHelp =>
      'What you did. All hours spent on the business count towards the urencriterium, not only billable ones.';

  @override
  String get hoursFieldHoursHelp =>
      'How many hours you worked that day, such as 7,5.';

  @override
  String get hoursFieldNotesHelp =>
      'Anything you want to remember about these hours.';

  @override
  String hoursFieldWorkTypeHelp(int hours) {
    return 'The kind of work. WBSO hours count towards the $hours hours needed for the S&O-aftrek.';
  }

  @override
  String get invoiceFieldClientHelp =>
      'Who the invoice is for. Their name and address are printed on it.';

  @override
  String get invoiceFieldDescriptionHelp =>
      'What you delivered: the nature of the goods or services, as the law requires on an invoice.';

  @override
  String get invoiceFieldDueDateHelp =>
      'The last day for payment: the invoice date plus the payment term.';

  @override
  String get invoiceFieldInvoiceDateHelp =>
      'The date the invoice is issued. It decides the year and quarter the revenue and VAT belong to.';

  @override
  String get invoiceFieldNumberHelp =>
      'A unique number in an unbroken sequence, as the law requires. Florin suggests the next one.';

  @override
  String get invoiceFieldPaymentTermHelp =>
      'How many days the client has to pay.';

  @override
  String get invoiceFieldPriceHelp => 'The price per unit without VAT.';

  @override
  String get invoiceFieldQuantityHelp =>
      'How many units, such as hours or pieces.';

  @override
  String get invoiceFieldRemarksHelp =>
      'Extra text printed at the bottom of the invoice.';

  @override
  String get invoiceFieldSupplyDateHelp =>
      'When you delivered, if that differs from the invoice date. The law requires it on the invoice in that case.';

  @override
  String invoiceLateNotice(int day, String date) {
    return 'An invoice is due by day $day of the month after the supply (Wet OB 1968 art. 34g): for this supply by $date.';
  }

  @override
  String get invoiceFieldUnitHelp =>
      'The unit of the quantity, such as hours or pieces.';

  @override
  String get invoiceFieldVatHelp => 'The VAT rate for this line.';

  @override
  String get invoiceFieldVatReverseHelp =>
      'The VAT rate that would apply without reverse charge. The invoice states it with the amount per rate, and your customer pays the VAT.';

  @override
  String get invoiceValidateLineRate =>
      'Choose the VAT rate for this line: the invoice states it, also when the VAT is reverse-charged.';

  @override
  String get invoiceFieldVatTreatmentHelp =>
      'How VAT applies. Dutch VAT for most Dutch clients, or Exempt under the KOR while you take part in it. Reverse charge when the customer pays the VAT. EU goods and services to businesses also go on the ICP report. Services to a business outside the EU are taxed there and stay out of the Dutch return.';

  @override
  String get labelCategoryHelp => 'Show only expenses of one category.';

  @override
  String get labelDateHelp =>
      'The date on the receipt. It decides the year and quarter of the expense.';

  @override
  String get labelNotesHelp =>
      'Anything you want to remember. Not used in calculations.';

  @override
  String get mileageFieldDateHelp => 'The day of the trip.';

  @override
  String get mileageFieldDistanceHelp =>
      'Calculated from the odometer readings.';

  @override
  String get mileageFieldFromHelp => 'Where the trip started.';

  @override
  String get mileageFieldMakeModelHelp =>
      'The make and model of the vehicle, for your trip log.';

  @override
  String get mileageFieldNotesHelp =>
      'Anything you want to remember about this trip.';

  @override
  String get mileageFieldOdoEndHelp =>
      'The odometer reading at the end of the trip.';

  @override
  String get mileageFieldOdoStartHelp =>
      'The odometer reading at the start of the trip.';

  @override
  String get mileageFieldPlateHelp => 'The licence plate, for your trip log.';

  @override
  String get mileageFieldPurposeHelp =>
      'Why you made the trip, such as the client or meeting.';

  @override
  String get mileageFieldRouteDeviationHelp =>
      'Tick when you took a longer or different route than the shortest one, and note why.';

  @override
  String get mileageFieldToHelp => 'Where the trip ended.';

  @override
  String get mileageFieldTripTypeHelp =>
      'Business and commuting trips in a private vehicle are deductible per km for income tax. Private trips are not.';

  @override
  String get pensionAovInsuredHelp =>
      'Tick when you have a private disability insurance (AOV). Its premiums are deductible.';

  @override
  String get pensionFactorAHelp =>
      'The pension you built up with an employer last year, from the factor A on your UPO. Leave 0 if you had none. If your pension scheme follows the Wet toekomst pensioenen, your UPO shows premiums instead: the law then lowers the jaarruimte by those premiums, which Florin does not calculate.';

  @override
  String get pensionLijfrenteHelp =>
      'What you pay or plan to pay into a lijfrente this year. Deducted up to the room you have.';

  @override
  String get pensionMonthlyPremiumHelp =>
      'The monthly premium of your disability insurance.';

  @override
  String get pensionPriorYearIncomeHelp =>
      'Last year\'s profit from business before the ondernemersaftrek, plus taxable wages, taxable result from other work and taxable periodic benefits, from that year\'s tax return (Wet IB 2001 art. 3.127 lid 3). The jaarruimte is based on it.';

  @override
  String pensionCountedIncomeHelp(String max) {
    return 'The income as it counts for the premiegrondslag: at most $max (Wet IB 2001 art. 3.127 lid 3).';
  }

  @override
  String get pensionReserveringsruimteLabelHelp =>
      'Unused jaarruimte from earlier years that you may still use. The Belastingdienst\'s Hulpmiddel Lijfrentepremie calculates it.';

  @override
  String get settingsBusinessAddressHelp =>
      'Your full business address. It is printed on every invoice.';

  @override
  String get settingsBusinessNameHelp =>
      'Your business name as registered with the KvK. It is printed on every invoice.';

  @override
  String get settingsIbanHelp =>
      'The bank account clients pay to. It is printed in the payment instructions.';

  @override
  String get settingsKvkNumberHelp =>
      'Your 8-digit KvK number. It is printed on every invoice.';

  @override
  String get settingsVatNumberHelp =>
      'Your VAT identification number (btw-id), NL followed by 9 digits, B and 2 digits. It is printed on every invoice.';

  @override
  String get vatReturnFiledHelp =>
      'Tick once you have filed this quarter\'s return in Mijn Belastingdienst Zakelijk.';

  @override
  String get vatReturnPaidHelp =>
      'Tick once you have paid the VAT due for this quarter.';

  @override
  String get assetKindGeneral => 'Business asset';

  @override
  String get assetKindCar => 'Car owned by the business';

  @override
  String get assetsFieldKind => 'Type';

  @override
  String get assetsFieldKindHelp =>
      'Choose car for a passenger car or van that belongs to the business. Private use of it is added to your profit and to your VAT return.';

  @override
  String get assetsCarSection => 'Car';

  @override
  String get assetsCarSectionHelp =>
      'These details decide the addition for private use (bijtelling) and the VAT on private use. A business car counts in full: the bijtelling and the VAT on private use correct for its private use.';

  @override
  String get assetsFieldCatalogueValue => 'Catalogue value';

  @override
  String get assetsFieldCatalogueValueHelp =>
      'The original list price including VAT and BPM, as on the registration certificate or the RDW website.';

  @override
  String get assetsValidateCatalogueValue =>
      'Enter the catalogue value including VAT and BPM, above zero: the private-use addition is a percentage of it.';

  @override
  String get assetsFieldFirstRegistration => 'First registration';

  @override
  String get assetsFieldFirstRegistrationHelp =>
      'The date the car was first registered, on the registration certificate. It decides which bijtelling percentage applies.';

  @override
  String get assetsValidateFirstRegistration =>
      'Enter the date of first registration from the registration certificate';

  @override
  String get assetsFieldZeroEmission => 'Zero emission';

  @override
  String get assetsFieldZeroEmissionHelp =>
      'Electric, hydrogen and solar cars with 0 g/km CO2 get a lower bijtelling.';

  @override
  String get zeroEmissionNone => 'No';

  @override
  String get zeroEmissionBattery => 'Battery electric';

  @override
  String get zeroEmissionHydrogenOrSolar => 'Hydrogen or integrated solar';

  @override
  String get assetsFieldMarketValue => 'Market value';

  @override
  String assetsFieldMarketValueHelp(int years) {
    return 'What the car is worth now. Only used once the car is more than $years years old.';
  }

  @override
  String get assetsFieldTripLog => 'I keep a complete trip log for this car';

  @override
  String assetsFieldTripLogHelp(int km) {
    return 'With a complete trip log of all trips in this car, there is no bijtelling at $km private km a year or less, and VAT on private use is based on the actual kilometres.';
  }

  @override
  String get assetsInvestmentSection => 'Investment deductions';

  @override
  String assetsInvestmentSectionHelp(int years) {
    return 'Extra deductions in the year of purchase. If you sell the asset within $years years, part of them is added back.';
  }

  @override
  String get assetsFieldEia => 'Energy investment (EIA), reported to RVO';

  @override
  String assetsFieldEiaHelp(int months, String min) {
    return 'An asset on the RVO Energy List, reported to RVO within $months months. At least $min per asset. Cannot be combined with MIA.';
  }

  @override
  String get assetsFieldMia => 'Environmental investment (MIA)';

  @override
  String assetsFieldMiaHelp(int months, String min) {
    return 'The category on the RVO Environmental List, reported to RVO within $months months. At least $min per asset.';
  }

  @override
  String get assetsMiaNone => 'None';

  @override
  String get miaCategoryOne => 'Category I';

  @override
  String get miaCategoryTwo => 'Category II';

  @override
  String get miaCategoryThree => 'Category III';

  @override
  String get assetsFieldDeductionReceived => 'Investment deduction received';

  @override
  String assetsFieldDeductionReceivedHelp(int years) {
    return 'The KIA, EIA and MIA you received for this asset in its purchase year, from that year\'s tax return. Needed to add part back if you sell it within $years years.';
  }

  @override
  String get assetsValidateDeductionReceived =>
      'Enter the investment deduction you received for this asset, or 0';

  @override
  String get assetsFieldReserveApplied => 'Herinvesteringsreserve booked off';

  @override
  String get assetsFieldReserveAppliedHelp =>
      'Part of the herinvesteringsreserve booked off on this purchase. It lowers the cost to depreciate.';

  @override
  String assetsReserveAvailable(String amount) {
    return 'Available: $amount';
  }

  @override
  String get assetsValidateReserveAboveAvailable =>
      'This is more than the herinvesteringsreserve available';

  @override
  String get assetsValidateReserveAboveCost =>
      'This is more than the cost minus the residual value';

  @override
  String get assetsFieldReserveGain =>
      'Put the gain in the herinvesteringsreserve';

  @override
  String assetsFieldReserveGainHelp(int years) {
    return 'Only when you intend to buy a replacement. The gain is then not taxed now but booked off on the next purchase; unused after $years years, it is added to your profit.';
  }

  @override
  String get dashboardDeductibleCostsHelp =>
      'Costs deductible for income tax, including depreciation and the mileage allowance. Estimated.';

  @override
  String get dashboardEstimatedTaxHelp =>
      'Estimated income tax and Zvw contribution on your profit so far. Not a tax assessment.';

  @override
  String get dashboardEstimatedTaxToPay => 'Estimated tax to pay';

  @override
  String get dashboardEstimatedRefund => 'Estimated refund';

  @override
  String get dashboardEstimatedTaxToPayHelp =>
      'Estimated income tax and Zvw contribution on your profit so far and your wages, minus the loonheffing withheld. Not a tax assessment.';

  @override
  String get dashboardNetProfitAfterTaxHelp =>
      'Profit minus the estimated tax the business adds. An estimate, not a final figure.';

  @override
  String get expensesFieldCar => 'Business car';

  @override
  String get expensesFieldCarHelp =>
      'Link costs such as fuel and insurance to a business car. A linked cost counts in full, as the bijtelling and the VAT on private use correct for private use. Linked costs cap the bijtelling and decide the VAT on private use.';

  @override
  String get expensesNoCar => 'Not for a business car';

  @override
  String get mileageFieldVehicle => 'Vehicle';

  @override
  String get mileageFieldVehicleHelp =>
      'A private vehicle earns the per-km deduction. Trips in a business car do not; they count for its trip log instead.';

  @override
  String get mileagePrivateVehicle => 'Private vehicle';

  @override
  String get inputPartnerHours => 'Partner\'s hours in the business';

  @override
  String inputPartnerHoursHelp(String pay, int hours) {
    return 'Hours your fiscal partner worked in your business this year without pay, or for less than $pay. From $hours hours you get the meewerkaftrek.';
  }

  @override
  String get inputUnrealisedZelfs => 'Unused zelfstandigenaftrek';

  @override
  String inputUnrealisedZelfsHelp(int years) {
    return 'Zelfstandigenaftrek from the previous $years years that did not fit your profit, as stated by the Belastingdienst. Used up to this year\'s profit.';
  }

  @override
  String get inputLossCarryForward => 'Losses from earlier years';

  @override
  String get inputLossCarryForwardHelp =>
      'Box 1 losses from earlier years still to offset, as stated by the Belastingdienst. Offset against this year\'s income.';

  @override
  String get inputEmployed => 'I also work as an employee this year';

  @override
  String get inputEmployedHelp =>
      'Wages count in box 1 together with your profit, and the urencriterium then also compares your hours in the business with your hours in employment.';

  @override
  String get inputWages => 'Wages (loon)';

  @override
  String get inputWagesHelp =>
      'The loon on your jaaropgaven: the wage that is taxed, not the gross salary. It is added to your profit in box 1.';

  @override
  String get inputWageTaxWithheld => 'Loonheffing withheld';

  @override
  String get inputWageTaxWithheldHelp =>
      'The loonheffing on your jaaropgaven: the loonbelasting and premie volksverzekeringen your employers withheld. The return subtracts it from the tax.';

  @override
  String get inputZvwWages => 'Loon Zvw';

  @override
  String get inputZvwWagesHelp =>
      'The loon Zorgverzekeringswet on your jaaropgaven, on which your employer paid the werkgeversheffing Zvw. You pay the Zvw contribution on your profit only up to the maximum bijdrage-inkomen minus this amount.';

  @override
  String get inputEmploymentHours => 'Hours in employment';

  @override
  String inputEmploymentHoursHelp(int years) {
    return 'The hours you work as an employee in the whole year. The urencriterium also requires more time in the business than in other work, unless you were not a business owner in one or more of the $years previous years.';
  }

  @override
  String inputNotOndernemerBefore(int years) {
    return 'I was not a business owner in one or more of the $years previous years';
  }

  @override
  String get inputNotOndernemerBeforeHelp =>
      'Then this year counts as a starting year: the urencriterium does not require more time in the business than in a job (Wet IB 2001 art. 3.6 lid 1 b), and the startersaftrek bij arbeidsongeschiktheid can apply (art. 3.78a). Answer it again for every year.';

  @override
  String inputStarter(int max) {
    return 'I had the zelfstandigenaftrek at most $max times in those years';
  }

  @override
  String inputStarterHelp(String amount) {
    return 'Then you get the startersaftrek of $amount on top of the zelfstandigenaftrek, if you meet the urencriterium (Wet IB 2001 art. 3.76 lid 3). It stops once you have had the zelfstandigenaftrek more often, so check it for every year.';
  }

  @override
  String get inputSoVerklaring => 'I have an S&O-verklaring for this year';

  @override
  String inputSoVerklaringHelp(int hours) {
    return 'An S&O-verklaring from RVO for research and development. With at least $hours WBSO hours you get the S&O-aftrek.';
  }

  @override
  String get inputSoStarter => 'Starter increase for the S&O-aftrek';

  @override
  String inputSoStarterHelp(int years, int max) {
    return 'You were not a business owner in one or more of the $years previous years and received an S&O-verklaring for at most $max years in that period.';
  }

  @override
  String get inputBusinessCeased => 'I stopped the whole business this year';

  @override
  String get inputBusinessCeasedHelp =>
      'Gains on selling or taking over the business assets are stakingswinst. You get the stakingsaftrek on them, and any herinvesteringsreserve is added to your profit.';

  @override
  String get inputStakingsUsedBefore => 'Stakingsaftrek used before';

  @override
  String inputStakingsUsedBeforeHelp(String max) {
    return 'Stakingsaftrek you received in earlier years. It lowers the maximum of $max.';
  }

  @override
  String get inputDisabilityBenefit => 'I receive a disability benefit';

  @override
  String inputDisabilityBenefitHelp(int reduced, int hours) {
    return 'A benefit such as WIA, WAO, WAZ or Wajong. As a starter with at least $reduced but under $hours hours you may get the startersaftrek bij arbeidsongeschiktheid.';
  }

  @override
  String inputDisabilityUsed(int years) {
    return 'Years used in the previous $years';
  }

  @override
  String inputDisabilityUsedHelp(int years, int max) {
    return 'How many of the previous $years years you received the startersaftrek bij arbeidsongeschiktheid, from 0 to $max.';
  }

  @override
  String inputWholeNumber(int max) {
    return 'Enter a whole number from 0 to $max';
  }

  @override
  String get pensionAowFranchiseHelp =>
      'The part of your income for which you already build up AOW. Jaarruimte is only calculated on income above it.';

  @override
  String get pensionPensioengrondslagHelp =>
      'Last year\'s income minus the AOW-franchise, up to the legal maximum.';

  @override
  String pensionJaarruimteHelp(String pct) {
    return '$pct of the premiegrondslag minus a multiple of factor A, up to the yearly maximum. What you may deduct for a lijfrente this year.';
  }

  @override
  String get pensionEstimatedTaxSavingHelp =>
      'Estimated: the box 1 tax you save by deducting the premium, before heffingskortingen.';

  @override
  String get plTaxAlgHeffingHelp =>
      'A tax credit everyone gets. It decreases as income rises above a threshold.';

  @override
  String get plTaxArbeidskortingHelp =>
      'A tax credit for working people, based on the profit before ondernemersaftrek and mkb-winstvrijstelling plus your wages.';

  @override
  String get plTaxAovHelp =>
      'Premiums for private disability insurance are fully deductible from box 1 income.';

  @override
  String get plTaxBelastbareWinstHelp =>
      'Profit after ondernemersaftrek and mkb-winstvrijstelling. The Zvw contribution is based on it.';

  @override
  String get plTaxWages => 'Wages from employment';

  @override
  String get plTaxWagesHelp =>
      'The loon you entered below. It is box 1 income like the profit, so it raises the rate on the profit and lowers the algemene heffingskorting.';

  @override
  String get plTaxBox1SectionHelp =>
      'Estimated income tax including national insurance premiums, in brackets, minus the heffingskortingen.';

  @override
  String get plTaxCarPrivateUse => 'Private use of business car';

  @override
  String plTaxCarPrivateUseHelp(int km) {
    return 'The bijtelling: a percentage of the catalogue value added to profit for private use, at most the car costs. None with a trip log of $km private km a year or less.';
  }

  @override
  String plTaxDeductionsSectionHelp(int hours) {
    return 'Deductions for business owners. Most require the urencriterium of $hours hours.';
  }

  @override
  String get plTaxDepreciationHelp =>
      'The part of your assets\' cost written off this year, spread by day over their useful life.';

  @override
  String get plTaxDesinvestering => 'Desinvesteringsbijtelling';

  @override
  String plTaxDesinvesteringHelp(int years) {
    return 'Part of an investment deduction added back because an asset was sold within $years years of the start of its purchase year.';
  }

  @override
  String get plTaxDisabilityStarters =>
      'Startersaftrek bij arbeidsongeschiktheid';

  @override
  String plTaxDisabilityStartersHelp(int hours) {
    return 'For starters with a disability benefit who work at least $hours hours but do not meet the urencriterium. At most the profit.';
  }

  @override
  String get plTaxDisposalResultHelp =>
      'Sale price minus book value of assets sold this year. A gain adds to profit, a loss lowers it.';

  @override
  String get plTaxEia => 'Energie-investeringsaftrek (EIA)';

  @override
  String get plTaxEiaHelp =>
      'An extra deduction for investments on the RVO Energy List.';

  @override
  String plTaxFoodLimitedHelp(String pct, String drempel) {
    return 'Food, drinks, representation, congresses, seminars and study trips are deductible for $pct, or above the first $drempel (Wet IB 2001 art. 3.15). Florin uses whichever gives the larger deduction.';
  }

  @override
  String plTaxCourseTravelHelp(String max) {
    return 'Travel and stay for courses, studies and congresses are deductible up to $max a year (Wet IB 2001 art. 3.16 lid 2 f). The limit does not apply when your work makes attending necessary (lid 8); Florin keeps it, because it cannot tell that from your records.';
  }

  @override
  String plTaxBarredCosts(String amount) {
    return 'Not deductible ($amount)';
  }

  @override
  String get plTaxBarredCostsHelp =>
      'Fines (Wet IB 2001 art. 3.14), clothing other than werkkleding, personal care, a phone line at home and literature other than professional literature (art. 3.16 lid 2). The law keeps these costs out of the profit, so they lower it by nothing.';

  @override
  String plTaxInputsSection(int year) {
    return 'Your situation in $year';
  }

  @override
  String get plTaxInputsSectionHelp =>
      'Facts the bookkeeping cannot show. They change the estimate above.';

  @override
  String plTaxEmploymentSection(int year) {
    return 'Employment in $year';
  }

  @override
  String get plTaxEmploymentSectionHelp =>
      'If you also work as an employee. Enter the totals of all your jaaropgaven for the year. During the year, enter what you expect for the whole year.';

  @override
  String get plTaxInvestmentSection => 'Investment deductions';

  @override
  String get plTaxInvestmentSectionHelp =>
      'Extra deductions for assets bought this year.';

  @override
  String get plTaxKiaHelp =>
      'Kleinschaligheidsinvesteringsaftrek: a percentage or fixed amount based on your total qualifying investments this year.';

  @override
  String get plTaxLijrenteHelp =>
      'Premiums for a lijfrente, deducted up to your jaarruimte and reserveringsruimte.';

  @override
  String get plTaxLossOffset => 'Losses from earlier years';

  @override
  String get plTaxLossOffsetHelp =>
      'Box 1 losses from earlier years, offset against this year\'s income.';

  @override
  String get plTaxMeewerk => 'Meewerkaftrek';

  @override
  String plTaxMeewerkHelp(int hours) {
    return 'A percentage of profit when your fiscal partner works at least $hours hours in the business without pay.';
  }

  @override
  String get plTaxMia => 'Milieu-investeringsaftrek (MIA)';

  @override
  String get plTaxMiaHelp =>
      'An extra deduction for investments on the RVO Environmental List.';

  @override
  String get plTaxMileageAllowanceHelp =>
      'Business and commuting kilometres in a private vehicle, at the Belastingdienst rate per km.';

  @override
  String get plTaxMkbHelp =>
      'A percentage of profit after ondernemersaftrek that is exempt from tax. No urencriterium needed.';

  @override
  String get plTaxProfit => 'Profit';

  @override
  String get plTaxProfitHelp =>
      'Profit from business before ondernemersaftrek. The arbeidskorting is based on it, together with any wages.';

  @override
  String get plTaxReserveReleased => 'Herinvesteringsreserve released';

  @override
  String plTaxReserveReleasedHelp(int years) {
    return 'Reserve not used within $years years, or left when the business stops, is added to profit.';
  }

  @override
  String get plTaxSo => 'S&O-aftrek';

  @override
  String plTaxSoHelp(int hours) {
    return 'For research and development with an S&O-verklaring and at least $hours hours.';
  }

  @override
  String get plTaxStakings => 'Stakingsaftrek';

  @override
  String plTaxStakingsHelp(String max) {
    return 'A deduction on the gain when the whole business stops, up to $max over your lifetime.';
  }

  @override
  String get plTaxStartersaftrekHelp =>
      'An extra deduction on top of the zelfstandigenaftrek for business owners who recently started.';

  @override
  String get plTaxTaxableProfitHelp =>
      'The income in box 1 the tax is calculated on: belastbare winst plus wages, minus the deductions above.';

  @override
  String get plTaxUnrealisedZelfs =>
      'Unused zelfstandigenaftrek from earlier years';

  @override
  String get plTaxUnrealisedZelfsHelp =>
      'Zelfstandigenaftrek from earlier years that did not fit the profit then, used up to this year\'s profit.';

  @override
  String get plTaxZelfstandigenaftrekHelp =>
      'A fixed deduction for business owners who meet the urencriterium. At most the profit, unless you are a starter.';

  @override
  String get plTaxZvwHelp =>
      'The income-related contribution to the health care insurance act, on belastbare winst up to a maximum. The loon Zvw your employer paid the werkgeversheffing on lowers that maximum.';

  @override
  String get vatReturnIcpSectionHelp =>
      'Supplies to businesses in other EU countries, reported separately in the ICP report. While you take part in the KOR you file no ICP report, so invoices from those dates are not listed.';

  @override
  String vatRow1aHelp(String rate) {
    return 'Revenue taxed at $rate and the VAT on it.';
  }

  @override
  String vatRow1bHelp(String rate) {
    return 'Revenue taxed at $rate and the VAT on it.';
  }

  @override
  String get vatRow1d => '1d  Private use';

  @override
  String vatRow1dHelp(String rate, String reduced) {
    return 'VAT on private use of business cars: $rate or $reduced of the catalogue value, or the actual private share with a trip log. In the last return of the year only.';
  }

  @override
  String get vatRow1eHelp =>
      'Revenue at 0% or where the VAT is reverse-charged to a Dutch business.';

  @override
  String get vatRow3aHelp =>
      'Exports of goods to countries outside the EU. Services to businesses outside the EU are not reported.';

  @override
  String get vatRow3bHelp =>
      'Goods and services to businesses in other EU countries.';

  @override
  String get vatRow5aHelp => 'The VAT you owe on your revenue and private use.';

  @override
  String get vatRow5bHelp => 'The VAT on business costs you may deduct.';

  @override
  String get clientsSearchHelp => 'Search clients by name.';

  @override
  String get invoicesSearchHelp => 'Search by invoice number or client name.';

  @override
  String get expensesFieldPurchaseVat => 'VAT on this purchase';

  @override
  String get expensesFieldPurchaseVatHelp =>
      'Dutch VAT when the supplier charged it. Shifted when the invoice says the VAT is reverse-charged to you, or the supplier is abroad: you then report and deduct the VAT yourself.';

  @override
  String get purchaseVatDomestic => 'Charged by the supplier';

  @override
  String get purchaseVatReverseChargeNl =>
      'Shifted to me by a Dutch supplier (2a)';

  @override
  String get purchaseVatFromEu => 'From a supplier in another EU country (4b)';

  @override
  String get purchaseVatFromOutsideEu =>
      'Service from a supplier outside the EU (4a)';

  @override
  String get vatReturnShiftedSection => 'VAT shifted to you';

  @override
  String get vatReturnShiftedSectionHelp =>
      'Purchases where you report the VAT yourself. You deduct the same VAT in 5b, so on balance you usually pay nothing.';

  @override
  String get vatRow2a => '2a  Domestic reverse charge';

  @override
  String get vatRow2aHelp =>
      'Purchases from Dutch suppliers who shifted the VAT to you.';

  @override
  String get vatRow4a => '4a  From countries outside the EU';

  @override
  String get vatRow4aHelp => 'Services from suppliers outside the EU.';

  @override
  String get vatRow4b => '4b  From EU countries';

  @override
  String get vatRow4bHelp =>
      'Goods and services from suppliers in other EU countries.';

  @override
  String vatBaseAndVat(String base, String vat) {
    return '$base, VAT $vat';
  }

  @override
  String get expensesBusinessUseHelp =>
      'The share used for the business. Only that share of the cost and VAT is deductible.';

  @override
  String get settingsLanguageSectionHelp =>
      'The language of the app. Invoices and CSV exports are always in Dutch.';

  @override
  String get vatTreatmentServicesOutsideEu =>
      'Services to a business outside the EU (not in the VAT return)';

  @override
  String get invoiceValidateTreatmentCountry =>
      'This VAT treatment does not fit the client\'s country. Domestic reverse charge is for Dutch clients, the EU treatments for other EU countries and the treatments outside the EU for countries outside it.';

  @override
  String get invoiceValidateTreatmentConsumer =>
      'This client is a private person. Choose Dutch BTW, the KOR or export of goods: BTW is not shifted to a private person, and a service to one is taxed in the Netherlands.';

  @override
  String invoiceEuConsumerNotice(String threshold, String total) {
    return 'Telecommunication, broadcasting and electronic services and distance sales of goods to private persons in other EU countries are taxed in their country once together they pass $threshold excl. BTW in this year or the last (Wet OB 1968 art. 6h, 6k). Your supplies with Dutch BTW to private persons in other EU countries this year, this invoice included: $total. Florin cannot tell which are electronic services, so it counts all of them, and it does not prepare the OSS return.';
  }

  @override
  String invoiceEuConsumerOverNotice(String threshold) {
    return 'Your supplies with Dutch BTW to private persons in other EU countries pass $threshold in this year or the last. If they include telecommunication, broadcasting or electronic services or distance sales of goods, those are taxed in the private person\'s country, not with Dutch BTW (Wet OB 1968 art. 6h, 6k), usually through the OSS. Florin does not model this and keeps charging Dutch BTW.';
  }

  @override
  String get invoiceSelfBilled => 'Issued by the customer (self-billing)';

  @override
  String get invoiceSelfBilledHelp =>
      'Tick this when the customer, such as a reseller, makes the invoice for what it owes you. The law allows this when you agreed on it beforehand and you accept each invoice. Florin records it with the customer\'s number and makes no PDF: the customer\'s document is the invoice.';

  @override
  String get invoiceFieldNumberSelfBilledHelp =>
      'The number on the invoice the customer issued to you.';

  @override
  String get invoiceActionRecord => 'Record';

  @override
  String get invoiceRecordTitle => 'Record invoice';

  @override
  String get invoiceRecordMessage =>
      'After recording, the invoice can no longer be changed or deleted. A correction is a credit note that names this invoice.';

  @override
  String get invoiceStatusSelfBilled => 'Issued by customer';

  @override
  String invoiceMerchantOfRecordNotice(String name) {
    return '$name is a merchant of record: it sells your product to end customers and pays you. Invoice it for what it owes you for those sales. One invoice may cover several sales over at most one calendar month. Florin records amounts in euros: for a payout in another currency, enter the euro amounts and keep the reseller\'s statement.';
  }

  @override
  String get invoicePaidDateTitle => 'Date paid';

  @override
  String get clientsMerchantOfRecord => 'Merchant of record (reseller)';

  @override
  String get clientsMerchantOfRecordHelp =>
      'Tick this for a platform that sells your product to end customers in its own name and pays you, such as a merchant of record or an app store. It is the seller towards the end customers, so you invoice only the platform. The Wet DBA section is about working relationships and is hidden for a reseller.';

  @override
  String get clientsConsumer => 'Private person, not a business';

  @override
  String get clientsConsumerHelp =>
      'Tick this for a customer who buys as a private person. BTW is never shifted to a private person and there is no ICP-opgaaf for one, so Florin offers only Dutch BTW, the KOR or export of goods. A service to a private person is taxed where you are established (Wet OB 1968 art. 6 lid 2), except telecommunication, broadcasting and electronic services, which are taxed where the private person lives (art. 6h) once such supplies to other EU countries pass a yearly threshold (art. 6k). For a private person in the Netherlands you need not issue an invoice (art. 34c).';

  @override
  String get clientsBadgeMerchantOfRecord => 'Merchant of record';

  @override
  String get clientsBadgeConsumer => 'Private person';

  @override
  String get vatRowOutsideReturn =>
      'Services to businesses outside the EU (not in the return)';

  @override
  String get vatRowOutsideReturnHelp =>
      'Revenue from services to businesses outside the EU. The Belastingdienst says these are not reported in the Dutch return when the service is taxed outside the EU. Shown so you can see where that revenue went.';

  @override
  String get vatShortReverseCharge => 'Reverse-charged';

  @override
  String get vatShortNotTaxedNl => 'Not taxed in NL';

  @override
  String get invoiceValidateNumberSelfBilled =>
      'Enter the number on the invoice the customer issued, so it can be traced to that invoice.';

  @override
  String get amountInvalidError =>
      'Enter an amount in euros, such as 1.234,50, with a comma before the cents and at most two decimals.';

  @override
  String get amountRequiredError =>
      'Enter an amount above zero: a record without an amount has no effect on your figures.';

  @override
  String clientsValidateVatCountry(String prefix) {
    return 'A VAT number of a client in this country starts with $prefix. Check the number or the country: the ICP report lists them together.';
  }

  @override
  String hoursValidateDayTotal(String logged, String left) {
    return 'This day already has $logged hours logged. A day has 24 hours, so enter at most $left.';
  }

  @override
  String get assetsValidateDisposalBeforePurchase =>
      'The sale date is before the purchase date. Change one of them: an asset is sold after it was bought.';

  @override
  String invoiceValidateCreditDate(String date) {
    return 'A credit note is dated on or after the invoice it corrects, which is dated $date.';
  }

  @override
  String invoiceValidateCreditAboveInvoice(String number, String amount) {
    return 'This credit note is more than is left to correct on invoice $number: at most $amount excluding VAT. A credit note can only reverse what was invoiced.';
  }

  @override
  String get vatTreatmentKor => 'Exempt under the KOR (no VAT on the invoice)';

  @override
  String get vatShortKor => 'KOR exempt';

  @override
  String get vatRowKorExempt => 'Exempt under the KOR (not in the return)';

  @override
  String get vatRowKorExemptHelp =>
      'Revenue exempt under the kleineondernemersregeling. You charged no VAT on it and it is not reported in a return.';

  @override
  String get invoiceValidateKorNotActive =>
      'The KOR does not apply on this date: you do not take part, or your turnover passed the limit. Choose the treatment that fits, usually Dutch VAT.';

  @override
  String get invoiceValidateKorTreatment =>
      'You take part in the KOR on this date: you charge no VAT and the invoice may not mention it. Choose Exempt under the KOR.';

  @override
  String invoiceValidateKorExceeded(String limit) {
    return 'This invoice takes your turnover for the KOR past $limit. The KOR ends with this supply, so it carries VAT: choose Dutch VAT, and deregister from the KOR in Mijn Belastingdienst Zakelijk.';
  }

  @override
  String get expensesValidateKorReclaim =>
      'You take part in the KOR on this date, so you cannot reclaim VAT on purchases. Untick Reclaim VAT: the VAT then counts as part of the cost.';

  @override
  String get expensesKorNotice =>
      'You take part in the KOR on this date. VAT on purchases is not reclaimed; it counts as part of the cost for income tax.';

  @override
  String get settingsKorStart => 'KOR applies from';

  @override
  String settingsKorStartHelp(String limit) {
    return 'The first day the kleineondernemersregeling (KOR) applies to you, as in the Belastingdienst\'s confirmation. Until that date you file every return as usual. Under the KOR you charge no VAT, file no regular VAT return and reclaim no VAT, while your turnover in the Netherlands stays at most $limit a year. Leave empty when you do not take part.';
  }

  @override
  String get settingsKorEnd => 'KOR ended on';

  @override
  String get settingsKorEndHelp =>
      'The first day the KOR no longer applies after you deregistered yourself. Leave empty otherwise: when your turnover passes the limit, Florin ends the KOR from that invoice on.';

  @override
  String get settingsValidateKorStart =>
      'The KOR starts on the first day of a return period, so enter a 1st of the month, as in the Belastingdienst\'s confirmation.';

  @override
  String get settingsValidateKorEndDay =>
      'A deregistration takes effect on the first day of a return period, so enter a 1st of the month.';

  @override
  String get settingsValidateKorEndBeforeStart =>
      'The end of the KOR comes after its start. Check both dates.';

  @override
  String get settingsKorClear => 'I do not take part in the KOR';

  @override
  String korProgress(String turnover, String limit) {
    return '$turnover of $limit';
  }

  @override
  String korExceededBadge(String date) {
    return 'Limit passed on $date';
  }

  @override
  String korLeftBadge(String left) {
    return '$left below the limit';
  }

  @override
  String get dashboardKor => 'KOR turnover';

  @override
  String dashboardKorHelp(String limit) {
    return 'Your turnover that counts for the kleineondernemersregeling: supplies taxed in the Netherlands, including 0% and domestic reverse charge, not services taxed abroad. Above $limit in a calendar year the KOR ends with the supply that passes the limit, for the rest of that year and the next. The KOR is not automatic: it applies only after you register and the Belastingdienst confirms the start date. Until then you file a return every quarter, however low your turnover.';
  }

  @override
  String get deadlineStatusKor => 'no return (KOR)';

  @override
  String get deadlineStatusIncidental => 'incidental return';

  @override
  String get deadlineBadgeKor => 'No return: KOR';

  @override
  String get deadlineBadgeIncidental => 'Incidental return due';

  @override
  String get vatReturnKorNotice =>
      'You take part in the KOR for this whole quarter and owe no VAT in it, so no return is due. If the Belastingdienst sends you one anyway, file it.';

  @override
  String get vatReturnKorPartNotice =>
      'The KOR applies for part of this quarter. Invoices exempt under the KOR are not in the return and VAT on purchases in that part is not reclaimed. File a return for the part outside the KOR.';

  @override
  String get vatReturnKorIncidentalNotice =>
      'You take part in the KOR for this whole quarter, but you owe VAT in it, such as VAT shifted to you (2a, 4a or 4b), which you cannot deduct. So you file a return for this quarter. The Belastingdienst does not send it: ask your belastingkantoor for it in writing once the quarter is over. Florin shows the usual deadline as the date to aim for.';

  @override
  String get vatReturnNilNotice =>
      'Nothing to report this quarter. You still file a return by the deadline: a nil return (0-aangifte). Without it the Belastingdienst sends an additional assessment and a fine.';

  @override
  String vatReturnKorExceeded(String date, String limit) {
    return 'Your turnover for the KOR passed $limit on $date. The KOR ended with that supply: from then on you charge VAT and file returns. Deregister in Mijn Belastingdienst Zakelijk; you cannot take part again this year or next year.';
  }

  @override
  String get errorDuplicate =>
      'Another record already uses this value, such as the same invoice number. Use a value that is not taken yet.';

  @override
  String get errorInUse =>
      'Other records refer to this one, such as invoices of a client. Remove or change those first, or mark this one inactive.';

  @override
  String get errorBusy =>
      'The database is in use by another program. Close that program, or wait a moment, and try again.';

  @override
  String get errorReadOnly =>
      'The database file cannot be written. Check that the folder is not read-only and that you have permission to change it.';

  @override
  String get errorCorrupt =>
      'The database file is damaged and cannot be read. Restore it from a backup, such as your iCloud Drive, OneDrive or Dropbox history.';

  @override
  String get errorDiskFull => 'The disk is full. Free up space and try again.';

  @override
  String get errorCannotOpen =>
      'The database file cannot be opened. Check that its folder still exists, or choose its location again in Settings.';

  @override
  String errorFile(String path, String reason) {
    return 'Could not use $path: $reason';
  }

  @override
  String genericUnhandledError(String error) {
    return 'Something went wrong: $error';
  }

  @override
  String get invoiceNoProfile =>
      'Fill in your business details in Settings first: every invoice shows them.';

  @override
  String get invoiceTotal => 'Total';

  @override
  String get settingsTaxKor => 'KOR turnover limit';

  @override
  String get settingsKorSection => 'Kleineondernemersregeling (KOR)';

  @override
  String settingsKorSectionHelp(String limit) {
    return 'A VAT exemption for businesses with at most $limit turnover in the Netherlands a year. It is not automatic: you register for it and deregister with the Belastingdienst, and without it you file a return every quarter. Enter its dates here so Florin follows it.';
  }

  @override
  String get receiptTypeEInvoice => 'E-invoice (UBL)';

  @override
  String get receiptsTitle => 'Receipts';

  @override
  String receiptsHelp(int years) {
    return 'The receipt or invoice for this expense, as a PDF, photo or scan. Florin copies it into the receipts folder next to your database and leaves your file as it is. The Belastingdienst asks you to keep receipts and invoices for $years years in the form you received them; a scan or photo must be a correct and complete copy of the original, with its marks of authenticity.';
  }

  @override
  String get receiptsAssetTitle => 'Purchase invoice and receipts';

  @override
  String receiptsAssetHelp(int years) {
    return 'The purchase invoice of this asset and any other proof, as a PDF, photo or scan. It belongs in your records while the asset is in use, and $years years after that.';
  }

  @override
  String get receiptsInvoiceTitle => 'Documents';

  @override
  String get receiptsInvoiceHelp =>
      'The PDF of this invoice exactly as Florin made it when you issued it, kept as sent. For an invoice your customer issued, add their document here.';

  @override
  String get receiptsNone =>
      'No files yet. Drop PDFs, photos or scans here, or add them.';

  @override
  String get receiptsAdd => 'Add files';

  @override
  String get receiptsPickDialog => 'Choose receipts';

  @override
  String get receiptsOpen => 'Open';

  @override
  String get receiptsRemove => 'Remove from this record';

  @override
  String get receiptsUnstage => 'Do not add';

  @override
  String get receiptsRemoved =>
      'Removed. Florin keeps the file under Removed receipts in Settings.';

  @override
  String get receiptsUndo => 'Undo';

  @override
  String get receiptsStaged => 'Stored when you save';

  @override
  String receiptsAdded(String date) {
    return 'added $date';
  }

  @override
  String get receiptsMissing =>
      'The file is missing from the receipts folder. Restore it from a backup.';

  @override
  String get receiptsKeepUntil => 'Keep until';

  @override
  String receiptsKeepUntilHelp(int years, int navordering, int foreign) {
    return 'The Belastingdienst asks you to keep invoices and receipts for $years years. Florin counts them from the end of the year they belong to and never deletes them. The Belastingdienst can raise a year\'s tax afterwards for $navordering years after the tax became due, longer when you had extra time to file, and for $foreign years for income or assets held abroad (AWR art. 16), so keep the records of such a year at least that long.';
  }

  @override
  String receiptsKeepWhileInUse(int years) {
    return 'While in use, then $years years';
  }

  @override
  String receiptsRejectedEmpty(String name) {
    return '$name is empty. Choose the file again.';
  }

  @override
  String receiptsRejectedTooLarge(String name, String max) {
    return '$name is larger than $max. Save the scan at a lower resolution, keeping every page readable, and add it again.';
  }

  @override
  String receiptsRejectedType(String name) {
    return '$name is not a PDF, JPEG, PNG, HEIC, TIFF or UBL e-invoice. Save or print it as PDF and add it again.';
  }

  @override
  String receiptsDuplicate(String name) {
    return '$name is already stored with another record. It was added here too.';
  }

  @override
  String receiptsOpenFailed(String name) {
    return 'Could not open $name. Open it from the receipts folder instead.';
  }

  @override
  String get expensesPaperOriginalKept => 'Paper original kept';

  @override
  String get expensesPaperOriginalKeptHelp =>
      'Tick when you keep the paper receipt or invoice yourself, for example a till receipt you have not scanned. You need proof to reclaim VAT and to show the cost; a file added above counts too.';

  @override
  String get expensesHasFiles => 'Receipt stored in Florin';

  @override
  String get expensesPaperOnly => 'Paper original kept';

  @override
  String get receiptsNotStored =>
      'No PDF is stored for this invoice. Florin stores it the first time you export it.';

  @override
  String get settingsReceiptsSection => 'Receipts';

  @override
  String get settingsReceiptsSectionHelp =>
      'Florin keeps the receipt files of expenses and assets, and the PDFs of issued invoices, in a receipts folder next to the database. It never deletes them: a removed receipt stays under Removed receipts. The folder moves with the database and belongs in the same backup.';

  @override
  String settingsReceiptsLocation(String path) {
    return 'Folder: $path';
  }

  @override
  String settingsReceiptsCount(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count files',
      one: '1 file',
    );
    return '$_temp0, $size';
  }

  @override
  String get settingsReceiptsShowFolder => 'Show folder';

  @override
  String get settingsReceiptsCheck => 'Check files';

  @override
  String get settingsReceiptsChecking => 'Checking';

  @override
  String settingsReceiptsAllOk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'All $count files are present and unchanged.',
      one: 'The file is present and unchanged.',
      zero: 'No files to check.',
    );
    return '$_temp0';
  }

  @override
  String settingsReceiptsProblems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count files need attention. Restore them from a backup:',
      one: '1 file needs attention. Restore it from a backup:',
    );
    return '$_temp0';
  }

  @override
  String get settingsReceiptMissing => 'missing';

  @override
  String get settingsReceiptChanged => 'changed since it was added';

  @override
  String get settingsReceiptsOpenFailed => 'The folder could not be opened';

  @override
  String get receiptOwnerExpense => 'Expense';

  @override
  String get receiptOwnerAsset => 'Asset';

  @override
  String get receiptOwnerInvoice => 'Invoice';

  @override
  String get removedReceiptsTitle => 'Removed receipts';

  @override
  String removedReceiptsNotice(String path) {
    return 'Receipts you removed from a record, or whose record was deleted. Florin never deletes a receipt: the files stay in $path. Put one back while its record exists.';
  }

  @override
  String get removedReceiptsNone => 'No removed receipts.';

  @override
  String removedReceiptsFrom(
    String kind,
    String date,
    String name,
    String removed,
  ) {
    return 'from $kind $date $name, removed $removed';
  }

  @override
  String get removedReceiptsPutBack => 'Put back on its record';

  @override
  String settingsRemovedReceipts(int count) {
    return 'Removed receipts ($count)';
  }
}
