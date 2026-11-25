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
  /// **'Estimated net profit after tax'**
  String get dashboardNetProfitAfterTax;

  /// No description provided for @dashboardOutstandingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Outstanding invoices'**
  String get dashboardOutstandingInvoices;

  /// No description provided for @dashboardInvoiceCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 invoice} other{{count} invoices}}'**
  String dashboardInvoiceCount(int count);

  /// No description provided for @dashboardUrencriterium.
  ///
  /// In en, this message translates to:
  /// **'Urencriterium'**
  String get dashboardUrencriterium;

  /// No description provided for @dashboardUrencriteriumHelp.
  ///
  /// In en, this message translates to:
  /// **'The hours you worked for the business this year against the urencriterium. The zelfstandigenaftrek and most other deductions for business owners require it (Wet IB 2001 art. 3.76). All business hours count, not only billable ones. With a job, the business must also take more of your time than the job (art. 3.6).'**
  String get dashboardUrencriteriumHelp;

  /// No description provided for @dashboardBtwDeadlines.
  ///
  /// In en, this message translates to:
  /// **'VAT deadlines'**
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

  /// No description provided for @invoiceFieldClient.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get invoiceFieldClient;

  /// No description provided for @invoiceFieldNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice number'**
  String get invoiceFieldNumber;

  /// No description provided for @invoiceFieldInvoiceDate.
  ///
  /// In en, this message translates to:
  /// **'Invoice date'**
  String get invoiceFieldInvoiceDate;

  /// No description provided for @invoiceFieldSupplyDate.
  ///
  /// In en, this message translates to:
  /// **'Supply date'**
  String get invoiceFieldSupplyDate;

  /// No description provided for @invoiceFieldPaymentTerm.
  ///
  /// In en, this message translates to:
  /// **'Term (days)'**
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
  /// **'Description'**
  String get invoiceFieldDescription;

  /// No description provided for @invoiceFieldQuantity.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get invoiceFieldQuantity;

  /// No description provided for @invoiceFieldUnit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get invoiceFieldUnit;

  /// No description provided for @invoiceFieldPrice.
  ///
  /// In en, this message translates to:
  /// **'Price (excl.)'**
  String get invoiceFieldPrice;

  /// No description provided for @invoiceFieldVat.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get invoiceFieldVat;

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

  /// No description provided for @invoiceActionExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get invoiceActionExportPdf;

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

  /// No description provided for @invoiceValidateClient.
  ///
  /// In en, this message translates to:
  /// **'Select a client for this invoice'**
  String get invoiceValidateClient;

  /// No description provided for @invoiceValidateNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a unique invoice number, e.g. F-2026-001'**
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

  /// No description provided for @clientsNewHeader.
  ///
  /// In en, this message translates to:
  /// **'New client'**
  String get clientsNewHeader;

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

  /// No description provided for @clientsPaidInYear.
  ///
  /// In en, this message translates to:
  /// **'Paid in {year}: {amount}'**
  String clientsPaidInYear(int year, String amount);

  /// No description provided for @clientsDbaBadge.
  ///
  /// In en, this message translates to:
  /// **'Wet DBA: {risk}'**
  String clientsDbaBadge(String risk);

  /// No description provided for @clientsFieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
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
  /// **'Use a 2-letter country code (e.g. NL, DE, FR): it decides which VAT treatments an invoice to this client can use.'**
  String get clientsValidateCountry;

  /// No description provided for @clientsFieldVat.
  ///
  /// In en, this message translates to:
  /// **'VAT number'**
  String get clientsFieldVat;

  /// No description provided for @clientsValidateVat.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid EU VAT number, e.g. NL123456789B01 or DE123456789'**
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
  /// **'Address'**
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

  /// No description provided for @clientsWetDbaHelp.
  ///
  /// In en, this message translates to:
  /// **'How you judge this working relationship under the Wet DBA (Wet deregulering beoordeling arbeidsrelaties), with the contract that goes with it. Florin keeps your judgement and the contract date; it does not assess the relationship.'**
  String get clientsWetDbaHelp;

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
  /// **'High Wet DBA risk in your own assessment: if the work is employment in law, the Belastingdienst treats it as such.'**
  String get clientsHighRiskWarning;

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

  /// No description provided for @expensesNewHeader.
  ///
  /// In en, this message translates to:
  /// **'New expense'**
  String get expensesNewHeader;

  /// No description provided for @expensesFieldSupplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
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
  /// **'Category'**
  String get expensesFieldCategory;

  /// No description provided for @expensesValidateCategory.
  ///
  /// In en, this message translates to:
  /// **'Select a category for this expense'**
  String get expensesValidateCategory;

  /// No description provided for @expensesFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get expensesFieldDescription;

  /// No description provided for @expensesValidateDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter a description for this expense'**
  String get expensesValidateDescription;

  /// No description provided for @expensesFieldAmountExcl.
  ///
  /// In en, this message translates to:
  /// **'Amount (excl. VAT)'**
  String get expensesFieldAmountExcl;

  /// No description provided for @expensesValidateAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount excluding VAT, above zero: it is the cost Florin deducts from your profit.'**
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
  /// **'e.g. INV-2026-0042, SEPA ref 123456'**
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
  /// **'Food, drinks, representation and congresses'**
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

  /// No description provided for @expenseCatCourseTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel and stay for courses and congresses'**
  String get expenseCatCourseTravel;

  /// No description provided for @expenseCatClothingAndCare.
  ///
  /// In en, this message translates to:
  /// **'Clothing and personal care'**
  String get expenseCatClothingAndCare;

  /// No description provided for @expenseCatHomePhoneLine.
  ///
  /// In en, this message translates to:
  /// **'Phone line at home'**
  String get expenseCatHomePhoneLine;

  /// No description provided for @expenseCatGeneralLiterature.
  ///
  /// In en, this message translates to:
  /// **'Books other than professional literature'**
  String get expenseCatGeneralLiterature;

  /// No description provided for @expenseCatFines.
  ///
  /// In en, this message translates to:
  /// **'Fines'**
  String get expenseCatFines;

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

  /// No description provided for @hoursUrencriteriumJob.
  ///
  /// In en, this message translates to:
  /// **'Not more than {hours} hrs in employment'**
  String hoursUrencriteriumJob(int hours);

  /// No description provided for @hoursFieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get hoursFieldDate;

  /// No description provided for @hoursFieldHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hoursFieldHours;

  /// No description provided for @hoursFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get hoursFieldDescription;

  /// No description provided for @hoursFieldWorkType.
  ///
  /// In en, this message translates to:
  /// **'Work type'**
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
  /// **'Enter the hours worked: more than 0 and at most 24'**
  String get hoursValidateHours;

  /// No description provided for @hoursValidateDescription.
  ///
  /// In en, this message translates to:
  /// **'Describe the work done'**
  String get hoursValidateDescription;

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

  /// No description provided for @mileageRoute.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to}'**
  String mileageRoute(String from, String to);

  /// No description provided for @mileageAllowance.
  ///
  /// In en, this message translates to:
  /// **'Allowance ({rate} / km)'**
  String mileageAllowance(String rate);

  /// No description provided for @mileageFieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get mileageFieldDate;

  /// No description provided for @mileageFieldMakeModel.
  ///
  /// In en, this message translates to:
  /// **'Make / model'**
  String get mileageFieldMakeModel;

  /// No description provided for @mileageFieldPlate.
  ///
  /// In en, this message translates to:
  /// **'Licence plate'**
  String get mileageFieldPlate;

  /// No description provided for @mileageFieldFrom.
  ///
  /// In en, this message translates to:
  /// **'Departure address'**
  String get mileageFieldFrom;

  /// No description provided for @mileageFieldTo.
  ///
  /// In en, this message translates to:
  /// **'Arrival address'**
  String get mileageFieldTo;

  /// No description provided for @mileageFieldOdoStart.
  ///
  /// In en, this message translates to:
  /// **'Odometer start'**
  String get mileageFieldOdoStart;

  /// No description provided for @mileageFieldOdoEnd.
  ///
  /// In en, this message translates to:
  /// **'Odometer end'**
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
  /// **'Trip type'**
  String get mileageFieldTripType;

  /// No description provided for @mileageFieldPurpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get mileageFieldPurpose;

  /// No description provided for @mileageFieldRouteDeviation.
  ///
  /// In en, this message translates to:
  /// **'Detour / non-direct route'**
  String get mileageFieldRouteDeviation;

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
  /// **'Asset name'**
  String get assetsFieldName;

  /// No description provided for @assetsFieldCost.
  ///
  /// In en, this message translates to:
  /// **'Cost excl. VAT'**
  String get assetsFieldCost;

  /// No description provided for @assetsFieldPurchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get assetsFieldPurchaseDate;

  /// No description provided for @assetsFieldUsefulLife.
  ///
  /// In en, this message translates to:
  /// **'Useful life'**
  String get assetsFieldUsefulLife;

  /// No description provided for @assetsFieldUsefulLifeUnit.
  ///
  /// In en, this message translates to:
  /// **'yrs'**
  String get assetsFieldUsefulLifeUnit;

  /// No description provided for @assetsFieldUsefulLifeMin.
  ///
  /// In en, this message translates to:
  /// **'Enter at least {years} years: depreciation is limited to {pct} of the cost a year'**
  String assetsFieldUsefulLifeMin(int years, String pct);

  /// No description provided for @assetsValidateName.
  ///
  /// In en, this message translates to:
  /// **'Enter the asset name'**
  String get assetsValidateName;

  /// No description provided for @assetsValidateCost.
  ///
  /// In en, this message translates to:
  /// **'Enter the cost excluding VAT, above zero: depreciation is calculated from it.'**
  String get assetsValidateCost;

  /// No description provided for @assetsFieldKia.
  ///
  /// In en, this message translates to:
  /// **'KIA eligible'**
  String get assetsFieldKia;

  /// No description provided for @assetsKiaBadge.
  ///
  /// In en, this message translates to:
  /// **'KIA'**
  String get assetsKiaBadge;

  /// No description provided for @assetsSoldBadge.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get assetsSoldBadge;

  /// No description provided for @assetsBookValueTooltip.
  ///
  /// In en, this message translates to:
  /// **'Book value at the end of {year}'**
  String assetsBookValueTooltip(int year);

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

  /// No description provided for @pensionJaarruimte.
  ///
  /// In en, this message translates to:
  /// **'Annual allowance calculation'**
  String get pensionJaarruimte;

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

  /// No description provided for @pensionReserveringsruimteLabel.
  ///
  /// In en, this message translates to:
  /// **'Reserveringsruimte'**
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

  /// No description provided for @vatRow1a.
  ///
  /// In en, this message translates to:
  /// **'1a  Supplies / services taxed at {rate}'**
  String vatRow1a(String rate);

  /// No description provided for @vatRow1b.
  ///
  /// In en, this message translates to:
  /// **'1b  Supplies / services taxed at {rate}'**
  String vatRow1b(String rate);

  /// No description provided for @vatRow3a.
  ///
  /// In en, this message translates to:
  /// **'3a  Supplies to countries outside the EU (export)'**
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
  /// **'P&L and estimated tax'**
  String get plTaxTitle;

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
  /// **'Business kilometres ({km} km × {rate})'**
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
  /// **'Zelfstandigenaftrek {year}'**
  String plTaxZelfstandigenaftrek(int year);

  /// No description provided for @plTaxStartersaftrek.
  ///
  /// In en, this message translates to:
  /// **'Startersaftrek'**
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
  /// **'Taxable income'**
  String get plTaxTaxableProfit;

  /// No description provided for @plTaxBox1Section.
  ///
  /// In en, this message translates to:
  /// **'Income tax box 1, estimated'**
  String get plTaxBox1Section;

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

  /// No description provided for @plTaxTariefaanpassing.
  ///
  /// In en, this message translates to:
  /// **'Tariefaanpassing'**
  String get plTaxTariefaanpassing;

  /// No description provided for @plTaxTariefaanpassingHelp.
  ///
  /// In en, this message translates to:
  /// **'The ondernemersaftrek and the mkb-winstvrijstelling lower your tax at most at the rate below the top bracket. For the part of them that falls in the top bracket, the difference is added back (Wet IB 2001 art. 2.10 lid 2).'**
  String get plTaxTariefaanpassingHelp;

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
  /// **'Estimated total tax'**
  String get plTaxTotalTax;

  /// No description provided for @plTaxWageTaxWithheld.
  ///
  /// In en, this message translates to:
  /// **'Loonheffing withheld'**
  String get plTaxWageTaxWithheld;

  /// No description provided for @plTaxWageTaxWithheldHelp.
  ///
  /// In en, this message translates to:
  /// **'The loonbelasting and premie volksverzekeringen your employers withheld, as you entered below. The return settles it against the tax above.'**
  String get plTaxWageTaxWithheldHelp;

  /// No description provided for @plTaxToPay.
  ///
  /// In en, this message translates to:
  /// **'Estimated tax to pay'**
  String get plTaxToPay;

  /// No description provided for @plTaxRefund.
  ///
  /// In en, this message translates to:
  /// **'Estimated refund'**
  String get plTaxRefund;

  /// No description provided for @plTaxToPayHelp.
  ///
  /// In en, this message translates to:
  /// **'Estimated: the total tax minus the loonheffing withheld. Payments on a voorlopige aanslag are not subtracted.'**
  String get plTaxToPayHelp;

  /// No description provided for @plTaxNetProfit.
  ///
  /// In en, this message translates to:
  /// **'Estimated net profit after tax'**
  String get plTaxNetProfit;

  /// No description provided for @plTaxNetProfitHelp.
  ///
  /// In en, this message translates to:
  /// **'Estimated: gross profit minus the tax the business adds. With wages, that is the total tax minus the tax on the wages alone.'**
  String get plTaxNetProfitHelp;

  /// No description provided for @plTaxEffectiveRate.
  ///
  /// In en, this message translates to:
  /// **'Effective rate on the profit: {rate}%'**
  String plTaxEffectiveRate(String rate);

  /// No description provided for @plTaxUrenBanner.
  ///
  /// In en, this message translates to:
  /// **'Urencriterium: {hours} of {target} hours logged{suffix}.'**
  String plTaxUrenBanner(String hours, String target, String suffix);

  /// No description provided for @plTaxUrenBannerSuffixDone.
  ///
  /// In en, this message translates to:
  /// **', so no zelfstandigenaftrek'**
  String get plTaxUrenBannerSuffixDone;

  /// No description provided for @plTaxUrenBannerSuffixPending.
  ///
  /// In en, this message translates to:
  /// **'. Until you reach it, the estimate leaves out the zelfstandigenaftrek and the other deductions that need it'**
  String get plTaxUrenBannerSuffixPending;

  /// No description provided for @plTaxUrenJobBanner.
  ///
  /// In en, this message translates to:
  /// **'Urencriterium: {hours} hours logged for the business, not more than the {jobHours} hours in employment. The urencriterium needs more time in the business than in other work, so the estimate leaves out the zelfstandigenaftrek and the other deductions that need it.'**
  String plTaxUrenJobBanner(String hours, int jobHours);

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

  /// No description provided for @settingsValidateName.
  ///
  /// In en, this message translates to:
  /// **'Enter your business name'**
  String get settingsValidateName;

  /// No description provided for @settingsValidateVat.
  ///
  /// In en, this message translates to:
  /// **'Enter your VAT number, e.g. NL123456789B01.'**
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

  /// No description provided for @settingsMoveDatabase.
  ///
  /// In en, this message translates to:
  /// **'Copy database and receipts to another folder'**
  String get settingsMoveDatabase;

  /// No description provided for @settingsExportSection.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get settingsExportSection;

  /// No description provided for @settingsExportDescription.
  ///
  /// In en, this message translates to:
  /// **'Export all {year} data to CSV files, with the VAT return of each quarter by rubriek in whole euros, the ICP list of each quarter and the estimated income tax of the year. Florin puts them in a new folder named after the export date, inside the folder you choose.'**
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
  /// **'Tax rules {year}'**
  String settingsTaxSection(int year);

  /// No description provided for @settingsTaxZelfs.
  ///
  /// In en, this message translates to:
  /// **'Zelfstandigenaftrek'**
  String get settingsTaxZelfs;

  /// No description provided for @settingsTaxStarters.
  ///
  /// In en, this message translates to:
  /// **'Startersaftrek'**
  String get settingsTaxStarters;

  /// No description provided for @settingsTaxMkb.
  ///
  /// In en, this message translates to:
  /// **'MKB-winstvrijstelling (%)'**
  String get settingsTaxMkb;

  /// No description provided for @settingsTaxMileage.
  ///
  /// In en, this message translates to:
  /// **'Mileage allowance per km'**
  String get settingsTaxMileage;

  /// No description provided for @settingsTaxZvwRate.
  ///
  /// In en, this message translates to:
  /// **'ZVW rate (%)'**
  String get settingsTaxZvwRate;

  /// No description provided for @settingsTaxUrencriterium.
  ///
  /// In en, this message translates to:
  /// **'Urencriterium (hours)'**
  String get settingsTaxUrencriterium;

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
  /// **'Default: the app data folder. Choose another folder to keep it in a synced folder. If that folder already holds a Florin database, Florin opens it.'**
  String get firstLaunchDbDescription;

  /// No description provided for @firstLaunchDbDefault.
  ///
  /// In en, this message translates to:
  /// **'{path} (default)'**
  String firstLaunchDbDefault(String path);

  /// No description provided for @firstLaunchDbDefaultFolder.
  ///
  /// In en, this message translates to:
  /// **'The app\'s own data folder (default)'**
  String get firstLaunchDbDefaultFolder;

  /// No description provided for @firstLaunchChooseFolder.
  ///
  /// In en, this message translates to:
  /// **'Choose folder'**
  String get firstLaunchChooseFolder;

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

  /// No description provided for @vatRate0.
  ///
  /// In en, this message translates to:
  /// **'0%'**
  String get vatRate0;

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
  /// **'Enter zero or more. A correction is its own record, such as a credit note.'**
  String get amountNegativeError;

  /// No description provided for @vatTreatmentStandard.
  ///
  /// In en, this message translates to:
  /// **'Dutch VAT'**
  String get vatTreatmentStandard;

  /// No description provided for @vatTreatmentReverseChargeNl.
  ///
  /// In en, this message translates to:
  /// **'VAT reverse-charged to a Dutch business'**
  String get vatTreatmentReverseChargeNl;

  /// No description provided for @vatTreatmentExportOutsideEu.
  ///
  /// In en, this message translates to:
  /// **'Export of goods outside the EU (0%)'**
  String get vatTreatmentExportOutsideEu;

  /// No description provided for @invoiceFieldVatTreatment.
  ///
  /// In en, this message translates to:
  /// **'VAT treatment'**
  String get invoiceFieldVatTreatment;

  /// No description provided for @invoiceValidateClientVat.
  ///
  /// In en, this message translates to:
  /// **'This client has no VAT number. Add it to the client: this invoice must show it.'**
  String get invoiceValidateClientVat;

  /// No description provided for @invoiceIssueTitle.
  ///
  /// In en, this message translates to:
  /// **'Send invoice'**
  String get invoiceIssueTitle;

  /// No description provided for @invoiceIssueMessage.
  ///
  /// In en, this message translates to:
  /// **'After sending, the invoice can no longer be changed or deleted. Corrections are made with a credit note.'**
  String get invoiceIssueMessage;

  /// No description provided for @invoiceIssueRenumber.
  ///
  /// In en, this message translates to:
  /// **'{number} does not follow the last invoice you issued in this series, so it is sent as {next}: invoice numbers follow on without gaps (Wet OB 1968 art. 35a lid 1 b).'**
  String invoiceIssueRenumber(String number, String next);

  /// No description provided for @invoiceActionSendAs.
  ///
  /// In en, this message translates to:
  /// **'Send as {number}'**
  String invoiceActionSendAs(String number);

  /// No description provided for @invoiceActionCreditNote.
  ///
  /// In en, this message translates to:
  /// **'Credit note'**
  String get invoiceActionCreditNote;

  /// No description provided for @invoiceNewCreditNoteHeader.
  ///
  /// In en, this message translates to:
  /// **'New credit note'**
  String get invoiceNewCreditNoteHeader;

  /// No description provided for @invoiceCorrects.
  ///
  /// In en, this message translates to:
  /// **'This credit note corrects invoice {number}.'**
  String invoiceCorrects(String number);

  /// No description provided for @invoiceVatTotal.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get invoiceVatTotal;

  /// No description provided for @invoiceRemoveLine.
  ///
  /// In en, this message translates to:
  /// **'Remove line'**
  String get invoiceRemoveLine;

  /// No description provided for @invoiceLockedNotice.
  ///
  /// In en, this message translates to:
  /// **'This invoice is issued, so it cannot be changed. To correct it, make a credit note that refers to it.'**
  String get invoiceLockedNotice;

  /// No description provided for @invoiceLockedCreditNotice.
  ///
  /// In en, this message translates to:
  /// **'This credit note is issued, so it cannot be changed.'**
  String get invoiceLockedCreditNotice;

  /// No description provided for @expensesFoodNotice.
  ///
  /// In en, this message translates to:
  /// **'Food, drinks, representation, congresses, seminars and study trips are deductible for income tax at {pct}, or as far as they exceed {drempel} a year if that is more (Wet IB 2001 art. 3.15). VAT on food and drinks consumed in a restaurant, café or hotel cannot be reclaimed (Wet OB 1968 art. 15).'**
  String expensesFoodNotice(String pct, String drempel);

  /// No description provided for @expensesCourseTravelNotice.
  ///
  /// In en, this message translates to:
  /// **'Travel and stay for courses, studies, congresses, seminars and study trips are deductible for income tax up to {max} a year; the part above it is not, unless your work makes attending necessary (Wet IB 2001 art. 3.16). Florin keeps the limit, because it cannot tell that from your records.'**
  String expensesCourseTravelNotice(String max);

  /// No description provided for @expensesBarredNotice.
  ///
  /// In en, this message translates to:
  /// **'The law keeps this cost out of your profit, whatever the amount: fines (Wet IB 2001 art. 3.14), and clothing other than werkkleding, personal care, a phone line in your home and literature other than professional literature (art. 3.16). Florin records it but deducts nothing. Clothing counts as werkkleding when it is only fit to wear for your work or shows that it is meant only for it; record werkkleding under Other.'**
  String get expensesBarredNotice;

  /// No description provided for @plTaxFoodLimited.
  ///
  /// In en, this message translates to:
  /// **'{category} ({amount})'**
  String plTaxFoodLimited(String category, String amount);

  /// No description provided for @plTaxBelastbareWinst.
  ///
  /// In en, this message translates to:
  /// **'Taxable profit'**
  String get plTaxBelastbareWinst;

  /// No description provided for @plTaxBracket.
  ///
  /// In en, this message translates to:
  /// **'Bracket {n} ({pct}%)'**
  String plTaxBracket(int n, String pct);

  /// No description provided for @plTaxEstimateNotice.
  ///
  /// In en, this message translates to:
  /// **'This is an estimate for a business owner under the AOW age. Wages from employment count when you enter them below. Income of a partner, from other work, box 2 or box 3 is not included.'**
  String get plTaxEstimateNotice;

  /// No description provided for @settingsMoved.
  ///
  /// In en, this message translates to:
  /// **'Database copied to {path} and now in use. The old file was kept.'**
  String settingsMoved(String path);

  /// No description provided for @settingsTaxVerified.
  ///
  /// In en, this message translates to:
  /// **'Florin uses these figures, checked against the Belastingdienst and the law. They cannot be edited.'**
  String get settingsTaxVerified;

  /// No description provided for @settingsTaxUpTo.
  ///
  /// In en, this message translates to:
  /// **'up to {amount}'**
  String settingsTaxUpTo(String amount);

  /// No description provided for @pensionPriorYearIncome.
  ///
  /// In en, this message translates to:
  /// **'Income from work in {year}'**
  String pensionPriorYearIncome(int year);

  /// No description provided for @pensionDeductible.
  ///
  /// In en, this message translates to:
  /// **'Deductible this year'**
  String get pensionDeductible;

  /// No description provided for @vatRow1e.
  ///
  /// In en, this message translates to:
  /// **'1e  Supplies / services taxed at 0% or not taxed with you'**
  String get vatRow1e;

  /// No description provided for @vatRow3b.
  ///
  /// In en, this message translates to:
  /// **'3b  Supplies to or services in EU countries'**
  String get vatRow3b;

  /// No description provided for @vatTreatmentEuServices.
  ///
  /// In en, this message translates to:
  /// **'Services to an EU business (VAT reverse-charged)'**
  String get vatTreatmentEuServices;

  /// No description provided for @vatTreatmentEuGoods.
  ///
  /// In en, this message translates to:
  /// **'Goods to an EU business (intra-Community supply, 0%)'**
  String get vatTreatmentEuGoods;

  /// No description provided for @vatReturnIcpNote.
  ///
  /// In en, this message translates to:
  /// **'Report these supplies in the ICP report over this quarter by {date}. If you supplied goods to EU businesses for more than {amount} in this quarter or in one of the {quarters} quarters before it, you report goods per month instead (Wet OB 1968 art. 37a).'**
  String vatReturnIcpNote(String date, String amount, int quarters);

  /// No description provided for @assetsFieldResidualValue.
  ///
  /// In en, this message translates to:
  /// **'Residual value'**
  String get assetsFieldResidualValue;

  /// No description provided for @assetsValidateResidualValue.
  ///
  /// In en, this message translates to:
  /// **'Enter the residual value, or 0 if the asset will have no value left'**
  String get assetsValidateResidualValue;

  /// No description provided for @assetsValidateResidualAboveCost.
  ///
  /// In en, this message translates to:
  /// **'The residual value cannot be higher than the cost'**
  String get assetsValidateResidualAboveCost;

  /// No description provided for @plTaxDisposalResult.
  ///
  /// In en, this message translates to:
  /// **'Result on sold assets'**
  String get plTaxDisposalResult;

  /// No description provided for @plTaxAov.
  ///
  /// In en, this message translates to:
  /// **'Disability insurance premiums'**
  String get plTaxAov;

  /// No description provided for @pensionAovHelper.
  ///
  /// In en, this message translates to:
  /// **'Premiums for disability insurance are deducted in full in the tax estimate.'**
  String get pensionAovHelper;

  /// No description provided for @assetsFieldCostHelp.
  ///
  /// In en, this message translates to:
  /// **'The purchase price without VAT. With any VAT you do not reclaim, it is the cost that depreciation and the investment deductions are based on.'**
  String get assetsFieldCostHelp;

  /// No description provided for @assetsFieldDisposalDateHelp.
  ///
  /// In en, this message translates to:
  /// **'The date you sold the asset or took it out of the business. Depreciation stops on this date.'**
  String get assetsFieldDisposalDateHelp;

  /// No description provided for @assetsFieldDisposalProceedsHelp.
  ///
  /// In en, this message translates to:
  /// **'What you received for the asset, without VAT, or its market value when you took it into private use. The difference with the book value is a gain or loss.'**
  String get assetsFieldDisposalProceedsHelp;

  /// No description provided for @assetsFieldKiaHelp.
  ///
  /// In en, this message translates to:
  /// **'Kleinschaligheidsinvesteringsaftrek: an extra deduction for business assets. Assets under {min} do not count, and passenger cars and some other assets are excluded.'**
  String assetsFieldKiaHelp(String min);

  /// No description provided for @assetsFieldNameHelp.
  ///
  /// In en, this message translates to:
  /// **'A name you recognise the asset by, such as \"MacBook Pro 2026\".'**
  String get assetsFieldNameHelp;

  /// No description provided for @assetsFieldNotesHelp.
  ///
  /// In en, this message translates to:
  /// **'Anything you want to remember about this asset. Not used in calculations.'**
  String get assetsFieldNotesHelp;

  /// No description provided for @assetsFieldPurchaseDateHelp.
  ///
  /// In en, this message translates to:
  /// **'The date you bought the asset. Depreciation starts on this date and the investment deductions apply to this year.'**
  String get assetsFieldPurchaseDateHelp;

  /// No description provided for @assetsFieldResidualValueHelp.
  ///
  /// In en, this message translates to:
  /// **'What the asset will still be worth at the end of its useful life. Depreciation stops at this value.'**
  String get assetsFieldResidualValueHelp;

  /// No description provided for @assetsFieldUsefulLifeHelp.
  ///
  /// In en, this message translates to:
  /// **'How many years you expect to use the asset. At least {years}, because depreciation is limited to {pct} of the cost a year.'**
  String assetsFieldUsefulLifeHelp(int years, String pct);

  /// No description provided for @assetsVatSection.
  ///
  /// In en, this message translates to:
  /// **'VAT on the purchase'**
  String get assetsVatSection;

  /// No description provided for @assetsVatSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'The VAT on the purchase invoice. VAT you reclaim goes into the VAT return of the quarter of purchase; VAT you do not reclaim is part of the asset\'s cost.'**
  String get assetsVatSectionHelp;

  /// No description provided for @assetsFieldVatRate.
  ///
  /// In en, this message translates to:
  /// **'VAT rate'**
  String get assetsFieldVatRate;

  /// No description provided for @assetsFieldVatRateHelp.
  ///
  /// In en, this message translates to:
  /// **'The VAT rate on the purchase invoice: {high}, {low}, 0% or exempt. Choose 0% when no VAT was charged, such as on a purchase from a private seller.'**
  String assetsFieldVatRateHelp(String high, String low);

  /// No description provided for @assetsValidateVatRate.
  ///
  /// In en, this message translates to:
  /// **'Choose the VAT rate on the purchase invoice: the VAT in your return depends on it.'**
  String get assetsValidateVatRate;

  /// No description provided for @assetsFieldVatAmount.
  ///
  /// In en, this message translates to:
  /// **'VAT amount'**
  String get assetsFieldVatAmount;

  /// No description provided for @assetsFieldVatAmountHelp.
  ///
  /// In en, this message translates to:
  /// **'The VAT on the purchase invoice. Florin has no tax rules for the year of purchase, so you enter the amount instead of a rate.'**
  String get assetsFieldVatAmountHelp;

  /// No description provided for @assetsFieldPurchaseVat.
  ///
  /// In en, this message translates to:
  /// **'How the VAT was charged'**
  String get assetsFieldPurchaseVat;

  /// No description provided for @assetsFieldPurchaseVatHelp.
  ///
  /// In en, this message translates to:
  /// **'Dutch VAT when the supplier charged it. Shifted when the invoice says the VAT is reverse-charged to you, or the supplier is abroad: you then report and deduct the VAT yourself.'**
  String get assetsFieldPurchaseVatHelp;

  /// No description provided for @assetsReclaimVat.
  ///
  /// In en, this message translates to:
  /// **'Reclaim this VAT'**
  String get assetsReclaimVat;

  /// No description provided for @assetsReclaimVatHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick when you may deduct this VAT in your VAT return. You may for the business share used for work you charge VAT on: not while you take part in the KOR, and not for an asset used only for VAT-exempt work.'**
  String get assetsReclaimVatHelp;

  /// No description provided for @assetsValidateKorReclaim.
  ///
  /// In en, this message translates to:
  /// **'You take part in the KOR on the purchase date, so you cannot reclaim this VAT. Untick Reclaim this VAT: the VAT is then part of the cost.'**
  String get assetsValidateKorReclaim;

  /// No description provided for @assetsKorNotice.
  ///
  /// In en, this message translates to:
  /// **'You take part in the KOR on the purchase date. The VAT is not reclaimed; it is part of the cost that depreciation and the investment deductions are based on.'**
  String get assetsKorNotice;

  /// No description provided for @assetsFieldVat.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get assetsFieldVat;

  /// No description provided for @assetsVatBack.
  ///
  /// In en, this message translates to:
  /// **'VAT back'**
  String get assetsVatBack;

  /// No description provided for @assetsCostForTax.
  ///
  /// In en, this message translates to:
  /// **'Cost for income tax'**
  String get assetsCostForTax;

  /// No description provided for @assetsCostForTaxHelp.
  ///
  /// In en, this message translates to:
  /// **'The price and any VAT you do not reclaim. Depreciation and the investment deductions are based on it.'**
  String get assetsCostForTaxHelp;

  /// No description provided for @assetsFieldSaleInvoice.
  ///
  /// In en, this message translates to:
  /// **'Sale invoice'**
  String get assetsFieldSaleInvoice;

  /// No description provided for @assetsFieldSaleInvoiceHelp.
  ///
  /// In en, this message translates to:
  /// **'The invoice you issued in Florin for this sale only. Its amount is the proceeds and its VAT is in your VAT return; it does not count as revenue or for the KOR turnover. Choose none for a sale without an invoice in Florin or when you took the asset into private use.'**
  String get assetsFieldSaleInvoiceHelp;

  /// No description provided for @assetsSaleInvoiceNone.
  ///
  /// In en, this message translates to:
  /// **'No invoice in Florin'**
  String get assetsSaleInvoiceNone;

  /// No description provided for @assetsProceedsFromInvoiceHelp.
  ///
  /// In en, this message translates to:
  /// **'What the sale invoice and any credit note on it come to, without VAT. The difference with the book value is a gain or loss.'**
  String get assetsProceedsFromInvoiceHelp;

  /// No description provided for @assetsFieldDisposalVatRate.
  ///
  /// In en, this message translates to:
  /// **'VAT on the sale'**
  String get assetsFieldDisposalVatRate;

  /// No description provided for @assetsFieldDisposalVatRateHelp.
  ///
  /// In en, this message translates to:
  /// **'The VAT you owe on the sale, or on taking the asset into private use, over the business share of the proceeds. It goes into the VAT return of that quarter. Usually {high}; exempt only when you used the asset solely for VAT-exempt work and deducted no VAT on it.'**
  String assetsFieldDisposalVatRateHelp(String high);

  /// No description provided for @assetsValidateDisposalVatRate.
  ///
  /// In en, this message translates to:
  /// **'Choose the VAT rate of the sale: the VAT in your return depends on it.'**
  String get assetsValidateDisposalVatRate;

  /// No description provided for @assetsSaleKorNotice.
  ///
  /// In en, this message translates to:
  /// **'You take part in the KOR on the sale date, so there is no VAT on the sale.'**
  String get assetsSaleKorNotice;

  /// No description provided for @clientsContractExpiryHelp.
  ///
  /// In en, this message translates to:
  /// **'When the agreement with this client ends.'**
  String get clientsContractExpiryHelp;

  /// No description provided for @clientsContractSignedHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick when you and the client have signed a written agreement.'**
  String get clientsContractSignedHelp;

  /// No description provided for @clientsFieldActiveHelp.
  ///
  /// In en, this message translates to:
  /// **'Inactive clients stay in your records but are not offered on new invoices.'**
  String get clientsFieldActiveHelp;

  /// No description provided for @clientsFieldAddressHelp.
  ///
  /// In en, this message translates to:
  /// **'The client\'s full business address. It is printed on every invoice.'**
  String get clientsFieldAddressHelp;

  /// No description provided for @clientsFieldContactHelp.
  ///
  /// In en, this message translates to:
  /// **'The person you deal with at this client.'**
  String get clientsFieldContactHelp;

  /// No description provided for @clientsFieldCountryHelp.
  ///
  /// In en, this message translates to:
  /// **'The two-letter country code, such as NL or DE. It decides which VAT treatments an invoice to this client can use.'**
  String get clientsFieldCountryHelp;

  /// No description provided for @clientsFieldEmailHelp.
  ///
  /// In en, this message translates to:
  /// **'The address you send invoices to.'**
  String get clientsFieldEmailHelp;

  /// No description provided for @clientsFieldKvkHelp.
  ///
  /// In en, this message translates to:
  /// **'The client\'s 8-digit Chamber of Commerce number, if they have one.'**
  String get clientsFieldKvkHelp;

  /// No description provided for @clientsFieldNameHelp.
  ///
  /// In en, this message translates to:
  /// **'The client\'s legal or registered trade name, as it should appear on invoices.'**
  String get clientsFieldNameHelp;

  /// No description provided for @clientsFieldNotesHelp.
  ///
  /// In en, this message translates to:
  /// **'Anything you want to remember about this client. Not printed on invoices.'**
  String get clientsFieldNotesHelp;

  /// No description provided for @clientsFieldPhoneHelp.
  ///
  /// In en, this message translates to:
  /// **'A phone number for this client.'**
  String get clientsFieldPhoneHelp;

  /// No description provided for @clientsFieldVatHelp.
  ///
  /// In en, this message translates to:
  /// **'The client\'s VAT identification number. Required on invoices where the VAT is reverse-charged or that go to an EU business.'**
  String get clientsFieldVatHelp;

  /// No description provided for @clientsRiskLevelHelp.
  ///
  /// In en, this message translates to:
  /// **'Your own assessment of whether the work could be seen as employment under the Wet DBA. Used only to remind you.'**
  String get clientsRiskLevelHelp;

  /// No description provided for @expensesFieldAmountExclHelp.
  ///
  /// In en, this message translates to:
  /// **'The amount on the receipt without VAT.'**
  String get expensesFieldAmountExclHelp;

  /// No description provided for @expensesFieldCategoryHelp.
  ///
  /// In en, this message translates to:
  /// **'What kind of cost this is. Food, drinks, representation, congresses, seminars, excursions and study trips are only partly deductible (Wet IB 2001 art. 3.15), travel for courses and congresses only up to a yearly amount, and fines, ordinary clothing, personal care, a phone line at home and general literature not at all (art. 3.14 and 3.16), so each has its own category.'**
  String get expensesFieldCategoryHelp;

  /// No description provided for @expensesFieldDescriptionHelp.
  ///
  /// In en, this message translates to:
  /// **'What you bought, so you and the Belastingdienst can see the business purpose.'**
  String get expensesFieldDescriptionHelp;

  /// No description provided for @expensesFieldPaidFromHelp.
  ///
  /// In en, this message translates to:
  /// **'The account or card you paid with, to match the expense with your bank statement.'**
  String get expensesFieldPaidFromHelp;

  /// No description provided for @expensesFieldPaymentRefHelp.
  ///
  /// In en, this message translates to:
  /// **'The reference of the payment or invoice, to find it back later.'**
  String get expensesFieldPaymentRefHelp;

  /// No description provided for @expensesFieldSupplierHelp.
  ///
  /// In en, this message translates to:
  /// **'The business you bought from, as on the receipt.'**
  String get expensesFieldSupplierHelp;

  /// No description provided for @expensesFieldVatRateHelp.
  ///
  /// In en, this message translates to:
  /// **'The VAT rate on the receipt: {high}, {low}, 0% or exempt.'**
  String expensesFieldVatRateHelp(String high, String low);

  /// No description provided for @expensesReclaimVatHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick when you may deduct this VAT in your VAT return. Not for food and drinks in a restaurant, for private use, or for gifts to someone who cannot deduct VAT when they total more than {amount} for that person in a year (Besluit uitsluiting aftrek omzetbelasting 1968).'**
  String expensesReclaimVatHelp(String amount);

  /// No description provided for @hoursFieldClientProjectHelp.
  ///
  /// In en, this message translates to:
  /// **'The client or project the hours were for.'**
  String get hoursFieldClientProjectHelp;

  /// No description provided for @hoursFieldDateHelp.
  ///
  /// In en, this message translates to:
  /// **'The day you worked.'**
  String get hoursFieldDateHelp;

  /// No description provided for @hoursFieldDescriptionHelp.
  ///
  /// In en, this message translates to:
  /// **'What you did. All hours spent on the business count towards the urencriterium, not only billable ones.'**
  String get hoursFieldDescriptionHelp;

  /// No description provided for @hoursFieldHoursHelp.
  ///
  /// In en, this message translates to:
  /// **'How many hours you worked that day, such as 7,5.'**
  String get hoursFieldHoursHelp;

  /// No description provided for @hoursFieldNotesHelp.
  ///
  /// In en, this message translates to:
  /// **'Anything you want to remember about these hours.'**
  String get hoursFieldNotesHelp;

  /// No description provided for @hoursFieldWorkTypeHelp.
  ///
  /// In en, this message translates to:
  /// **'The kind of work. WBSO hours count towards the {hours} hours needed for the S&O-aftrek.'**
  String hoursFieldWorkTypeHelp(int hours);

  /// No description provided for @invoiceFieldClientHelp.
  ///
  /// In en, this message translates to:
  /// **'Who the invoice is for. Their name and address are printed on it.'**
  String get invoiceFieldClientHelp;

  /// No description provided for @invoiceFieldDescriptionHelp.
  ///
  /// In en, this message translates to:
  /// **'What you delivered: the nature of the goods or services, as the law requires on an invoice.'**
  String get invoiceFieldDescriptionHelp;

  /// No description provided for @invoiceFieldDueDateHelp.
  ///
  /// In en, this message translates to:
  /// **'The last day for payment: the invoice date plus the payment term.'**
  String get invoiceFieldDueDateHelp;

  /// No description provided for @invoiceFieldInvoiceDateHelp.
  ///
  /// In en, this message translates to:
  /// **'The date the invoice is issued. It decides the year and quarter the revenue and VAT belong to.'**
  String get invoiceFieldInvoiceDateHelp;

  /// No description provided for @invoiceFieldNumberHelp.
  ///
  /// In en, this message translates to:
  /// **'A unique number in an unbroken sequence, as the law requires. Florin suggests the next one.'**
  String get invoiceFieldNumberHelp;

  /// No description provided for @invoiceFieldPaymentTermHelp.
  ///
  /// In en, this message translates to:
  /// **'How many days the client has to pay.'**
  String get invoiceFieldPaymentTermHelp;

  /// No description provided for @invoiceFieldPriceHelp.
  ///
  /// In en, this message translates to:
  /// **'The price per unit without VAT.'**
  String get invoiceFieldPriceHelp;

  /// No description provided for @invoiceFieldQuantityHelp.
  ///
  /// In en, this message translates to:
  /// **'How many units, such as hours or pieces.'**
  String get invoiceFieldQuantityHelp;

  /// No description provided for @invoiceFieldRemarksHelp.
  ///
  /// In en, this message translates to:
  /// **'Extra text printed at the bottom of the invoice.'**
  String get invoiceFieldRemarksHelp;

  /// No description provided for @invoiceFieldSupplyDateHelp.
  ///
  /// In en, this message translates to:
  /// **'When you delivered, if that differs from the invoice date. The law requires it on the invoice in that case.'**
  String get invoiceFieldSupplyDateHelp;

  /// No description provided for @invoiceLateNotice.
  ///
  /// In en, this message translates to:
  /// **'An invoice is due by day {day} of the month after the supply (Wet OB 1968 art. 34g): for this supply by {date}.'**
  String invoiceLateNotice(int day, String date);

  /// No description provided for @invoiceFieldUnitHelp.
  ///
  /// In en, this message translates to:
  /// **'The unit of the quantity, such as hours or pieces.'**
  String get invoiceFieldUnitHelp;

  /// No description provided for @invoiceFieldVatHelp.
  ///
  /// In en, this message translates to:
  /// **'The VAT rate for this line.'**
  String get invoiceFieldVatHelp;

  /// No description provided for @invoiceFieldVatReverseHelp.
  ///
  /// In en, this message translates to:
  /// **'The VAT rate that would apply without reverse charge. The invoice states it with the amount per rate, and your customer pays the VAT.'**
  String get invoiceFieldVatReverseHelp;

  /// No description provided for @invoiceValidateLineRate.
  ///
  /// In en, this message translates to:
  /// **'Choose the VAT rate for this line: the invoice states it, also when the VAT is reverse-charged.'**
  String get invoiceValidateLineRate;

  /// No description provided for @invoiceFieldVatTreatmentHelp.
  ///
  /// In en, this message translates to:
  /// **'How VAT applies. Dutch VAT for most Dutch clients, or Exempt under the KOR while you take part in it. Reverse charge when the customer pays the VAT. EU goods and services to businesses also go on the ICP report. Services to a business outside the EU are taxed there and stay out of the Dutch return.'**
  String get invoiceFieldVatTreatmentHelp;

  /// No description provided for @labelCategoryHelp.
  ///
  /// In en, this message translates to:
  /// **'Show only expenses of one category.'**
  String get labelCategoryHelp;

  /// No description provided for @labelDateHelp.
  ///
  /// In en, this message translates to:
  /// **'The date on the receipt. It decides the year and quarter of the expense.'**
  String get labelDateHelp;

  /// No description provided for @labelNotesHelp.
  ///
  /// In en, this message translates to:
  /// **'Anything you want to remember. Not used in calculations.'**
  String get labelNotesHelp;

  /// No description provided for @mileageFieldDateHelp.
  ///
  /// In en, this message translates to:
  /// **'The day of the trip.'**
  String get mileageFieldDateHelp;

  /// No description provided for @mileageFieldDistanceHelp.
  ///
  /// In en, this message translates to:
  /// **'Calculated from the odometer readings.'**
  String get mileageFieldDistanceHelp;

  /// No description provided for @mileageFieldFromHelp.
  ///
  /// In en, this message translates to:
  /// **'Where the trip started.'**
  String get mileageFieldFromHelp;

  /// No description provided for @mileageFieldMakeModelHelp.
  ///
  /// In en, this message translates to:
  /// **'The make and model of the vehicle, for your trip log.'**
  String get mileageFieldMakeModelHelp;

  /// No description provided for @mileageFieldNotesHelp.
  ///
  /// In en, this message translates to:
  /// **'Anything you want to remember about this trip.'**
  String get mileageFieldNotesHelp;

  /// No description provided for @mileageFieldOdoEndHelp.
  ///
  /// In en, this message translates to:
  /// **'The odometer reading at the end of the trip.'**
  String get mileageFieldOdoEndHelp;

  /// No description provided for @mileageFieldOdoStartHelp.
  ///
  /// In en, this message translates to:
  /// **'The odometer reading at the start of the trip.'**
  String get mileageFieldOdoStartHelp;

  /// No description provided for @mileageFieldPlateHelp.
  ///
  /// In en, this message translates to:
  /// **'The licence plate, for your trip log.'**
  String get mileageFieldPlateHelp;

  /// No description provided for @mileageFieldPurposeHelp.
  ///
  /// In en, this message translates to:
  /// **'Why you made the trip, such as the client or meeting.'**
  String get mileageFieldPurposeHelp;

  /// No description provided for @mileageFieldRouteDeviationHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick when you took a longer or different route than the shortest one, and note why.'**
  String get mileageFieldRouteDeviationHelp;

  /// No description provided for @mileageFieldToHelp.
  ///
  /// In en, this message translates to:
  /// **'Where the trip ended.'**
  String get mileageFieldToHelp;

  /// No description provided for @mileageFieldTripTypeHelp.
  ///
  /// In en, this message translates to:
  /// **'Business and commuting trips in a private vehicle are deductible per km for income tax. Private trips are not.'**
  String get mileageFieldTripTypeHelp;

  /// No description provided for @pensionAovInsuredHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick when you have a private disability insurance (AOV). Its premiums are deductible.'**
  String get pensionAovInsuredHelp;

  /// No description provided for @pensionFactorAHelp.
  ///
  /// In en, this message translates to:
  /// **'The pension you built up with an employer last year, from the factor A on your UPO. Leave 0 if you had none. If your pension scheme follows the Wet toekomst pensioenen, your UPO shows premiums instead: the law then lowers the jaarruimte by those premiums, which Florin does not calculate.'**
  String get pensionFactorAHelp;

  /// No description provided for @pensionLijfrenteHelp.
  ///
  /// In en, this message translates to:
  /// **'What you pay or plan to pay into a lijfrente this year. Deducted up to the room you have.'**
  String get pensionLijfrenteHelp;

  /// No description provided for @pensionMonthlyPremiumHelp.
  ///
  /// In en, this message translates to:
  /// **'The monthly premium of your disability insurance.'**
  String get pensionMonthlyPremiumHelp;

  /// No description provided for @pensionPriorYearIncomeHelp.
  ///
  /// In en, this message translates to:
  /// **'Last year\'s profit from business before the ondernemersaftrek, plus taxable wages, taxable result from other work and taxable periodic benefits, from that year\'s tax return (Wet IB 2001 art. 3.127 lid 3). The jaarruimte is based on it.'**
  String get pensionPriorYearIncomeHelp;

  /// No description provided for @pensionCountedIncomeHelp.
  ///
  /// In en, this message translates to:
  /// **'The income as it counts for the premiegrondslag: at most {max} (Wet IB 2001 art. 3.127 lid 3).'**
  String pensionCountedIncomeHelp(String max);

  /// No description provided for @pensionReserveringsruimteLabelHelp.
  ///
  /// In en, this message translates to:
  /// **'Unused jaarruimte from earlier years that you may still use. The Belastingdienst\'s Hulpmiddel Lijfrentepremie calculates it.'**
  String get pensionReserveringsruimteLabelHelp;

  /// No description provided for @settingsBusinessAddressHelp.
  ///
  /// In en, this message translates to:
  /// **'Your full business address. It is printed on every invoice.'**
  String get settingsBusinessAddressHelp;

  /// No description provided for @settingsBusinessNameHelp.
  ///
  /// In en, this message translates to:
  /// **'Your business name as registered with the KvK. It is printed on every invoice.'**
  String get settingsBusinessNameHelp;

  /// No description provided for @settingsIbanHelp.
  ///
  /// In en, this message translates to:
  /// **'The bank account clients pay to. It is printed in the payment instructions.'**
  String get settingsIbanHelp;

  /// No description provided for @settingsKvkNumberHelp.
  ///
  /// In en, this message translates to:
  /// **'Your 8-digit KvK number. It is printed on every invoice.'**
  String get settingsKvkNumberHelp;

  /// No description provided for @settingsVatNumberHelp.
  ///
  /// In en, this message translates to:
  /// **'Your VAT identification number (btw-id), NL followed by 9 digits, B and 2 digits. It is printed on every invoice.'**
  String get settingsVatNumberHelp;

  /// No description provided for @vatReturnFiledHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick once you have filed this quarter\'s return in Mijn Belastingdienst Zakelijk.'**
  String get vatReturnFiledHelp;

  /// No description provided for @vatReturnPaidHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick once you have paid the VAT due for this quarter.'**
  String get vatReturnPaidHelp;

  /// No description provided for @assetKindGeneral.
  ///
  /// In en, this message translates to:
  /// **'Business asset'**
  String get assetKindGeneral;

  /// No description provided for @assetKindCar.
  ///
  /// In en, this message translates to:
  /// **'Car owned by the business'**
  String get assetKindCar;

  /// No description provided for @assetsFieldKind.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get assetsFieldKind;

  /// No description provided for @assetsFieldKindHelp.
  ///
  /// In en, this message translates to:
  /// **'Choose car for a passenger car or van that belongs to the business. Private use of it is added to your profit and to your VAT return.'**
  String get assetsFieldKindHelp;

  /// No description provided for @assetsCarSection.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get assetsCarSection;

  /// No description provided for @assetsCarSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'These details decide the addition for private use (bijtelling) and the VAT on private use. A business car counts in full: the bijtelling and the VAT on private use correct for its private use.'**
  String get assetsCarSectionHelp;

  /// No description provided for @assetsFieldCatalogueValue.
  ///
  /// In en, this message translates to:
  /// **'Catalogue value'**
  String get assetsFieldCatalogueValue;

  /// No description provided for @assetsFieldCatalogueValueHelp.
  ///
  /// In en, this message translates to:
  /// **'The original list price including VAT and BPM, as on the registration certificate or the RDW website.'**
  String get assetsFieldCatalogueValueHelp;

  /// No description provided for @assetsValidateCatalogueValue.
  ///
  /// In en, this message translates to:
  /// **'Enter the catalogue value including VAT and BPM, above zero: the private-use addition is a percentage of it.'**
  String get assetsValidateCatalogueValue;

  /// No description provided for @assetsFieldFirstRegistration.
  ///
  /// In en, this message translates to:
  /// **'First registration'**
  String get assetsFieldFirstRegistration;

  /// No description provided for @assetsFieldFirstRegistrationHelp.
  ///
  /// In en, this message translates to:
  /// **'The date the car was first registered, on the registration certificate. It decides which bijtelling percentage applies.'**
  String get assetsFieldFirstRegistrationHelp;

  /// No description provided for @assetsValidateFirstRegistration.
  ///
  /// In en, this message translates to:
  /// **'Enter the date of first registration from the registration certificate'**
  String get assetsValidateFirstRegistration;

  /// No description provided for @assetsFieldZeroEmission.
  ///
  /// In en, this message translates to:
  /// **'Zero emission'**
  String get assetsFieldZeroEmission;

  /// No description provided for @assetsFieldZeroEmissionHelp.
  ///
  /// In en, this message translates to:
  /// **'Electric, hydrogen and solar cars with 0 g/km CO2 get a lower bijtelling.'**
  String get assetsFieldZeroEmissionHelp;

  /// No description provided for @zeroEmissionNone.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get zeroEmissionNone;

  /// No description provided for @zeroEmissionBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery electric'**
  String get zeroEmissionBattery;

  /// No description provided for @zeroEmissionHydrogenOrSolar.
  ///
  /// In en, this message translates to:
  /// **'Hydrogen or integrated solar'**
  String get zeroEmissionHydrogenOrSolar;

  /// No description provided for @assetsFieldMarketValue.
  ///
  /// In en, this message translates to:
  /// **'Market value'**
  String get assetsFieldMarketValue;

  /// No description provided for @assetsFieldMarketValueHelp.
  ///
  /// In en, this message translates to:
  /// **'What the car is worth now. Only used once the car is more than {years} years old.'**
  String assetsFieldMarketValueHelp(int years);

  /// No description provided for @assetsFieldTripLog.
  ///
  /// In en, this message translates to:
  /// **'I keep a complete trip log for this car'**
  String get assetsFieldTripLog;

  /// No description provided for @assetsFieldTripLogHelp.
  ///
  /// In en, this message translates to:
  /// **'With a complete trip log of all trips in this car, there is no bijtelling at {km} private km a year or less, and VAT on private use is based on the actual kilometres.'**
  String assetsFieldTripLogHelp(int km);

  /// No description provided for @assetsInvestmentSection.
  ///
  /// In en, this message translates to:
  /// **'Investment deductions'**
  String get assetsInvestmentSection;

  /// No description provided for @assetsInvestmentSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Extra deductions in the year of purchase. If you sell the asset within {years} years, part of them is added back.'**
  String assetsInvestmentSectionHelp(int years);

  /// No description provided for @assetsFieldEia.
  ///
  /// In en, this message translates to:
  /// **'Energy investment (EIA), reported to RVO'**
  String get assetsFieldEia;

  /// No description provided for @assetsFieldEiaHelp.
  ///
  /// In en, this message translates to:
  /// **'An asset on the RVO Energy List, reported to RVO within {months} months. At least {min} per asset. Cannot be combined with MIA.'**
  String assetsFieldEiaHelp(int months, String min);

  /// No description provided for @assetsFieldMia.
  ///
  /// In en, this message translates to:
  /// **'Environmental investment (MIA)'**
  String get assetsFieldMia;

  /// No description provided for @assetsFieldMiaHelp.
  ///
  /// In en, this message translates to:
  /// **'The category on the RVO Environmental List, reported to RVO within {months} months. At least {min} per asset.'**
  String assetsFieldMiaHelp(int months, String min);

  /// No description provided for @assetsMiaNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get assetsMiaNone;

  /// No description provided for @miaCategoryOne.
  ///
  /// In en, this message translates to:
  /// **'Category I'**
  String get miaCategoryOne;

  /// No description provided for @miaCategoryTwo.
  ///
  /// In en, this message translates to:
  /// **'Category II'**
  String get miaCategoryTwo;

  /// No description provided for @miaCategoryThree.
  ///
  /// In en, this message translates to:
  /// **'Category III'**
  String get miaCategoryThree;

  /// No description provided for @assetsFieldDeductionReceived.
  ///
  /// In en, this message translates to:
  /// **'Investment deduction received'**
  String get assetsFieldDeductionReceived;

  /// No description provided for @assetsFieldDeductionReceivedHelp.
  ///
  /// In en, this message translates to:
  /// **'The KIA, EIA and MIA you received for this asset in its purchase year, from that year\'s tax return. Needed to add part back if you sell it within {years} years.'**
  String assetsFieldDeductionReceivedHelp(int years);

  /// No description provided for @assetsValidateDeductionReceived.
  ///
  /// In en, this message translates to:
  /// **'Enter the investment deduction you received for this asset, or 0'**
  String get assetsValidateDeductionReceived;

  /// No description provided for @assetsFieldReserveApplied.
  ///
  /// In en, this message translates to:
  /// **'Herinvesteringsreserve booked off'**
  String get assetsFieldReserveApplied;

  /// No description provided for @assetsFieldReserveAppliedHelp.
  ///
  /// In en, this message translates to:
  /// **'Part of the herinvesteringsreserve booked off on this purchase. It lowers the cost to depreciate.'**
  String get assetsFieldReserveAppliedHelp;

  /// No description provided for @assetsReserveAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available: {amount}'**
  String assetsReserveAvailable(String amount);

  /// No description provided for @assetsValidateReserveAboveAvailable.
  ///
  /// In en, this message translates to:
  /// **'This is more than the herinvesteringsreserve available'**
  String get assetsValidateReserveAboveAvailable;

  /// No description provided for @assetsValidateReserveAboveCost.
  ///
  /// In en, this message translates to:
  /// **'This is more than the cost minus the residual value'**
  String get assetsValidateReserveAboveCost;

  /// No description provided for @assetsFieldReserveGain.
  ///
  /// In en, this message translates to:
  /// **'Put the gain in the herinvesteringsreserve'**
  String get assetsFieldReserveGain;

  /// No description provided for @assetsFieldReserveGainHelp.
  ///
  /// In en, this message translates to:
  /// **'Only when you intend to buy a replacement. The gain is then not taxed now but booked off on the next purchase; unused after {years} years, it is added to your profit.'**
  String assetsFieldReserveGainHelp(int years);

  /// No description provided for @dashboardDeductibleCostsHelp.
  ///
  /// In en, this message translates to:
  /// **'Costs deductible for income tax, including depreciation and the mileage allowance. Estimated.'**
  String get dashboardDeductibleCostsHelp;

  /// No description provided for @dashboardEstimatedTaxHelp.
  ///
  /// In en, this message translates to:
  /// **'Estimated income tax and Zvw contribution on your profit so far. Not a tax assessment.'**
  String get dashboardEstimatedTaxHelp;

  /// No description provided for @dashboardEstimatedTaxToPay.
  ///
  /// In en, this message translates to:
  /// **'Estimated tax to pay'**
  String get dashboardEstimatedTaxToPay;

  /// No description provided for @dashboardEstimatedRefund.
  ///
  /// In en, this message translates to:
  /// **'Estimated refund'**
  String get dashboardEstimatedRefund;

  /// No description provided for @dashboardEstimatedTaxToPayHelp.
  ///
  /// In en, this message translates to:
  /// **'Estimated income tax and Zvw contribution on your profit so far and your wages, minus the loonheffing withheld. Not a tax assessment.'**
  String get dashboardEstimatedTaxToPayHelp;

  /// No description provided for @dashboardNetProfitAfterTaxHelp.
  ///
  /// In en, this message translates to:
  /// **'Profit minus the estimated tax the business adds. An estimate, not a final figure.'**
  String get dashboardNetProfitAfterTaxHelp;

  /// No description provided for @expensesFieldCar.
  ///
  /// In en, this message translates to:
  /// **'Business car'**
  String get expensesFieldCar;

  /// No description provided for @expensesFieldCarHelp.
  ///
  /// In en, this message translates to:
  /// **'Link costs such as fuel and insurance to a business car. A linked cost counts in full, as the bijtelling and the VAT on private use correct for private use. Linked costs cap the bijtelling and decide the VAT on private use.'**
  String get expensesFieldCarHelp;

  /// No description provided for @expensesNoCar.
  ///
  /// In en, this message translates to:
  /// **'Not for a business car'**
  String get expensesNoCar;

  /// No description provided for @mileageFieldVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get mileageFieldVehicle;

  /// No description provided for @mileageFieldVehicleHelp.
  ///
  /// In en, this message translates to:
  /// **'A private vehicle earns the per-km deduction. Trips in a business car do not; they count for its trip log instead.'**
  String get mileageFieldVehicleHelp;

  /// No description provided for @mileagePrivateVehicle.
  ///
  /// In en, this message translates to:
  /// **'Private vehicle'**
  String get mileagePrivateVehicle;

  /// No description provided for @inputPartnerHours.
  ///
  /// In en, this message translates to:
  /// **'Partner\'s hours in the business'**
  String get inputPartnerHours;

  /// No description provided for @inputPartnerHoursHelp.
  ///
  /// In en, this message translates to:
  /// **'Hours your fiscal partner worked in your business this year without pay, or for less than {pay}. From {hours} hours you get the meewerkaftrek.'**
  String inputPartnerHoursHelp(String pay, int hours);

  /// No description provided for @inputUnrealisedZelfs.
  ///
  /// In en, this message translates to:
  /// **'Unused zelfstandigenaftrek'**
  String get inputUnrealisedZelfs;

  /// No description provided for @inputUnrealisedZelfsHelp.
  ///
  /// In en, this message translates to:
  /// **'Zelfstandigenaftrek from the previous {years} years that did not fit your profit, as stated by the Belastingdienst. Used up to this year\'s profit.'**
  String inputUnrealisedZelfsHelp(int years);

  /// No description provided for @inputLossCarryForward.
  ///
  /// In en, this message translates to:
  /// **'Losses from earlier years'**
  String get inputLossCarryForward;

  /// No description provided for @inputLossCarryForwardHelp.
  ///
  /// In en, this message translates to:
  /// **'Box 1 losses from earlier years still to offset, as stated by the Belastingdienst. Offset against this year\'s income.'**
  String get inputLossCarryForwardHelp;

  /// No description provided for @inputEmployed.
  ///
  /// In en, this message translates to:
  /// **'I also work as an employee this year'**
  String get inputEmployed;

  /// No description provided for @inputEmployedHelp.
  ///
  /// In en, this message translates to:
  /// **'Wages count in box 1 together with your profit, and the urencriterium then also compares your hours in the business with your hours in employment.'**
  String get inputEmployedHelp;

  /// No description provided for @inputWages.
  ///
  /// In en, this message translates to:
  /// **'Wages (loon)'**
  String get inputWages;

  /// No description provided for @inputWagesHelp.
  ///
  /// In en, this message translates to:
  /// **'The loon on your jaaropgaven: the wage that is taxed, not the gross salary. It is added to your profit in box 1.'**
  String get inputWagesHelp;

  /// No description provided for @inputWageTaxWithheld.
  ///
  /// In en, this message translates to:
  /// **'Loonheffing withheld'**
  String get inputWageTaxWithheld;

  /// No description provided for @inputWageTaxWithheldHelp.
  ///
  /// In en, this message translates to:
  /// **'The loonheffing on your jaaropgaven: the loonbelasting and premie volksverzekeringen your employers withheld. The return subtracts it from the tax.'**
  String get inputWageTaxWithheldHelp;

  /// No description provided for @inputZvwWages.
  ///
  /// In en, this message translates to:
  /// **'Loon Zvw'**
  String get inputZvwWages;

  /// No description provided for @inputZvwWagesHelp.
  ///
  /// In en, this message translates to:
  /// **'The loon Zorgverzekeringswet on your jaaropgaven, on which your employer paid the werkgeversheffing Zvw. You pay the Zvw contribution on your profit only up to the maximum bijdrage-inkomen minus this amount.'**
  String get inputZvwWagesHelp;

  /// No description provided for @inputEmploymentHours.
  ///
  /// In en, this message translates to:
  /// **'Hours in employment'**
  String get inputEmploymentHours;

  /// No description provided for @inputEmploymentHoursHelp.
  ///
  /// In en, this message translates to:
  /// **'The hours you work as an employee in the whole year. The urencriterium also requires more time in the business than in other work, unless you were not a business owner in one or more of the {years} previous years.'**
  String inputEmploymentHoursHelp(int years);

  /// No description provided for @inputNotOndernemerBefore.
  ///
  /// In en, this message translates to:
  /// **'I was not a business owner in one or more of the {years} previous years'**
  String inputNotOndernemerBefore(int years);

  /// No description provided for @inputNotOndernemerBeforeHelp.
  ///
  /// In en, this message translates to:
  /// **'Then this year counts as a starting year: the urencriterium does not require more time in the business than in a job (Wet IB 2001 art. 3.6 lid 1 b), and the startersaftrek bij arbeidsongeschiktheid can apply (art. 3.78a). Answer it again for every year.'**
  String get inputNotOndernemerBeforeHelp;

  /// No description provided for @inputStarter.
  ///
  /// In en, this message translates to:
  /// **'I had the zelfstandigenaftrek at most {max} times in those years'**
  String inputStarter(int max);

  /// No description provided for @inputStarterHelp.
  ///
  /// In en, this message translates to:
  /// **'Then you get the startersaftrek of {amount} on top of the zelfstandigenaftrek, if you meet the urencriterium (Wet IB 2001 art. 3.76 lid 3). It stops once you have had the zelfstandigenaftrek more often, so check it for every year.'**
  String inputStarterHelp(String amount);

  /// No description provided for @inputSoVerklaring.
  ///
  /// In en, this message translates to:
  /// **'I have an S&O-verklaring for this year'**
  String get inputSoVerklaring;

  /// No description provided for @inputSoVerklaringHelp.
  ///
  /// In en, this message translates to:
  /// **'An S&O-verklaring from RVO for research and development. With at least {hours} WBSO hours you get the S&O-aftrek.'**
  String inputSoVerklaringHelp(int hours);

  /// No description provided for @inputSoStarter.
  ///
  /// In en, this message translates to:
  /// **'Starter increase for the S&O-aftrek'**
  String get inputSoStarter;

  /// No description provided for @inputSoStarterHelp.
  ///
  /// In en, this message translates to:
  /// **'You were not a business owner in one or more of the {years} previous years and received an S&O-verklaring for at most {max} years in that period.'**
  String inputSoStarterHelp(int years, int max);

  /// No description provided for @inputBusinessCeased.
  ///
  /// In en, this message translates to:
  /// **'I stopped the whole business this year'**
  String get inputBusinessCeased;

  /// No description provided for @inputBusinessCeasedHelp.
  ///
  /// In en, this message translates to:
  /// **'Gains on selling or taking over the business assets are stakingswinst. You get the stakingsaftrek on them, and any herinvesteringsreserve is added to your profit.'**
  String get inputBusinessCeasedHelp;

  /// No description provided for @inputStakingsUsedBefore.
  ///
  /// In en, this message translates to:
  /// **'Stakingsaftrek used before'**
  String get inputStakingsUsedBefore;

  /// No description provided for @inputStakingsUsedBeforeHelp.
  ///
  /// In en, this message translates to:
  /// **'Stakingsaftrek you received in earlier years. It lowers the maximum of {max}.'**
  String inputStakingsUsedBeforeHelp(String max);

  /// No description provided for @inputDisabilityBenefit.
  ///
  /// In en, this message translates to:
  /// **'I receive a disability benefit'**
  String get inputDisabilityBenefit;

  /// No description provided for @inputDisabilityBenefitHelp.
  ///
  /// In en, this message translates to:
  /// **'A benefit such as WIA, WAO, WAZ or Wajong. As a starter with at least {reduced} but under {hours} hours you may get the startersaftrek bij arbeidsongeschiktheid.'**
  String inputDisabilityBenefitHelp(int reduced, int hours);

  /// No description provided for @inputDisabilityUsed.
  ///
  /// In en, this message translates to:
  /// **'Years used in the previous {years}'**
  String inputDisabilityUsed(int years);

  /// No description provided for @inputDisabilityUsedHelp.
  ///
  /// In en, this message translates to:
  /// **'How many of the previous {years} years you received the startersaftrek bij arbeidsongeschiktheid, from 0 to {max}.'**
  String inputDisabilityUsedHelp(int years, int max);

  /// No description provided for @inputWholeNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number from 0 to {max}'**
  String inputWholeNumber(int max);

  /// No description provided for @pensionAowFranchiseHelp.
  ///
  /// In en, this message translates to:
  /// **'The part of your income for which you already build up AOW. Jaarruimte is only calculated on income above it.'**
  String get pensionAowFranchiseHelp;

  /// No description provided for @pensionPensioengrondslagHelp.
  ///
  /// In en, this message translates to:
  /// **'Last year\'s income minus the AOW-franchise, up to the legal maximum.'**
  String get pensionPensioengrondslagHelp;

  /// No description provided for @pensionJaarruimteHelp.
  ///
  /// In en, this message translates to:
  /// **'{pct} of the premiegrondslag minus a multiple of factor A, up to the yearly maximum. What you may deduct for a lijfrente this year.'**
  String pensionJaarruimteHelp(String pct);

  /// No description provided for @pensionEstimatedTaxSavingHelp.
  ///
  /// In en, this message translates to:
  /// **'Estimated: the box 1 tax you save by deducting the premium, before heffingskortingen.'**
  String get pensionEstimatedTaxSavingHelp;

  /// No description provided for @plTaxAlgHeffingHelp.
  ///
  /// In en, this message translates to:
  /// **'A tax credit everyone gets. It decreases as income rises above a threshold.'**
  String get plTaxAlgHeffingHelp;

  /// No description provided for @plTaxArbeidskortingHelp.
  ///
  /// In en, this message translates to:
  /// **'A tax credit for working people, based on the profit before ondernemersaftrek and mkb-winstvrijstelling plus your wages.'**
  String get plTaxArbeidskortingHelp;

  /// No description provided for @plTaxAovHelp.
  ///
  /// In en, this message translates to:
  /// **'Premiums for private disability insurance are fully deductible from box 1 income.'**
  String get plTaxAovHelp;

  /// No description provided for @plTaxBelastbareWinstHelp.
  ///
  /// In en, this message translates to:
  /// **'Profit after ondernemersaftrek and mkb-winstvrijstelling. The Zvw contribution is based on it.'**
  String get plTaxBelastbareWinstHelp;

  /// No description provided for @plTaxWages.
  ///
  /// In en, this message translates to:
  /// **'Wages from employment'**
  String get plTaxWages;

  /// No description provided for @plTaxWagesHelp.
  ///
  /// In en, this message translates to:
  /// **'The loon you entered below. It is box 1 income like the profit, so it raises the rate on the profit and lowers the algemene heffingskorting.'**
  String get plTaxWagesHelp;

  /// No description provided for @plTaxBox1SectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Estimated income tax including national insurance premiums, in brackets, minus the heffingskortingen.'**
  String get plTaxBox1SectionHelp;

  /// No description provided for @plTaxCarPrivateUse.
  ///
  /// In en, this message translates to:
  /// **'Private use of business car'**
  String get plTaxCarPrivateUse;

  /// No description provided for @plTaxCarPrivateUseHelp.
  ///
  /// In en, this message translates to:
  /// **'The bijtelling: a percentage of the catalogue value added to profit for private use, at most the car costs. None with a trip log of {km} private km a year or less.'**
  String plTaxCarPrivateUseHelp(int km);

  /// No description provided for @plTaxDeductionsSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Deductions for business owners. Most require the urencriterium of {hours} hours.'**
  String plTaxDeductionsSectionHelp(int hours);

  /// No description provided for @plTaxDepreciationHelp.
  ///
  /// In en, this message translates to:
  /// **'The part of your assets\' cost written off this year, spread by day over their useful life.'**
  String get plTaxDepreciationHelp;

  /// No description provided for @plTaxDesinvestering.
  ///
  /// In en, this message translates to:
  /// **'Desinvesteringsbijtelling'**
  String get plTaxDesinvestering;

  /// No description provided for @plTaxDesinvesteringHelp.
  ///
  /// In en, this message translates to:
  /// **'Part of an investment deduction added back because an asset was sold within {years} years of the start of its purchase year.'**
  String plTaxDesinvesteringHelp(int years);

  /// No description provided for @plTaxDisabilityStarters.
  ///
  /// In en, this message translates to:
  /// **'Startersaftrek bij arbeidsongeschiktheid'**
  String get plTaxDisabilityStarters;

  /// No description provided for @plTaxDisabilityStartersHelp.
  ///
  /// In en, this message translates to:
  /// **'For starters with a disability benefit who work at least {hours} hours but do not meet the urencriterium. At most the profit.'**
  String plTaxDisabilityStartersHelp(int hours);

  /// No description provided for @plTaxDisposalResultHelp.
  ///
  /// In en, this message translates to:
  /// **'Sale price minus book value of assets sold this year. A gain adds to profit, a loss lowers it.'**
  String get plTaxDisposalResultHelp;

  /// No description provided for @plTaxEia.
  ///
  /// In en, this message translates to:
  /// **'Energie-investeringsaftrek (EIA)'**
  String get plTaxEia;

  /// No description provided for @plTaxEiaHelp.
  ///
  /// In en, this message translates to:
  /// **'An extra deduction for investments on the RVO Energy List.'**
  String get plTaxEiaHelp;

  /// No description provided for @plTaxFoodLimitedHelp.
  ///
  /// In en, this message translates to:
  /// **'Food, drinks, representation, congresses, seminars and study trips are deductible for {pct}, or above the first {drempel} (Wet IB 2001 art. 3.15). Florin uses whichever gives the larger deduction.'**
  String plTaxFoodLimitedHelp(String pct, String drempel);

  /// No description provided for @plTaxCourseTravelHelp.
  ///
  /// In en, this message translates to:
  /// **'Travel and stay for courses, studies and congresses are deductible up to {max} a year (Wet IB 2001 art. 3.16 lid 2 f). The limit does not apply when your work makes attending necessary (lid 8); Florin keeps it, because it cannot tell that from your records.'**
  String plTaxCourseTravelHelp(String max);

  /// No description provided for @plTaxBarredCosts.
  ///
  /// In en, this message translates to:
  /// **'Not deductible ({amount})'**
  String plTaxBarredCosts(String amount);

  /// No description provided for @plTaxBarredCostsHelp.
  ///
  /// In en, this message translates to:
  /// **'Fines (Wet IB 2001 art. 3.14), clothing other than werkkleding, personal care, a phone line at home and literature other than professional literature (art. 3.16 lid 2). The law keeps these costs out of the profit, so they lower it by nothing.'**
  String get plTaxBarredCostsHelp;

  /// No description provided for @plTaxInputsSection.
  ///
  /// In en, this message translates to:
  /// **'Your situation in {year}'**
  String plTaxInputsSection(int year);

  /// No description provided for @plTaxInputsSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Facts the bookkeeping cannot show. They change the estimate above.'**
  String get plTaxInputsSectionHelp;

  /// No description provided for @plTaxEmploymentSection.
  ///
  /// In en, this message translates to:
  /// **'Employment in {year}'**
  String plTaxEmploymentSection(int year);

  /// No description provided for @plTaxEmploymentSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'If you also work as an employee. Enter the totals of all your jaaropgaven for the year. During the year, enter what you expect for the whole year.'**
  String get plTaxEmploymentSectionHelp;

  /// No description provided for @plTaxInvestmentSection.
  ///
  /// In en, this message translates to:
  /// **'Investment deductions'**
  String get plTaxInvestmentSection;

  /// No description provided for @plTaxInvestmentSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Extra deductions for assets bought this year.'**
  String get plTaxInvestmentSectionHelp;

  /// No description provided for @plTaxKiaHelp.
  ///
  /// In en, this message translates to:
  /// **'Kleinschaligheidsinvesteringsaftrek: a percentage or fixed amount based on your total qualifying investments this year.'**
  String get plTaxKiaHelp;

  /// No description provided for @plTaxLijrenteHelp.
  ///
  /// In en, this message translates to:
  /// **'Premiums for a lijfrente, deducted up to your jaarruimte and reserveringsruimte.'**
  String get plTaxLijrenteHelp;

  /// No description provided for @plTaxLossOffset.
  ///
  /// In en, this message translates to:
  /// **'Losses from earlier years'**
  String get plTaxLossOffset;

  /// No description provided for @plTaxLossOffsetHelp.
  ///
  /// In en, this message translates to:
  /// **'Box 1 losses from earlier years, offset against this year\'s income.'**
  String get plTaxLossOffsetHelp;

  /// No description provided for @plTaxMeewerk.
  ///
  /// In en, this message translates to:
  /// **'Meewerkaftrek'**
  String get plTaxMeewerk;

  /// No description provided for @plTaxMeewerkHelp.
  ///
  /// In en, this message translates to:
  /// **'A percentage of profit when your fiscal partner works at least {hours} hours in the business without pay.'**
  String plTaxMeewerkHelp(int hours);

  /// No description provided for @plTaxMia.
  ///
  /// In en, this message translates to:
  /// **'Milieu-investeringsaftrek (MIA)'**
  String get plTaxMia;

  /// No description provided for @plTaxMiaHelp.
  ///
  /// In en, this message translates to:
  /// **'An extra deduction for investments on the RVO Environmental List.'**
  String get plTaxMiaHelp;

  /// No description provided for @plTaxMileageAllowanceHelp.
  ///
  /// In en, this message translates to:
  /// **'Business and commuting kilometres in a private vehicle, at the Belastingdienst rate per km.'**
  String get plTaxMileageAllowanceHelp;

  /// No description provided for @plTaxMkbHelp.
  ///
  /// In en, this message translates to:
  /// **'A percentage of profit after ondernemersaftrek that is exempt from tax. No urencriterium needed.'**
  String get plTaxMkbHelp;

  /// No description provided for @plTaxProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get plTaxProfit;

  /// No description provided for @plTaxProfitHelp.
  ///
  /// In en, this message translates to:
  /// **'Profit from business before ondernemersaftrek. The arbeidskorting is based on it, together with any wages.'**
  String get plTaxProfitHelp;

  /// No description provided for @plTaxReserveReleased.
  ///
  /// In en, this message translates to:
  /// **'Herinvesteringsreserve released'**
  String get plTaxReserveReleased;

  /// No description provided for @plTaxReserveReleasedHelp.
  ///
  /// In en, this message translates to:
  /// **'Reserve not used within {years} years, or left when the business stops, is added to profit.'**
  String plTaxReserveReleasedHelp(int years);

  /// No description provided for @plTaxSo.
  ///
  /// In en, this message translates to:
  /// **'S&O-aftrek'**
  String get plTaxSo;

  /// No description provided for @plTaxSoHelp.
  ///
  /// In en, this message translates to:
  /// **'For research and development with an S&O-verklaring and at least {hours} hours.'**
  String plTaxSoHelp(int hours);

  /// No description provided for @plTaxStakings.
  ///
  /// In en, this message translates to:
  /// **'Stakingsaftrek'**
  String get plTaxStakings;

  /// No description provided for @plTaxStakingsHelp.
  ///
  /// In en, this message translates to:
  /// **'A deduction on the gain when the whole business stops, up to {max} over your lifetime.'**
  String plTaxStakingsHelp(String max);

  /// No description provided for @plTaxStartersaftrekHelp.
  ///
  /// In en, this message translates to:
  /// **'An extra deduction on top of the zelfstandigenaftrek for business owners who recently started.'**
  String get plTaxStartersaftrekHelp;

  /// No description provided for @plTaxTaxableProfitHelp.
  ///
  /// In en, this message translates to:
  /// **'The income in box 1 the tax is calculated on: belastbare winst plus wages, minus the deductions above.'**
  String get plTaxTaxableProfitHelp;

  /// No description provided for @plTaxUnrealisedZelfs.
  ///
  /// In en, this message translates to:
  /// **'Unused zelfstandigenaftrek from earlier years'**
  String get plTaxUnrealisedZelfs;

  /// No description provided for @plTaxUnrealisedZelfsHelp.
  ///
  /// In en, this message translates to:
  /// **'Zelfstandigenaftrek from earlier years that did not fit the profit then, used up to this year\'s profit.'**
  String get plTaxUnrealisedZelfsHelp;

  /// No description provided for @plTaxZelfstandigenaftrekHelp.
  ///
  /// In en, this message translates to:
  /// **'A fixed deduction for business owners who meet the urencriterium. At most the profit, unless you are a starter.'**
  String get plTaxZelfstandigenaftrekHelp;

  /// No description provided for @plTaxZvwHelp.
  ///
  /// In en, this message translates to:
  /// **'The income-related contribution to the health care insurance act, on belastbare winst up to a maximum. The loon Zvw your employer paid the werkgeversheffing on lowers that maximum.'**
  String get plTaxZvwHelp;

  /// No description provided for @vatReturnIcpSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Supplies to businesses in other EU countries, reported separately in the ICP report. While you take part in the KOR you file no ICP report, so invoices from those dates are not listed.'**
  String get vatReturnIcpSectionHelp;

  /// No description provided for @vatRow1aHelp.
  ///
  /// In en, this message translates to:
  /// **'Revenue taxed at {rate} and the VAT on it.'**
  String vatRow1aHelp(String rate);

  /// No description provided for @vatRow1bHelp.
  ///
  /// In en, this message translates to:
  /// **'Revenue taxed at {rate} and the VAT on it.'**
  String vatRow1bHelp(String rate);

  /// No description provided for @vatRow1d.
  ///
  /// In en, this message translates to:
  /// **'1d  Private use'**
  String get vatRow1d;

  /// No description provided for @vatRow1dHelp.
  ///
  /// In en, this message translates to:
  /// **'VAT on private use of business cars: {rate} or {reduced} of the catalogue value, or the actual private share with a trip log. In the last return of the year only.'**
  String vatRow1dHelp(String rate, String reduced);

  /// No description provided for @vatRow1eHelp.
  ///
  /// In en, this message translates to:
  /// **'Revenue at 0% or where the VAT is reverse-charged to a Dutch business.'**
  String get vatRow1eHelp;

  /// No description provided for @vatRow3aHelp.
  ///
  /// In en, this message translates to:
  /// **'Exports of goods to countries outside the EU. Services to businesses outside the EU are not reported.'**
  String get vatRow3aHelp;

  /// No description provided for @vatRow3bHelp.
  ///
  /// In en, this message translates to:
  /// **'Goods and services to businesses in other EU countries.'**
  String get vatRow3bHelp;

  /// No description provided for @vatRow5aHelp.
  ///
  /// In en, this message translates to:
  /// **'The VAT you owe on your revenue and private use.'**
  String get vatRow5aHelp;

  /// No description provided for @vatRow5bHelp.
  ///
  /// In en, this message translates to:
  /// **'The VAT on business costs you may deduct.'**
  String get vatRow5bHelp;

  /// No description provided for @clientsSearchHelp.
  ///
  /// In en, this message translates to:
  /// **'Search clients by name.'**
  String get clientsSearchHelp;

  /// No description provided for @invoicesSearchHelp.
  ///
  /// In en, this message translates to:
  /// **'Search by invoice number or client name.'**
  String get invoicesSearchHelp;

  /// No description provided for @expensesFieldPurchaseVat.
  ///
  /// In en, this message translates to:
  /// **'VAT on this purchase'**
  String get expensesFieldPurchaseVat;

  /// No description provided for @expensesFieldPurchaseVatHelp.
  ///
  /// In en, this message translates to:
  /// **'Dutch VAT when the supplier charged it. Shifted when the invoice says the VAT is reverse-charged to you, or the supplier is abroad: you then report and deduct the VAT yourself.'**
  String get expensesFieldPurchaseVatHelp;

  /// No description provided for @purchaseVatDomestic.
  ///
  /// In en, this message translates to:
  /// **'Charged by the supplier'**
  String get purchaseVatDomestic;

  /// No description provided for @purchaseVatReverseChargeNl.
  ///
  /// In en, this message translates to:
  /// **'Shifted to me by a Dutch supplier (2a)'**
  String get purchaseVatReverseChargeNl;

  /// No description provided for @purchaseVatFromEu.
  ///
  /// In en, this message translates to:
  /// **'From a supplier in another EU country (4b)'**
  String get purchaseVatFromEu;

  /// No description provided for @purchaseVatFromOutsideEu.
  ///
  /// In en, this message translates to:
  /// **'Service from a supplier outside the EU (4a)'**
  String get purchaseVatFromOutsideEu;

  /// No description provided for @vatReturnShiftedSection.
  ///
  /// In en, this message translates to:
  /// **'VAT shifted to you'**
  String get vatReturnShiftedSection;

  /// No description provided for @vatReturnShiftedSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Purchases where you report the VAT yourself. You deduct the same VAT in 5b, so on balance you usually pay nothing.'**
  String get vatReturnShiftedSectionHelp;

  /// No description provided for @vatRow2a.
  ///
  /// In en, this message translates to:
  /// **'2a  Domestic reverse charge'**
  String get vatRow2a;

  /// No description provided for @vatRow2aHelp.
  ///
  /// In en, this message translates to:
  /// **'Purchases from Dutch suppliers who shifted the VAT to you.'**
  String get vatRow2aHelp;

  /// No description provided for @vatRow4a.
  ///
  /// In en, this message translates to:
  /// **'4a  From countries outside the EU'**
  String get vatRow4a;

  /// No description provided for @vatRow4aHelp.
  ///
  /// In en, this message translates to:
  /// **'Services from suppliers outside the EU.'**
  String get vatRow4aHelp;

  /// No description provided for @vatRow4b.
  ///
  /// In en, this message translates to:
  /// **'4b  From EU countries'**
  String get vatRow4b;

  /// No description provided for @vatRow4bHelp.
  ///
  /// In en, this message translates to:
  /// **'Goods and services from suppliers in other EU countries.'**
  String get vatRow4bHelp;

  /// No description provided for @vatBaseAndVat.
  ///
  /// In en, this message translates to:
  /// **'{base}, VAT {vat}'**
  String vatBaseAndVat(String base, String vat);

  /// No description provided for @expensesBusinessUseHelp.
  ///
  /// In en, this message translates to:
  /// **'The share used for the business. Only that share of the cost and VAT is deductible.'**
  String get expensesBusinessUseHelp;

  /// No description provided for @settingsLanguageSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'The language of the app. Invoices and CSV exports are always in Dutch.'**
  String get settingsLanguageSectionHelp;

  /// No description provided for @vatTreatmentServicesOutsideEu.
  ///
  /// In en, this message translates to:
  /// **'Services to a business outside the EU (not in the VAT return)'**
  String get vatTreatmentServicesOutsideEu;

  /// No description provided for @invoiceValidateTreatmentCountry.
  ///
  /// In en, this message translates to:
  /// **'This VAT treatment does not fit the client\'s country. Domestic reverse charge is for Dutch clients, the EU treatments for other EU countries and the treatments outside the EU for countries outside it.'**
  String get invoiceValidateTreatmentCountry;

  /// No description provided for @invoiceSelfBilled.
  ///
  /// In en, this message translates to:
  /// **'Issued by the customer (self-billing)'**
  String get invoiceSelfBilled;

  /// No description provided for @invoiceSelfBilledHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick this when the customer, such as a reseller, makes the invoice for what it owes you. The law allows this when you agreed on it beforehand and you accept each invoice. Florin records it with the customer\'s number and makes no PDF: the customer\'s document is the invoice.'**
  String get invoiceSelfBilledHelp;

  /// No description provided for @invoiceFieldNumberSelfBilledHelp.
  ///
  /// In en, this message translates to:
  /// **'The number on the invoice the customer issued to you.'**
  String get invoiceFieldNumberSelfBilledHelp;

  /// No description provided for @invoiceActionRecord.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get invoiceActionRecord;

  /// No description provided for @invoiceRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Record invoice'**
  String get invoiceRecordTitle;

  /// No description provided for @invoiceRecordMessage.
  ///
  /// In en, this message translates to:
  /// **'After recording, the invoice can no longer be changed or deleted. A correction is a credit note that names this invoice.'**
  String get invoiceRecordMessage;

  /// No description provided for @invoiceStatusSelfBilled.
  ///
  /// In en, this message translates to:
  /// **'Issued by customer'**
  String get invoiceStatusSelfBilled;

  /// No description provided for @invoiceMerchantOfRecordNotice.
  ///
  /// In en, this message translates to:
  /// **'{name} is a merchant of record: it sells your product to end customers and pays you. Invoice it for what it owes you for those sales. One invoice may cover several sales over at most one calendar month. Florin records amounts in euros: for a payout in another currency, enter the euro amounts and keep the reseller\'s statement.'**
  String invoiceMerchantOfRecordNotice(String name);

  /// No description provided for @invoicePaidDateTitle.
  ///
  /// In en, this message translates to:
  /// **'Date paid'**
  String get invoicePaidDateTitle;

  /// No description provided for @clientsMerchantOfRecord.
  ///
  /// In en, this message translates to:
  /// **'Merchant of record (reseller)'**
  String get clientsMerchantOfRecord;

  /// No description provided for @clientsMerchantOfRecordHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick this for a platform that sells your product to end customers in its own name and pays you, such as a merchant of record or an app store. It is the seller towards the end customers, so you invoice only the platform. The Wet DBA section is about working relationships and is hidden for a reseller.'**
  String get clientsMerchantOfRecordHelp;

  /// No description provided for @clientsBadgeMerchantOfRecord.
  ///
  /// In en, this message translates to:
  /// **'Merchant of record'**
  String get clientsBadgeMerchantOfRecord;

  /// No description provided for @vatRowOutsideReturn.
  ///
  /// In en, this message translates to:
  /// **'Services to businesses outside the EU (not in the return)'**
  String get vatRowOutsideReturn;

  /// No description provided for @vatRowOutsideReturnHelp.
  ///
  /// In en, this message translates to:
  /// **'Revenue from services to businesses outside the EU. The Belastingdienst says these are not reported in the Dutch return when the service is taxed outside the EU. Shown so you can see where that revenue went.'**
  String get vatRowOutsideReturnHelp;

  /// No description provided for @vatShortReverseCharge.
  ///
  /// In en, this message translates to:
  /// **'Reverse-charged'**
  String get vatShortReverseCharge;

  /// No description provided for @vatShortNotTaxedNl.
  ///
  /// In en, this message translates to:
  /// **'Not taxed in NL'**
  String get vatShortNotTaxedNl;

  /// No description provided for @invoiceValidateNumberSelfBilled.
  ///
  /// In en, this message translates to:
  /// **'Enter the number on the invoice the customer issued, so it can be traced to that invoice.'**
  String get invoiceValidateNumberSelfBilled;

  /// No description provided for @amountInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount in euros, such as 1.234,50, with a comma before the cents and at most two decimals.'**
  String get amountInvalidError;

  /// No description provided for @amountRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount above zero: a record without an amount has no effect on your figures.'**
  String get amountRequiredError;

  /// No description provided for @clientsValidateVatCountry.
  ///
  /// In en, this message translates to:
  /// **'A VAT number of a client in this country starts with {prefix}. Check the number or the country: the ICP report lists them together.'**
  String clientsValidateVatCountry(String prefix);

  /// No description provided for @hoursValidateDayTotal.
  ///
  /// In en, this message translates to:
  /// **'This day already has {logged} hours logged. A day has 24 hours, so enter at most {left}.'**
  String hoursValidateDayTotal(String logged, String left);

  /// No description provided for @assetsValidateDisposalBeforePurchase.
  ///
  /// In en, this message translates to:
  /// **'The sale date is before the purchase date. Change one of them: an asset is sold after it was bought.'**
  String get assetsValidateDisposalBeforePurchase;

  /// No description provided for @invoiceValidateCreditDate.
  ///
  /// In en, this message translates to:
  /// **'A credit note is dated on or after the invoice it corrects, which is dated {date}.'**
  String invoiceValidateCreditDate(String date);

  /// No description provided for @invoiceValidateCreditAboveInvoice.
  ///
  /// In en, this message translates to:
  /// **'This credit note is more than is left to correct on invoice {number}: at most {amount} excluding VAT. A credit note can only reverse what was invoiced.'**
  String invoiceValidateCreditAboveInvoice(String number, String amount);

  /// No description provided for @vatTreatmentKor.
  ///
  /// In en, this message translates to:
  /// **'Exempt under the KOR (no VAT on the invoice)'**
  String get vatTreatmentKor;

  /// No description provided for @vatShortKor.
  ///
  /// In en, this message translates to:
  /// **'KOR exempt'**
  String get vatShortKor;

  /// No description provided for @vatRowKorExempt.
  ///
  /// In en, this message translates to:
  /// **'Exempt under the KOR (not in the return)'**
  String get vatRowKorExempt;

  /// No description provided for @vatRowKorExemptHelp.
  ///
  /// In en, this message translates to:
  /// **'Revenue exempt under the kleineondernemersregeling. You charged no VAT on it and it is not reported in a return.'**
  String get vatRowKorExemptHelp;

  /// No description provided for @invoiceValidateKorNotActive.
  ///
  /// In en, this message translates to:
  /// **'The KOR does not apply on this date: you do not take part, or your turnover passed the limit. Choose the treatment that fits, usually Dutch VAT.'**
  String get invoiceValidateKorNotActive;

  /// No description provided for @invoiceValidateKorTreatment.
  ///
  /// In en, this message translates to:
  /// **'You take part in the KOR on this date: you charge no VAT and the invoice may not mention it. Choose Exempt under the KOR.'**
  String get invoiceValidateKorTreatment;

  /// No description provided for @invoiceValidateKorExceeded.
  ///
  /// In en, this message translates to:
  /// **'This invoice takes your turnover for the KOR past {limit}. The KOR ends with this supply, so it carries VAT: choose Dutch VAT, and deregister from the KOR in Mijn Belastingdienst Zakelijk.'**
  String invoiceValidateKorExceeded(String limit);

  /// No description provided for @expensesValidateKorReclaim.
  ///
  /// In en, this message translates to:
  /// **'You take part in the KOR on this date, so you cannot reclaim VAT on purchases. Untick Reclaim VAT: the VAT then counts as part of the cost.'**
  String get expensesValidateKorReclaim;

  /// No description provided for @expensesKorNotice.
  ///
  /// In en, this message translates to:
  /// **'You take part in the KOR on this date. VAT on purchases is not reclaimed; it counts as part of the cost for income tax.'**
  String get expensesKorNotice;

  /// No description provided for @settingsKorStart.
  ///
  /// In en, this message translates to:
  /// **'KOR applies from'**
  String get settingsKorStart;

  /// No description provided for @settingsKorStartHelp.
  ///
  /// In en, this message translates to:
  /// **'The first day the kleineondernemersregeling (KOR) applies to you, as in the Belastingdienst\'s confirmation. Until that date you file every return as usual. Under the KOR you charge no VAT, file no regular VAT return and reclaim no VAT, while your turnover in the Netherlands stays at most {limit} a year. Leave empty when you do not take part.'**
  String settingsKorStartHelp(String limit);

  /// No description provided for @settingsKorEnd.
  ///
  /// In en, this message translates to:
  /// **'KOR ended on'**
  String get settingsKorEnd;

  /// No description provided for @settingsKorEndHelp.
  ///
  /// In en, this message translates to:
  /// **'The first day the KOR no longer applies after you deregistered yourself. Leave empty otherwise: when your turnover passes the limit, Florin ends the KOR from that invoice on.'**
  String get settingsKorEndHelp;

  /// No description provided for @settingsValidateKorStart.
  ///
  /// In en, this message translates to:
  /// **'The KOR starts on the first day of a return period, so enter a 1st of the month, as in the Belastingdienst\'s confirmation.'**
  String get settingsValidateKorStart;

  /// No description provided for @settingsValidateKorEndDay.
  ///
  /// In en, this message translates to:
  /// **'A deregistration takes effect on the first day of a return period, so enter a 1st of the month.'**
  String get settingsValidateKorEndDay;

  /// No description provided for @settingsValidateKorEndBeforeStart.
  ///
  /// In en, this message translates to:
  /// **'The end of the KOR comes after its start. Check both dates.'**
  String get settingsValidateKorEndBeforeStart;

  /// No description provided for @settingsKorClear.
  ///
  /// In en, this message translates to:
  /// **'I do not take part in the KOR'**
  String get settingsKorClear;

  /// No description provided for @korProgress.
  ///
  /// In en, this message translates to:
  /// **'{turnover} of {limit}'**
  String korProgress(String turnover, String limit);

  /// No description provided for @korExceededBadge.
  ///
  /// In en, this message translates to:
  /// **'Limit passed on {date}'**
  String korExceededBadge(String date);

  /// No description provided for @korLeftBadge.
  ///
  /// In en, this message translates to:
  /// **'{left} below the limit'**
  String korLeftBadge(String left);

  /// No description provided for @dashboardKor.
  ///
  /// In en, this message translates to:
  /// **'KOR turnover'**
  String get dashboardKor;

  /// No description provided for @dashboardKorHelp.
  ///
  /// In en, this message translates to:
  /// **'Your turnover that counts for the kleineondernemersregeling: supplies taxed in the Netherlands, including 0% and domestic reverse charge, not services taxed abroad. Above {limit} in a calendar year the KOR ends with the supply that passes the limit, for the rest of that year and the next. The KOR is not automatic: it applies only after you register and the Belastingdienst confirms the start date. Until then you file a return every quarter, however low your turnover.'**
  String dashboardKorHelp(String limit);

  /// No description provided for @deadlineStatusKor.
  ///
  /// In en, this message translates to:
  /// **'no return (KOR)'**
  String get deadlineStatusKor;

  /// No description provided for @deadlineStatusIncidental.
  ///
  /// In en, this message translates to:
  /// **'incidental return'**
  String get deadlineStatusIncidental;

  /// No description provided for @deadlineBadgeKor.
  ///
  /// In en, this message translates to:
  /// **'No return: KOR'**
  String get deadlineBadgeKor;

  /// No description provided for @deadlineBadgeIncidental.
  ///
  /// In en, this message translates to:
  /// **'Incidental return due'**
  String get deadlineBadgeIncidental;

  /// No description provided for @vatReturnKorNotice.
  ///
  /// In en, this message translates to:
  /// **'You take part in the KOR for this whole quarter and owe no VAT in it, so no return is due. If the Belastingdienst sends you one anyway, file it.'**
  String get vatReturnKorNotice;

  /// No description provided for @vatReturnKorPartNotice.
  ///
  /// In en, this message translates to:
  /// **'The KOR applies for part of this quarter. Invoices exempt under the KOR are not in the return and VAT on purchases in that part is not reclaimed. File a return for the part outside the KOR.'**
  String get vatReturnKorPartNotice;

  /// No description provided for @vatReturnKorIncidentalNotice.
  ///
  /// In en, this message translates to:
  /// **'You take part in the KOR for this whole quarter, but you owe VAT in it, such as VAT shifted to you (2a, 4a or 4b), which you cannot deduct. So you file a return for this quarter. The Belastingdienst does not send it: ask your belastingkantoor for it in writing once the quarter is over. Florin shows the usual deadline as the date to aim for.'**
  String get vatReturnKorIncidentalNotice;

  /// No description provided for @vatReturnNilNotice.
  ///
  /// In en, this message translates to:
  /// **'Nothing to report this quarter. You still file a return by the deadline: a nil return (0-aangifte). Without it the Belastingdienst sends an additional assessment and a fine.'**
  String get vatReturnNilNotice;

  /// No description provided for @vatReturnKorExceeded.
  ///
  /// In en, this message translates to:
  /// **'Your turnover for the KOR passed {limit} on {date}. The KOR ended with that supply: from then on you charge VAT and file returns. Deregister in Mijn Belastingdienst Zakelijk; you cannot take part again this year or next year.'**
  String vatReturnKorExceeded(String date, String limit);

  /// No description provided for @errorDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Another record already uses this value, such as the same invoice number. Use a value that is not taken yet.'**
  String get errorDuplicate;

  /// No description provided for @errorInUse.
  ///
  /// In en, this message translates to:
  /// **'Other records refer to this one, such as invoices of a client. Remove or change those first, or mark this one inactive.'**
  String get errorInUse;

  /// No description provided for @errorBusy.
  ///
  /// In en, this message translates to:
  /// **'The database is in use by another program. Close that program, or wait a moment, and try again.'**
  String get errorBusy;

  /// No description provided for @errorReadOnly.
  ///
  /// In en, this message translates to:
  /// **'The database file cannot be written. Check that the folder is not read-only and that you have permission to change it.'**
  String get errorReadOnly;

  /// No description provided for @errorCorrupt.
  ///
  /// In en, this message translates to:
  /// **'The database file is damaged and cannot be read. Restore it from a backup, such as your iCloud Drive, OneDrive or Dropbox history.'**
  String get errorCorrupt;

  /// No description provided for @errorDiskFull.
  ///
  /// In en, this message translates to:
  /// **'The disk is full. Free up space and try again.'**
  String get errorDiskFull;

  /// No description provided for @errorCannotOpen.
  ///
  /// In en, this message translates to:
  /// **'The database file cannot be opened. Check that its folder still exists, or choose its location again in Settings.'**
  String get errorCannotOpen;

  /// No description provided for @errorFile.
  ///
  /// In en, this message translates to:
  /// **'Could not use {path}: {reason}'**
  String errorFile(String path, String reason);

  /// No description provided for @genericUnhandledError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong: {error}'**
  String genericUnhandledError(String error);

  /// No description provided for @invoiceNoProfile.
  ///
  /// In en, this message translates to:
  /// **'Fill in your business details in Settings first: every invoice shows them.'**
  String get invoiceNoProfile;

  /// No description provided for @invoiceTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get invoiceTotal;

  /// No description provided for @settingsTaxKor.
  ///
  /// In en, this message translates to:
  /// **'KOR turnover limit'**
  String get settingsTaxKor;

  /// No description provided for @settingsKorSection.
  ///
  /// In en, this message translates to:
  /// **'Kleineondernemersregeling (KOR)'**
  String get settingsKorSection;

  /// No description provided for @settingsKorSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'A VAT exemption for businesses with at most {limit} turnover in the Netherlands a year. It is not automatic: you register for it and deregister with the Belastingdienst, and without it you file a return every quarter. Enter its dates here so Florin follows it.'**
  String settingsKorSectionHelp(String limit);

  /// No description provided for @receiptTypeEInvoice.
  ///
  /// In en, this message translates to:
  /// **'E-invoice (UBL)'**
  String get receiptTypeEInvoice;

  /// No description provided for @receiptsTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipts'**
  String get receiptsTitle;

  /// No description provided for @receiptsHelp.
  ///
  /// In en, this message translates to:
  /// **'The receipt or invoice for this expense, as a PDF, photo or scan. Florin copies it into the receipts folder next to your database and leaves your file as it is. The Belastingdienst asks you to keep receipts and invoices for {years} years in the form you received them; a scan or photo must be a correct and complete copy of the original, with its marks of authenticity.'**
  String receiptsHelp(int years);

  /// No description provided for @receiptsAssetTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase invoice and receipts'**
  String get receiptsAssetTitle;

  /// No description provided for @receiptsAssetHelp.
  ///
  /// In en, this message translates to:
  /// **'The purchase invoice of this asset and any other proof, as a PDF, photo or scan. It belongs in your records while the asset is in use, and {years} years after that.'**
  String receiptsAssetHelp(int years);

  /// No description provided for @receiptsInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get receiptsInvoiceTitle;

  /// No description provided for @receiptsInvoiceHelp.
  ///
  /// In en, this message translates to:
  /// **'The PDF of this invoice exactly as Florin made it when you issued it, kept as sent. For an invoice your customer issued, add their document here.'**
  String get receiptsInvoiceHelp;

  /// No description provided for @receiptsNone.
  ///
  /// In en, this message translates to:
  /// **'No files yet. Drop PDFs, photos or scans here, or add them.'**
  String get receiptsNone;

  /// No description provided for @receiptsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add files'**
  String get receiptsAdd;

  /// No description provided for @receiptsPickDialog.
  ///
  /// In en, this message translates to:
  /// **'Choose receipts'**
  String get receiptsPickDialog;

  /// No description provided for @receiptsOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get receiptsOpen;

  /// No description provided for @receiptsRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from this record'**
  String get receiptsRemove;

  /// No description provided for @receiptsUnstage.
  ///
  /// In en, this message translates to:
  /// **'Do not add'**
  String get receiptsUnstage;

  /// No description provided for @receiptsRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed. Florin keeps the file under Removed receipts in Settings.'**
  String get receiptsRemoved;

  /// No description provided for @receiptsUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get receiptsUndo;

  /// No description provided for @receiptsStaged.
  ///
  /// In en, this message translates to:
  /// **'Stored when you save'**
  String get receiptsStaged;

  /// No description provided for @receiptsAdded.
  ///
  /// In en, this message translates to:
  /// **'added {date}'**
  String receiptsAdded(String date);

  /// No description provided for @receiptsMissing.
  ///
  /// In en, this message translates to:
  /// **'The file is missing from the receipts folder. Restore it from a backup.'**
  String get receiptsMissing;

  /// No description provided for @receiptsKeepUntil.
  ///
  /// In en, this message translates to:
  /// **'Keep until'**
  String get receiptsKeepUntil;

  /// No description provided for @receiptsKeepUntilHelp.
  ///
  /// In en, this message translates to:
  /// **'The Belastingdienst asks you to keep invoices and receipts for {years} years. Florin counts them from the end of the year they belong to and never deletes them.'**
  String receiptsKeepUntilHelp(int years);

  /// No description provided for @receiptsKeepWhileInUse.
  ///
  /// In en, this message translates to:
  /// **'While in use, then {years} years'**
  String receiptsKeepWhileInUse(int years);

  /// No description provided for @receiptsRejectedEmpty.
  ///
  /// In en, this message translates to:
  /// **'{name} is empty. Choose the file again.'**
  String receiptsRejectedEmpty(String name);

  /// No description provided for @receiptsRejectedTooLarge.
  ///
  /// In en, this message translates to:
  /// **'{name} is larger than {max}. Save the scan at a lower resolution, keeping every page readable, and add it again.'**
  String receiptsRejectedTooLarge(String name, String max);

  /// No description provided for @receiptsRejectedType.
  ///
  /// In en, this message translates to:
  /// **'{name} is not a PDF, JPEG, PNG, HEIC, TIFF or UBL e-invoice. Save or print it as PDF and add it again.'**
  String receiptsRejectedType(String name);

  /// No description provided for @receiptsDuplicate.
  ///
  /// In en, this message translates to:
  /// **'{name} is already stored with another record. It was added here too.'**
  String receiptsDuplicate(String name);

  /// No description provided for @receiptsOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open {name}. Open it from the receipts folder instead.'**
  String receiptsOpenFailed(String name);

  /// No description provided for @expensesPaperOriginalKept.
  ///
  /// In en, this message translates to:
  /// **'Paper original kept'**
  String get expensesPaperOriginalKept;

  /// No description provided for @expensesPaperOriginalKeptHelp.
  ///
  /// In en, this message translates to:
  /// **'Tick when you keep the paper receipt or invoice yourself, for example a till receipt you have not scanned. You need proof to reclaim VAT and to show the cost; a file added above counts too.'**
  String get expensesPaperOriginalKeptHelp;

  /// No description provided for @expensesHasFiles.
  ///
  /// In en, this message translates to:
  /// **'Receipt stored in Florin'**
  String get expensesHasFiles;

  /// No description provided for @expensesPaperOnly.
  ///
  /// In en, this message translates to:
  /// **'Paper original kept'**
  String get expensesPaperOnly;

  /// No description provided for @receiptsNotStored.
  ///
  /// In en, this message translates to:
  /// **'No PDF is stored for this invoice. Florin stores it the first time you export it.'**
  String get receiptsNotStored;

  /// No description provided for @settingsReceiptsSection.
  ///
  /// In en, this message translates to:
  /// **'Receipts'**
  String get settingsReceiptsSection;

  /// No description provided for @settingsReceiptsSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Florin keeps the receipt files of expenses and assets, and the PDFs of issued invoices, in a receipts folder next to the database. It never deletes them: a removed receipt stays under Removed receipts. The folder moves with the database and belongs in the same backup.'**
  String get settingsReceiptsSectionHelp;

  /// No description provided for @settingsReceiptsLocation.
  ///
  /// In en, this message translates to:
  /// **'Folder: {path}'**
  String settingsReceiptsLocation(String path);

  /// No description provided for @settingsReceiptsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 file} other{{count} files}}, {size}'**
  String settingsReceiptsCount(int count, String size);

  /// No description provided for @settingsReceiptsShowFolder.
  ///
  /// In en, this message translates to:
  /// **'Show folder'**
  String get settingsReceiptsShowFolder;

  /// No description provided for @settingsReceiptsCheck.
  ///
  /// In en, this message translates to:
  /// **'Check files'**
  String get settingsReceiptsCheck;

  /// No description provided for @settingsReceiptsChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking'**
  String get settingsReceiptsChecking;

  /// No description provided for @settingsReceiptsAllOk.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No files to check.} =1{The file is present and unchanged.} other{All {count} files are present and unchanged.}}'**
  String settingsReceiptsAllOk(int count);

  /// No description provided for @settingsReceiptsProblems.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 file needs attention. Restore it from a backup:} other{{count} files need attention. Restore them from a backup:}}'**
  String settingsReceiptsProblems(int count);

  /// No description provided for @settingsReceiptMissing.
  ///
  /// In en, this message translates to:
  /// **'missing'**
  String get settingsReceiptMissing;

  /// No description provided for @settingsReceiptChanged.
  ///
  /// In en, this message translates to:
  /// **'changed since it was added'**
  String get settingsReceiptChanged;

  /// No description provided for @settingsReceiptsOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'The folder could not be opened'**
  String get settingsReceiptsOpenFailed;

  /// No description provided for @receiptOwnerExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get receiptOwnerExpense;

  /// No description provided for @receiptOwnerAsset.
  ///
  /// In en, this message translates to:
  /// **'Asset'**
  String get receiptOwnerAsset;

  /// No description provided for @receiptOwnerInvoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get receiptOwnerInvoice;

  /// No description provided for @removedReceiptsTitle.
  ///
  /// In en, this message translates to:
  /// **'Removed receipts'**
  String get removedReceiptsTitle;

  /// No description provided for @removedReceiptsNotice.
  ///
  /// In en, this message translates to:
  /// **'Receipts you removed from a record, or whose record was deleted. Florin never deletes a receipt: the files stay in {path}. Put one back while its record exists.'**
  String removedReceiptsNotice(String path);

  /// No description provided for @removedReceiptsNone.
  ///
  /// In en, this message translates to:
  /// **'No removed receipts.'**
  String get removedReceiptsNone;

  /// No description provided for @removedReceiptsFrom.
  ///
  /// In en, this message translates to:
  /// **'from {kind} {date} {name}, removed {removed}'**
  String removedReceiptsFrom(
    String kind,
    String date,
    String name,
    String removed,
  );

  /// No description provided for @removedReceiptsPutBack.
  ///
  /// In en, this message translates to:
  /// **'Put back on its record'**
  String get removedReceiptsPutBack;

  /// No description provided for @settingsRemovedReceipts.
  ///
  /// In en, this message translates to:
  /// **'Removed receipts ({count})'**
  String settingsRemovedReceipts(int count);
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
