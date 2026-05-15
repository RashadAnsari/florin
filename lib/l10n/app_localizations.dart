import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Florin'**
  String get appTitle;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get navInvoices;

  /// No description provided for @navClients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get navClients;

  /// No description provided for @navExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get navExpenses;

  /// No description provided for @navVatReturn.
  ///
  /// In en, this message translates to:
  /// **'VAT Return'**
  String get navVatReturn;

  /// No description provided for @navPlTax.
  ///
  /// In en, this message translates to:
  /// **'P&L & Tax'**
  String get navPlTax;

  /// No description provided for @navHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get navHours;

  /// No description provided for @navMileage.
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get navMileage;

  /// No description provided for @navAssets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get navAssets;

  /// No description provided for @navPension.
  ///
  /// In en, this message translates to:
  /// **'Pension'**
  String get navPension;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navYear.
  ///
  /// In en, this message translates to:
  /// **'Year:'**
  String get navYear;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get actionConfirm;

  /// No description provided for @actionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get actionAdd;

  /// No description provided for @actionNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get actionNew;

  /// No description provided for @labelRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get labelRequired;

  /// No description provided for @labelDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get labelDate;

  /// No description provided for @labelNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get labelNotes;

  /// No description provided for @labelDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get labelDescription;

  /// No description provided for @labelAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get labelAmount;

  /// No description provided for @labelAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get labelAddress;

  /// No description provided for @labelName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get labelName;

  /// No description provided for @labelCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get labelCategory;

  /// No description provided for @labelAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get labelAll;

  /// No description provided for @labelSearch.
  ///
  /// In en, this message translates to:
  /// **'Search…'**
  String get labelSearch;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard {year}'**
  String dashboardTitle(int year);

  /// No description provided for @dashboardNetRevenue.
  ///
  /// In en, this message translates to:
  /// **'Net revenue'**
  String get dashboardNetRevenue;

  /// No description provided for @dashboardDeductibleCosts.
  ///
  /// In en, this message translates to:
  /// **'Costs (deductible)'**
  String get dashboardDeductibleCosts;

  /// No description provided for @dashboardEstimatedTax.
  ///
  /// In en, this message translates to:
  /// **'Estimated tax'**
  String get dashboardEstimatedTax;

  /// No description provided for @dashboardEffectiveRate.
  ///
  /// In en, this message translates to:
  /// **'Effective {rate}%'**
  String dashboardEffectiveRate(String rate);

  /// No description provided for @dashboardNetProfitAfterTax.
  ///
  /// In en, this message translates to:
  /// **'Net profit after tax'**
  String get dashboardNetProfitAfterTax;

  /// No description provided for @dashboardOutstandingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Outstanding invoices'**
  String get dashboardOutstandingInvoices;

  /// No description provided for @dashboardInvoiceCount.
  ///
  /// In en, this message translates to:
  /// **'{count} invoice(s)'**
  String dashboardInvoiceCount(int count);

  /// No description provided for @dashboardUrencriterium.
  ///
  /// In en, this message translates to:
  /// **'Urencriterium'**
  String get dashboardUrencriterium;

  /// No description provided for @dashboardHoursProgress.
  ///
  /// In en, this message translates to:
  /// **'{total} / {target} hrs'**
  String dashboardHoursProgress(String total, String target);

  /// No description provided for @dashboardBtwDeadlines.
  ///
  /// In en, this message translates to:
  /// **'BTW-deadlines'**
  String get dashboardBtwDeadlines;

  /// No description provided for @dashboardMonthlyRevenue.
  ///
  /// In en, this message translates to:
  /// **'Monthly revenue'**
  String get dashboardMonthlyRevenue;

  /// No description provided for @deadlineStatusFiled.
  ///
  /// In en, this message translates to:
  /// **'filed'**
  String get deadlineStatusFiled;

  /// No description provided for @deadlineStatusOverdue.
  ///
  /// In en, this message translates to:
  /// **'overdue'**
  String get deadlineStatusOverdue;

  /// No description provided for @deadlineDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{days} d'**
  String deadlineDaysLeft(int days);

  /// No description provided for @genericLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load data: {error}'**
  String genericLoadError(String error);

  /// No description provided for @invoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoicesTitle;

  /// No description provided for @invoicesNewTooltip.
  ///
  /// In en, this message translates to:
  /// **'New invoice'**
  String get invoicesNewTooltip;

  /// No description provided for @invoicesNone.
  ///
  /// In en, this message translates to:
  /// **'No invoices'**
  String get invoicesNone;

  /// No description provided for @invoicesSelectOrNew.
  ///
  /// In en, this message translates to:
  /// **'Select an invoice or create a new one'**
  String get invoicesSelectOrNew;

  /// No description provided for @invoicesNewHeader.
  ///
  /// In en, this message translates to:
  /// **'New invoice'**
  String get invoicesNewHeader;

  /// No description provided for @invoicesFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get invoicesFilterAll;

  /// No description provided for @invoicesFilterOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get invoicesFilterOverdue;

  /// No description provided for @invoiceStatusConcept.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get invoiceStatusConcept;

  /// No description provided for @invoiceStatusSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get invoiceStatusSent;

  /// No description provided for @invoiceStatusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get invoiceStatusPaid;

  /// No description provided for @invoiceStatusOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get invoiceStatusOverdue;

  /// No description provided for @invoiceStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get invoiceStatusCancelled;

  /// No description provided for @invoiceStatusRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get invoiceStatusRefunded;

  /// No description provided for @invoiceTypeInvoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoiceTypeInvoice;

  /// No description provided for @invoiceTypeCreditNote.
  ///
  /// In en, this message translates to:
  /// **'Credit note'**
  String get invoiceTypeCreditNote;

  /// No description provided for @invoiceFieldType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get invoiceFieldType;

  /// No description provided for @invoiceFieldClient.
  ///
  /// In en, this message translates to:
  /// **'Client *'**
  String get invoiceFieldClient;

  /// No description provided for @invoiceFieldNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice number *'**
  String get invoiceFieldNumber;

  /// No description provided for @invoiceFieldInvoiceDate.
  ///
  /// In en, this message translates to:
  /// **'Invoice date *'**
  String get invoiceFieldInvoiceDate;

  /// No description provided for @invoiceFieldSupplyDate.
  ///
  /// In en, this message translates to:
  /// **'Supply date'**
  String get invoiceFieldSupplyDate;

  /// No description provided for @invoiceFieldPaymentTerm.
  ///
  /// In en, this message translates to:
  /// **'Term (days) *'**
  String get invoiceFieldPaymentTerm;

  /// No description provided for @invoiceValidatePaymentTerm.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number of days (e.g. 14 or 30)'**
  String get invoiceValidatePaymentTerm;

  /// No description provided for @invoiceFieldDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get invoiceFieldDueDate;

  /// No description provided for @invoiceFieldIcp.
  ///
  /// In en, this message translates to:
  /// **'ICP (intracommunautair)'**
  String get invoiceFieldIcp;

  /// No description provided for @invoiceTooltipIcp.
  ///
  /// In en, this message translates to:
  /// **'Intra-Community transactions (ICP): sales of goods or services to VAT-registered clients in EU countries outside the Netherlands. These must be reported separately in the ICP declaration alongside your VAT return.'**
  String get invoiceTooltipIcp;

  /// No description provided for @invoiceWarnIcpNoVat.
  ///
  /// In en, this message translates to:
  /// **'The selected client has no VAT number. The ICP declaration requires a valid EU VAT number for the client.'**
  String get invoiceWarnIcpNoVat;

  /// No description provided for @invoiceFieldBtwVerlegd.
  ///
  /// In en, this message translates to:
  /// **'BTW verlegd'**
  String get invoiceFieldBtwVerlegd;

  /// No description provided for @invoiceTooltipBtwVerlegd.
  ///
  /// In en, this message translates to:
  /// **'Reverse charge VAT: the VAT obligation is shifted from you to the recipient. Used when supplying goods or services to VAT-registered businesses, often in cross-border EU transactions. The invoice shows 0% VAT with the note \'BTW verlegd\'.'**
  String get invoiceTooltipBtwVerlegd;

  /// No description provided for @invoiceFieldLines.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get invoiceFieldLines;

  /// No description provided for @invoiceFieldAddLine.
  ///
  /// In en, this message translates to:
  /// **'Add line'**
  String get invoiceFieldAddLine;

  /// No description provided for @invoiceFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description *'**
  String get invoiceFieldDescription;

  /// No description provided for @invoiceHintDescription.
  ///
  /// In en, this message translates to:
  /// **'e.g. Consulting services, web design...'**
  String get invoiceHintDescription;

  /// No description provided for @invoiceFieldQuantity.
  ///
  /// In en, this message translates to:
  /// **'Qty *'**
  String get invoiceFieldQuantity;

  /// No description provided for @invoiceFieldUnit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get invoiceFieldUnit;

  /// No description provided for @invoiceFieldPrice.
  ///
  /// In en, this message translates to:
  /// **'Price (excl.) *'**
  String get invoiceFieldPrice;

  /// No description provided for @invoiceFieldVat.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get invoiceFieldVat;

  /// No description provided for @invoiceFieldVatAmount.
  ///
  /// In en, this message translates to:
  /// **'VAT amount'**
  String get invoiceFieldVatAmount;

  /// No description provided for @invoiceFieldLineTotal.
  ///
  /// In en, this message translates to:
  /// **'Total excl.'**
  String get invoiceFieldLineTotal;

  /// No description provided for @invoiceVatLine.
  ///
  /// In en, this message translates to:
  /// **'VAT {rate}'**
  String invoiceVatLine(String rate);

  /// No description provided for @invoiceValidateLineDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter a line description'**
  String get invoiceValidateLineDescription;

  /// No description provided for @invoiceValidateLineQuantity.
  ///
  /// In en, this message translates to:
  /// **'Enter a quantity greater than zero'**
  String get invoiceValidateLineQuantity;

  /// No description provided for @invoiceValidateLinePrice.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid unit price'**
  String get invoiceValidateLinePrice;

  /// No description provided for @invoiceSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal (excl. VAT)'**
  String get invoiceSubtotal;

  /// No description provided for @invoiceTotalInclVat.
  ///
  /// In en, this message translates to:
  /// **'Total (incl. VAT)'**
  String get invoiceTotalInclVat;

  /// No description provided for @invoiceFieldRemarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get invoiceFieldRemarks;

  /// No description provided for @invoiceActionSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get invoiceActionSend;

  /// No description provided for @invoiceActionMarkPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get invoiceActionMarkPaid;

  /// No description provided for @invoiceActionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get invoiceActionCancel;

  /// No description provided for @invoiceActionMarkRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get invoiceActionMarkRefunded;

  /// No description provided for @invoiceActionExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get invoiceActionExportPdf;

  /// No description provided for @invoiceActionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get invoiceActionDelete;

  /// No description provided for @invoiceDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete invoice'**
  String get invoiceDeleteTitle;

  /// No description provided for @invoiceDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete invoice \"{number}\"?'**
  String invoiceDeleteMessage(String number);

  /// No description provided for @invoiceCreated.
  ///
  /// In en, this message translates to:
  /// **'Invoice created'**
  String get invoiceCreated;

  /// No description provided for @invoiceSaved.
  ///
  /// In en, this message translates to:
  /// **'Invoice saved'**
  String get invoiceSaved;

  /// No description provided for @invoiceDeleted.
  ///
  /// In en, this message translates to:
  /// **'Invoice deleted'**
  String get invoiceDeleted;

  /// No description provided for @invoiceValidateClient.
  ///
  /// In en, this message translates to:
  /// **'Select a client for this invoice'**
  String get invoiceValidateClient;

  /// No description provided for @invoiceValidateNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a unique invoice number, e.g. F-2024-001'**
  String get invoiceValidateNumber;

  /// No description provided for @invoiceUnitHint.
  ///
  /// In en, this message translates to:
  /// **'hrs'**
  String get invoiceUnitHint;

  /// No description provided for @clientsTitle.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clientsTitle;

  /// No description provided for @clientsNewTooltip.
  ///
  /// In en, this message translates to:
  /// **'New client'**
  String get clientsNewTooltip;

  /// No description provided for @clientsNone.
  ///
  /// In en, this message translates to:
  /// **'No clients'**
  String get clientsNone;

  /// No description provided for @clientsSelectOrNew.
  ///
  /// In en, this message translates to:
  /// **'Select a client or create a new one'**
  String get clientsSelectOrNew;

  /// No description provided for @clientsNewHeader.
  ///
  /// In en, this message translates to:
  /// **'New client'**
  String get clientsNewHeader;

  /// No description provided for @clientsShowInactive.
  ///
  /// In en, this message translates to:
  /// **'Show inactive'**
  String get clientsShowInactive;

  /// No description provided for @clientsHideInactive.
  ///
  /// In en, this message translates to:
  /// **'Hide inactive'**
  String get clientsHideInactive;

  /// No description provided for @clientsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get clientsFilterAll;

  /// No description provided for @clientsFilterActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get clientsFilterActive;

  /// No description provided for @clientsFilterInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get clientsFilterInactive;

  /// No description provided for @clientsInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get clientsInactive;

  /// No description provided for @clientsFieldName.
  ///
  /// In en, this message translates to:
  /// **'Name *'**
  String get clientsFieldName;

  /// No description provided for @clientsValidateName.
  ///
  /// In en, this message translates to:
  /// **'Enter the client\'s name'**
  String get clientsValidateName;

  /// No description provided for @clientsFieldCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get clientsFieldCountry;

  /// No description provided for @clientsValidateCountry.
  ///
  /// In en, this message translates to:
  /// **'Use a 2-letter country code (e.g. NL, DE, FR)'**
  String get clientsValidateCountry;

  /// No description provided for @clientsFieldVat.
  ///
  /// In en, this message translates to:
  /// **'VAT number'**
  String get clientsFieldVat;

  /// No description provided for @clientsValidateVat.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid EU VAT number (e.g. NL854224798B01)'**
  String get clientsValidateVat;

  /// No description provided for @clientsFieldKvk.
  ///
  /// In en, this message translates to:
  /// **'KVK number'**
  String get clientsFieldKvk;

  /// No description provided for @clientsValidateKvk.
  ///
  /// In en, this message translates to:
  /// **'KVK number must be exactly 8 digits'**
  String get clientsValidateKvk;

  /// No description provided for @clientsFieldAddress.
  ///
  /// In en, this message translates to:
  /// **'Address *'**
  String get clientsFieldAddress;

  /// No description provided for @clientsValidateAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter the client\'s street address'**
  String get clientsValidateAddress;

  /// No description provided for @clientsFieldContact.
  ///
  /// In en, this message translates to:
  /// **'Contact person'**
  String get clientsFieldContact;

  /// No description provided for @clientsFieldEmail.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get clientsFieldEmail;

  /// No description provided for @clientsValidateEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address (e.g. name@company.nl)'**
  String get clientsValidateEmail;

  /// No description provided for @clientsValidatePhone.
  ///
  /// In en, this message translates to:
  /// **'Digits, spaces, + and dashes only'**
  String get clientsValidatePhone;

  /// No description provided for @clientsFieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get clientsFieldPhone;

  /// No description provided for @clientsFieldActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get clientsFieldActive;

  /// No description provided for @clientsFieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get clientsFieldNotes;

  /// No description provided for @clientsWetDba.
  ///
  /// In en, this message translates to:
  /// **'Wet DBA'**
  String get clientsWetDba;

  /// No description provided for @clientsRiskLevel.
  ///
  /// In en, this message translates to:
  /// **'Risk level'**
  String get clientsRiskLevel;

  /// No description provided for @clientsRiskLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get clientsRiskLow;

  /// No description provided for @clientsRiskMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get clientsRiskMedium;

  /// No description provided for @clientsRiskHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get clientsRiskHigh;

  /// No description provided for @clientsContractSigned.
  ///
  /// In en, this message translates to:
  /// **'Contract signed'**
  String get clientsContractSigned;

  /// No description provided for @clientsContractExpiry.
  ///
  /// In en, this message translates to:
  /// **'Contract expiry date'**
  String get clientsContractExpiry;

  /// No description provided for @clientsHighRiskWarning.
  ///
  /// In en, this message translates to:
  /// **'High Wet DBA risk: ensure a valid assignment agreement is in place.'**
  String get clientsHighRiskWarning;

  /// No description provided for @clientsViesEmptyVat.
  ///
  /// In en, this message translates to:
  /// **'Please enter a VAT number first'**
  String get clientsViesEmptyVat;

  /// No description provided for @clientsCreated.
  ///
  /// In en, this message translates to:
  /// **'Client created'**
  String get clientsCreated;

  /// No description provided for @clientsSaved.
  ///
  /// In en, this message translates to:
  /// **'Client saved'**
  String get clientsSaved;

  /// No description provided for @clientsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete client'**
  String get clientsDeleteTitle;

  /// No description provided for @clientsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String clientsDeleteMessage(String name);

  /// No description provided for @clientsDeleteBlockedTooltip.
  ///
  /// In en, this message translates to:
  /// **'Client has invoices and cannot be deleted'**
  String get clientsDeleteBlockedTooltip;

  /// No description provided for @expensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesTitle;

  /// No description provided for @expensesNewTooltip.
  ///
  /// In en, this message translates to:
  /// **'New expense'**
  String get expensesNewTooltip;

  /// No description provided for @expensesNone.
  ///
  /// In en, this message translates to:
  /// **'No expenses'**
  String get expensesNone;

  /// No description provided for @expensesSelectOrNew.
  ///
  /// In en, this message translates to:
  /// **'Select an expense or add a new one'**
  String get expensesSelectOrNew;

  /// No description provided for @expensesNewHeader.
  ///
  /// In en, this message translates to:
  /// **'New expense'**
  String get expensesNewHeader;

  /// No description provided for @expensesFieldSupplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier *'**
  String get expensesFieldSupplier;

  /// No description provided for @expensesHintSupplier.
  ///
  /// In en, this message translates to:
  /// **'e.g. Albert Heijn, Amazon, KPN'**
  String get expensesHintSupplier;

  /// No description provided for @expensesValidateSupplier.
  ///
  /// In en, this message translates to:
  /// **'Enter the supplier name'**
  String get expensesValidateSupplier;

  /// No description provided for @expensesFieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category *'**
  String get expensesFieldCategory;

  /// No description provided for @expensesValidateCategory.
  ///
  /// In en, this message translates to:
  /// **'Select a category for this expense'**
  String get expensesValidateCategory;

  /// No description provided for @expensesFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description *'**
  String get expensesFieldDescription;

  /// No description provided for @expensesValidateDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter a description for this expense'**
  String get expensesValidateDescription;

  /// No description provided for @expensesFieldAmountExcl.
  ///
  /// In en, this message translates to:
  /// **'Amount (excl. VAT) *'**
  String get expensesFieldAmountExcl;

  /// No description provided for @expensesValidateAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount excluding VAT'**
  String get expensesValidateAmount;

  /// No description provided for @expensesFieldVatRate.
  ///
  /// In en, this message translates to:
  /// **'VAT rate'**
  String get expensesFieldVatRate;

  /// No description provided for @expensesFieldVat.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get expensesFieldVat;

  /// No description provided for @expensesFieldTotalIncl.
  ///
  /// In en, this message translates to:
  /// **'Total (incl. VAT)'**
  String get expensesFieldTotalIncl;

  /// No description provided for @expensesFieldPaidFrom.
  ///
  /// In en, this message translates to:
  /// **'Paid from'**
  String get expensesFieldPaidFrom;

  /// No description provided for @expensesHintPaidFrom.
  ///
  /// In en, this message translates to:
  /// **'e.g. ING business account, Visa card'**
  String get expensesHintPaidFrom;

  /// No description provided for @expensesFieldPaymentRef.
  ///
  /// In en, this message translates to:
  /// **'Payment reference'**
  String get expensesFieldPaymentRef;

  /// No description provided for @expensesHintPaymentRef.
  ///
  /// In en, this message translates to:
  /// **'e.g. INV-2024-0042, SEPA ref 123456'**
  String get expensesHintPaymentRef;

  /// No description provided for @expensesBusinessUse.
  ///
  /// In en, this message translates to:
  /// **'Business use'**
  String get expensesBusinessUse;

  /// No description provided for @expensesBusinessUsePct.
  ///
  /// In en, this message translates to:
  /// **'{pct}% business'**
  String expensesBusinessUsePct(int pct);

  /// No description provided for @expensesDeductible.
  ///
  /// In en, this message translates to:
  /// **'Deductible'**
  String get expensesDeductible;

  /// No description provided for @expensesReclaimVat.
  ///
  /// In en, this message translates to:
  /// **'Reclaim VAT'**
  String get expensesReclaimVat;

  /// No description provided for @expensesVatBack.
  ///
  /// In en, this message translates to:
  /// **'VAT back'**
  String get expensesVatBack;

  /// No description provided for @expensesVatBackAmount.
  ///
  /// In en, this message translates to:
  /// **'VAT back: {amount}'**
  String expensesVatBackAmount(String amount);

  /// No description provided for @expensesMixedCosts.
  ///
  /// In en, this message translates to:
  /// **'Mixed costs'**
  String get expensesMixedCosts;

  /// No description provided for @expensesReceiptAttached.
  ///
  /// In en, this message translates to:
  /// **'Receipt attached'**
  String get expensesReceiptAttached;

  /// No description provided for @expensesBuaWarning.
  ///
  /// In en, this message translates to:
  /// **'BUA: meals & entertainment above €227. VAT deduction may be restricted (Besluit Uitsluiting Aftrek).'**
  String get expensesBuaWarning;

  /// No description provided for @expensesCreated.
  ///
  /// In en, this message translates to:
  /// **'Expense created'**
  String get expensesCreated;

  /// No description provided for @expensesSaved.
  ///
  /// In en, this message translates to:
  /// **'Expense saved'**
  String get expensesSaved;

  /// No description provided for @expensesDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete expense'**
  String get expensesDeleteTitle;

  /// No description provided for @expensesDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this expense?'**
  String get expensesDeleteMessage;

  /// No description provided for @expenseCatOffice.
  ///
  /// In en, this message translates to:
  /// **'Office & supplies'**
  String get expenseCatOffice;

  /// No description provided for @expenseCatTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel & accommodation'**
  String get expenseCatTravel;

  /// No description provided for @expenseCatMeals.
  ///
  /// In en, this message translates to:
  /// **'Meals & entertainment'**
  String get expenseCatMeals;

  /// No description provided for @expenseCatSoftware.
  ///
  /// In en, this message translates to:
  /// **'Software & subscriptions'**
  String get expenseCatSoftware;

  /// No description provided for @expenseCatHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware & equipment'**
  String get expenseCatHardware;

  /// No description provided for @expenseCatMarketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing & advertising'**
  String get expenseCatMarketing;

  /// No description provided for @expenseCatProfessional.
  ///
  /// In en, this message translates to:
  /// **'Professional services'**
  String get expenseCatProfessional;

  /// No description provided for @expenseCatPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone & internet'**
  String get expenseCatPhone;

  /// No description provided for @expenseCatInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get expenseCatInsurance;

  /// No description provided for @expenseCatTraining.
  ///
  /// In en, this message translates to:
  /// **'Training & education'**
  String get expenseCatTraining;

  /// No description provided for @expenseCatOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get expenseCatOther;

  /// No description provided for @hoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Hour registration'**
  String get hoursTitle;

  /// No description provided for @hoursNone.
  ///
  /// In en, this message translates to:
  /// **'No hours registered'**
  String get hoursNone;

  /// No description provided for @hoursSelectOrNew.
  ///
  /// In en, this message translates to:
  /// **'Select an entry or click +'**
  String get hoursSelectOrNew;

  /// No description provided for @hoursBillable.
  ///
  /// In en, this message translates to:
  /// **'Billable: {hours} hrs'**
  String hoursBillable(String hours);

  /// No description provided for @hoursUnitShort.
  ///
  /// In en, this message translates to:
  /// **'hrs'**
  String get hoursUnitShort;

  /// No description provided for @hoursProgress.
  ///
  /// In en, this message translates to:
  /// **'{total} / {target} hrs'**
  String hoursProgress(String total, String target);

  /// No description provided for @hoursUrencriteriumOk.
  ///
  /// In en, this message translates to:
  /// **'Urencriterium OK'**
  String get hoursUrencriteriumOk;

  /// No description provided for @hoursUrencriteriumLeft.
  ///
  /// In en, this message translates to:
  /// **'{left} hrs to go'**
  String hoursUrencriteriumLeft(String left);

  /// No description provided for @hoursFieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date *'**
  String get hoursFieldDate;

  /// No description provided for @hoursFieldHours.
  ///
  /// In en, this message translates to:
  /// **'Hours *'**
  String get hoursFieldHours;

  /// No description provided for @hoursFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description *'**
  String get hoursFieldDescription;

  /// No description provided for @hoursFieldWorkType.
  ///
  /// In en, this message translates to:
  /// **'Work type *'**
  String get hoursFieldWorkType;

  /// No description provided for @hoursFieldClientProject.
  ///
  /// In en, this message translates to:
  /// **'Client / project'**
  String get hoursFieldClientProject;

  /// No description provided for @hoursFieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get hoursFieldNotes;

  /// No description provided for @hoursNewEntry.
  ///
  /// In en, this message translates to:
  /// **'New entry'**
  String get hoursNewEntry;

  /// No description provided for @hoursEditEntry.
  ///
  /// In en, this message translates to:
  /// **'Edit entry'**
  String get hoursEditEntry;

  /// No description provided for @hoursDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete hour entry'**
  String get hoursDeleteTitle;

  /// No description provided for @hoursDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{description}\"?'**
  String hoursDeleteMessage(String description);

  /// No description provided for @hoursValidateHours.
  ///
  /// In en, this message translates to:
  /// **'Enter a number of hours greater than 0'**
  String get hoursValidateHours;

  /// No description provided for @hoursValidateDescription.
  ///
  /// In en, this message translates to:
  /// **'Describe the work done'**
  String get hoursValidateDescription;

  /// No description provided for @hoursValidateWorkType.
  ///
  /// In en, this message translates to:
  /// **'Select a work type'**
  String get hoursValidateWorkType;

  /// No description provided for @workTypeBillable.
  ///
  /// In en, this message translates to:
  /// **'Billable'**
  String get workTypeBillable;

  /// No description provided for @workTypeNonBillable.
  ///
  /// In en, this message translates to:
  /// **'Non-billable'**
  String get workTypeNonBillable;

  /// No description provided for @workTypeAdministrative.
  ///
  /// In en, this message translates to:
  /// **'Administrative'**
  String get workTypeAdministrative;

  /// No description provided for @workTypeWbso.
  ///
  /// In en, this message translates to:
  /// **'WBSO'**
  String get workTypeWbso;

  /// No description provided for @workTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get workTypeOther;

  /// No description provided for @mileageTitle.
  ///
  /// In en, this message translates to:
  /// **'Mileage registration'**
  String get mileageTitle;

  /// No description provided for @mileageNone.
  ///
  /// In en, this message translates to:
  /// **'No trips registered'**
  String get mileageNone;

  /// No description provided for @mileageSelectOrNew.
  ///
  /// In en, this message translates to:
  /// **'Select a trip or click +'**
  String get mileageSelectOrNew;

  /// No description provided for @mileageBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get mileageBusiness;

  /// No description provided for @mileageTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get mileageTotal;

  /// No description provided for @mileageUnitKm.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get mileageUnitKm;

  /// No description provided for @mileageAllowance.
  ///
  /// In en, this message translates to:
  /// **'Allowance (€{rate}/km)'**
  String mileageAllowance(String rate);

  /// No description provided for @mileageFieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date *'**
  String get mileageFieldDate;

  /// No description provided for @mileageFieldMakeModel.
  ///
  /// In en, this message translates to:
  /// **'Make / model *'**
  String get mileageFieldMakeModel;

  /// No description provided for @mileageFieldPlate.
  ///
  /// In en, this message translates to:
  /// **'Licence plate *'**
  String get mileageFieldPlate;

  /// No description provided for @mileageFieldFrom.
  ///
  /// In en, this message translates to:
  /// **'Departure address *'**
  String get mileageFieldFrom;

  /// No description provided for @mileageFieldTo.
  ///
  /// In en, this message translates to:
  /// **'Arrival address *'**
  String get mileageFieldTo;

  /// No description provided for @mileageFieldOdoStart.
  ///
  /// In en, this message translates to:
  /// **'Odometer start *'**
  String get mileageFieldOdoStart;

  /// No description provided for @mileageFieldOdoEnd.
  ///
  /// In en, this message translates to:
  /// **'Odometer end *'**
  String get mileageFieldOdoEnd;

  /// No description provided for @mileageFieldOdoError.
  ///
  /// In en, this message translates to:
  /// **'End reading must be higher than start reading'**
  String get mileageFieldOdoError;

  /// No description provided for @mileageValidateMakeModel.
  ///
  /// In en, this message translates to:
  /// **'Enter the vehicle make and model'**
  String get mileageValidateMakeModel;

  /// No description provided for @mileageValidatePlate.
  ///
  /// In en, this message translates to:
  /// **'Enter the vehicle licence plate'**
  String get mileageValidatePlate;

  /// No description provided for @mileageValidateFrom.
  ///
  /// In en, this message translates to:
  /// **'Enter the departure address'**
  String get mileageValidateFrom;

  /// No description provided for @mileageValidateTo.
  ///
  /// In en, this message translates to:
  /// **'Enter the arrival address'**
  String get mileageValidateTo;

  /// No description provided for @mileageValidateOdoStart.
  ///
  /// In en, this message translates to:
  /// **'Enter the starting odometer reading'**
  String get mileageValidateOdoStart;

  /// No description provided for @mileageValidateOdoEnd.
  ///
  /// In en, this message translates to:
  /// **'Enter the ending odometer reading'**
  String get mileageValidateOdoEnd;

  /// No description provided for @mileageValidateTripType.
  ///
  /// In en, this message translates to:
  /// **'Select the type of trip'**
  String get mileageValidateTripType;

  /// No description provided for @mileageValidatePurpose.
  ///
  /// In en, this message translates to:
  /// **'Describe the purpose of this trip'**
  String get mileageValidatePurpose;

  /// No description provided for @mileageFieldDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get mileageFieldDistance;

  /// No description provided for @mileageFieldTripType.
  ///
  /// In en, this message translates to:
  /// **'Trip type *'**
  String get mileageFieldTripType;

  /// No description provided for @mileageFieldPurpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose *'**
  String get mileageFieldPurpose;

  /// No description provided for @mileageFieldRouteDeviation.
  ///
  /// In en, this message translates to:
  /// **'Detour / non-direct route'**
  String get mileageFieldRouteDeviation;

  /// No description provided for @mileageTooltipRouteDeviation.
  ///
  /// In en, this message translates to:
  /// **'Check this if you took a longer or indirect route than strictly necessary. The tax authority may ask you to explain why the route deviated from the shortest path.'**
  String get mileageTooltipRouteDeviation;

  /// No description provided for @mileageFieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get mileageFieldNotes;

  /// No description provided for @mileageNewTrip.
  ///
  /// In en, this message translates to:
  /// **'New trip'**
  String get mileageNewTrip;

  /// No description provided for @mileageEditTrip.
  ///
  /// In en, this message translates to:
  /// **'Edit trip'**
  String get mileageEditTrip;

  /// No description provided for @mileageDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete trip'**
  String get mileageDeleteTitle;

  /// No description provided for @mileageDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{purpose}\"?'**
  String mileageDeleteMessage(String purpose);

  /// No description provided for @tripTypeBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get tripTypeBusiness;

  /// No description provided for @tripTypeCommute.
  ///
  /// In en, this message translates to:
  /// **'Commute'**
  String get tripTypeCommute;

  /// No description provided for @tripTypePrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get tripTypePrivate;

  /// No description provided for @assetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Fixed assets'**
  String get assetsTitle;

  /// No description provided for @assetsNone.
  ///
  /// In en, this message translates to:
  /// **'No assets registered'**
  String get assetsNone;

  /// No description provided for @assetsSelectOrNew.
  ///
  /// In en, this message translates to:
  /// **'Select an asset or click +'**
  String get assetsSelectOrNew;

  /// No description provided for @assetsKiaInvestments.
  ///
  /// In en, this message translates to:
  /// **'KIA investments'**
  String get assetsKiaInvestments;

  /// No description provided for @assetsKiaDeduction.
  ///
  /// In en, this message translates to:
  /// **'KIA deduction'**
  String get assetsKiaDeduction;

  /// No description provided for @assetsDepreciationThisYear.
  ///
  /// In en, this message translates to:
  /// **'Depreciation this year'**
  String get assetsDepreciationThisYear;

  /// No description provided for @assetsFieldName.
  ///
  /// In en, this message translates to:
  /// **'Asset name *'**
  String get assetsFieldName;

  /// No description provided for @assetsFieldCost.
  ///
  /// In en, this message translates to:
  /// **'Cost excl. VAT *'**
  String get assetsFieldCost;

  /// No description provided for @assetsFieldPurchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date *'**
  String get assetsFieldPurchaseDate;

  /// No description provided for @assetsFieldBusinessUse.
  ///
  /// In en, this message translates to:
  /// **'Business use: {pct}% *'**
  String assetsFieldBusinessUse(int pct);

  /// No description provided for @assetsFieldUsefulLife.
  ///
  /// In en, this message translates to:
  /// **'Useful life *'**
  String get assetsFieldUsefulLife;

  /// No description provided for @assetsFieldUsefulLifeUnit.
  ///
  /// In en, this message translates to:
  /// **'yrs'**
  String get assetsFieldUsefulLifeUnit;

  /// No description provided for @assetsFieldUsefulLifeMin.
  ///
  /// In en, this message translates to:
  /// **'Minimum 1 year'**
  String get assetsFieldUsefulLifeMin;

  /// No description provided for @assetsValidateName.
  ///
  /// In en, this message translates to:
  /// **'Enter the asset name'**
  String get assetsValidateName;

  /// No description provided for @assetsValidateCost.
  ///
  /// In en, this message translates to:
  /// **'Enter the cost excluding VAT'**
  String get assetsValidateCost;

  /// No description provided for @assetsFieldKia.
  ///
  /// In en, this message translates to:
  /// **'KIA eligible'**
  String get assetsFieldKia;

  /// No description provided for @assetsTooltipKia.
  ///
  /// In en, this message translates to:
  /// **'Kleinschaligheidsinvesteringsaftrek (KIA): an additional deduction from your taxable profit for small business investments. You qualify if your total investments in a calendar year fall within the statutory thresholds set by the Dutch tax authority.'**
  String get assetsTooltipKia;

  /// No description provided for @assetsKiaBadge.
  ///
  /// In en, this message translates to:
  /// **'KIA'**
  String get assetsKiaBadge;

  /// No description provided for @assetsFieldEiaMia.
  ///
  /// In en, this message translates to:
  /// **'EIA / MIA'**
  String get assetsFieldEiaMia;

  /// No description provided for @assetsTooltipEiaMia.
  ///
  /// In en, this message translates to:
  /// **'Energie-investeringsaftrek (EIA) and Milieu-investeringsaftrek (MIA): additional tax deductions for investments in energy-efficient or environmentally-friendly business assets listed on the official Energy List or Environmental List published by RVO.'**
  String get assetsTooltipEiaMia;

  /// No description provided for @assetsFieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get assetsFieldNotes;

  /// No description provided for @assetsDisposal.
  ///
  /// In en, this message translates to:
  /// **'Disposal'**
  String get assetsDisposal;

  /// No description provided for @assetsFieldDisposalDate.
  ///
  /// In en, this message translates to:
  /// **'Disposal date'**
  String get assetsFieldDisposalDate;

  /// No description provided for @assetsFieldDisposalProceeds.
  ///
  /// In en, this message translates to:
  /// **'Proceeds excl. VAT'**
  String get assetsFieldDisposalProceeds;

  /// No description provided for @assetsClearDisposalDate.
  ///
  /// In en, this message translates to:
  /// **'Clear disposal date'**
  String get assetsClearDisposalDate;

  /// No description provided for @assetsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete asset'**
  String get assetsDeleteTitle;

  /// No description provided for @assetsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String assetsDeleteMessage(String name);

  /// No description provided for @assetsNewAsset.
  ///
  /// In en, this message translates to:
  /// **'New asset'**
  String get assetsNewAsset;

  /// No description provided for @assetsEditAsset.
  ///
  /// In en, this message translates to:
  /// **'Edit asset'**
  String get assetsEditAsset;

  /// No description provided for @assetsYears.
  ///
  /// In en, this message translates to:
  /// **'{n} yrs'**
  String assetsYears(int n);

  /// No description provided for @pensionTitle.
  ///
  /// In en, this message translates to:
  /// **'Pension'**
  String get pensionTitle;

  /// No description provided for @pensionLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load pension data: {error}'**
  String pensionLoadError(String error);

  /// No description provided for @pensionJaarruimte.
  ///
  /// In en, this message translates to:
  /// **'Annual allowance calculation'**
  String get pensionJaarruimte;

  /// No description provided for @pensionTaxableProfit.
  ///
  /// In en, this message translates to:
  /// **'Taxable profit'**
  String get pensionTaxableProfit;

  /// No description provided for @pensionAowFranchise.
  ///
  /// In en, this message translates to:
  /// **'AOW franchise'**
  String get pensionAowFranchise;

  /// No description provided for @pensionPensioengrondslag.
  ///
  /// In en, this message translates to:
  /// **'Pension base'**
  String get pensionPensioengrondslag;

  /// No description provided for @pensionJaarruimte30.
  ///
  /// In en, this message translates to:
  /// **'Annual allowance (30%)'**
  String get pensionJaarruimte30;

  /// No description provided for @pensionJaarruimteMax.
  ///
  /// In en, this message translates to:
  /// **'Annual allowance (max {max})'**
  String pensionJaarruimteMax(String max);

  /// No description provided for @pensionReserveringsruimte.
  ///
  /// In en, this message translates to:
  /// **'Unused annual allowance'**
  String get pensionReserveringsruimte;

  /// No description provided for @pensionTotalBudget.
  ///
  /// In en, this message translates to:
  /// **'Total available'**
  String get pensionTotalBudget;

  /// No description provided for @pensionEstimatedTaxSaving.
  ///
  /// In en, this message translates to:
  /// **'Estimated tax saving'**
  String get pensionEstimatedTaxSaving;

  /// No description provided for @pensionInputSection.
  ///
  /// In en, this message translates to:
  /// **'Input'**
  String get pensionInputSection;

  /// No description provided for @pensionFactorA.
  ///
  /// In en, this message translates to:
  /// **'Factor A'**
  String get pensionFactorA;

  /// No description provided for @pensionFactorAHelper.
  ///
  /// In en, this message translates to:
  /// **'Pension accrual with employer / BV'**
  String get pensionFactorAHelper;

  /// No description provided for @pensionReserveringsruimteLabel.
  ///
  /// In en, this message translates to:
  /// **'Unused annual allowance from prior years'**
  String get pensionReserveringsruimteLabel;

  /// No description provided for @pensionPlannedSection.
  ///
  /// In en, this message translates to:
  /// **'Planned contribution'**
  String get pensionPlannedSection;

  /// No description provided for @pensionLijfrente.
  ///
  /// In en, this message translates to:
  /// **'Annuity premium / AOV premium'**
  String get pensionLijfrente;

  /// No description provided for @pensionLijfrenteHelper.
  ///
  /// In en, this message translates to:
  /// **'Included as deduction in tax calculation'**
  String get pensionLijfrenteHelper;

  /// No description provided for @pensionAovSection.
  ///
  /// In en, this message translates to:
  /// **'AOV disability insurance'**
  String get pensionAovSection;

  /// No description provided for @pensionAovInsured.
  ///
  /// In en, this message translates to:
  /// **'AOV insured'**
  String get pensionAovInsured;

  /// No description provided for @pensionMonthlyPremium.
  ///
  /// In en, this message translates to:
  /// **'Monthly premium'**
  String get pensionMonthlyPremium;

  /// No description provided for @pensionAnnualPremium.
  ///
  /// In en, this message translates to:
  /// **'Annual premium: {amount}'**
  String pensionAnnualPremium(String amount);

  /// No description provided for @vatReturnTitle.
  ///
  /// In en, this message translates to:
  /// **'VAT return'**
  String get vatReturnTitle;

  /// No description provided for @vatReturnRevenueSection.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get vatReturnRevenueSection;

  /// No description provided for @vatReturnCalculationSection.
  ///
  /// In en, this message translates to:
  /// **'VAT calculation'**
  String get vatReturnCalculationSection;

  /// No description provided for @vatReturnIcpSection.
  ///
  /// In en, this message translates to:
  /// **'ICP report'**
  String get vatReturnIcpSection;

  /// No description provided for @vatReturnIcpDeadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline same as VAT return: {date}.'**
  String vatReturnIcpDeadline(String date);

  /// No description provided for @vatReturnStatusSection.
  ///
  /// In en, this message translates to:
  /// **'Processing status'**
  String get vatReturnStatusSection;

  /// No description provided for @vatReturnFiled.
  ///
  /// In en, this message translates to:
  /// **'Return filed'**
  String get vatReturnFiled;

  /// No description provided for @vatReturnPaid.
  ///
  /// In en, this message translates to:
  /// **'VAT paid'**
  String get vatReturnPaid;

  /// No description provided for @vatReturnYtdRevenue.
  ///
  /// In en, this message translates to:
  /// **'YTD revenue: {amount}'**
  String vatReturnYtdRevenue(String amount);

  /// No description provided for @vatReturnLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load VAT return data: {error}'**
  String vatReturnLoadError(String error);

  /// No description provided for @vatReturnDue.
  ///
  /// In en, this message translates to:
  /// **'VAT due'**
  String get vatReturnDue;

  /// No description provided for @vatReturnRefund.
  ///
  /// In en, this message translates to:
  /// **'VAT refund'**
  String get vatReturnRefund;

  /// No description provided for @vatReturnKorWarning.
  ///
  /// In en, this message translates to:
  /// **'KOR threshold reached ({ytd} of {max}). Charge VAT from next transaction.'**
  String vatReturnKorWarning(String ytd, String max);

  /// No description provided for @vatRow1a.
  ///
  /// In en, this message translates to:
  /// **'1a  Supplies / services taxed at 21%'**
  String get vatRow1a;

  /// No description provided for @vatRow1b.
  ///
  /// In en, this message translates to:
  /// **'1b  Supplies / services taxed at 9%'**
  String get vatRow1b;

  /// No description provided for @vatRow1c.
  ///
  /// In en, this message translates to:
  /// **'1c  Supplies / services taxed at 0% (export)'**
  String get vatRow1c;

  /// No description provided for @vatRow3a.
  ///
  /// In en, this message translates to:
  /// **'3a  Supplies to EU businesses (ICP / RC)'**
  String get vatRow3a;

  /// No description provided for @vatRow5a.
  ///
  /// In en, this message translates to:
  /// **'5a  VAT on revenue'**
  String get vatRow5a;

  /// No description provided for @vatRow5b.
  ///
  /// In en, this message translates to:
  /// **'5b  Input tax (to reclaim)'**
  String get vatRow5b;

  /// No description provided for @plTaxTitle.
  ///
  /// In en, this message translates to:
  /// **'P&L / Tax'**
  String get plTaxTitle;

  /// No description provided for @plTaxLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load P&L / tax data: {error}'**
  String plTaxLoadError(String error);

  /// No description provided for @plTaxRevenuSection.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get plTaxRevenuSection;

  /// No description provided for @plTaxGrossRevenue.
  ///
  /// In en, this message translates to:
  /// **'Gross revenue (excl. VAT)'**
  String get plTaxGrossRevenue;

  /// No description provided for @plTaxCreditNotes.
  ///
  /// In en, this message translates to:
  /// **'Less: credit notes'**
  String get plTaxCreditNotes;

  /// No description provided for @plTaxNetRevenue.
  ///
  /// In en, this message translates to:
  /// **'Net revenue'**
  String get plTaxNetRevenue;

  /// No description provided for @plTaxCostsSection.
  ///
  /// In en, this message translates to:
  /// **'Costs'**
  String get plTaxCostsSection;

  /// No description provided for @plTaxMileageAllowance.
  ///
  /// In en, this message translates to:
  /// **'Mileage allowance ({km}km × €{rate})'**
  String plTaxMileageAllowance(int km, String rate);

  /// No description provided for @plTaxDepreciation.
  ///
  /// In en, this message translates to:
  /// **'Depreciation'**
  String get plTaxDepreciation;

  /// No description provided for @plTaxTotalCosts.
  ///
  /// In en, this message translates to:
  /// **'Total costs'**
  String get plTaxTotalCosts;

  /// No description provided for @plTaxGrossProfit.
  ///
  /// In en, this message translates to:
  /// **'Gross profit'**
  String get plTaxGrossProfit;

  /// No description provided for @plTaxDeductionsSection.
  ///
  /// In en, this message translates to:
  /// **'Entrepreneur deductions'**
  String get plTaxDeductionsSection;

  /// No description provided for @plTaxZelfstandigenaftrek.
  ///
  /// In en, this message translates to:
  /// **'Self-employed deduction {year}'**
  String plTaxZelfstandigenaftrek(int year);

  /// No description provided for @plTaxStartersaftrek.
  ///
  /// In en, this message translates to:
  /// **'Starter deduction'**
  String get plTaxStartersaftrek;

  /// No description provided for @plTaxMkb.
  ///
  /// In en, this message translates to:
  /// **'SME profit exemption ({pct}%)'**
  String plTaxMkb(String pct);

  /// No description provided for @plTaxKia.
  ///
  /// In en, this message translates to:
  /// **'KIA deduction'**
  String get plTaxKia;

  /// No description provided for @plTaxLijrente.
  ///
  /// In en, this message translates to:
  /// **'Annuity deduction'**
  String get plTaxLijrente;

  /// No description provided for @plTaxTaxableProfit.
  ///
  /// In en, this message translates to:
  /// **'Taxable profit'**
  String get plTaxTaxableProfit;

  /// No description provided for @plTaxBox1Section.
  ///
  /// In en, this message translates to:
  /// **'Income tax box 1'**
  String get plTaxBox1Section;

  /// No description provided for @plTaxBracket1.
  ///
  /// In en, this message translates to:
  /// **'Bracket 1 ({pct}%)'**
  String plTaxBracket1(String pct);

  /// No description provided for @plTaxBracket2.
  ///
  /// In en, this message translates to:
  /// **'Bracket 2 ({pct}%)'**
  String plTaxBracket2(String pct);

  /// No description provided for @plTaxBracket3.
  ///
  /// In en, this message translates to:
  /// **'Bracket 3 ({pct}%)'**
  String plTaxBracket3(String pct);

  /// No description provided for @plTaxAlgHeffing.
  ///
  /// In en, this message translates to:
  /// **'General tax credit'**
  String get plTaxAlgHeffing;

  /// No description provided for @plTaxArbeidskorting.
  ///
  /// In en, this message translates to:
  /// **'Labour tax credit'**
  String get plTaxArbeidskorting;

  /// No description provided for @plTaxDeduct.
  ///
  /// In en, this message translates to:
  /// **'Less: {label}'**
  String plTaxDeduct(String label);

  /// No description provided for @plTaxMax.
  ///
  /// In en, this message translates to:
  /// **'(max {amount})'**
  String plTaxMax(String amount);

  /// No description provided for @plTaxInkomsten.
  ///
  /// In en, this message translates to:
  /// **'Income tax'**
  String get plTaxInkomsten;

  /// No description provided for @plTaxZvw.
  ///
  /// In en, this message translates to:
  /// **'ZVW contribution ({pct}%)'**
  String plTaxZvw(String pct);

  /// No description provided for @plTaxTotalTax.
  ///
  /// In en, this message translates to:
  /// **'Total tax'**
  String get plTaxTotalTax;

  /// No description provided for @plTaxNetProfit.
  ///
  /// In en, this message translates to:
  /// **'Net profit after tax'**
  String get plTaxNetProfit;

  /// No description provided for @plTaxEffectiveRate.
  ///
  /// In en, this message translates to:
  /// **'Effective rate: {rate}%'**
  String plTaxEffectiveRate(String rate);

  /// No description provided for @plTaxSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get plTaxSettingsSection;

  /// No description provided for @plTaxClaimZelfs.
  ///
  /// In en, this message translates to:
  /// **'Claim self-employed deduction'**
  String get plTaxClaimZelfs;

  /// No description provided for @plTaxClaimStarters.
  ///
  /// In en, this message translates to:
  /// **'Claim starter deduction'**
  String get plTaxClaimStarters;

  /// No description provided for @plTaxUrenBanner.
  ///
  /// In en, this message translates to:
  /// **'Urencriterium: {hours} / 1,225 hrs logged{suffix}.'**
  String plTaxUrenBanner(String hours, String suffix);

  /// No description provided for @plTaxUrenBannerSuffixDone.
  ///
  /// In en, this message translates to:
  /// **', self-employed deduction lapses'**
  String get plTaxUrenBannerSuffixDone;

  /// No description provided for @plTaxUrenBannerSuffixPending.
  ///
  /// In en, this message translates to:
  /// **', not yet reached'**
  String get plTaxUrenBannerSuffixPending;

  /// No description provided for @settingsLanguageSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageSection;

  /// No description provided for @settingsLanguageNl.
  ///
  /// In en, this message translates to:
  /// **'Dutch'**
  String get settingsLanguageNl;

  /// No description provided for @settingsLanguageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEn;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsBusinessSection.
  ///
  /// In en, this message translates to:
  /// **'Business details'**
  String get settingsBusinessSection;

  /// No description provided for @settingsBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get settingsBusinessName;

  /// No description provided for @settingsVatNumber.
  ///
  /// In en, this message translates to:
  /// **'VAT number'**
  String get settingsVatNumber;

  /// No description provided for @settingsKvkNumber.
  ///
  /// In en, this message translates to:
  /// **'KVK number'**
  String get settingsKvkNumber;

  /// No description provided for @settingsBusinessAddress.
  ///
  /// In en, this message translates to:
  /// **'Business address'**
  String get settingsBusinessAddress;

  /// No description provided for @settingsIban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get settingsIban;

  /// No description provided for @settingsStartersaftrek.
  ///
  /// In en, this message translates to:
  /// **'Eligible for startersaftrek'**
  String get settingsStartersaftrek;

  /// No description provided for @settingsValidateName.
  ///
  /// In en, this message translates to:
  /// **'Enter your business name'**
  String get settingsValidateName;

  /// No description provided for @settingsValidateVat.
  ///
  /// In en, this message translates to:
  /// **'Enter your BTW number, e.g. NL123456789B01.'**
  String get settingsValidateVat;

  /// No description provided for @settingsValidateVatFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid VAT number. Format: NL + 9 digits + B + 2 digits, e.g. NL123456789B01.'**
  String get settingsValidateVatFormat;

  /// No description provided for @settingsValidateKvk.
  ///
  /// In en, this message translates to:
  /// **'Enter your KVK number.'**
  String get settingsValidateKvk;

  /// No description provided for @settingsValidateKvkFormat.
  ///
  /// In en, this message translates to:
  /// **'KVK number must be exactly 8 digits.'**
  String get settingsValidateKvkFormat;

  /// No description provided for @settingsValidateAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your business address'**
  String get settingsValidateAddress;

  /// No description provided for @settingsValidateIban.
  ///
  /// In en, this message translates to:
  /// **'Enter your IBAN, e.g. NL91ABNA0417164300.'**
  String get settingsValidateIban;

  /// No description provided for @settingsValidateIbanFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid IBAN format (e.g. NL91ABNA0417164300).'**
  String get settingsValidateIbanFormat;

  /// No description provided for @actionOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get actionOk;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Business details saved'**
  String get settingsSaved;

  /// No description provided for @settingsDatabaseSection.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get settingsDatabaseSection;

  /// No description provided for @settingsDatabaseLocation.
  ///
  /// In en, this message translates to:
  /// **'Location: {path}'**
  String settingsDatabaseLocation(String path);

  /// No description provided for @settingsDatabaseNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get settingsDatabaseNotSet;

  /// No description provided for @settingsMoveDatabase.
  ///
  /// In en, this message translates to:
  /// **'Move database…'**
  String get settingsMoveDatabase;

  /// No description provided for @settingsDatabaseMoved.
  ///
  /// In en, this message translates to:
  /// **'Database file moved to: {path}'**
  String settingsDatabaseMoved(String path);

  /// No description provided for @settingsExportSection.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get settingsExportSection;

  /// No description provided for @settingsExportDescription.
  ///
  /// In en, this message translates to:
  /// **'Export all {year} data to CSV files.'**
  String settingsExportDescription(int year);

  /// No description provided for @settingsExportButton.
  ///
  /// In en, this message translates to:
  /// **'Export {year} as CSV'**
  String settingsExportButton(int year);

  /// No description provided for @settingsExportRunning.
  ///
  /// In en, this message translates to:
  /// **'Exporting…'**
  String get settingsExportRunning;

  /// No description provided for @settingsExported.
  ///
  /// In en, this message translates to:
  /// **'CSV files exported to: {dir}'**
  String settingsExported(String dir);

  /// No description provided for @settingsTaxSection.
  ///
  /// In en, this message translates to:
  /// **'Tax parameters {year}'**
  String settingsTaxSection(int year);

  /// No description provided for @settingsTaxNoParams.
  ///
  /// In en, this message translates to:
  /// **'No parameters found for {year}. Restart the app after creating a database.'**
  String settingsTaxNoParams(int year);

  /// No description provided for @settingsTaxRates.
  ///
  /// In en, this message translates to:
  /// **'Rates & brackets'**
  String get settingsTaxRates;

  /// No description provided for @settingsTaxZelfs.
  ///
  /// In en, this message translates to:
  /// **'Self-employed deduction'**
  String get settingsTaxZelfs;

  /// No description provided for @settingsTaxStarters.
  ///
  /// In en, this message translates to:
  /// **'Starter deduction'**
  String get settingsTaxStarters;

  /// No description provided for @settingsTaxMkb.
  ///
  /// In en, this message translates to:
  /// **'MKB-winstvrijstelling (%)'**
  String get settingsTaxMkb;

  /// No description provided for @settingsTaxMileage.
  ///
  /// In en, this message translates to:
  /// **'Mileage rate (€/km)'**
  String get settingsTaxMileage;

  /// No description provided for @settingsTaxBrackets.
  ///
  /// In en, this message translates to:
  /// **'Income tax brackets'**
  String get settingsTaxBrackets;

  /// No description provided for @settingsTaxB1Rate.
  ///
  /// In en, this message translates to:
  /// **'Bracket 1 rate (%)'**
  String get settingsTaxB1Rate;

  /// No description provided for @settingsTaxB1Thresh.
  ///
  /// In en, this message translates to:
  /// **'Bracket 1 threshold'**
  String get settingsTaxB1Thresh;

  /// No description provided for @settingsTaxB2Rate.
  ///
  /// In en, this message translates to:
  /// **'Bracket 2 rate (%)'**
  String get settingsTaxB2Rate;

  /// No description provided for @settingsTaxB2Thresh.
  ///
  /// In en, this message translates to:
  /// **'Bracket 2 threshold'**
  String get settingsTaxB2Thresh;

  /// No description provided for @settingsTaxB3Rate.
  ///
  /// In en, this message translates to:
  /// **'Bracket 3 rate (%)'**
  String get settingsTaxB3Rate;

  /// No description provided for @settingsTaxKortingen.
  ///
  /// In en, this message translates to:
  /// **'Discounts & ZVW'**
  String get settingsTaxKortingen;

  /// No description provided for @settingsTaxAlgHeff.
  ///
  /// In en, this message translates to:
  /// **'General tax credit max'**
  String get settingsTaxAlgHeff;

  /// No description provided for @settingsTaxArbeids.
  ///
  /// In en, this message translates to:
  /// **'Labour credit max'**
  String get settingsTaxArbeids;

  /// No description provided for @settingsTaxZvwRate.
  ///
  /// In en, this message translates to:
  /// **'ZVW rate (%)'**
  String get settingsTaxZvwRate;

  /// No description provided for @settingsTaxZvwMax.
  ///
  /// In en, this message translates to:
  /// **'ZVW max'**
  String get settingsTaxZvwMax;

  /// No description provided for @settingsTaxUrencriterium.
  ///
  /// In en, this message translates to:
  /// **'Hours criterion'**
  String get settingsTaxUrencriterium;

  /// No description provided for @settingsTaxKia.
  ///
  /// In en, this message translates to:
  /// **'KIA deduction'**
  String get settingsTaxKia;

  /// No description provided for @settingsTaxKiaLowerThresh.
  ///
  /// In en, this message translates to:
  /// **'Lower threshold'**
  String get settingsTaxKiaLowerThresh;

  /// No description provided for @settingsTaxKiaUpperThresh.
  ///
  /// In en, this message translates to:
  /// **'Upper threshold'**
  String get settingsTaxKiaUpperThresh;

  /// No description provided for @settingsTaxKiaFlatThresh.
  ///
  /// In en, this message translates to:
  /// **'Flat threshold'**
  String get settingsTaxKiaFlatThresh;

  /// No description provided for @settingsTaxKiaRate.
  ///
  /// In en, this message translates to:
  /// **'KIA rate (%)'**
  String get settingsTaxKiaRate;

  /// No description provided for @settingsTaxKiaFlatAmount.
  ///
  /// In en, this message translates to:
  /// **'Flat amount'**
  String get settingsTaxKiaFlatAmount;

  /// No description provided for @settingsTaxKiaDecreaseRate.
  ///
  /// In en, this message translates to:
  /// **'Decrease rate (%)'**
  String get settingsTaxKiaDecreaseRate;

  /// No description provided for @settingsTaxKor.
  ///
  /// In en, this message translates to:
  /// **'KOR threshold'**
  String get settingsTaxKor;

  /// No description provided for @settingsTaxKorThresh.
  ///
  /// In en, this message translates to:
  /// **'KOR threshold'**
  String get settingsTaxKorThresh;

  /// No description provided for @settingsTaxSaveParams.
  ///
  /// In en, this message translates to:
  /// **'Save parameters'**
  String get settingsTaxSaveParams;

  /// No description provided for @settingsTaxParamsSaved.
  ///
  /// In en, this message translates to:
  /// **'Tax parameters saved for {year}'**
  String settingsTaxParamsSaved(int year);

  /// No description provided for @settingsTaxValidateField.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number.'**
  String get settingsTaxValidateField;

  /// No description provided for @firstLaunchWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Florin'**
  String get firstLaunchWelcome;

  /// No description provided for @firstLaunchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your bookkeeping workspace.'**
  String get firstLaunchSubtitle;

  /// No description provided for @firstLaunchDbSection.
  ///
  /// In en, this message translates to:
  /// **'Database location'**
  String get firstLaunchDbSection;

  /// No description provided for @firstLaunchDbDescription.
  ///
  /// In en, this message translates to:
  /// **'Default: Application Support. Choose another folder for iCloud / Google Drive sync.'**
  String get firstLaunchDbDescription;

  /// No description provided for @firstLaunchDbDefault.
  ///
  /// In en, this message translates to:
  /// **'Application Support (default)'**
  String get firstLaunchDbDefault;

  /// No description provided for @firstLaunchChooseFolder.
  ///
  /// In en, this message translates to:
  /// **'Choose folder'**
  String get firstLaunchChooseFolder;

  /// No description provided for @firstLaunchBusinessSection.
  ///
  /// In en, this message translates to:
  /// **'Business identity'**
  String get firstLaunchBusinessSection;

  /// No description provided for @firstLaunchStartersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'First 3 years of business: €2,123 additional deduction'**
  String get firstLaunchStartersSubtitle;

  /// No description provided for @firstLaunchGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get firstLaunchGetStarted;

  /// No description provided for @firstLaunchSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not finish setup: {error}'**
  String firstLaunchSaveError(String error);

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get confirmDeleteCancel;

  /// No description provided for @confirmDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get confirmDeleteConfirm;

  /// No description provided for @deadlineBadgeFiled.
  ///
  /// In en, this message translates to:
  /// **'Filed'**
  String get deadlineBadgeFiled;

  /// No description provided for @deadlineBadgeOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get deadlineBadgeOverdue;

  /// No description provided for @deadlineBadgeDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String deadlineBadgeDays(int days);

  /// No description provided for @vatRateSelectorLabel.
  ///
  /// In en, this message translates to:
  /// **'VAT rate'**
  String get vatRateSelectorLabel;

  /// No description provided for @vatRate21.
  ///
  /// In en, this message translates to:
  /// **'21%'**
  String get vatRate21;

  /// No description provided for @vatRate9.
  ///
  /// In en, this message translates to:
  /// **'9%'**
  String get vatRate9;

  /// No description provided for @vatRate0.
  ///
  /// In en, this message translates to:
  /// **'0%'**
  String get vatRate0;

  /// No description provided for @vatRateEuReverseCharge.
  ///
  /// In en, this message translates to:
  /// **'0% EU reverse charge'**
  String get vatRateEuReverseCharge;

  /// No description provided for @vatRateExempt.
  ///
  /// In en, this message translates to:
  /// **'Exempt'**
  String get vatRateExempt;

  /// No description provided for @genericSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save: {error}'**
  String genericSaveError(String error);

  /// No description provided for @dbLocationChooseFolderDialog.
  ///
  /// In en, this message translates to:
  /// **'Choose folder to store Florin database'**
  String get dbLocationChooseFolderDialog;

  /// No description provided for @csvExportChooseFolderDialog.
  ///
  /// In en, this message translates to:
  /// **'Choose export folder'**
  String get csvExportChooseFolderDialog;

  /// No description provided for @invoiceSaveAsDialog.
  ///
  /// In en, this message translates to:
  /// **'Save invoice as'**
  String get invoiceSaveAsDialog;

  /// No description provided for @amountNegativeError.
  ///
  /// In en, this message translates to:
  /// **'Amount cannot be negative'**
  String get amountNegativeError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
