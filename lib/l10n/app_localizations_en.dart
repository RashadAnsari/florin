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
  String get actionConfirm => 'Confirm';

  @override
  String get actionAdd => 'Add';

  @override
  String get actionNew => 'New';

  @override
  String get labelRequired => 'Required';

  @override
  String get labelDate => 'Date';

  @override
  String get labelNotes => 'Notes';

  @override
  String get labelDescription => 'Description';

  @override
  String get labelAmount => 'Amount';

  @override
  String get labelAddress => 'Address';

  @override
  String get labelName => 'Name';

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
  String get dashboardNetProfitAfterTax => 'Net profit after tax';

  @override
  String get dashboardOutstandingInvoices => 'Outstanding invoices';

  @override
  String dashboardInvoiceCount(int count) {
    return '$count invoice(s)';
  }

  @override
  String get dashboardUrencriterium => 'Urencriterium';

  @override
  String dashboardHoursProgress(String total, String target) {
    return '$total / $target hrs';
  }

  @override
  String get dashboardBtwDeadlines => 'BTW-deadlines';

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
  String get invoicesSelectOrNew => 'Select an invoice or create a new one';

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
  String get invoiceStatusCancelled => 'Cancelled';

  @override
  String get invoiceStatusRefunded => 'Refunded';

  @override
  String get invoiceTypeInvoice => 'Invoice';

  @override
  String get invoiceTypeCreditNote => 'Credit note';

  @override
  String get invoiceFieldType => 'Type';

  @override
  String get invoiceFieldClient => 'Client *';

  @override
  String get invoiceFieldNumber => 'Invoice number *';

  @override
  String get invoiceFieldInvoiceDate => 'Invoice date *';

  @override
  String get invoiceFieldSupplyDate => 'Supply date';

  @override
  String get invoiceFieldPaymentTerm => 'Term (days) *';

  @override
  String get invoiceValidatePaymentTerm =>
      'Enter a whole number of days (e.g. 14 or 30)';

  @override
  String get invoiceFieldDueDate => 'Due date';

  @override
  String get invoiceFieldIcp => 'ICP (intracommunautair)';

  @override
  String get invoiceTooltipIcp =>
      'Intra-Community transactions (ICP): sales of goods or services to VAT-registered clients in EU countries outside the Netherlands. These must be reported separately in the ICP declaration alongside your VAT return.';

  @override
  String get invoiceWarnIcpNoVat =>
      'The selected client has no VAT number. The ICP declaration requires a valid EU VAT number for the client.';

  @override
  String get invoiceFieldBtwVerlegd => 'BTW verlegd';

  @override
  String get invoiceTooltipBtwVerlegd =>
      'Reverse charge VAT: the VAT obligation is shifted from you to the recipient. Used when supplying goods or services to VAT-registered businesses, often in cross-border EU transactions. The invoice shows 0% VAT with the note \'BTW verlegd\'.';

  @override
  String get invoiceFieldLines => 'Lines';

  @override
  String get invoiceFieldAddLine => 'Add line';

  @override
  String get invoiceFieldDescription => 'Description *';

  @override
  String get invoiceHintDescription =>
      'e.g. Consulting services, web design...';

  @override
  String get invoiceFieldQuantity => 'Qty *';

  @override
  String get invoiceFieldUnit => 'Unit';

  @override
  String get invoiceFieldPrice => 'Price (excl.) *';

  @override
  String get invoiceFieldVat => 'VAT';

  @override
  String get invoiceFieldVatAmount => 'VAT amount';

  @override
  String get invoiceFieldLineTotal => 'Total excl.';

  @override
  String invoiceVatLine(String rate) {
    return 'VAT $rate';
  }

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
  String get invoiceActionCancel => 'Cancel';

  @override
  String get invoiceActionMarkRefunded => 'Refunded';

  @override
  String get invoiceActionExportPdf => 'Export PDF';

  @override
  String get invoiceActionDelete => 'Delete';

  @override
  String get invoiceDeleteTitle => 'Delete invoice';

  @override
  String invoiceDeleteMessage(String number) {
    return 'Are you sure you want to delete invoice \"$number\"?';
  }

  @override
  String get invoiceCreated => 'Invoice created';

  @override
  String get invoiceSaved => 'Invoice saved';

  @override
  String get invoiceDeleted => 'Invoice deleted';

  @override
  String get invoiceValidateClient => 'Select a client for this invoice';

  @override
  String get invoiceValidateNumber =>
      'Enter a unique invoice number, e.g. F-2024-001';

  @override
  String get invoiceUnitHint => 'hrs';

  @override
  String get clientsTitle => 'Clients';

  @override
  String get clientsNewTooltip => 'New client';

  @override
  String get clientsNone => 'No clients';

  @override
  String get clientsSelectOrNew => 'Select a client or create a new one';

  @override
  String get clientsNewHeader => 'New client';

  @override
  String get clientsShowInactive => 'Show inactive';

  @override
  String get clientsHideInactive => 'Hide inactive';

  @override
  String get clientsFilterAll => 'All';

  @override
  String get clientsFilterActive => 'Active';

  @override
  String get clientsFilterInactive => 'Inactive';

  @override
  String get clientsInactive => 'Inactive';

  @override
  String get clientsFieldName => 'Name *';

  @override
  String get clientsValidateName => 'Enter the client\'s name';

  @override
  String get clientsFieldCountry => 'Country';

  @override
  String get clientsValidateCountry =>
      'Use a 2-letter country code (e.g. NL, DE, FR)';

  @override
  String get clientsFieldVat => 'VAT number';

  @override
  String get clientsValidateVat =>
      'Enter a valid EU VAT number (e.g. NL854224798B01)';

  @override
  String get clientsFieldKvk => 'KVK number';

  @override
  String get clientsValidateKvk => 'KVK number must be exactly 8 digits';

  @override
  String get clientsFieldAddress => 'Address *';

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
      'High Wet DBA risk: ensure a valid assignment agreement is in place.';

  @override
  String get clientsViesEmptyVat => 'Please enter a VAT number first';

  @override
  String get clientsCreated => 'Client created';

  @override
  String get clientsSaved => 'Client saved';

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
  String get expensesSelectOrNew => 'Select an expense or add a new one';

  @override
  String get expensesNewHeader => 'New expense';

  @override
  String get expensesFieldSupplier => 'Supplier *';

  @override
  String get expensesHintSupplier => 'e.g. Albert Heijn, Amazon, KPN';

  @override
  String get expensesValidateSupplier => 'Enter the supplier name';

  @override
  String get expensesFieldCategory => 'Category *';

  @override
  String get expensesValidateCategory => 'Select a category for this expense';

  @override
  String get expensesFieldDescription => 'Description *';

  @override
  String get expensesValidateDescription =>
      'Enter a description for this expense';

  @override
  String get expensesFieldAmountExcl => 'Amount (excl. VAT) *';

  @override
  String get expensesValidateAmount => 'Enter the amount excluding VAT';

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
  String get expensesHintPaymentRef => 'e.g. INV-2024-0042, SEPA ref 123456';

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
  String expensesVatBackAmount(String amount) {
    return 'VAT back: $amount';
  }

  @override
  String get expensesMixedCosts => 'Mixed costs';

  @override
  String get expensesReceiptAttached => 'Receipt attached';

  @override
  String get expensesBuaWarning =>
      'BUA: meals & entertainment above €227. VAT deduction may be restricted (Besluit Uitsluiting Aftrek).';

  @override
  String get expensesCreated => 'Expense created';

  @override
  String get expensesSaved => 'Expense saved';

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
  String get expenseCatMeals => 'Meals & entertainment';

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
  String get expenseCatOther => 'Other';

  @override
  String get hoursTitle => 'Hour registration';

  @override
  String get hoursNone => 'No hours registered';

  @override
  String get hoursSelectOrNew => 'Select an entry or click +';

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
  String get hoursFieldDate => 'Date *';

  @override
  String get hoursFieldHours => 'Hours *';

  @override
  String get hoursFieldDescription => 'Description *';

  @override
  String get hoursFieldWorkType => 'Work type *';

  @override
  String get hoursFieldClientProject => 'Client / project';

  @override
  String get hoursFieldNotes => 'Notes';

  @override
  String get hoursNewEntry => 'New entry';

  @override
  String get hoursEditEntry => 'Edit entry';

  @override
  String get hoursDeleteTitle => 'Delete hour entry';

  @override
  String hoursDeleteMessage(String description) {
    return 'Are you sure you want to delete \"$description\"?';
  }

  @override
  String get hoursValidateHours => 'Enter a number of hours greater than 0';

  @override
  String get hoursValidateDescription => 'Describe the work done';

  @override
  String get hoursValidateWorkType => 'Select a work type';

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
  String get mileageSelectOrNew => 'Select a trip or click +';

  @override
  String get mileageBusiness => 'Business';

  @override
  String get mileageTotal => 'Total';

  @override
  String get mileageUnitKm => 'km';

  @override
  String mileageAllowance(String rate) {
    return 'Allowance (€$rate/km)';
  }

  @override
  String get mileageFieldDate => 'Date *';

  @override
  String get mileageFieldMakeModel => 'Make / model *';

  @override
  String get mileageFieldPlate => 'Licence plate *';

  @override
  String get mileageFieldFrom => 'Departure address *';

  @override
  String get mileageFieldTo => 'Arrival address *';

  @override
  String get mileageFieldOdoStart => 'Odometer start *';

  @override
  String get mileageFieldOdoEnd => 'Odometer end *';

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
  String get mileageValidateTripType => 'Select the type of trip';

  @override
  String get mileageValidatePurpose => 'Describe the purpose of this trip';

  @override
  String get mileageFieldDistance => 'Distance';

  @override
  String get mileageFieldTripType => 'Trip type *';

  @override
  String get mileageFieldPurpose => 'Purpose *';

  @override
  String get mileageFieldRouteDeviation => 'Detour / non-direct route';

  @override
  String get mileageTooltipRouteDeviation =>
      'Check this if you took a longer or indirect route than strictly necessary. The tax authority may ask you to explain why the route deviated from the shortest path.';

  @override
  String get mileageFieldNotes => 'Notes';

  @override
  String get mileageNewTrip => 'New trip';

  @override
  String get mileageEditTrip => 'Edit trip';

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
  String get assetsSelectOrNew => 'Select an asset or click +';

  @override
  String get assetsKiaInvestments => 'KIA investments';

  @override
  String get assetsKiaDeduction => 'KIA deduction';

  @override
  String get assetsDepreciationThisYear => 'Depreciation this year';

  @override
  String get assetsFieldName => 'Asset name *';

  @override
  String get assetsFieldCost => 'Cost excl. VAT *';

  @override
  String get assetsFieldPurchaseDate => 'Purchase date *';

  @override
  String assetsFieldBusinessUse(int pct) {
    return 'Business use: $pct% *';
  }

  @override
  String get assetsFieldUsefulLife => 'Useful life *';

  @override
  String get assetsFieldUsefulLifeUnit => 'yrs';

  @override
  String get assetsFieldUsefulLifeMin => 'Minimum 1 year';

  @override
  String get assetsValidateName => 'Enter the asset name';

  @override
  String get assetsValidateCost => 'Enter the cost excluding VAT';

  @override
  String get assetsFieldKia => 'KIA eligible';

  @override
  String get assetsTooltipKia =>
      'Kleinschaligheidsinvesteringsaftrek (KIA): an additional deduction from your taxable profit for small business investments. You qualify if your total investments in a calendar year fall within the statutory thresholds set by the Dutch tax authority.';

  @override
  String get assetsKiaBadge => 'KIA';

  @override
  String get assetsFieldEiaMia => 'EIA / MIA';

  @override
  String get assetsTooltipEiaMia =>
      'Energie-investeringsaftrek (EIA) and Milieu-investeringsaftrek (MIA): additional tax deductions for investments in energy-efficient or environmentally-friendly business assets listed on the official Energy List or Environmental List published by RVO.';

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
  String get assetsEditAsset => 'Edit asset';

  @override
  String assetsYears(int n) {
    return '$n yrs';
  }

  @override
  String get pensionTitle => 'Pension';

  @override
  String pensionLoadError(String error) {
    return 'Could not load pension data: $error';
  }

  @override
  String get pensionJaarruimte => 'Annual allowance calculation';

  @override
  String get pensionTaxableProfit => 'Taxable profit';

  @override
  String get pensionAowFranchise => 'AOW franchise';

  @override
  String get pensionPensioengrondslag => 'Pension base';

  @override
  String get pensionJaarruimte30 => 'Annual allowance (30%)';

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
  String get pensionFactorAHelper => 'Pension accrual with employer / BV';

  @override
  String get pensionReserveringsruimteLabel =>
      'Unused annual allowance from prior years';

  @override
  String get pensionPlannedSection => 'Planned contribution';

  @override
  String get pensionLijfrente => 'Annuity premium / AOV premium';

  @override
  String get pensionLijfrenteHelper =>
      'Included as deduction in tax calculation';

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
  String vatReturnIcpDeadline(String date) {
    return 'Deadline same as VAT return: $date.';
  }

  @override
  String get vatReturnStatusSection => 'Processing status';

  @override
  String get vatReturnFiled => 'Return filed';

  @override
  String get vatReturnPaid => 'VAT paid';

  @override
  String vatReturnYtdRevenue(String amount) {
    return 'YTD revenue: $amount';
  }

  @override
  String vatReturnLoadError(String error) {
    return 'Could not load VAT return data: $error';
  }

  @override
  String get vatReturnDue => 'VAT due';

  @override
  String get vatReturnRefund => 'VAT refund';

  @override
  String vatReturnKorWarning(String ytd, String max) {
    return 'KOR threshold reached ($ytd of $max). Charge VAT from next transaction.';
  }

  @override
  String get vatRow1a => '1a  Supplies / services taxed at 21%';

  @override
  String get vatRow1b => '1b  Supplies / services taxed at 9%';

  @override
  String get vatRow1c => '1c  Supplies / services taxed at 0% (export)';

  @override
  String get vatRow3a => '3a  Supplies to EU businesses (ICP / RC)';

  @override
  String get vatRow5a => '5a  VAT on revenue';

  @override
  String get vatRow5b => '5b  Input tax (to reclaim)';

  @override
  String get plTaxTitle => 'P&L / Tax';

  @override
  String plTaxLoadError(String error) {
    return 'Could not load P&L / tax data: $error';
  }

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
    return 'Mileage allowance (${km}km × €$rate)';
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
    return 'Self-employed deduction $year';
  }

  @override
  String get plTaxStartersaftrek => 'Starter deduction';

  @override
  String plTaxMkb(String pct) {
    return 'SME profit exemption ($pct%)';
  }

  @override
  String get plTaxKia => 'KIA deduction';

  @override
  String get plTaxLijrente => 'Annuity deduction';

  @override
  String get plTaxTaxableProfit => 'Taxable profit';

  @override
  String get plTaxBox1Section => 'Income tax box 1';

  @override
  String plTaxBracket1(String pct) {
    return 'Bracket 1 ($pct%)';
  }

  @override
  String plTaxBracket2(String pct) {
    return 'Bracket 2 ($pct%)';
  }

  @override
  String plTaxBracket3(String pct) {
    return 'Bracket 3 ($pct%)';
  }

  @override
  String get plTaxAlgHeffing => 'General tax credit';

  @override
  String get plTaxArbeidskorting => 'Labour tax credit';

  @override
  String plTaxDeduct(String label) {
    return 'Less: $label';
  }

  @override
  String plTaxMax(String amount) {
    return '(max $amount)';
  }

  @override
  String get plTaxInkomsten => 'Income tax';

  @override
  String plTaxZvw(String pct) {
    return 'ZVW contribution ($pct%)';
  }

  @override
  String get plTaxTotalTax => 'Total tax';

  @override
  String get plTaxNetProfit => 'Net profit after tax';

  @override
  String plTaxEffectiveRate(String rate) {
    return 'Effective rate: $rate%';
  }

  @override
  String get plTaxSettingsSection => 'Settings';

  @override
  String get plTaxClaimZelfs => 'Claim self-employed deduction';

  @override
  String get plTaxClaimStarters => 'Claim starter deduction';

  @override
  String plTaxUrenBanner(String hours, String suffix) {
    return 'Urencriterium: $hours / 1,225 hrs logged$suffix.';
  }

  @override
  String get plTaxUrenBannerSuffixDone => ', self-employed deduction lapses';

  @override
  String get plTaxUrenBannerSuffixPending => ', not yet reached';

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
  String get settingsStartersaftrek => 'Eligible for startersaftrek';

  @override
  String get settingsValidateName => 'Enter your business name';

  @override
  String get settingsValidateVat =>
      'Enter your BTW number, e.g. NL123456789B01.';

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
  String get actionOk => 'OK';

  @override
  String get settingsSaved => 'Business details saved';

  @override
  String get settingsDatabaseSection => 'Database';

  @override
  String settingsDatabaseLocation(String path) {
    return 'Location: $path';
  }

  @override
  String get settingsDatabaseNotSet => 'Not set';

  @override
  String get settingsMoveDatabase => 'Move database…';

  @override
  String settingsDatabaseMoved(String path) {
    return 'Database file moved to: $path';
  }

  @override
  String get settingsExportSection => 'Export';

  @override
  String settingsExportDescription(int year) {
    return 'Export all $year data to CSV files.';
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
    return 'Tax parameters $year';
  }

  @override
  String settingsTaxNoParams(int year) {
    return 'No parameters found for $year. Restart the app after creating a database.';
  }

  @override
  String get settingsTaxRates => 'Rates & brackets';

  @override
  String get settingsTaxZelfs => 'Self-employed deduction';

  @override
  String get settingsTaxStarters => 'Starter deduction';

  @override
  String get settingsTaxMkb => 'MKB-winstvrijstelling (%)';

  @override
  String get settingsTaxMileage => 'Mileage rate (€/km)';

  @override
  String get settingsTaxBrackets => 'Income tax brackets';

  @override
  String get settingsTaxB1Rate => 'Bracket 1 rate (%)';

  @override
  String get settingsTaxB1Thresh => 'Bracket 1 threshold';

  @override
  String get settingsTaxB2Rate => 'Bracket 2 rate (%)';

  @override
  String get settingsTaxB2Thresh => 'Bracket 2 threshold';

  @override
  String get settingsTaxB3Rate => 'Bracket 3 rate (%)';

  @override
  String get settingsTaxKortingen => 'Discounts & ZVW';

  @override
  String get settingsTaxAlgHeff => 'General tax credit max';

  @override
  String get settingsTaxArbeids => 'Labour credit max';

  @override
  String get settingsTaxZvwRate => 'ZVW rate (%)';

  @override
  String get settingsTaxZvwMax => 'ZVW max';

  @override
  String get settingsTaxUrencriterium => 'Hours criterion';

  @override
  String get settingsTaxKia => 'KIA deduction';

  @override
  String get settingsTaxKiaLowerThresh => 'Lower threshold';

  @override
  String get settingsTaxKiaUpperThresh => 'Upper threshold';

  @override
  String get settingsTaxKiaFlatThresh => 'Flat threshold';

  @override
  String get settingsTaxKiaRate => 'KIA rate (%)';

  @override
  String get settingsTaxKiaFlatAmount => 'Flat amount';

  @override
  String get settingsTaxKiaDecreaseRate => 'Decrease rate (%)';

  @override
  String get settingsTaxKor => 'KOR threshold';

  @override
  String get settingsTaxKorThresh => 'KOR threshold';

  @override
  String get settingsTaxSaveParams => 'Save parameters';

  @override
  String settingsTaxParamsSaved(int year) {
    return 'Tax parameters saved for $year';
  }

  @override
  String get settingsTaxValidateField => 'Enter a valid number.';

  @override
  String get firstLaunchWelcome => 'Welcome to Florin';

  @override
  String get firstLaunchSubtitle => 'Set up your bookkeeping workspace.';

  @override
  String get firstLaunchDbSection => 'Database location';

  @override
  String get firstLaunchDbDescription =>
      'Default: Application Support. Choose another folder for iCloud / Google Drive sync.';

  @override
  String get firstLaunchDbDefault => 'Application Support (default)';

  @override
  String get firstLaunchChooseFolder => 'Choose folder';

  @override
  String get firstLaunchBusinessSection => 'Business identity';

  @override
  String get firstLaunchStartersSubtitle =>
      'First 3 years of business: €2,123 additional deduction';

  @override
  String get firstLaunchGetStarted => 'Get started';

  @override
  String firstLaunchSaveError(String error) {
    return 'Could not finish setup: $error';
  }

  @override
  String get confirmDeleteTitle => 'Delete';

  @override
  String get confirmDeleteCancel => 'Cancel';

  @override
  String get confirmDeleteConfirm => 'Delete';

  @override
  String get deadlineBadgeFiled => 'Filed';

  @override
  String get deadlineBadgeOverdue => 'Overdue';

  @override
  String deadlineBadgeDays(int days) {
    return '$days days';
  }

  @override
  String get vatRateSelectorLabel => 'VAT rate';

  @override
  String get vatRate21 => '21%';

  @override
  String get vatRate9 => '9%';

  @override
  String get vatRate0 => '0%';

  @override
  String get vatRateEuReverseCharge => '0% EU reverse charge';

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
  String get amountNegativeError => 'Amount cannot be negative';
}
