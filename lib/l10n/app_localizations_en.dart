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
      'High Wet DBA risk: the Belastingdienst may treat this work as employment. Review the working relationship with an adviser.';

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
  String assetsFieldUsefulLifeMin(int years) {
    return 'Enter at least $years years: depreciation is limited to 20% of the cost a year';
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
  String get vatRow1a => '1a  Supplies / services taxed at 21%';

  @override
  String get vatRow1b => '1b  Supplies / services taxed at 9%';

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
  String get plTaxInkomsten => 'Income tax';

  @override
  String plTaxZvw(String pct) {
    return 'ZVW contribution ($pct%)';
  }

  @override
  String get plTaxTotalTax => 'Estimated total tax';

  @override
  String get plTaxNetProfit => 'Estimated net profit after tax';

  @override
  String plTaxEffectiveRate(String rate) {
    return 'Effective rate: $rate%';
  }

  @override
  String plTaxUrenBanner(String hours, String target, String suffix) {
    return 'Urencriterium: $hours of $target hours logged$suffix.';
  }

  @override
  String get plTaxUrenBannerSuffixDone => ', so no zelfstandigenaftrek';

  @override
  String get plTaxUrenBannerSuffixPending =>
      '. The estimate assumes you reach it this year';

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
  String get firstLaunchDbDefault => 'Application Support (default)';

  @override
  String get firstLaunchChooseFolder => 'Choose folder';

  @override
  String get firstLaunchStartersSubtitle =>
      'For business owners who were not a business owner in one or more of the 5 previous years, and used the zelfstandigenaftrek at most twice in that period';

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
  String get vatRate21 => '21%';

  @override
  String get vatRate9 => '9%';

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
  String get expensesFoodNotice =>
      'Food, drinks and representation are 80% deductible for income tax (Wet IB 2001 art. 3.15). VAT on food and drinks consumed in a restaurant, café or hotel cannot be reclaimed (Wet OB 1968 art. 15).';

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
      'This is an estimate for a business owner under the AOW age with no other income. Income from employment, a partner, box 2 or box 3 is not included.';

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
  String get vatReturnIcpNote =>
      'Report these supplies in the ICP report. Goods to EU businesses above € 50.000 in a quarter must be reported per month.';

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
      'The purchase price without VAT. Depreciation and the investment deductions are based on this amount.';

  @override
  String get assetsFieldDisposalDateHelp =>
      'The date you sold the asset or took it out of the business. Depreciation stops on this date.';

  @override
  String get assetsFieldDisposalProceedsHelp =>
      'What you received for the asset, without VAT. The difference with the book value is a gain or loss.';

  @override
  String get assetsFieldKiaHelp =>
      'Kleinschaligheidsinvesteringsaftrek: an extra deduction for business assets. Assets under € 450 do not count, and passenger cars and some other assets are excluded.';

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
  String get assetsFieldUsefulLifeHelp =>
      'How many years you expect to use the asset. At least 5, because depreciation is limited to 20% of the cost a year.';

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
      'What kind of cost this is. Food, drinks and representation are only partly deductible.';

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
  String get expensesFieldVatRateHelp =>
      'The VAT rate on the receipt: 21%, 9%, 0% or exempt.';

  @override
  String get expensesReclaimVatHelp =>
      'Tick when you may deduct this VAT in your VAT return. Not for food and drinks in a restaurant, or for private use.';

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
  String get hoursFieldWorkTypeHelp =>
      'The kind of work. WBSO hours count towards the 500 hours needed for the S&O-aftrek.';

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
  String get invoiceFieldUnitHelp =>
      'The unit of the quantity, such as hours or pieces.';

  @override
  String get invoiceFieldVatHelp => 'The VAT rate for this line.';

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
      'The pension you built up with an employer last year, from the factor A on your UPO. Leave 0 if you had none.';

  @override
  String get pensionLijfrenteHelp =>
      'What you pay or plan to pay into a lijfrente this year. Deducted up to the room you have.';

  @override
  String get pensionMonthlyPremiumHelp =>
      'The monthly premium of your disability insurance.';

  @override
  String get pensionPriorYearIncomeHelp =>
      'Your profit from business and wages last year, from that year\'s tax return. The jaarruimte is based on it.';

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
  String get settingsStartersaftrekHelp =>
      'You get the startersaftrek if you were not a business owner in at least one of the 5 previous years and used the zelfstandigenaftrek at most twice in that period.';

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
      'These details decide the addition for private use (bijtelling) and the VAT on private use.';

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
  String get assetsFieldVatOnPurchase => 'VAT deducted on purchase';

  @override
  String get assetsFieldVatOnPurchaseHelp =>
      'The VAT on the purchase that you deducted in your VAT return. Leave 0 if you deducted none, for example for a car bought from a private seller.';

  @override
  String get assetsFieldMarketValue => 'Market value';

  @override
  String get assetsFieldMarketValueHelp =>
      'What the car is worth now. Only used once the car is more than 15 years old.';

  @override
  String get assetsFieldTripLog => 'I keep a complete trip log for this car';

  @override
  String get assetsFieldTripLogHelp =>
      'With a complete trip log of all trips in this car, there is no bijtelling at 500 private km a year or less, and VAT on private use is based on the actual kilometres.';

  @override
  String get assetsInvestmentSection => 'Investment deductions';

  @override
  String get assetsInvestmentSectionHelp =>
      'Extra deductions in the year of purchase. If you sell the asset within 5 years, part of them is added back.';

  @override
  String get assetsFieldEia => 'Energy investment (EIA), reported to RVO';

  @override
  String get assetsFieldEiaHelp =>
      'An asset on the RVO Energy List, reported to RVO within 3 months. At least € 2.500 per asset. Cannot be combined with MIA.';

  @override
  String get assetsFieldMia => 'Environmental investment (MIA)';

  @override
  String get assetsFieldMiaHelp =>
      'The category on the RVO Environmental List, reported to RVO within 3 months. At least € 2.500 per asset.';

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
  String get assetsFieldDeductionReceivedHelp =>
      'The KIA, EIA and MIA you received for this asset in its purchase year, from that year\'s tax return. Needed to add part back if you sell it within 5 years.';

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
  String get assetsFieldReserveGainHelp =>
      'Only when you intend to buy a replacement. The gain is then not taxed now but booked off on the next purchase; unused after 3 years, it is added to your profit.';

  @override
  String get dashboardDeductibleCostsHelp =>
      'Costs deductible for income tax, including depreciation and the mileage allowance. Estimated.';

  @override
  String get dashboardEstimatedTaxHelp =>
      'Estimated income tax and Zvw contribution on your profit so far. Not a tax assessment.';

  @override
  String get dashboardNetProfitAfterTaxHelp =>
      'Profit minus the estimated tax. An estimate, not a final figure.';

  @override
  String get expensesFieldCar => 'Business car';

  @override
  String get expensesFieldCarHelp =>
      'Link costs such as fuel and insurance to a business car. They cap the bijtelling and decide the VAT on private use.';

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
  String get inputPartnerHoursHelp =>
      'Hours your fiscal partner worked in your business this year without pay, or for less than € 5.000. From 525 hours you get the meewerkaftrek.';

  @override
  String get inputUnrealisedZelfs => 'Unused zelfstandigenaftrek';

  @override
  String get inputUnrealisedZelfsHelp =>
      'Zelfstandigenaftrek from the previous 9 years that did not fit your profit, as stated by the Belastingdienst. Used up to this year\'s profit.';

  @override
  String get inputLossCarryForward => 'Losses from earlier years';

  @override
  String get inputLossCarryForwardHelp =>
      'Box 1 losses from earlier years still to offset, as stated by the Belastingdienst. Offset against this year\'s income.';

  @override
  String get inputSoVerklaring => 'I have an S&O-verklaring for this year';

  @override
  String get inputSoVerklaringHelp =>
      'An S&O-verklaring from RVO for research and development. With at least 500 WBSO hours you get the S&O-aftrek.';

  @override
  String get inputSoStarter => 'Starter increase for the S&O-aftrek';

  @override
  String get inputSoStarterHelp =>
      'You were not a business owner in one or more of the 5 previous years and received an S&O-verklaring for at most 2 years in that period.';

  @override
  String get inputBusinessCeased => 'I stopped the whole business this year';

  @override
  String get inputBusinessCeasedHelp =>
      'Gains on selling or taking over the business assets are stakingswinst. You get the stakingsaftrek on them, and any herinvesteringsreserve is added to your profit.';

  @override
  String get inputStakingsUsedBefore => 'Stakingsaftrek used before';

  @override
  String get inputStakingsUsedBeforeHelp =>
      'Stakingsaftrek you received in earlier years. It lowers the maximum of € 3.630.';

  @override
  String get inputDisabilityBenefit => 'I receive a disability benefit';

  @override
  String get inputDisabilityBenefitHelp =>
      'A benefit such as WIA, WAO, WAZ or Wajong. As a starter with at least 800 but under 1.225 hours you may get the startersaftrek bij arbeidsongeschiktheid.';

  @override
  String get inputDisabilityUsed => 'Years used in the previous 5';

  @override
  String get inputDisabilityUsedHelp =>
      'How many of the previous 5 years you received the startersaftrek bij arbeidsongeschiktheid: 0, 1, 2 or 3.';

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
  String get pensionJaarruimteHelp =>
      '30% of the premiegrondslag minus a multiple of factor A, up to the yearly maximum. What you may deduct for a lijfrente this year.';

  @override
  String get pensionEstimatedTaxSavingHelp =>
      'Estimated: the box 1 tax you save by deducting the premium, before heffingskortingen.';

  @override
  String get plTaxAlgHeffingHelp =>
      'A tax credit everyone gets. It decreases as income rises above a threshold.';

  @override
  String get plTaxArbeidskortingHelp =>
      'A tax credit for working people, based on profit before ondernemersaftrek and mkb-winstvrijstelling.';

  @override
  String get plTaxAovHelp =>
      'Premiums for private disability insurance are fully deductible from box 1 income.';

  @override
  String get plTaxBelastbareWinstHelp =>
      'Profit after ondernemersaftrek and mkb-winstvrijstelling. The Zvw contribution is based on it.';

  @override
  String get plTaxBox1SectionHelp =>
      'Estimated income tax including national insurance premiums, in brackets, minus the heffingskortingen.';

  @override
  String get plTaxCarPrivateUse => 'Private use of business car';

  @override
  String get plTaxCarPrivateUseHelp =>
      'The bijtelling: a percentage of the catalogue value added to profit for private use, at most the car costs. None with a trip log of 500 private km a year or less.';

  @override
  String get plTaxDeductionsSectionHelp =>
      'Deductions for business owners. Most require the urencriterium of 1.225 hours.';

  @override
  String get plTaxDepreciationHelp =>
      'The part of your assets\' cost written off this year, spread by day over their useful life.';

  @override
  String get plTaxDesinvestering => 'Desinvesteringsbijtelling';

  @override
  String get plTaxDesinvesteringHelp =>
      'Part of an investment deduction added back because an asset was sold within 5 years of the start of its purchase year.';

  @override
  String get plTaxDisabilityStarters =>
      'Startersaftrek bij arbeidsongeschiktheid';

  @override
  String get plTaxDisabilityStartersHelp =>
      'For starters with a disability benefit who work at least 800 hours but do not meet the urencriterium. At most the profit.';

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
    return 'Food, drinks and representation are deductible for $pct%, or above the first $drempel. Florin uses whichever gives the larger deduction.';
  }

  @override
  String plTaxInputsSection(int year) {
    return 'Your situation in $year';
  }

  @override
  String get plTaxInputsSectionHelp =>
      'Facts the bookkeeping cannot show. They change the estimate above.';

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
  String get plTaxMeewerkHelp =>
      'A percentage of profit when your fiscal partner works at least 525 hours in the business without pay.';

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
      'Profit from business before ondernemersaftrek. The arbeidskorting is based on it.';

  @override
  String get plTaxReserveReleased => 'Herinvesteringsreserve released';

  @override
  String get plTaxReserveReleasedHelp =>
      'Reserve not used within 3 years, or left when the business stops, is added to profit.';

  @override
  String get plTaxSo => 'S&O-aftrek';

  @override
  String get plTaxSoHelp =>
      'For research and development with an S&O-verklaring and at least 500 hours.';

  @override
  String get plTaxStakings => 'Stakingsaftrek';

  @override
  String get plTaxStakingsHelp =>
      'A deduction on the gain when the whole business stops, up to € 3.630 over your lifetime.';

  @override
  String get plTaxStartersaftrekHelp =>
      'An extra deduction on top of the zelfstandigenaftrek for business owners who recently started.';

  @override
  String get plTaxTaxableProfitHelp =>
      'The income in box 1 the tax is calculated on.';

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
      'The income-related contribution to the health care insurance act, on belastbare winst up to a maximum.';

  @override
  String get vatReturnIcpSectionHelp =>
      'Supplies to businesses in other EU countries, reported separately in the ICP report.';

  @override
  String get vatRow1aHelp => 'Revenue taxed at 21% and the VAT on it.';

  @override
  String get vatRow1bHelp => 'Revenue taxed at 9% and the VAT on it.';

  @override
  String get vatRow1d => '1d  Private use';

  @override
  String get vatRow1dHelp =>
      'VAT on private use of business cars: 2,7% or 1,5% of the catalogue value, or the actual private share with a trip log. In the last return of the year only.';

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
  String get clientsBadgeMerchantOfRecord => 'Merchant of record';

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
  String get settingsKorStartHelp =>
      'The first day the kleineondernemersregeling (KOR) applies to you, as in the Belastingdienst\'s confirmation. Under the KOR you charge no VAT, file no regular VAT return and reclaim no VAT, while your turnover in the Netherlands stays at most € 20.000 a year. Leave empty when you do not take part.';

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
  String get dashboardKorHelp =>
      'Your turnover that counts for the kleineondernemersregeling: supplies taxed in the Netherlands, including 0% and domestic reverse charge, not services taxed abroad. Above € 20.000 in a calendar year the KOR ends with the supply that passes the limit, for the rest of that year and the next.';

  @override
  String get deadlineStatusKor => 'no return (KOR)';

  @override
  String get deadlineBadgeKor => 'No return: KOR';

  @override
  String get vatReturnKorNotice =>
      'You take part in the KOR for this whole quarter: you charge no VAT and file no regular return. When VAT was shifted to you (2a, 4a or 4b), you may still owe it in an incidental return: the Belastingdienst\'s Incidentele btw-aangifte tool says whether you do. Florin shows those amounts below.';

  @override
  String get vatReturnKorPartNotice =>
      'The KOR applies for part of this quarter. Invoices exempt under the KOR are not in the return and VAT on purchases in that part is not reclaimed. File a return for the part outside the KOR.';

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
  String get settingsKorSectionHelp =>
      'A BTW exemption for businesses with at most € 20.000 turnover in the Netherlands a year. You join and leave it with the Belastingdienst; enter its dates here so Florin follows it.';

  @override
  String get receiptTypeEInvoice => 'E-invoice (UBL)';

  @override
  String get receiptsTitle => 'Receipts';

  @override
  String get receiptsHelp =>
      'The receipt or invoice for this expense, as a PDF, photo or scan. Florin copies it into the receipts folder next to your database and leaves your file as it is. The Belastingdienst asks you to keep receipts and invoices for 7 years in the form you received them; a scan or photo must show the whole document, front and back.';

  @override
  String get receiptsAssetTitle => 'Purchase invoice and receipts';

  @override
  String get receiptsAssetHelp =>
      'The purchase invoice of this asset and any other proof, as a PDF, photo or scan. It belongs in your records while the asset is in use, and 7 years after that.';

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
  String get receiptsRemove => 'Move to the trash';

  @override
  String get receiptsUnstage => 'Do not add';

  @override
  String get receiptsRemoved => 'Moved to the receipts trash';

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
  String get receiptsKeepUntilHelp =>
      'The Belastingdienst asks you to keep invoices and receipts for 7 years. Florin counts them from the end of the year they belong to and never deletes them itself.';

  @override
  String get receiptsKeepWhileInUse => 'While in use, then 7 years';

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
      'Florin keeps the receipt files of expenses and assets, and the PDFs of issued invoices, in a receipts folder next to the database. It moves with the database and belongs in the same backup.';

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
  String settingsEmptyTrash(int count) {
    return 'Empty trash ($count)';
  }

  @override
  String get settingsEmptyTrashTitle => 'Empty the receipts trash';

  @override
  String settingsEmptyTrashMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count removed files are deleted for good.',
      one: '1 removed file is deleted for good.',
    );
    return '$_temp0 Keep receipts for 7 years: only empty the trash when you are sure none of them is still needed.';
  }

  @override
  String get settingsReceiptsOpenFailed => 'The folder could not be opened';
}
