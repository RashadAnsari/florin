// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Florin';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navInvoices => 'Facturen';

  @override
  String get navClients => 'Klanten';

  @override
  String get navExpenses => 'Uitgaven';

  @override
  String get navVatReturn => 'BTW-aangifte';

  @override
  String get navPlTax => 'W&V & Belasting';

  @override
  String get navHours => 'Uren';

  @override
  String get navMileage => 'Kilometers';

  @override
  String get navAssets => 'Activa';

  @override
  String get navPension => 'Pensioen';

  @override
  String get navSettings => 'Instellingen';

  @override
  String get navYear => 'Jaar:';

  @override
  String get actionSave => 'Opslaan';

  @override
  String get actionDelete => 'Verwijderen';

  @override
  String get actionCancel => 'Annuleren';

  @override
  String get labelDate => 'Datum';

  @override
  String get labelNotes => 'Opmerkingen';

  @override
  String get labelCategory => 'Categorie';

  @override
  String get labelAll => 'Alle';

  @override
  String get labelSearch => 'Zoeken…';

  @override
  String dashboardTitle(int year) {
    return 'Dashboard $year';
  }

  @override
  String get dashboardNetRevenue => 'Netto omzet';

  @override
  String get dashboardDeductibleCosts => 'Kosten (aftrekbaar)';

  @override
  String get dashboardEstimatedTax => 'Geschatte belasting';

  @override
  String dashboardEffectiveRate(String rate) {
    return 'Effectief $rate%';
  }

  @override
  String get dashboardNetProfitAfterTax => 'Geschatte nettowinst na belasting';

  @override
  String get dashboardOutstandingInvoices => 'Openstaande facturen';

  @override
  String dashboardInvoiceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count facturen',
      one: '1 factuur',
    );
    return '$_temp0';
  }

  @override
  String get dashboardUrencriterium => 'Urencriterium';

  @override
  String get dashboardUrencriteriumHelp =>
      'De uren die je dit jaar voor je onderneming werkte, tegenover het urencriterium. De zelfstandigenaftrek en de meeste andere ondernemersaftrekken vereisen het (Wet IB 2001 art. 3.76). Alle uren voor je onderneming tellen, niet alleen declarabele. Met een baan moet de onderneming ook meer van je tijd vragen dan de baan (art. 3.6).';

  @override
  String get dashboardBtwDeadlines => 'BTW-deadlines';

  @override
  String get dashboardMonthlyRevenue => 'Maandelijkse omzet';

  @override
  String get deadlineStatusFiled => 'ingediend';

  @override
  String get deadlineStatusOverdue => 'te laat';

  @override
  String deadlineDaysLeft(int days) {
    return '$days d';
  }

  @override
  String genericLoadError(String error) {
    return 'Kan gegevens niet laden: $error';
  }

  @override
  String get invoicesTitle => 'Facturen';

  @override
  String get invoicesNewTooltip => 'Nieuwe factuur';

  @override
  String get invoicesNone => 'Geen facturen';

  @override
  String get invoicesNewHeader => 'Nieuwe factuur';

  @override
  String get invoicesFilterAll => 'Alle';

  @override
  String get invoicesFilterOverdue => 'Verlopen';

  @override
  String get invoiceStatusConcept => 'Concept';

  @override
  String get invoiceStatusSent => 'Verzonden';

  @override
  String get invoiceStatusPaid => 'Betaald';

  @override
  String get invoiceStatusOverdue => 'Verlopen';

  @override
  String get invoiceTypeInvoice => 'Factuur';

  @override
  String get invoiceTypeCreditNote => 'Creditnota';

  @override
  String get invoiceFieldClient => 'Klant';

  @override
  String get invoiceFieldNumber => 'Factuurnummer';

  @override
  String get invoiceFieldInvoiceDate => 'Factuurdatum';

  @override
  String get invoiceFieldSupplyDate => 'Leveringsdatum';

  @override
  String get invoiceFieldPaymentTerm => 'Termijn (dagen)';

  @override
  String get invoiceValidatePaymentTerm =>
      'Voer een heel aantal dagen in (bijv. 14 of 30)';

  @override
  String get invoiceFieldDueDate => 'Vervaldatum';

  @override
  String get invoiceFieldLines => 'Regels';

  @override
  String get invoiceFieldAddLine => 'Regel toevoegen';

  @override
  String get invoiceFieldDescription => 'Omschrijving';

  @override
  String get invoiceFieldQuantity => 'Aantal';

  @override
  String get invoiceFieldUnit => 'Eenheid';

  @override
  String get invoiceFieldPrice => 'Prijs (excl.)';

  @override
  String get invoiceFieldVat => 'BTW';

  @override
  String get invoiceValidateLineDescription => 'Voer een regelomschrijving in';

  @override
  String get invoiceValidateLineQuantity => 'Voer een aantal groter dan nul in';

  @override
  String get invoiceValidateLinePrice => 'Voer een geldige eenheidsprijs in';

  @override
  String get invoiceSubtotal => 'Subtotaal (excl. BTW)';

  @override
  String get invoiceTotalInclVat => 'Totaal (incl. BTW)';

  @override
  String get invoiceFieldRemarks => 'Opmerkingen';

  @override
  String get invoiceActionSend => 'Verzenden';

  @override
  String get invoiceActionMarkPaid => 'Betaald';

  @override
  String get invoiceActionExportPdf => 'PDF exporteren';

  @override
  String get invoiceDeleteTitle => 'Factuur verwijderen';

  @override
  String invoiceDeleteMessage(String number) {
    return 'Weet je zeker dat je factuur \"$number\" wilt verwijderen?';
  }

  @override
  String get invoiceValidateClient => 'Selecteer een klant voor deze factuur';

  @override
  String get invoiceValidateNumber =>
      'Voer een uniek factuurnummer in, bijv. F-2026-001';

  @override
  String get invoiceUnitHint => 'uur';

  @override
  String get clientsTitle => 'Klanten';

  @override
  String get clientsNewTooltip => 'Nieuwe klant';

  @override
  String get clientsNone => 'Geen klanten';

  @override
  String get clientsNewHeader => 'Nieuwe klant';

  @override
  String get clientsFilterAll => 'Alle';

  @override
  String get clientsFilterActive => 'Actief';

  @override
  String get clientsFilterInactive => 'Inactief';

  @override
  String get clientsInactive => 'Inactief';

  @override
  String clientsPaidInYear(int year, String amount) {
    return 'Betaald in $year: $amount';
  }

  @override
  String clientsDbaBadge(String risk) {
    return 'Wet DBA: $risk';
  }

  @override
  String get clientsFieldName => 'Naam';

  @override
  String get clientsValidateName => 'Voer de naam van de klant in';

  @override
  String get clientsFieldCountry => 'Land';

  @override
  String get clientsValidateCountry =>
      'Gebruik een landcode van 2 letters (bijv. NL, DE, FR): die bepaalt welke btw-behandelingen een factuur aan deze klant kan hebben.';

  @override
  String get clientsFieldVat => 'BTW-nummer';

  @override
  String get clientsValidateVat =>
      'Voer een geldig EU-btw-id in, bijv. NL123456789B01 of DE123456789';

  @override
  String get clientsFieldKvk => 'KVK-nummer';

  @override
  String get clientsValidateKvk => 'KVK-nummer moet exact 8 cijfers bevatten';

  @override
  String get clientsFieldAddress => 'Adres';

  @override
  String get clientsValidateAddress => 'Voer het straatadres van de klant in';

  @override
  String get clientsFieldContact => 'Contactpersoon';

  @override
  String get clientsFieldEmail => 'E-mail';

  @override
  String get clientsValidateEmail =>
      'Voer een geldig e-mailadres in (bijv. naam@bedrijf.nl)';

  @override
  String get clientsValidatePhone =>
      'Alleen cijfers, spaties, + en koppeltekens';

  @override
  String get clientsFieldPhone => 'Telefoon';

  @override
  String get clientsFieldActive => 'Actief';

  @override
  String get clientsFieldNotes => 'Opmerkingen';

  @override
  String get clientsWetDba => 'Wet DBA';

  @override
  String get clientsWetDbaHelp =>
      'Hoe je deze arbeidsrelatie beoordeelt onder de Wet DBA (Wet deregulering beoordeling arbeidsrelaties), met het contract dat erbij hoort. Florin bewaart je oordeel en de contractdatum; het beoordeelt de relatie niet.';

  @override
  String get clientsRiskLevel => 'Risiconiveau';

  @override
  String get clientsRiskLow => 'Laag';

  @override
  String get clientsRiskMedium => 'Gemiddeld';

  @override
  String get clientsRiskHigh => 'Hoog';

  @override
  String get clientsContractSigned => 'Contract getekend';

  @override
  String get clientsContractExpiry => 'Vervaldatum contract';

  @override
  String get clientsHighRiskWarning =>
      'Hoog Wet DBA-risico in je eigen beoordeling: is het werk volgens de wet een dienstbetrekking, dan behandelt de Belastingdienst het zo.';

  @override
  String get clientsDeleteTitle => 'Klant verwijderen';

  @override
  String clientsDeleteMessage(String name) {
    return 'Weet je zeker dat je \"$name\" wilt verwijderen?';
  }

  @override
  String get clientsDeleteBlockedTooltip =>
      'Klant heeft facturen en kan niet worden verwijderd';

  @override
  String get expensesTitle => 'Uitgaven';

  @override
  String get expensesNewTooltip => 'Nieuwe uitgave';

  @override
  String get expensesNone => 'Geen uitgaven';

  @override
  String get expensesNewHeader => 'Nieuwe uitgave';

  @override
  String get expensesFieldSupplier => 'Leverancier';

  @override
  String get expensesHintSupplier => 'bijv. Albert Heijn, Amazon, KPN';

  @override
  String get expensesValidateSupplier => 'Voer de naam van de leverancier in';

  @override
  String get expensesFieldCategory => 'Categorie';

  @override
  String get expensesValidateCategory =>
      'Selecteer een categorie voor deze uitgave';

  @override
  String get expensesFieldDescription => 'Omschrijving';

  @override
  String get expensesValidateDescription =>
      'Voer een omschrijving voor deze uitgave in';

  @override
  String get expensesFieldAmountExcl => 'Bedrag (excl. BTW)';

  @override
  String get expensesValidateAmount =>
      'Vul het bedrag exclusief btw in, boven nul: dit zijn de kosten die Florin van je winst aftrekt.';

  @override
  String get expensesFieldVatRate => 'BTW-tarief';

  @override
  String get expensesFieldVat => 'BTW';

  @override
  String get expensesFieldTotalIncl => 'Totaal (incl. BTW)';

  @override
  String get expensesFieldPaidFrom => 'Betaald van';

  @override
  String get expensesHintPaidFrom => 'bijv. ING zakelijke rekening, Visa-kaart';

  @override
  String get expensesFieldPaymentRef => 'Betalingsreferentie';

  @override
  String get expensesHintPaymentRef =>
      'bijv. INV-2026-0042, SEPA-kenmerk 123456';

  @override
  String get expensesBusinessUse => 'Zakelijk gebruik';

  @override
  String expensesBusinessUsePct(int pct) {
    return '$pct% zakelijk';
  }

  @override
  String get expensesDeductible => 'Aftrekbaar';

  @override
  String get expensesReclaimVat => 'BTW terugvragen';

  @override
  String get expensesVatBack => 'BTW terug';

  @override
  String get expensesDeleteTitle => 'Uitgave verwijderen';

  @override
  String get expensesDeleteMessage =>
      'Weet je zeker dat je deze uitgave wilt verwijderen?';

  @override
  String get expenseCatOffice => 'Kantoor & benodigdheden';

  @override
  String get expenseCatTravel => 'Reizen & verblijf';

  @override
  String get expenseCatMeals => 'Voedsel, drank, representatie en congressen';

  @override
  String get expenseCatSoftware => 'Software & abonnementen';

  @override
  String get expenseCatHardware => 'Hardware & apparatuur';

  @override
  String get expenseCatMarketing => 'Marketing & reclame';

  @override
  String get expenseCatProfessional => 'Professionele diensten';

  @override
  String get expenseCatPhone => 'Telefoon & internet';

  @override
  String get expenseCatInsurance => 'Verzekering';

  @override
  String get expenseCatTraining => 'Training & opleiding';

  @override
  String get expenseCatOther => 'Overig';

  @override
  String get hoursTitle => 'Urenregistratie';

  @override
  String get hoursNone => 'Geen uren geregistreerd';

  @override
  String hoursBillable(String hours) {
    return 'Facturabel: $hours uur';
  }

  @override
  String get hoursUnitShort => 'u';

  @override
  String hoursProgress(String total, String target) {
    return '$total / $target uur';
  }

  @override
  String get hoursUrencriteriumOk => 'Urencriterium OK';

  @override
  String hoursUrencriteriumLeft(String left) {
    return '$left uur te gaan';
  }

  @override
  String hoursUrencriteriumJob(int hours) {
    return 'Niet meer dan $hours uur in loondienst';
  }

  @override
  String get hoursFieldDate => 'Datum';

  @override
  String get hoursFieldHours => 'Uren';

  @override
  String get hoursFieldDescription => 'Omschrijving';

  @override
  String get hoursFieldWorkType => 'Type werk';

  @override
  String get hoursFieldClientProject => 'Klant / project';

  @override
  String get hoursFieldNotes => 'Notities';

  @override
  String get hoursNewEntry => 'Nieuwe invoer';

  @override
  String get hoursDeleteTitle => 'Ureninvoer verwijderen';

  @override
  String hoursDeleteMessage(String description) {
    return 'Weet je zeker dat je \"$description\" wilt verwijderen?';
  }

  @override
  String get hoursValidateHours =>
      'Voer de gewerkte uren in: meer dan 0 en hoogstens 24';

  @override
  String get hoursValidateDescription => 'Omschrijf het uitgevoerde werk';

  @override
  String get workTypeBillable => 'Factureerbaar';

  @override
  String get workTypeNonBillable => 'Niet-factureerbaar';

  @override
  String get workTypeAdministrative => 'Administratief';

  @override
  String get workTypeWbso => 'WBSO';

  @override
  String get workTypeOther => 'Overig';

  @override
  String get mileageTitle => 'Kilometerregistratie';

  @override
  String get mileageNone => 'Geen ritten geregistreerd';

  @override
  String get mileageBusiness => 'Zakelijk';

  @override
  String get mileageTotal => 'Totaal';

  @override
  String get mileageUnitKm => 'km';

  @override
  String mileageRoute(String from, String to) {
    return '$from naar $to';
  }

  @override
  String mileageAllowance(String rate) {
    return 'Aftrek ($rate / km)';
  }

  @override
  String get mileageFieldDate => 'Datum';

  @override
  String get mileageFieldMakeModel => 'Merk / model';

  @override
  String get mileageFieldPlate => 'Kenteken';

  @override
  String get mileageFieldFrom => 'Vertrekadres';

  @override
  String get mileageFieldTo => 'Aankomstadres';

  @override
  String get mileageFieldOdoStart => 'Km-stand begin';

  @override
  String get mileageFieldOdoEnd => 'Km-stand eind';

  @override
  String get mileageFieldOdoError => 'Eindstand moet hoger zijn dan beginstand';

  @override
  String get mileageValidateMakeModel =>
      'Voer het merk en model van het voertuig in';

  @override
  String get mileageValidatePlate => 'Voer het kenteken van het voertuig in';

  @override
  String get mileageValidateFrom => 'Voer het vertrekadres in';

  @override
  String get mileageValidateTo => 'Voer het aankomstadres in';

  @override
  String get mileageValidateOdoStart =>
      'Voer de beginstand van de kilometerteller in';

  @override
  String get mileageValidateOdoEnd =>
      'Voer de eindstand van de kilometerteller in';

  @override
  String get mileageValidatePurpose => 'Omschrijf het doel van de rit';

  @override
  String get mileageFieldDistance => 'Afstand';

  @override
  String get mileageFieldTripType => 'Type rit';

  @override
  String get mileageFieldPurpose => 'Doel';

  @override
  String get mileageFieldRouteDeviation => 'Omweg / geen directe route';

  @override
  String get mileageFieldNotes => 'Notities';

  @override
  String get mileageNewTrip => 'Nieuwe rit';

  @override
  String get mileageDeleteTitle => 'Rit verwijderen';

  @override
  String mileageDeleteMessage(String purpose) {
    return 'Weet je zeker dat je \"$purpose\" wilt verwijderen?';
  }

  @override
  String get tripTypeBusiness => 'Zakelijk';

  @override
  String get tripTypeCommute => 'Woon-werkverkeer';

  @override
  String get tripTypePrivate => 'Privé';

  @override
  String get assetsTitle => 'Vaste activa';

  @override
  String get assetsNone => 'Geen activa geregistreerd';

  @override
  String get assetsKiaInvestments => 'KIA-investeringen';

  @override
  String get assetsKiaDeduction => 'KIA-aftrek';

  @override
  String get assetsDepreciationThisYear => 'Afschrijving dit jaar';

  @override
  String get assetsFieldName => 'Naam activum';

  @override
  String get assetsFieldCost => 'Kosten excl. BTW';

  @override
  String get assetsFieldPurchaseDate => 'Aankoopdatum';

  @override
  String get assetsFieldUsefulLife => 'Levensduur';

  @override
  String get assetsFieldUsefulLifeUnit => 'jaar';

  @override
  String assetsFieldUsefulLifeMin(int years, String pct) {
    return 'Voer minstens $years jaar in: afschrijving is beperkt tot $pct van de kosten per jaar';
  }

  @override
  String get assetsValidateName => 'Voer de naam van het activum in';

  @override
  String get assetsValidateCost =>
      'Vul de aanschafprijs exclusief btw in, boven nul: de afschrijving wordt ervan berekend.';

  @override
  String get assetsFieldKia => 'KIA-aanspraak';

  @override
  String get assetsKiaBadge => 'KIA';

  @override
  String get assetsSoldBadge => 'Verkocht';

  @override
  String assetsBookValueTooltip(int year) {
    return 'Boekwaarde eind $year';
  }

  @override
  String get assetsFieldNotes => 'Notities';

  @override
  String get assetsDisposal => 'Vervreemding';

  @override
  String get assetsFieldDisposalDate => 'Vervreemdingsdatum';

  @override
  String get assetsFieldDisposalProceeds => 'Opbrengst excl. BTW';

  @override
  String get assetsClearDisposalDate => 'Vervreemdingsdatum wissen';

  @override
  String get assetsDeleteTitle => 'Activum verwijderen';

  @override
  String assetsDeleteMessage(String name) {
    return 'Weet je zeker dat je \"$name\" wilt verwijderen?';
  }

  @override
  String get assetsNewAsset => 'Nieuw activum';

  @override
  String assetsYears(int n) {
    return '$n jaar';
  }

  @override
  String get pensionTitle => 'Pensioen';

  @override
  String get pensionJaarruimte => 'Jaarruimteberekening';

  @override
  String get pensionAowFranchise => 'AOW-franchise';

  @override
  String get pensionPensioengrondslag => 'Pensioengrondslag';

  @override
  String pensionJaarruimteMax(String max) {
    return 'Jaarruimte (max $max)';
  }

  @override
  String get pensionReserveringsruimte => 'Reserveringsruimte';

  @override
  String get pensionTotalBudget => 'Totaal beschikbaar';

  @override
  String get pensionEstimatedTaxSaving => 'Geschatte belastingbesparing';

  @override
  String get pensionInputSection => 'Invoer';

  @override
  String get pensionFactorA => 'Factor A';

  @override
  String get pensionReserveringsruimteLabel => 'Reserveringsruimte';

  @override
  String get pensionPlannedSection => 'Voorgenomen inleg';

  @override
  String get pensionLijfrente => 'Lijfrentepremie / AOV-premie';

  @override
  String get pensionAovSection => 'AOV arbeidsongeschiktheidsverzekering';

  @override
  String get pensionAovInsured => 'AOV afgesloten';

  @override
  String get pensionMonthlyPremium => 'Maandelijkse premie';

  @override
  String pensionAnnualPremium(String amount) {
    return 'Jaarlijkse premie: $amount';
  }

  @override
  String get vatReturnTitle => 'BTW-aangifte';

  @override
  String get vatReturnRevenueSection => 'Omzet';

  @override
  String get vatReturnCalculationSection => 'BTW-berekening';

  @override
  String get vatReturnIcpSection => 'ICP-opgaaf';

  @override
  String get vatReturnStatusSection => 'Afhandelstatus';

  @override
  String get vatReturnFiled => 'Aangifte ingediend';

  @override
  String get vatReturnPaid => 'BTW betaald';

  @override
  String get vatReturnDue => 'Te betalen BTW';

  @override
  String get vatReturnRefund => 'Terug te ontvangen BTW';

  @override
  String vatRow1a(String rate) {
    return '1a  Leveringen / diensten belast met $rate';
  }

  @override
  String vatRow1b(String rate) {
    return '1b  Leveringen / diensten belast met $rate';
  }

  @override
  String get vatRow3a => '3a  Leveringen naar landen buiten de EU (uitvoer)';

  @override
  String get vatRow5a => '5a  BTW over omzet';

  @override
  String get vatRow5b => '5b  Voorbelasting (terug te vragen)';

  @override
  String get plTaxTitle => 'Winst en geschatte belasting';

  @override
  String get plTaxRevenuSection => 'Omzet';

  @override
  String get plTaxGrossRevenue => 'Bruto omzet (excl. BTW)';

  @override
  String get plTaxCreditNotes => 'Af: creditnota\'s';

  @override
  String get plTaxNetRevenue => 'Netto omzet';

  @override
  String get plTaxCostsSection => 'Kosten';

  @override
  String plTaxMileageAllowance(int km, String rate) {
    return 'Zakelijke kilometers ($km km × $rate)';
  }

  @override
  String get plTaxDepreciation => 'Afschrijvingen';

  @override
  String get plTaxTotalCosts => 'Totaal kosten';

  @override
  String get plTaxGrossProfit => 'Brutowinst';

  @override
  String get plTaxDeductionsSection => 'Ondernemersaftrek';

  @override
  String plTaxZelfstandigenaftrek(int year) {
    return 'Zelfstandigenaftrek $year';
  }

  @override
  String get plTaxStartersaftrek => 'Startersaftrek';

  @override
  String plTaxMkb(String pct) {
    return 'MKB-winstvrijstelling ($pct%)';
  }

  @override
  String get plTaxKia => 'KIA-aftrek';

  @override
  String get plTaxLijrente => 'Lijfrenteaftrek';

  @override
  String get plTaxTaxableProfit => 'Belastbaar inkomen';

  @override
  String get plTaxBox1Section => 'Inkomstenbelasting box 1, geschat';

  @override
  String get plTaxAlgHeffing => 'Algemene heffingskorting';

  @override
  String get plTaxArbeidskorting => 'Arbeidskorting';

  @override
  String get plTaxTariefaanpassing => 'Tariefaanpassing';

  @override
  String get plTaxTariefaanpassingHelp =>
      'De ondernemersaftrek en de mkb-winstvrijstelling verlagen je belasting hoogstens tegen het tarief onder de hoogste schijf. Voor het deel dat in de hoogste schijf valt, wordt het verschil bijgeteld (Wet IB 2001 art. 2.10 lid 2).';

  @override
  String get plTaxInkomsten => 'Inkomstenbelasting';

  @override
  String plTaxZvw(String pct) {
    return 'ZVW-bijdrage ($pct%)';
  }

  @override
  String get plTaxTotalTax => 'Geschatte totale belasting';

  @override
  String get plTaxWageTaxWithheld => 'Ingehouden loonheffing';

  @override
  String get plTaxWageTaxWithheldHelp =>
      'De loonbelasting en premie volksverzekeringen die je werkgevers inhielden, zoals je hieronder invulde. De aangifte verrekent die met de belasting hierboven.';

  @override
  String get plTaxToPay => 'Geschatte belasting te betalen';

  @override
  String get plTaxRefund => 'Geschatte teruggave';

  @override
  String get plTaxToPayHelp =>
      'Geschat: de totale belasting min de ingehouden loonheffing. Betalingen op een voorlopige aanslag zijn niet afgetrokken.';

  @override
  String get plTaxNetProfit => 'Geschatte nettowinst na belasting';

  @override
  String get plTaxNetProfitHelp =>
      'Geschat: brutowinst min de belasting die de onderneming toevoegt. Met loon is dat de totale belasting min de belasting over alleen het loon.';

  @override
  String plTaxEffectiveRate(String rate) {
    return 'Effectief tarief over de winst: $rate%';
  }

  @override
  String plTaxUrenBanner(String hours, String target, String suffix) {
    return 'Urencriterium: $hours van $target uur gelogd$suffix.';
  }

  @override
  String get plTaxUrenBannerSuffixDone => ', dus geen zelfstandigenaftrek';

  @override
  String get plTaxUrenBannerSuffixPending =>
      '. Tot je het haalt, laat de schatting de zelfstandigenaftrek en de andere aftrekposten die het vereisen weg';

  @override
  String plTaxUrenJobBanner(String hours, int jobHours) {
    return 'Urencriterium: $hours uur gelogd voor de onderneming, niet meer dan de $jobHours uur in loondienst. Het urencriterium vraagt meer tijd in de onderneming dan in ander werk, dus de schatting laat de zelfstandigenaftrek en de andere aftrekposten die het vereisen weg.';
  }

  @override
  String get settingsLanguageSection => 'Taal';

  @override
  String get settingsLanguageNl => 'Nederlands';

  @override
  String get settingsLanguageEn => 'Engels';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get settingsBusinessSection => 'Bedrijfsgegevens';

  @override
  String get settingsBusinessName => 'Bedrijfsnaam';

  @override
  String get settingsVatNumber => 'BTW-nummer';

  @override
  String get settingsKvkNumber => 'KVK-nummer';

  @override
  String get settingsBusinessAddress => 'Bedrijfsadres';

  @override
  String get settingsIban => 'IBAN';

  @override
  String get settingsStartersaftrek => 'Recht op startersaftrek';

  @override
  String get settingsValidateName => 'Voer je bedrijfsnaam in';

  @override
  String get settingsValidateVat =>
      'Voer je BTW-nummer in, bijv. NL123456789B01.';

  @override
  String get settingsValidateVatFormat =>
      'Ongeldig BTW-nummer. Formaat: NL + 9 cijfers + B + 2 cijfers, bijv. NL123456789B01.';

  @override
  String get settingsValidateKvk => 'Voer je KVK-nummer in.';

  @override
  String get settingsValidateKvkFormat =>
      'KVK-nummer moet exact 8 cijfers bevatten.';

  @override
  String get settingsValidateAddress => 'Voer je bedrijfsadres in';

  @override
  String get settingsValidateIban =>
      'Voer je IBAN in, bijv. NL91ABNA0417164300.';

  @override
  String get settingsValidateIbanFormat =>
      'Ongeldig IBAN-formaat (bijv. NL91ABNA0417164300).';

  @override
  String get settingsDatabaseSection => 'Database';

  @override
  String settingsDatabaseLocation(String path) {
    return 'Locatie: $path';
  }

  @override
  String get settingsMoveDatabase =>
      'Database en bonnen naar een andere map kopiëren';

  @override
  String get settingsExportSection => 'Exporteren';

  @override
  String settingsExportDescription(int year) {
    return 'Exporteer alle gegevens van $year naar CSV-bestanden, met per kwartaal de btw-aangifte per rubriek in hele euro\'s, het ICP-overzicht en de geschatte inkomstenbelasting van het jaar. Florin zet ze in een nieuwe map met de exportdatum in de naam, in de map die je kiest.';
  }

  @override
  String settingsExportButton(int year) {
    return 'Exporteer $year als CSV';
  }

  @override
  String get settingsExportRunning => 'Bezig met exporteren…';

  @override
  String settingsExported(String dir) {
    return 'Geëxporteerd naar $dir';
  }

  @override
  String settingsTaxSection(int year) {
    return 'Belastingregels $year';
  }

  @override
  String get settingsTaxZelfs => 'Zelfstandigenaftrek';

  @override
  String get settingsTaxStarters => 'Startersaftrek';

  @override
  String get settingsTaxMkb => 'MKB-winstvrijstelling (%)';

  @override
  String get settingsTaxMileage => 'Kilometervergoeding per km';

  @override
  String get settingsTaxZvwRate => 'ZVW-tarief (%)';

  @override
  String get settingsTaxUrencriterium => 'Urencriterium (uren)';

  @override
  String get firstLaunchWelcome => 'Welkom bij Florin';

  @override
  String get firstLaunchSubtitle => 'Stel je boekhoudwerkruimte in.';

  @override
  String get firstLaunchDbSection => 'Databaselocatie';

  @override
  String get firstLaunchDbDescription =>
      'Standaard: de map met app-gegevens. Kies een andere map om hem in een gesynchroniseerde map te bewaren. Staat daar al een Florin-database, dan opent Florin die.';

  @override
  String firstLaunchDbDefault(String path) {
    return '$path (standaard)';
  }

  @override
  String get firstLaunchDbDefaultFolder =>
      'De eigen gegevensmap van de app (standaard)';

  @override
  String get firstLaunchChooseFolder => 'Map kiezen';

  @override
  String firstLaunchStartersSubtitle(int years, int max) {
    return 'Voor ondernemers die in een of meer van de $years voorgaande jaren geen ondernemer waren en in die periode hoogstens $max keer zelfstandigenaftrek hadden';
  }

  @override
  String get firstLaunchGetStarted => 'Aan de slag';

  @override
  String firstLaunchSaveError(String error) {
    return 'Kan setup niet afronden: $error';
  }

  @override
  String get deadlineBadgeFiled => 'Ingediend';

  @override
  String get deadlineBadgeOverdue => 'Te laat';

  @override
  String deadlineBadgeDays(int days) {
    return '$days dagen';
  }

  @override
  String get vatRate0 => '0%';

  @override
  String get vatRateExempt => 'Vrijgesteld';

  @override
  String genericSaveError(String error) {
    return 'Kan niet opslaan: $error';
  }

  @override
  String get dbLocationChooseFolderDialog => 'Kies map voor de Florin-database';

  @override
  String get csvExportChooseFolderDialog => 'Kies exportmap';

  @override
  String get invoiceSaveAsDialog => 'Factuur opslaan als';

  @override
  String get amountNegativeError =>
      'Vul nul of meer in. Een correctie is een eigen registratie, zoals een creditnota.';

  @override
  String get vatTreatmentStandard => 'Nederlandse btw';

  @override
  String get vatTreatmentReverseChargeNl =>
      'Btw verlegd naar Nederlandse ondernemer';

  @override
  String get vatTreatmentExportOutsideEu =>
      'Uitvoer van goederen buiten de EU (0%)';

  @override
  String get invoiceFieldVatTreatment => 'Btw-behandeling';

  @override
  String get invoiceValidateClientVat =>
      'Deze klant heeft geen btw-id. Vul het in bij de klant: deze factuur moet het vermelden.';

  @override
  String get invoiceIssueTitle => 'Factuur verzenden';

  @override
  String get invoiceIssueMessage =>
      'Na verzenden kan de factuur niet meer worden gewijzigd of verwijderd. Correcties maak je met een creditnota.';

  @override
  String invoiceIssueRenumber(String number, String next) {
    return '$number sluit niet aan op de laatste factuur die je in deze reeks uitreikte, dus hij wordt verstuurd als $next: factuurnummers lopen zonder gaten door (Wet OB 1968 art. 35a lid 1 b).';
  }

  @override
  String invoiceActionSendAs(String number) {
    return 'Versturen als $number';
  }

  @override
  String get invoiceActionCreditNote => 'Creditnota';

  @override
  String get invoiceNewCreditNoteHeader => 'Nieuwe creditnota';

  @override
  String invoiceCorrects(String number) {
    return 'Deze creditnota corrigeert factuur $number.';
  }

  @override
  String get invoiceVatTotal => 'Btw';

  @override
  String get invoiceRemoveLine => 'Regel verwijderen';

  @override
  String get invoiceLockedNotice =>
      'Deze factuur is uitgereikt en kan niet meer veranderen. Corrigeer hem met een creditnota die ernaar verwijst.';

  @override
  String get invoiceLockedCreditNotice =>
      'Deze creditnota is uitgereikt en kan niet meer veranderen.';

  @override
  String expensesFoodNotice(String pct, String drempel) {
    return 'Voedsel, drank, representatie, congressen, seminars en studiereizen zijn voor de inkomstenbelasting voor $pct aftrekbaar, of voor zover ze $drempel per jaar overschrijden als dat meer is (Wet IB 2001 art. 3.15). Btw op eten en drinken in een restaurant, café of hotel is niet aftrekbaar (Wet OB 1968 art. 15).';
  }

  @override
  String plTaxFoodLimited(String category, String amount) {
    return '$category ($amount)';
  }

  @override
  String get plTaxBelastbareWinst => 'Belastbare winst';

  @override
  String plTaxBracket(int n, String pct) {
    return 'Schijf $n ($pct%)';
  }

  @override
  String get plTaxEstimateNotice =>
      'Dit is een schatting voor een ondernemer onder de AOW-leeftijd. Loon uit dienstbetrekking telt mee als je het hieronder invult. Inkomen van een partner, uit overig werk, box 2 of box 3 telt niet mee.';

  @override
  String settingsMoved(String path) {
    return 'Database gekopieerd naar $path en in gebruik. Het oude bestand is bewaard.';
  }

  @override
  String get settingsTaxVerified =>
      'Florin gebruikt deze bedragen, gecontroleerd bij de Belastingdienst en in de wet. Ze zijn niet aan te passen.';

  @override
  String settingsTaxUpTo(String amount) {
    return 'tot en met $amount';
  }

  @override
  String pensionPriorYearIncome(int year) {
    return 'Inkomen uit arbeid in $year';
  }

  @override
  String get pensionDeductible => 'Aftrekbaar dit jaar';

  @override
  String get vatRow1e =>
      '1e  Leveringen / diensten belast met 0% of niet bij u belast';

  @override
  String get vatRow3b =>
      '3b  Leveringen naar of diensten in landen binnen de EU';

  @override
  String get vatTreatmentEuServices =>
      'Diensten aan EU-ondernemer (btw verlegd)';

  @override
  String get vatTreatmentEuGoods =>
      'Goederen aan EU-ondernemer (intracommunautaire levering, 0%)';

  @override
  String vatReturnIcpNote(String amount) {
    return 'Geef deze prestaties op in de ICP-opgaaf. Lever je in een kwartaal meer dan $amount aan goederen aan EU-ondernemers, dan doe je de opgaaf per maand.';
  }

  @override
  String get assetsFieldResidualValue => 'Restwaarde';

  @override
  String get assetsValidateResidualValue =>
      'Voer de restwaarde in, of 0 als het bedrijfsmiddel dan niets meer waard is';

  @override
  String get assetsValidateResidualAboveCost =>
      'De restwaarde kan niet hoger zijn dan de kosten';

  @override
  String get plTaxDisposalResult => 'Resultaat op verkochte bedrijfsmiddelen';

  @override
  String get plTaxAov => 'Premies arbeidsongeschiktheidsverzekering';

  @override
  String get pensionAovHelper =>
      'Premies voor een arbeidsongeschiktheidsverzekering worden in de belastingschatting volledig afgetrokken.';

  @override
  String get assetsFieldCostHelp =>
      'De aankoopprijs zonder btw. Met de btw die je niet terugvraagt is dit de kostprijs waarover je afschrijft en investeringsaftrek krijgt.';

  @override
  String get assetsFieldDisposalDateHelp =>
      'De datum waarop je het bedrijfsmiddel verkocht of uit de onderneming haalde. De afschrijving stopt op die datum.';

  @override
  String get assetsFieldDisposalProceedsHelp =>
      'Wat je voor het bedrijfsmiddel kreeg, zonder btw, of de marktwaarde als je het privé ging gebruiken. Het verschil met de boekwaarde is winst of verlies.';

  @override
  String assetsFieldKiaHelp(String min) {
    return 'Kleinschaligheidsinvesteringsaftrek: een extra aftrek voor bedrijfsmiddelen. Bedrijfsmiddelen onder $min tellen niet mee, en personenauto\'s en sommige andere bedrijfsmiddelen zijn uitgesloten.';
  }

  @override
  String get assetsFieldNameHelp =>
      'Een naam waaraan je het bedrijfsmiddel herkent, zoals \"MacBook Pro 2026\".';

  @override
  String get assetsFieldNotesHelp =>
      'Alles wat je over dit bedrijfsmiddel wilt onthouden. Telt niet mee in berekeningen.';

  @override
  String get assetsFieldPurchaseDateHelp =>
      'De datum waarop je het bedrijfsmiddel kocht. De afschrijving begint op die datum en de investeringsaftrek geldt voor dit jaar.';

  @override
  String get assetsFieldResidualValueHelp =>
      'Wat het bedrijfsmiddel aan het eind van de levensduur nog waard is. De afschrijving stopt bij deze waarde.';

  @override
  String assetsFieldUsefulLifeHelp(int years, String pct) {
    return 'Hoeveel jaar je het bedrijfsmiddel verwacht te gebruiken. Minimaal $years, omdat afschrijving beperkt is tot $pct van de kosten per jaar.';
  }

  @override
  String get assetsVatSection => 'Btw op de aankoop';

  @override
  String get assetsVatSectionHelp =>
      'De btw op de aankoopfactuur. Btw die je terugvraagt komt in de btw-aangifte van het kwartaal van aankoop; btw die je niet terugvraagt hoort bij de kosten van het bedrijfsmiddel.';

  @override
  String get assetsFieldVatRate => 'BTW-tarief';

  @override
  String assetsFieldVatRateHelp(String high, String low) {
    return 'Het btw-tarief op de aankoopfactuur: $high, $low, 0% of vrijgesteld. Kies 0% als er geen btw is gerekend, zoals bij een aankoop van een particulier.';
  }

  @override
  String get assetsValidateVatRate =>
      'Kies het btw-tarief op de aankoopfactuur: de btw in je aangifte hangt ervan af.';

  @override
  String get assetsFieldVatAmount => 'Btw-bedrag';

  @override
  String get assetsFieldVatAmountHelp =>
      'De btw op de aankoopfactuur. Florin heeft geen belastingregels voor het jaar van aankoop, dus je vult het bedrag in in plaats van een tarief.';

  @override
  String get assetsFieldPurchaseVat => 'Hoe de btw is berekend';

  @override
  String get assetsFieldPurchaseVatHelp =>
      'Nederlandse btw als de leverancier die rekende. Verlegd als op de factuur staat dat de btw naar jou is verlegd, of als de leverancier in het buitenland zit: je geeft de btw dan zelf aan en trekt hem weer af.';

  @override
  String get assetsReclaimVat => 'Deze btw terugvragen';

  @override
  String get assetsReclaimVatHelp =>
      'Vink aan als je deze btw mag aftrekken in je btw-aangifte. Dat mag voor het zakelijke deel dat je gebruikt voor werk waarover je btw rekent: niet zolang je meedoet aan de KOR, en niet voor een bedrijfsmiddel dat je alleen voor btw-vrijgesteld werk gebruikt.';

  @override
  String get assetsValidateKorReclaim =>
      'Je doet op de aankoopdatum mee aan de KOR, dus je kunt deze btw niet terugvragen. Vink Deze btw terugvragen uit: de btw hoort dan bij de kosten.';

  @override
  String get assetsKorNotice =>
      'Je doet op de aankoopdatum mee aan de KOR. De btw vraag je niet terug; die hoort bij de kosten waarover je afschrijft en investeringsaftrek krijgt.';

  @override
  String get assetsFieldVat => 'BTW';

  @override
  String get assetsVatBack => 'BTW terug';

  @override
  String get assetsCostForTax => 'Kosten voor de inkomstenbelasting';

  @override
  String get assetsCostForTaxHelp =>
      'De prijs en de btw die je niet terugvraagt. Afschrijving en investeringsaftrek gaan hiervan uit.';

  @override
  String get assetsFieldSaleInvoice => 'Verkoopfactuur';

  @override
  String get assetsFieldSaleInvoiceHelp =>
      'De factuur die je in Florin alleen voor deze verkoop maakte. Het bedrag is de opbrengst en de btw staat in je btw-aangifte; het telt niet als omzet en niet voor de KOR-omzet. Kies geen bij een verkoop zonder factuur in Florin of als je het bedrijfsmiddel privé ging gebruiken.';

  @override
  String get assetsSaleInvoiceNone => 'Geen factuur in Florin';

  @override
  String get assetsProceedsFromInvoiceHelp =>
      'Waar de verkoopfactuur en een creditnota daarop samen op uitkomen, zonder btw. Het verschil met de boekwaarde is winst of verlies.';

  @override
  String get assetsFieldDisposalVatRate => 'Btw op de verkoop';

  @override
  String assetsFieldDisposalVatRateHelp(String high) {
    return 'De btw die je verschuldigd bent over de verkoop, of over het privé gaan gebruiken van het bedrijfsmiddel, over het zakelijke deel van de opbrengst. Die komt in de btw-aangifte van dat kwartaal. Meestal $high; vrijgesteld alleen als je het bedrijfsmiddel uitsluitend voor btw-vrijgesteld werk gebruikte en er geen btw op aftrok.';
  }

  @override
  String get assetsValidateDisposalVatRate =>
      'Kies het btw-tarief van de verkoop: de btw in je aangifte hangt ervan af.';

  @override
  String get assetsSaleKorNotice =>
      'Je doet op de verkoopdatum mee aan de KOR, dus er is geen btw op de verkoop.';

  @override
  String get clientsContractExpiryHelp =>
      'Wanneer de overeenkomst met deze klant afloopt.';

  @override
  String get clientsContractSignedHelp =>
      'Vink aan als jij en de klant een schriftelijke overeenkomst hebben getekend.';

  @override
  String get clientsFieldActiveHelp =>
      'Inactieve klanten blijven in je administratie, maar staan niet in de keuzelijst voor nieuwe facturen.';

  @override
  String get clientsFieldAddressHelp =>
      'Het volledige zakelijke adres van de klant. Het staat op elke factuur.';

  @override
  String get clientsFieldContactHelp =>
      'De persoon met wie je bij deze klant contact hebt.';

  @override
  String get clientsFieldCountryHelp =>
      'De landcode van twee letters, zoals NL of DE. Bepaalt welke btw-behandelingen een factuur aan deze klant kan hebben.';

  @override
  String get clientsFieldEmailHelp =>
      'Het adres waar je facturen naartoe stuurt.';

  @override
  String get clientsFieldKvkHelp =>
      'Het KvK-nummer van 8 cijfers van de klant, als die er een heeft.';

  @override
  String get clientsFieldNameHelp =>
      'De officiële naam of handelsnaam van de klant, zoals die op facturen moet staan.';

  @override
  String get clientsFieldNotesHelp =>
      'Alles wat je over deze klant wilt onthouden. Staat niet op facturen.';

  @override
  String get clientsFieldPhoneHelp => 'Een telefoonnummer van deze klant.';

  @override
  String get clientsFieldVatHelp =>
      'Het btw-identificatienummer van de klant. Verplicht op facturen met btw verlegd of aan een EU-ondernemer.';

  @override
  String get clientsRiskLevelHelp =>
      'Je eigen inschatting of het werk als dienstbetrekking gezien kan worden onder de Wet DBA. Alleen als geheugensteun.';

  @override
  String get expensesFieldAmountExclHelp => 'Het bedrag op de bon zonder btw.';

  @override
  String get expensesFieldCategoryHelp =>
      'Wat voor kosten dit zijn. Voedsel, drank, representatie, congressen, seminars, excursies en studiereizen zijn maar gedeeltelijk aftrekbaar (Wet IB 2001 art. 3.15), dus ze horen in hun eigen categorie.';

  @override
  String get expensesFieldDescriptionHelp =>
      'Wat je hebt gekocht, zodat jij en de Belastingdienst het zakelijke doel zien.';

  @override
  String get expensesFieldPaidFromHelp =>
      'De rekening of kaart waarmee je betaalde, om de uitgave met je afschrift te koppelen.';

  @override
  String get expensesFieldPaymentRefHelp =>
      'Het kenmerk van de betaling of factuur, om hem later terug te vinden.';

  @override
  String get expensesFieldSupplierHelp =>
      'Het bedrijf waar je kocht, zoals op de bon.';

  @override
  String expensesFieldVatRateHelp(String high, String low) {
    return 'Het btw-tarief op de bon: $high, $low, 0% of vrijgesteld.';
  }

  @override
  String expensesReclaimVatHelp(String amount) {
    return 'Vink aan als je deze btw mag aftrekken in je btw-aangifte. Niet voor eten en drinken in een restaurant, voor privégebruik, of voor geschenken aan iemand die zelf geen btw aftrekt als ze voor die persoon samen meer dan $amount per jaar zijn (Besluit uitsluiting aftrek omzetbelasting 1968).';
  }

  @override
  String get hoursFieldClientProjectHelp =>
      'De klant of het project waarvoor de uren waren.';

  @override
  String get hoursFieldDateHelp => 'De dag waarop je werkte.';

  @override
  String get hoursFieldDescriptionHelp =>
      'Wat je deed. Alle uren voor de onderneming tellen mee voor het urencriterium, niet alleen declarabele.';

  @override
  String get hoursFieldHoursHelp =>
      'Hoeveel uur je die dag werkte, bijvoorbeeld 7,5.';

  @override
  String get hoursFieldNotesHelp =>
      'Alles wat je over deze uren wilt onthouden.';

  @override
  String hoursFieldWorkTypeHelp(int hours) {
    return 'Het soort werk. WBSO-uren tellen mee voor de $hours uur die nodig zijn voor de S&O-aftrek.';
  }

  @override
  String get invoiceFieldClientHelp =>
      'Voor wie de factuur is. Naam en adres komen erop te staan.';

  @override
  String get invoiceFieldDescriptionHelp =>
      'Wat je leverde: de aard van de goederen of diensten, zoals de wet op een factuur vereist.';

  @override
  String get invoiceFieldDueDateHelp =>
      'De laatste dag om te betalen: de factuurdatum plus de betalingstermijn.';

  @override
  String get invoiceFieldInvoiceDateHelp =>
      'De datum waarop de factuur wordt uitgereikt. Bepaalt in welk jaar en kwartaal de omzet en btw vallen.';

  @override
  String get invoiceFieldNumberHelp =>
      'Een uniek nummer in een doorlopende reeks, zoals de wet vereist. Florin stelt het volgende voor.';

  @override
  String get invoiceFieldPaymentTermHelp =>
      'Hoeveel dagen de klant heeft om te betalen.';

  @override
  String get invoiceFieldPriceHelp => 'De prijs per eenheid zonder btw.';

  @override
  String get invoiceFieldQuantityHelp =>
      'Hoeveel eenheden, bijvoorbeeld uren of stuks.';

  @override
  String get invoiceFieldRemarksHelp => 'Extra tekst onderaan de factuur.';

  @override
  String get invoiceFieldSupplyDateHelp =>
      'Wanneer je leverde, als dat afwijkt van de factuurdatum. De wet vereist het dan op de factuur.';

  @override
  String invoiceLateNotice(String date) {
    return 'Een factuur reik je uit uiterlijk de 15e van de maand na de levering (Wet OB 1968 art. 34g): voor deze levering uiterlijk $date.';
  }

  @override
  String get invoiceFieldUnitHelp =>
      'De eenheid van het aantal, zoals uren of stuks.';

  @override
  String get invoiceFieldVatHelp => 'Het btw-tarief voor deze regel.';

  @override
  String get invoiceFieldVatReverseHelp =>
      'Het btw-tarief dat zonder verlegging zou gelden. De factuur vermeldt het met het bedrag per tarief, en je klant betaalt de btw.';

  @override
  String get invoiceValidateLineRate =>
      'Kies het btw-tarief voor deze regel: de factuur vermeldt het, ook als de btw verlegd is.';

  @override
  String get invoiceFieldVatTreatmentHelp =>
      'Hoe de btw werkt. Nederlandse btw voor de meeste Nederlandse klanten, of Vrijgesteld, kleineondernemersregeling zolang je aan de KOR meedoet. Btw verlegd als de klant de btw betaalt. EU-goederen en -diensten aan ondernemers komen ook op de ICP-opgaaf. Diensten aan een ondernemer buiten de EU zijn daar belast en blijven buiten de Nederlandse aangifte.';

  @override
  String get labelCategoryHelp => 'Toon alleen uitgaven van één categorie.';

  @override
  String get labelDateHelp =>
      'De datum op de bon. Bepaalt het jaar en kwartaal van de uitgave.';

  @override
  String get labelNotesHelp =>
      'Alles wat je wilt onthouden. Telt niet mee in berekeningen.';

  @override
  String get mileageFieldDateHelp => 'De dag van de rit.';

  @override
  String get mileageFieldDistanceHelp => 'Berekend uit de kilometerstanden.';

  @override
  String get mileageFieldFromHelp => 'Waar de rit begon.';

  @override
  String get mileageFieldMakeModelHelp =>
      'Merk en model van het voertuig, voor je rittenregistratie.';

  @override
  String get mileageFieldNotesHelp =>
      'Alles wat je over deze rit wilt onthouden.';

  @override
  String get mileageFieldOdoEndHelp =>
      'De kilometerstand aan het eind van de rit.';

  @override
  String get mileageFieldOdoStartHelp =>
      'De kilometerstand aan het begin van de rit.';

  @override
  String get mileageFieldPlateHelp =>
      'Het kenteken, voor je rittenregistratie.';

  @override
  String get mileageFieldPurposeHelp =>
      'Waarom je de rit maakte, bijvoorbeeld de klant of afspraak.';

  @override
  String get mileageFieldRouteDeviationHelp =>
      'Vink aan als je een langere of andere route dan de kortste reed, en noteer waarom.';

  @override
  String get mileageFieldToHelp => 'Waar de rit eindigde.';

  @override
  String get mileageFieldTripTypeHelp =>
      'Zakelijke ritten en woon-werkritten met een privévoertuig zijn per km aftrekbaar voor de inkomstenbelasting. Privéritten niet.';

  @override
  String get pensionAovInsuredHelp =>
      'Vink aan als je een particuliere arbeidsongeschiktheidsverzekering (AOV) hebt. De premies zijn aftrekbaar.';

  @override
  String get pensionFactorAHelp =>
      'Het pensioen dat je vorig jaar bij een werkgever opbouwde, uit de factor A op je UPO. Laat 0 als je dat niet had. Valt je pensioenregeling onder de Wet toekomst pensioenen, dan staan op je UPO premies: de wet verlaagt de jaarruimte dan met die premies, en dat berekent Florin niet.';

  @override
  String get pensionLijfrenteHelp =>
      'Wat je dit jaar in een lijfrente stort of wilt storten. Aftrekbaar tot de ruimte die je hebt.';

  @override
  String get pensionMonthlyPremiumHelp =>
      'De maandpremie van je arbeidsongeschiktheidsverzekering.';

  @override
  String get pensionPriorYearIncomeHelp =>
      'Je winst uit onderneming en loon van vorig jaar, uit de aangifte van dat jaar. De jaarruimte gaat hiervan uit.';

  @override
  String get pensionReserveringsruimteLabelHelp =>
      'Niet-gebruikte jaarruimte uit eerdere jaren die je nog mag gebruiken. Het Hulpmiddel Lijfrentepremie van de Belastingdienst rekent het uit.';

  @override
  String get settingsBusinessAddressHelp =>
      'Je volledige zakelijke adres. Het staat op elke factuur.';

  @override
  String get settingsBusinessNameHelp =>
      'Je bedrijfsnaam zoals ingeschreven bij de KvK. Hij staat op elke factuur.';

  @override
  String get settingsIbanHelp =>
      'De rekening waarop klanten betalen. Hij staat in de betaalinstructies.';

  @override
  String get settingsKvkNumberHelp =>
      'Je KvK-nummer van 8 cijfers. Het staat op elke factuur.';

  @override
  String settingsStartersaftrekHelp(int years, int max) {
    return 'Je krijgt de startersaftrek als je in minstens één van de $years voorgaande jaren geen ondernemer was en in die periode hoogstens $max keer zelfstandigenaftrek had.';
  }

  @override
  String get settingsVatNumberHelp =>
      'Je btw-identificatienummer (btw-id): NL, 9 cijfers, B en 2 cijfers. Het staat op elke factuur.';

  @override
  String get vatReturnFiledHelp =>
      'Vink aan zodra je de aangifte van dit kwartaal hebt gedaan in Mijn Belastingdienst Zakelijk.';

  @override
  String get vatReturnPaidHelp =>
      'Vink aan zodra je de btw van dit kwartaal hebt betaald.';

  @override
  String get assetKindGeneral => 'Bedrijfsmiddel';

  @override
  String get assetKindCar => 'Auto van de zaak';

  @override
  String get assetsFieldKind => 'Soort';

  @override
  String get assetsFieldKindHelp =>
      'Kies auto voor een personen- of bestelauto die tot de onderneming hoort. Privégebruik ervan telt bij je winst en in je btw-aangifte.';

  @override
  String get assetsCarSection => 'Auto';

  @override
  String get assetsCarSectionHelp =>
      'Deze gegevens bepalen de bijtelling voor privégebruik en de btw over privégebruik. Een auto van de zaak telt volledig mee: de bijtelling en de btw over privégebruik corrigeren het privégebruik.';

  @override
  String get assetsFieldCatalogueValue => 'Cataloguswaarde';

  @override
  String get assetsFieldCatalogueValueHelp =>
      'De oorspronkelijke catalogusprijs inclusief btw en bpm, zoals op het kentekenbewijs of de website van de RDW.';

  @override
  String get assetsValidateCatalogueValue =>
      'Vul de cataloguswaarde inclusief btw en bpm in, boven nul: de bijtelling privégebruik is een percentage ervan.';

  @override
  String get assetsFieldFirstRegistration => 'Eerste toelating';

  @override
  String get assetsFieldFirstRegistrationHelp =>
      'De datum waarop de auto voor het eerst werd toegelaten, op het kentekenbewijs. Bepaalt welk bijtellingspercentage geldt.';

  @override
  String get assetsValidateFirstRegistration =>
      'Voer de datum van eerste toelating van het kentekenbewijs in';

  @override
  String get assetsFieldZeroEmission => 'Emissievrij';

  @override
  String get assetsFieldZeroEmissionHelp =>
      'Elektrische, waterstof- en zonne-auto\'s met 0 g/km CO2 krijgen een lagere bijtelling.';

  @override
  String get zeroEmissionNone => 'Nee';

  @override
  String get zeroEmissionBattery => 'Elektrisch met accu';

  @override
  String get zeroEmissionHydrogenOrSolar =>
      'Waterstof of geïntegreerde zonnepanelen';

  @override
  String get assetsFieldMarketValue => 'Waarde in het economisch verkeer';

  @override
  String assetsFieldMarketValueHelp(int years) {
    return 'Wat de auto nu waard is. Wordt alleen gebruikt als de auto ouder is dan $years jaar.';
  }

  @override
  String get assetsFieldTripLog =>
      'Ik houd een sluitende rittenregistratie bij voor deze auto';

  @override
  String assetsFieldTripLogHelp(int km) {
    return 'Met een sluitende rittenregistratie van alle ritten in deze auto is er geen bijtelling bij $km privékilometers per jaar of minder, en gaat de btw over privégebruik uit van de werkelijke kilometers.';
  }

  @override
  String get assetsInvestmentSection => 'Investeringsaftrek';

  @override
  String assetsInvestmentSectionHelp(int years) {
    return 'Extra aftrek in het jaar van aankoop. Verkoop je het bedrijfsmiddel binnen $years jaar, dan telt een deel weer bij de winst.';
  }

  @override
  String get assetsFieldEia => 'Energie-investering (EIA), gemeld bij RVO';

  @override
  String assetsFieldEiaHelp(int months, String min) {
    return 'Een bedrijfsmiddel op de Energielijst van RVO, binnen $months maanden gemeld bij RVO. Minimaal $min per bedrijfsmiddel. Niet te combineren met MIA.';
  }

  @override
  String get assetsFieldMia => 'Milieu-investering (MIA)';

  @override
  String assetsFieldMiaHelp(int months, String min) {
    return 'De categorie op de Milieulijst van RVO, binnen $months maanden gemeld bij RVO. Minimaal $min per bedrijfsmiddel.';
  }

  @override
  String get assetsMiaNone => 'Geen';

  @override
  String get miaCategoryOne => 'Categorie I';

  @override
  String get miaCategoryTwo => 'Categorie II';

  @override
  String get miaCategoryThree => 'Categorie III';

  @override
  String get assetsFieldDeductionReceived => 'Ontvangen investeringsaftrek';

  @override
  String assetsFieldDeductionReceivedHelp(int years) {
    return 'De KIA, EIA en MIA die je voor dit bedrijfsmiddel kreeg in het jaar van aankoop, uit de aangifte van dat jaar. Nodig om een deel bij te tellen als je het binnen $years jaar verkoopt.';
  }

  @override
  String get assetsValidateDeductionReceived =>
      'Voer de investeringsaftrek in die je voor dit bedrijfsmiddel kreeg, of 0';

  @override
  String get assetsFieldReserveApplied => 'Afgeboekte herinvesteringsreserve';

  @override
  String get assetsFieldReserveAppliedHelp =>
      'Deel van de herinvesteringsreserve dat je op deze aankoop afboekt. Verlaagt het bedrag waarover je afschrijft.';

  @override
  String assetsReserveAvailable(String amount) {
    return 'Beschikbaar: $amount';
  }

  @override
  String get assetsValidateReserveAboveAvailable =>
      'Dit is meer dan de beschikbare herinvesteringsreserve';

  @override
  String get assetsValidateReserveAboveCost =>
      'Dit is meer dan de kosten min de restwaarde';

  @override
  String get assetsFieldReserveGain =>
      'Boekwinst naar de herinvesteringsreserve';

  @override
  String assetsFieldReserveGainHelp(int years) {
    return 'Alleen als je van plan bent een vervanger te kopen. De boekwinst wordt dan nu niet belast maar afgeboekt op de volgende aankoop; na $years jaar ongebruikt telt hij bij je winst.';
  }

  @override
  String get dashboardDeductibleCostsHelp =>
      'Kosten die aftrekbaar zijn voor de inkomstenbelasting, inclusief afschrijving en kilometervergoeding. Geschat.';

  @override
  String get dashboardEstimatedTaxHelp =>
      'Geschatte inkomstenbelasting en Zvw-bijdrage over je winst tot nu toe. Geen aanslag.';

  @override
  String get dashboardEstimatedTaxToPay => 'Geschatte belasting te betalen';

  @override
  String get dashboardEstimatedRefund => 'Geschatte teruggave';

  @override
  String get dashboardEstimatedTaxToPayHelp =>
      'Geschatte inkomstenbelasting en Zvw-bijdrage over je winst tot nu toe en je loon, min de ingehouden loonheffing. Geen aanslag.';

  @override
  String get dashboardNetProfitAfterTaxHelp =>
      'Winst min de geschatte belasting die de onderneming toevoegt. Een schatting, geen definitief bedrag.';

  @override
  String get expensesFieldCar => 'Auto van de zaak';

  @override
  String get expensesFieldCarHelp =>
      'Koppel kosten zoals brandstof en verzekering aan een auto van de zaak. Een gekoppelde kost telt volledig mee, want de bijtelling en de btw over privégebruik corrigeren het privégebruik. Gekoppelde kosten begrenzen de bijtelling en bepalen de btw over privégebruik.';

  @override
  String get expensesNoCar => 'Niet voor een auto van de zaak';

  @override
  String get mileageFieldVehicle => 'Voertuig';

  @override
  String get mileageFieldVehicleHelp =>
      'Een privévoertuig geeft de aftrek per km. Ritten in een auto van de zaak niet; die tellen voor de rittenregistratie van die auto.';

  @override
  String get mileagePrivateVehicle => 'Privévoertuig';

  @override
  String get inputPartnerHours => 'Uren van je partner in de onderneming';

  @override
  String inputPartnerHoursHelp(String pay, int hours) {
    return 'Uren die je fiscale partner dit jaar in je onderneming werkte zonder vergoeding of voor minder dan $pay. Vanaf $hours uur krijg je de meewerkaftrek.';
  }

  @override
  String get inputUnrealisedZelfs => 'Niet-gerealiseerde zelfstandigenaftrek';

  @override
  String inputUnrealisedZelfsHelp(int years) {
    return 'Zelfstandigenaftrek uit de vorige $years jaar die niet in je winst paste, zoals vastgesteld door de Belastingdienst. Wordt gebruikt tot de winst van dit jaar.';
  }

  @override
  String get inputLossCarryForward => 'Verliezen uit eerdere jaren';

  @override
  String get inputLossCarryForwardHelp =>
      'Verliezen in box 1 uit eerdere jaren die je nog mag verrekenen, zoals vastgesteld door de Belastingdienst. Verrekend met het inkomen van dit jaar.';

  @override
  String get inputEmployed => 'Ik werk dit jaar ook in loondienst';

  @override
  String get inputEmployedHelp =>
      'Loon telt in box 1 mee met je winst, en het urencriterium vergelijkt dan ook je uren in de onderneming met je uren in loondienst.';

  @override
  String get inputWages => 'Loon';

  @override
  String get inputWagesHelp =>
      'Het loon op je jaaropgaven: het belaste loon, niet het brutosalaris. Het telt in box 1 op bij je winst.';

  @override
  String get inputWageTaxWithheld => 'Ingehouden loonheffing';

  @override
  String get inputWageTaxWithheldHelp =>
      'De loonheffing op je jaaropgaven: de loonbelasting en premie volksverzekeringen die je werkgevers inhielden. De aangifte trekt die af van de belasting.';

  @override
  String get inputZvwWages => 'Loon Zvw';

  @override
  String get inputZvwWagesHelp =>
      'Het loon Zorgverzekeringswet op je jaaropgaven, waarover je werkgever de werkgeversheffing Zvw betaalde. Je betaalt de Zvw-bijdrage over je winst alleen tot het maximumbijdrage-inkomen min dit bedrag.';

  @override
  String get inputEmploymentHours => 'Uren in loondienst';

  @override
  String inputEmploymentHoursHelp(int years) {
    return 'De uren die je in het hele jaar in loondienst werkt. Het urencriterium vraagt ook meer tijd in de onderneming dan in ander werk, tenzij je in een of meer van de $years voorgaande jaren geen ondernemer was.';
  }

  @override
  String inputNotOndernemerBefore(int years) {
    return 'Ik was in een of meer van de $years voorgaande jaren geen ondernemer';
  }

  @override
  String get inputNotOndernemerBeforeHelp =>
      'Dan vraagt het urencriterium niet meer tijd in de onderneming dan in je baan. Dat geldt al als je recht hebt op startersaftrek.';

  @override
  String get inputSoVerklaring => 'Ik heb een S&O-verklaring voor dit jaar';

  @override
  String inputSoVerklaringHelp(int hours) {
    return 'Een S&O-verklaring van RVO voor speur- en ontwikkelingswerk. Met minstens $hours WBSO-uren krijg je de S&O-aftrek.';
  }

  @override
  String get inputSoStarter => 'Startersverhoging S&O-aftrek';

  @override
  String inputSoStarterHelp(int years, int max) {
    return 'Je was in een of meer van de $years voorgaande jaren geen ondernemer en kreeg in die periode voor hoogstens $max jaar een S&O-verklaring.';
  }

  @override
  String get inputBusinessCeased =>
      'Ik ben dit jaar met de hele onderneming gestopt';

  @override
  String get inputBusinessCeasedHelp =>
      'Winst op het verkopen of overnemen van de bedrijfsmiddelen is stakingswinst. Daarop krijg je de stakingsaftrek, en een herinvesteringsreserve telt bij je winst.';

  @override
  String get inputStakingsUsedBefore => 'Eerder gebruikte stakingsaftrek';

  @override
  String inputStakingsUsedBeforeHelp(String max) {
    return 'Stakingsaftrek die je in eerdere jaren kreeg. Verlaagt het maximum van $max.';
  }

  @override
  String get inputDisabilityBenefit =>
      'Ik heb een arbeidsongeschiktheidsuitkering';

  @override
  String inputDisabilityBenefitHelp(int reduced, int hours) {
    return 'Een uitkering zoals WIA, WAO, WAZ of Wajong. Als starter met minstens $reduced maar minder dan $hours uur kun je de startersaftrek bij arbeidsongeschiktheid krijgen.';
  }

  @override
  String get inputDisabilityUsed => 'Jaren gebruikt in de vorige 5';

  @override
  String inputDisabilityUsedHelp(int years, int max) {
    return 'In hoeveel van de vorige $years jaar je de startersaftrek bij arbeidsongeschiktheid kreeg, van 0 tot $max.';
  }

  @override
  String inputWholeNumber(int max) {
    return 'Voer een heel getal in van 0 tot en met $max';
  }

  @override
  String get pensionAowFranchiseHelp =>
      'Het deel van je inkomen waarover je al AOW opbouwt. De jaarruimte wordt alleen berekend over inkomen daarboven.';

  @override
  String get pensionPensioengrondslagHelp =>
      'Het inkomen van vorig jaar min de AOW-franchise, tot het wettelijke maximum.';

  @override
  String pensionJaarruimteHelp(String pct) {
    return '$pct van de premiegrondslag min een veelvoud van factor A, tot het jaarlijkse maximum. Wat je dit jaar voor een lijfrente mag aftrekken.';
  }

  @override
  String get pensionEstimatedTaxSavingHelp =>
      'Geschat: de box 1-belasting die je bespaart door de premie af te trekken, vóór heffingskortingen.';

  @override
  String get plTaxAlgHeffingHelp =>
      'Een heffingskorting die iedereen krijgt. Wordt lager naarmate het inkomen boven een grens stijgt.';

  @override
  String get plTaxArbeidskortingHelp =>
      'Een heffingskorting voor werkenden, op basis van de winst vóór ondernemersaftrek en mkb-winstvrijstelling plus je loon.';

  @override
  String get plTaxAovHelp =>
      'Premies voor een particuliere arbeidsongeschiktheidsverzekering zijn volledig aftrekbaar van het inkomen in box 1.';

  @override
  String get plTaxBelastbareWinstHelp =>
      'Winst na ondernemersaftrek en mkb-winstvrijstelling. De Zvw-bijdrage gaat hiervan uit.';

  @override
  String get plTaxWages => 'Loon uit dienstbetrekking';

  @override
  String get plTaxWagesHelp =>
      'Het loon dat je hieronder invulde. Het is inkomen in box 1, net als de winst, dus het verhoogt het tarief over de winst en verlaagt de algemene heffingskorting.';

  @override
  String get plTaxBox1SectionHelp =>
      'Geschatte inkomstenbelasting inclusief premies volksverzekeringen, per schijf, min de heffingskortingen.';

  @override
  String get plTaxCarPrivateUse => 'Privégebruik auto van de zaak';

  @override
  String plTaxCarPrivateUseHelp(int km) {
    return 'De bijtelling: een percentage van de cataloguswaarde dat bij de winst telt voor privégebruik, hoogstens de autokosten. Geen bijtelling met een rittenregistratie van $km privékilometers per jaar of minder.';
  }

  @override
  String plTaxDeductionsSectionHelp(int hours) {
    return 'Aftrekposten voor ondernemers. De meeste vereisen het urencriterium van $hours uur.';
  }

  @override
  String get plTaxDepreciationHelp =>
      'Het deel van de kosten van je bedrijfsmiddelen dat dit jaar wordt afgeschreven, per dag verdeeld over de levensduur.';

  @override
  String get plTaxDesinvestering => 'Desinvesteringsbijtelling';

  @override
  String plTaxDesinvesteringHelp(int years) {
    return 'Deel van een investeringsaftrek dat terugkomt omdat een bedrijfsmiddel binnen $years jaar na het begin van het jaar van aankoop is verkocht.';
  }

  @override
  String get plTaxDisabilityStarters =>
      'Startersaftrek bij arbeidsongeschiktheid';

  @override
  String plTaxDisabilityStartersHelp(int hours) {
    return 'Voor starters met een arbeidsongeschiktheidsuitkering die minstens $hours uur werken maar niet aan het urencriterium voldoen. Hoogstens de winst.';
  }

  @override
  String get plTaxDisposalResultHelp =>
      'Verkoopprijs min boekwaarde van bedrijfsmiddelen die dit jaar zijn verkocht. Winst telt erbij, verlies gaat eraf.';

  @override
  String get plTaxEia => 'Energie-investeringsaftrek (EIA)';

  @override
  String get plTaxEiaHelp =>
      'Een extra aftrek voor investeringen op de Energielijst van RVO.';

  @override
  String plTaxFoodLimitedHelp(String pct, String drempel) {
    return 'Voedsel, drank, representatie, congressen, seminars en studiereizen zijn voor $pct% aftrekbaar, of boven de eerste $drempel (Wet IB 2001 art. 3.15). Florin neemt wat de grootste aftrek geeft.';
  }

  @override
  String plTaxInputsSection(int year) {
    return 'Jouw situatie in $year';
  }

  @override
  String get plTaxInputsSectionHelp =>
      'Gegevens die de administratie niet laat zien. Ze veranderen de schatting hierboven.';

  @override
  String plTaxEmploymentSection(int year) {
    return 'Loondienst in $year';
  }

  @override
  String get plTaxEmploymentSectionHelp =>
      'Als je ook in loondienst werkt. Vul de totalen van al je jaaropgaven van het jaar in. Tijdens het jaar vul je in wat je voor het hele jaar verwacht.';

  @override
  String get plTaxInvestmentSection => 'Investeringsaftrek';

  @override
  String get plTaxInvestmentSectionHelp =>
      'Extra aftrek voor bedrijfsmiddelen die dit jaar zijn gekocht.';

  @override
  String get plTaxKiaHelp =>
      'Kleinschaligheidsinvesteringsaftrek: een percentage of vast bedrag op basis van je totale investeringen die meetellen dit jaar.';

  @override
  String get plTaxLijrenteHelp =>
      'Premies voor een lijfrente, afgetrokken tot je jaarruimte en reserveringsruimte.';

  @override
  String get plTaxLossOffset => 'Verliezen uit eerdere jaren';

  @override
  String get plTaxLossOffsetHelp =>
      'Verliezen in box 1 uit eerdere jaren, verrekend met het inkomen van dit jaar.';

  @override
  String get plTaxMeewerk => 'Meewerkaftrek';

  @override
  String plTaxMeewerkHelp(int hours) {
    return 'Een percentage van de winst als je fiscale partner minstens $hours uur zonder vergoeding in de onderneming werkt.';
  }

  @override
  String get plTaxMia => 'Milieu-investeringsaftrek (MIA)';

  @override
  String get plTaxMiaHelp =>
      'Een extra aftrek voor investeringen op de Milieulijst van RVO.';

  @override
  String get plTaxMileageAllowanceHelp =>
      'Zakelijke en woon-werkkilometers met een privévoertuig, tegen het tarief per km van de Belastingdienst.';

  @override
  String get plTaxMkbHelp =>
      'Een percentage van de winst na ondernemersaftrek dat is vrijgesteld. Het urencriterium is niet nodig.';

  @override
  String get plTaxProfit => 'Winst';

  @override
  String get plTaxProfitHelp =>
      'Winst uit onderneming vóór ondernemersaftrek. De arbeidskorting gaat hiervan uit, samen met eventueel loon.';

  @override
  String get plTaxReserveReleased => 'Vrijval herinvesteringsreserve';

  @override
  String plTaxReserveReleasedHelp(int years) {
    return 'Reserve die niet binnen $years jaar is gebruikt, of overblijft als de onderneming stopt, telt bij de winst.';
  }

  @override
  String get plTaxSo => 'S&O-aftrek';

  @override
  String plTaxSoHelp(int hours) {
    return 'Voor speur- en ontwikkelingswerk met een S&O-verklaring en minstens $hours uur.';
  }

  @override
  String get plTaxStakings => 'Stakingsaftrek';

  @override
  String plTaxStakingsHelp(String max) {
    return 'Een aftrek op de winst bij het stoppen van de hele onderneming, tot $max over je hele leven.';
  }

  @override
  String get plTaxStartersaftrekHelp =>
      'Een extra aftrek bovenop de zelfstandigenaftrek voor ondernemers die net zijn begonnen.';

  @override
  String get plTaxTaxableProfitHelp =>
      'Het inkomen in box 1 waarover de belasting wordt berekend: belastbare winst plus loon, min de aftrekposten hierboven.';

  @override
  String get plTaxUnrealisedZelfs => 'Niet-gerealiseerde zelfstandigenaftrek';

  @override
  String get plTaxUnrealisedZelfsHelp =>
      'Zelfstandigenaftrek uit eerdere jaren die toen niet in de winst paste, gebruikt tot de winst van dit jaar.';

  @override
  String get plTaxZelfstandigenaftrekHelp =>
      'Een vaste aftrek voor ondernemers die aan het urencriterium voldoen. Hoogstens de winst, tenzij je starter bent.';

  @override
  String get plTaxZvwHelp =>
      'De inkomensafhankelijke bijdrage Zorgverzekeringswet, over de belastbare winst tot een maximum. Het loon Zvw waarover je werkgever de werkgeversheffing betaalde, verlaagt dat maximum.';

  @override
  String get vatReturnIcpSectionHelp =>
      'Leveringen aan ondernemers in andere EU-landen, apart opgegeven in de ICP-opgaaf. Zolang je meedoet aan de KOR doe je geen ICP-opgaaf, dus facturen van die datums staan er niet in.';

  @override
  String vatRow1aHelp(String rate) {
    return 'Omzet belast met $rate en de btw daarover.';
  }

  @override
  String vatRow1bHelp(String rate) {
    return 'Omzet belast met $rate en de btw daarover.';
  }

  @override
  String get vatRow1d => '1d  Privégebruik';

  @override
  String vatRow1dHelp(String rate, String reduced) {
    return 'Btw over privégebruik van auto\'s van de zaak: $rate of $reduced van de cataloguswaarde, of het werkelijke privédeel met een rittenregistratie. Alleen in de laatste aangifte van het jaar.';
  }

  @override
  String get vatRow1eHelp =>
      'Omzet tegen 0% of waarbij de btw is verlegd naar een Nederlandse ondernemer.';

  @override
  String get vatRow3aHelp =>
      'Uitvoer van goederen naar landen buiten de EU. Diensten aan ondernemers buiten de EU geef je niet aan.';

  @override
  String get vatRow3bHelp =>
      'Goederen en diensten aan ondernemers in andere EU-landen.';

  @override
  String get vatRow5aHelp =>
      'De btw die je verschuldigd bent over je omzet en privégebruik.';

  @override
  String get vatRow5bHelp => 'De btw op zakelijke kosten die je mag aftrekken.';

  @override
  String get clientsSearchHelp => 'Zoek klanten op naam.';

  @override
  String get invoicesSearchHelp => 'Zoek op factuurnummer of klantnaam.';

  @override
  String get expensesFieldPurchaseVat => 'Btw op deze aankoop';

  @override
  String get expensesFieldPurchaseVatHelp =>
      'Nederlandse btw als de leverancier die rekende. Verlegd als op de factuur staat dat de btw naar jou is verlegd, of als de leverancier in het buitenland zit: je geeft de btw dan zelf aan en trekt hem weer af.';

  @override
  String get purchaseVatDomestic => 'Gerekend door de leverancier';

  @override
  String get purchaseVatReverseChargeNl =>
      'Naar mij verlegd door een Nederlandse leverancier (2a)';

  @override
  String get purchaseVatFromEu =>
      'Van een leverancier in een ander EU-land (4b)';

  @override
  String get purchaseVatFromOutsideEu =>
      'Dienst van een leverancier buiten de EU (4a)';

  @override
  String get vatReturnShiftedSection => 'Naar jou verlegde btw';

  @override
  String get vatReturnShiftedSectionHelp =>
      'Aankopen waarover je zelf de btw aangeeft. Dezelfde btw trek je af bij 5b, dus per saldo betaal je meestal niets.';

  @override
  String get vatRow2a => '2a  Verleggingsregelingen binnenland';

  @override
  String get vatRow2aHelp =>
      'Aankopen bij Nederlandse leveranciers die de btw naar jou verlegden.';

  @override
  String get vatRow4a => '4a  Leveringen / diensten uit landen buiten de EU';

  @override
  String get vatRow4aHelp => 'Diensten van leveranciers buiten de EU.';

  @override
  String get vatRow4b => '4b  Leveringen / diensten uit landen binnen de EU';

  @override
  String get vatRow4bHelp =>
      'Goederen en diensten van leveranciers in andere EU-landen.';

  @override
  String vatBaseAndVat(String base, String vat) {
    return '$base, btw $vat';
  }

  @override
  String get expensesBusinessUseHelp =>
      'Het deel dat zakelijk wordt gebruikt. Alleen dat deel van de kosten en btw is aftrekbaar.';

  @override
  String get settingsLanguageSectionHelp =>
      'De taal van de app. Facturen en CSV-exports zijn altijd in het Nederlands.';

  @override
  String get vatTreatmentServicesOutsideEu =>
      'Diensten aan ondernemer buiten de EU (niet in de btw-aangifte)';

  @override
  String get invoiceValidateTreatmentCountry =>
      'Deze btw-behandeling past niet bij het land van de klant. Btw verlegd binnenland is voor Nederlandse klanten, de EU-behandelingen voor andere EU-landen en de behandelingen buiten de EU voor landen daarbuiten.';

  @override
  String get invoiceSelfBilled => 'Uitgereikt door afnemer (self-billing)';

  @override
  String get invoiceSelfBilledHelp =>
      'Vink aan als de klant, zoals een wederverkoper, de factuur maakt voor wat hij je verschuldigd is. De wet staat dit toe als jullie dat vooraf hebben afgesproken en je elke factuur aanvaardt. Florin legt hem vast met het nummer van de klant en maakt geen pdf: het document van de klant is de factuur.';

  @override
  String get invoiceFieldNumberSelfBilledHelp =>
      'Het nummer op de factuur die de klant aan jou heeft uitgereikt.';

  @override
  String get invoiceActionRecord => 'Vastleggen';

  @override
  String get invoiceRecordTitle => 'Factuur vastleggen';

  @override
  String get invoiceRecordMessage =>
      'Na vastleggen kan de factuur niet meer worden gewijzigd of verwijderd. Een correctie is een creditnota die deze factuur noemt.';

  @override
  String get invoiceStatusSelfBilled => 'Uitgereikt door afnemer';

  @override
  String invoiceMerchantOfRecordNotice(String name) {
    return '$name is een merchant of record: verkoopt jouw product aan eindklanten en betaalt jou. Factureer voor wat je voor die verkopen tegoed hebt. Eén factuur mag meerdere verkopen over ten hoogste één kalendermaand bevatten. Florin legt bedragen vast in euro\'s: bij een uitbetaling in een andere valuta vul je de bedragen in euro\'s in en bewaar je het overzicht van de wederverkoper.';
  }

  @override
  String get invoicePaidDateTitle => 'Datum betaald';

  @override
  String get clientsMerchantOfRecord => 'Merchant of record (wederverkoper)';

  @override
  String get clientsMerchantOfRecordHelp =>
      'Vink aan voor een platform dat jouw product op eigen naam aan eindklanten verkoopt en jou betaalt, zoals een merchant of record of een app store. Het platform is de verkoper tegenover de eindklanten, dus je factureert alleen aan het platform. Het onderdeel Wet DBA gaat over arbeidsrelaties en is verborgen bij een wederverkoper.';

  @override
  String get clientsBadgeMerchantOfRecord => 'Merchant of record';

  @override
  String get vatRowOutsideReturn =>
      'Diensten aan ondernemers buiten de EU (niet in de aangifte)';

  @override
  String get vatRowOutsideReturnHelp =>
      'Omzet uit diensten aan ondernemers buiten de EU. Volgens de Belastingdienst geef je die niet aan in de Nederlandse aangifte als de dienst buiten de EU is belast. Getoond zodat je ziet waar die omzet is gebleven.';

  @override
  String get vatShortReverseCharge => 'Verlegd';

  @override
  String get vatShortNotTaxedNl => 'Niet in NL belast';

  @override
  String get invoiceValidateNumberSelfBilled =>
      'Vul het nummer in van de factuur die de klant heeft uitgereikt, zodat hij naar die factuur te herleiden is.';

  @override
  String get amountInvalidError =>
      'Vul een bedrag in euro\'s in, zoals 1.234,50, met een komma voor de centen en ten hoogste twee decimalen.';

  @override
  String get amountRequiredError =>
      'Vul een bedrag boven nul in: een registratie zonder bedrag telt niet mee in je cijfers.';

  @override
  String clientsValidateVatCountry(String prefix) {
    return 'Een btw-id van een klant in dit land begint met $prefix. Controleer het nummer of het land: de ICP-opgaaf vermeldt ze samen.';
  }

  @override
  String hoursValidateDayTotal(String logged, String left) {
    return 'Op deze dag staan al $logged uur. Een dag heeft 24 uur, dus vul hoogstens $left in.';
  }

  @override
  String get assetsValidateDisposalBeforePurchase =>
      'De verkoopdatum ligt voor de aanschafdatum. Pas er een aan: een bedrijfsmiddel wordt verkocht nadat het is gekocht.';

  @override
  String invoiceValidateCreditDate(String date) {
    return 'Een creditnota is gedateerd op of na de factuur die hij corrigeert, en die is van $date.';
  }

  @override
  String invoiceValidateCreditAboveInvoice(String number, String amount) {
    return 'Deze creditnota is meer dan er op factuur $number nog te corrigeren is: hoogstens $amount exclusief btw. Een creditnota kan alleen terugdraaien wat is gefactureerd.';
  }

  @override
  String get vatTreatmentKor =>
      'Vrijgesteld, kleineondernemersregeling (geen btw op de factuur)';

  @override
  String get vatShortKor => 'KOR-vrijgesteld';

  @override
  String get vatRowKorExempt =>
      'Vrijgesteld onder de KOR (niet in de aangifte)';

  @override
  String get vatRowKorExemptHelp =>
      'Omzet die vrijgesteld is onder de kleineondernemersregeling. Je hebt er geen btw over berekend en je geeft hem niet aan.';

  @override
  String get invoiceValidateKorNotActive =>
      'De KOR geldt niet op deze datum: je doet niet mee, of je omzet is boven de grens gekomen. Kies de behandeling die past, meestal Nederlandse btw.';

  @override
  String get invoiceValidateKorTreatment =>
      'Je doet op deze datum mee aan de KOR: je berekent geen btw en de factuur mag die niet vermelden. Kies Vrijgesteld, kleineondernemersregeling.';

  @override
  String invoiceValidateKorExceeded(String limit) {
    return 'Met deze factuur komt je omzet voor de KOR boven $limit. De KOR eindigt met deze levering, dus die is belast met btw: kies Nederlandse btw en meld je af voor de KOR in Mijn Belastingdienst Zakelijk.';
  }

  @override
  String get expensesValidateKorReclaim =>
      'Je doet op deze datum mee aan de KOR, dus je kunt geen btw op inkopen terugvragen. Vink BTW terugvragen uit: de btw telt dan mee als kosten.';

  @override
  String get expensesKorNotice =>
      'Je doet op deze datum mee aan de KOR. Btw op inkopen vraag je niet terug; die telt mee als kosten voor de inkomstenbelasting.';

  @override
  String get settingsKorStart => 'KOR geldt vanaf';

  @override
  String settingsKorStartHelp(String limit) {
    return 'De eerste dag waarop de kleineondernemersregeling (KOR) voor je geldt, zoals in de bevestiging van de Belastingdienst. Tot die datum doe je elke aangifte zoals gewoonlijk. Onder de KOR bereken je geen btw, doe je geen gewone btw-aangifte en vraag je geen btw terug, zolang je omzet in Nederland hoogstens $limit per jaar is. Laat leeg als je niet meedoet.';
  }

  @override
  String get settingsKorEnd => 'KOR beëindigd op';

  @override
  String get settingsKorEndHelp =>
      'De eerste dag waarop de KOR niet meer geldt nadat je je zelf hebt afgemeld. Laat anders leeg: als je omzet boven de grens komt, beëindigt Florin de KOR vanaf die factuur.';

  @override
  String get settingsValidateKorStart =>
      'De KOR begint op de eerste dag van een aangiftetijdvak, dus vul de 1e van een maand in, zoals in de bevestiging van de Belastingdienst.';

  @override
  String get settingsValidateKorEndDay =>
      'Een afmelding gaat in op de eerste dag van een aangiftetijdvak, dus vul de 1e van een maand in.';

  @override
  String get settingsValidateKorEndBeforeStart =>
      'Het einde van de KOR ligt na het begin. Controleer beide datums.';

  @override
  String get settingsKorClear => 'Ik doe niet mee aan de KOR';

  @override
  String korProgress(String turnover, String limit) {
    return '$turnover van $limit';
  }

  @override
  String korExceededBadge(String date) {
    return 'Grens overschreden op $date';
  }

  @override
  String korLeftBadge(String left) {
    return '$left onder de grens';
  }

  @override
  String get dashboardKor => 'Omzet voor de KOR';

  @override
  String dashboardKorHelp(String limit) {
    return 'Je omzet die meetelt voor de kleineondernemersregeling: prestaties belast in Nederland, ook 0% en verlegging binnenland, niet diensten die in het buitenland belast zijn. Boven $limit in een kalenderjaar eindigt de KOR met de levering die de grens overschrijdt, voor de rest van dat jaar en het jaar erna. De KOR gaat niet vanzelf: hij geldt pas als je je aanmeldt en de Belastingdienst de ingangsdatum bevestigt. Tot dan doe je elk kwartaal aangifte, hoe laag je omzet ook is.';
  }

  @override
  String get deadlineStatusKor => 'geen aangifte (KOR)';

  @override
  String get deadlineStatusIncidental => 'incidentele aangifte';

  @override
  String get deadlineBadgeKor => 'Geen aangifte: KOR';

  @override
  String get deadlineBadgeIncidental => 'Incidentele aangifte nodig';

  @override
  String get vatReturnKorNotice =>
      'Je doet dit hele kwartaal mee aan de KOR en bent er geen btw over verschuldigd, dus je doet geen aangifte. Stuurt de Belastingdienst je toch een aangifte, dien die dan in.';

  @override
  String get vatReturnKorPartNotice =>
      'De KOR geldt voor een deel van dit kwartaal. Facturen die onder de KOR zijn vrijgesteld staan niet in de aangifte en btw op inkopen in dat deel vraag je niet terug. Doe aangifte voor het deel buiten de KOR.';

  @override
  String get vatReturnKorIncidentalNotice =>
      'Je doet dit hele kwartaal mee aan de KOR, maar je bent er btw over verschuldigd, zoals btw die naar je is verlegd (2a, 4a of 4b) en die je niet aftrekt. Daarom doe je over dit kwartaal aangifte. De Belastingdienst stuurt die niet vanzelf: vraag hem schriftelijk aan bij je belastingkantoor zodra het kwartaal voorbij is. Florin toont de gewone termijn als datum om aan te houden.';

  @override
  String get vatReturnNilNotice =>
      'Niets aan te geven dit kwartaal. Je doet toch op tijd aangifte: een nihilaangifte (0-aangifte). Zonder aangifte stuurt de Belastingdienst een naheffingsaanslag en een boete.';

  @override
  String vatReturnKorExceeded(String date, String limit) {
    return 'Je omzet voor de KOR kwam op $date boven $limit. De KOR eindigde met die levering: vanaf dan bereken je btw en doe je aangifte. Meld je af in Mijn Belastingdienst Zakelijk; je kunt dit jaar en volgend jaar niet opnieuw meedoen.';
  }

  @override
  String get errorDuplicate =>
      'Een andere registratie gebruikt deze waarde al, zoals hetzelfde factuurnummer. Gebruik een waarde die nog niet bestaat.';

  @override
  String get errorInUse =>
      'Andere registraties verwijzen naar deze, zoals facturen van een klant. Verwijder of wijzig die eerst, of zet deze op inactief.';

  @override
  String get errorBusy =>
      'De database wordt door een ander programma gebruikt. Sluit dat programma, of wacht even, en probeer het opnieuw.';

  @override
  String get errorReadOnly =>
      'Het databasebestand kan niet worden beschreven. Controleer of de map niet alleen-lezen is en of je er rechten op hebt.';

  @override
  String get errorCorrupt =>
      'Het databasebestand is beschadigd en kan niet worden gelezen. Zet het terug uit een back-up, zoals de geschiedenis van iCloud Drive, OneDrive of Dropbox.';

  @override
  String get errorDiskFull =>
      'De schijf is vol. Maak ruimte vrij en probeer het opnieuw.';

  @override
  String get errorCannotOpen =>
      'Het databasebestand kan niet worden geopend. Controleer of de map nog bestaat, of kies de locatie opnieuw in Instellingen.';

  @override
  String errorFile(String path, String reason) {
    return 'Kon $path niet gebruiken: $reason';
  }

  @override
  String genericUnhandledError(String error) {
    return 'Er ging iets mis: $error';
  }

  @override
  String get invoiceNoProfile =>
      'Vul eerst je bedrijfsgegevens in bij Instellingen: elke factuur toont ze.';

  @override
  String get invoiceTotal => 'Totaal';

  @override
  String get settingsTaxKor => 'Omzetgrens KOR';

  @override
  String get settingsKorSection => 'Kleineondernemersregeling (KOR)';

  @override
  String settingsKorSectionHelp(String limit) {
    return 'Een btw-vrijstelling voor ondernemers met hoogstens $limit omzet in Nederland per jaar. Hij gaat niet vanzelf: je meldt je aan en af bij de Belastingdienst, en zonder KOR doe je elk kwartaal aangifte. Vul hier de datums in zodat Florin hem volgt.';
  }

  @override
  String get receiptTypeEInvoice => 'E-factuur (UBL)';

  @override
  String get receiptsTitle => 'Bonnen';

  @override
  String receiptsHelp(int years) {
    return 'De bon of factuur van deze uitgave, als pdf, foto of scan. Florin kopieert hem naar de map met bonnen naast je database en laat je eigen bestand ongemoeid. De Belastingdienst vraagt bonnen en facturen $years jaar te bewaren in de vorm waarin je ze ontving; een scan of foto moet een juiste en volledige weergave van het origineel zijn, met de echtheidskenmerken.';
  }

  @override
  String get receiptsAssetTitle => 'Aankoopfactuur en bonnen';

  @override
  String receiptsAssetHelp(int years) {
    return 'De aankoopfactuur van dit bedrijfsmiddel en ander bewijs, als pdf, foto of scan. Die hoort in je administratie zolang je het bedrijfsmiddel gebruikt, en $years jaar daarna.';
  }

  @override
  String get receiptsInvoiceTitle => 'Documenten';

  @override
  String get receiptsInvoiceHelp =>
      'De pdf van deze factuur precies zoals Florin hem maakte toen je hem uitreikte, bewaard zoals verstuurd. Voeg bij een factuur die je klant uitreikte hier zijn document toe.';

  @override
  String get receiptsNone =>
      'Nog geen bestanden. Sleep pdf\'s, foto\'s of scans hierheen, of voeg ze toe.';

  @override
  String get receiptsAdd => 'Bestanden toevoegen';

  @override
  String get receiptsPickDialog => 'Kies bonnen';

  @override
  String get receiptsOpen => 'Openen';

  @override
  String get receiptsRemove => 'Van deze registratie halen';

  @override
  String get receiptsUnstage => 'Niet toevoegen';

  @override
  String get receiptsRemoved =>
      'Verwijderd. Florin bewaart het bestand onder Verwijderde bonnen in Instellingen.';

  @override
  String get receiptsUndo => 'Ongedaan maken';

  @override
  String get receiptsStaged => 'Wordt opgeslagen als je bewaart';

  @override
  String receiptsAdded(String date) {
    return 'toegevoegd $date';
  }

  @override
  String get receiptsMissing =>
      'Het bestand ontbreekt in de map met bonnen. Zet het terug uit een back-up.';

  @override
  String get receiptsKeepUntil => 'Bewaren tot';

  @override
  String receiptsKeepUntilHelp(int years) {
    return 'De Belastingdienst vraagt facturen en bonnen $years jaar te bewaren. Florin telt vanaf het einde van het jaar waar ze bij horen en verwijdert ze nooit.';
  }

  @override
  String receiptsKeepWhileInUse(int years) {
    return 'Zolang in gebruik, daarna $years jaar';
  }

  @override
  String receiptsRejectedEmpty(String name) {
    return '$name is leeg. Kies het bestand opnieuw.';
  }

  @override
  String receiptsRejectedTooLarge(String name, String max) {
    return '$name is groter dan $max. Sla de scan op met een lagere resolutie, met elke pagina leesbaar, en voeg hem opnieuw toe.';
  }

  @override
  String receiptsRejectedType(String name) {
    return '$name is geen pdf, JPEG, PNG, HEIC, TIFF of UBL-e-factuur. Sla hem op of druk hem af als pdf en voeg hem opnieuw toe.';
  }

  @override
  String receiptsDuplicate(String name) {
    return '$name is al opgeslagen bij een andere registratie. Hij is hier ook toegevoegd.';
  }

  @override
  String receiptsOpenFailed(String name) {
    return 'Kon $name niet openen. Open hem vanuit de map met bonnen.';
  }

  @override
  String get expensesPaperOriginalKept => 'Papieren origineel bewaard';

  @override
  String get expensesPaperOriginalKeptHelp =>
      'Vink aan als je de papieren bon of factuur zelf bewaart, bijvoorbeeld een kassabon die je niet hebt gescand. Je hebt bewijs nodig om btw terug te vragen en de kosten aan te tonen; een bestand hierboven telt ook.';

  @override
  String get expensesHasFiles => 'Bon opgeslagen in Florin';

  @override
  String get expensesPaperOnly => 'Papieren origineel bewaard';

  @override
  String get receiptsNotStored =>
      'Voor deze factuur is geen pdf opgeslagen. Florin slaat hem op zodra je hem voor het eerst exporteert.';

  @override
  String get settingsReceiptsSection => 'Bonnen';

  @override
  String get settingsReceiptsSectionHelp =>
      'Florin bewaart de bonnen van uitgaven en bedrijfsmiddelen, en de pdf\'s van verstuurde facturen, in een map met bonnen naast de database. Florin verwijdert ze nooit: een verwijderde bon blijft onder Verwijderde bonnen. De map verhuist mee met de database en hoort in dezelfde back-up.';

  @override
  String settingsReceiptsLocation(String path) {
    return 'Map: $path';
  }

  @override
  String settingsReceiptsCount(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bestanden',
      one: '1 bestand',
    );
    return '$_temp0, $size';
  }

  @override
  String get settingsReceiptsShowFolder => 'Map tonen';

  @override
  String get settingsReceiptsCheck => 'Bestanden controleren';

  @override
  String get settingsReceiptsChecking => 'Bezig met controleren';

  @override
  String settingsReceiptsAllOk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Alle $count bestanden zijn aanwezig en ongewijzigd.',
      one: 'Het bestand is aanwezig en ongewijzigd.',
      zero: 'Geen bestanden om te controleren.',
    );
    return '$_temp0';
  }

  @override
  String settingsReceiptsProblems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bestanden vragen aandacht. Zet ze terug uit een back-up:',
      one: '1 bestand vraagt aandacht. Zet het terug uit een back-up:',
    );
    return '$_temp0';
  }

  @override
  String get settingsReceiptMissing => 'ontbreekt';

  @override
  String get settingsReceiptChanged => 'gewijzigd sinds het werd toegevoegd';

  @override
  String get settingsReceiptsOpenFailed => 'De map kon niet worden geopend';

  @override
  String get receiptOwnerExpense => 'Uitgave';

  @override
  String get receiptOwnerAsset => 'Bedrijfsmiddel';

  @override
  String get receiptOwnerInvoice => 'Factuur';

  @override
  String get removedReceiptsTitle => 'Verwijderde bonnen';

  @override
  String removedReceiptsNotice(String path) {
    return 'Bonnen die je van een registratie hebt gehaald, of waarvan de registratie is verwijderd. Florin verwijdert nooit een bon: de bestanden blijven in $path. Zet er een terug zolang de registratie bestaat.';
  }

  @override
  String get removedReceiptsNone => 'Geen verwijderde bonnen.';

  @override
  String removedReceiptsFrom(
    String kind,
    String date,
    String name,
    String removed,
  ) {
    return 'van $kind $date $name, verwijderd $removed';
  }

  @override
  String get removedReceiptsPutBack => 'Terugzetten op de registratie';

  @override
  String settingsRemovedReceipts(int count) {
    return 'Verwijderde bonnen ($count)';
  }
}
