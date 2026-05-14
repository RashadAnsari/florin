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
  String get actionConfirm => 'Bevestigen';

  @override
  String get actionAdd => 'Toevoegen';

  @override
  String get actionNew => 'Nieuw';

  @override
  String get labelRequired => 'Verplicht';

  @override
  String get labelDate => 'Datum';

  @override
  String get labelNotes => 'Opmerkingen';

  @override
  String get labelDescription => 'Omschrijving';

  @override
  String get labelAmount => 'Bedrag';

  @override
  String get labelAddress => 'Adres';

  @override
  String get labelName => 'Naam';

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
  String get dashboardNetProfitAfterTax => 'Netto winst na belasting';

  @override
  String get dashboardOutstandingInvoices => 'Openstaande facturen';

  @override
  String dashboardInvoiceCount(int count) {
    return '$count factuur/facturen';
  }

  @override
  String get dashboardUrencriterium => 'Urencriterium';

  @override
  String dashboardHoursProgress(String total, String target) {
    return '$total / $target uur';
  }

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
  String get invoicesSelectOrNew =>
      'Selecteer een factuur of maak een nieuwe aan';

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
  String get invoiceStatusCancelled => 'Geannuleerd';

  @override
  String get invoiceStatusRefunded => 'Terugbetaald';

  @override
  String get invoiceTypeInvoice => 'Factuur';

  @override
  String get invoiceTypeCreditNote => 'Creditnota';

  @override
  String get invoiceFieldType => 'Type';

  @override
  String get invoiceFieldClient => 'Klant *';

  @override
  String get invoiceFieldNumber => 'Factuurnummer *';

  @override
  String get invoiceFieldInvoiceDate => 'Factuurdatum *';

  @override
  String get invoiceFieldSupplyDate => 'Leveringsdatum';

  @override
  String get invoiceFieldPaymentTerm => 'Termijn (dagen) *';

  @override
  String get invoiceValidatePaymentTerm =>
      'Voer een heel aantal dagen in (bijv. 14 of 30)';

  @override
  String get invoiceFieldDueDate => 'Vervaldatum';

  @override
  String get invoiceFieldIcp => 'ICP (intracommunautair)';

  @override
  String get invoiceFieldBtwVerlegd => 'BTW verlegd';

  @override
  String get invoiceFieldLines => 'Regels';

  @override
  String get invoiceFieldAddLine => 'Regel toevoegen';

  @override
  String get invoiceFieldDescription => 'Omschrijving *';

  @override
  String get invoiceHintDescription => 'bijv. Advieswerk, webdesign...';

  @override
  String get invoiceFieldQuantity => 'Aantal *';

  @override
  String get invoiceFieldUnit => 'Eenheid';

  @override
  String get invoiceFieldPrice => 'Prijs (excl.) *';

  @override
  String get invoiceFieldVat => 'BTW';

  @override
  String get invoiceFieldVatAmount => 'BTW bedrag';

  @override
  String get invoiceFieldLineTotal => 'Totaal excl.';

  @override
  String invoiceVatLine(String rate) {
    return 'BTW $rate';
  }

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
  String get invoiceActionCancel => 'Annuleren';

  @override
  String get invoiceActionMarkRefunded => 'Terugbetaald';

  @override
  String get invoiceActionExportPdf => 'PDF exporteren';

  @override
  String get invoiceActionDelete => 'Verwijderen';

  @override
  String get invoiceDeleteTitle => 'Factuur verwijderen';

  @override
  String invoiceDeleteMessage(String number) {
    return 'Weet je zeker dat je factuur \"$number\" wilt verwijderen?';
  }

  @override
  String get invoiceCreated => 'Factuur aangemaakt';

  @override
  String get invoiceSaved => 'Factuur opgeslagen';

  @override
  String get invoiceDeleted => 'Factuur verwijderd';

  @override
  String get invoiceValidateClient => 'Selecteer een klant voor deze factuur';

  @override
  String get invoiceValidateNumber =>
      'Voer een uniek factuurnummer in, bijv. F-2024-001';

  @override
  String get invoiceUnitHint => 'uur';

  @override
  String get clientsTitle => 'Klanten';

  @override
  String get clientsNewTooltip => 'Nieuwe klant';

  @override
  String get clientsNone => 'Geen klanten';

  @override
  String get clientsSelectOrNew => 'Selecteer een klant of maak een nieuwe aan';

  @override
  String get clientsNewHeader => 'Nieuwe klant';

  @override
  String get clientsShowInactive => 'Toon inactief';

  @override
  String get clientsHideInactive => 'Verberg inactief';

  @override
  String get clientsFilterAll => 'Alle';

  @override
  String get clientsFilterActive => 'Actief';

  @override
  String get clientsFilterInactive => 'Inactief';

  @override
  String get clientsInactive => 'Inactief';

  @override
  String get clientsFieldName => 'Naam *';

  @override
  String get clientsValidateName => 'Voer de naam van de klant in';

  @override
  String get clientsFieldCountry => 'Land';

  @override
  String get clientsValidateCountry =>
      'Gebruik een landcode van 2 letters (bijv. NL, DE, FR)';

  @override
  String get clientsFieldVat => 'BTW-nummer';

  @override
  String get clientsValidateVat =>
      'Voer een geldig EU BTW-nummer in (bijv. NL854224798B01)';

  @override
  String get clientsFieldKvk => 'KVK-nummer';

  @override
  String get clientsValidateKvk => 'KVK-nummer moet exact 8 cijfers bevatten';

  @override
  String get clientsFieldAddress => 'Adres *';

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
      'Hoog Wet DBA-risico: zorg voor een geldige overeenkomst van opdracht.';

  @override
  String get clientsViesEmptyVat => 'Voer eerst een BTW-nummer in';

  @override
  String get clientsCreated => 'Klant aangemaakt';

  @override
  String get clientsSaved => 'Klant opgeslagen';

  @override
  String get clientsDeleteTitle => 'Klant verwijderen';

  @override
  String clientsDeleteMessage(String name) {
    return 'Weet je zeker dat je \"$name\" wilt verwijderen?';
  }

  @override
  String get clientsDeleteBlockedTitle => 'Kan klant niet verwijderen';

  @override
  String clientsDeleteBlockedMessage(String name) {
    return '\"$name\" heeft facturen en kan niet worden verwijderd.';
  }

  @override
  String get expensesTitle => 'Uitgaven';

  @override
  String get expensesNewTooltip => 'Nieuwe uitgave';

  @override
  String get expensesNone => 'Geen uitgaven';

  @override
  String get expensesSelectOrNew =>
      'Selecteer een uitgave of voeg een nieuwe toe';

  @override
  String get expensesNewHeader => 'Nieuwe uitgave';

  @override
  String get expensesFieldSupplier => 'Leverancier *';

  @override
  String get expensesHintSupplier => 'bijv. Albert Heijn, Amazon, KPN';

  @override
  String get expensesValidateSupplier => 'Voer de naam van de leverancier in';

  @override
  String get expensesFieldCategory => 'Categorie *';

  @override
  String get expensesValidateCategory =>
      'Selecteer een categorie voor deze uitgave';

  @override
  String get expensesFieldDescription => 'Omschrijving *';

  @override
  String get expensesValidateDescription =>
      'Voer een omschrijving voor deze uitgave in';

  @override
  String get expensesFieldAmountExcl => 'Bedrag (excl. BTW) *';

  @override
  String get expensesValidateAmount => 'Voer het bedrag exclusief BTW in';

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
      'bijv. INV-2024-0042, SEPA-kenmerk 123456';

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
  String expensesVatBackAmount(String amount) {
    return 'BTW terug: $amount';
  }

  @override
  String get expensesMixedCosts => 'Gemengde kosten';

  @override
  String get expensesReceiptAttached => 'Bon aanwezig';

  @override
  String get expensesBuaWarning =>
      'BUA: maaltijden & entertainment boven €227. BTW-aftrek mogelijk beperkt (Besluit Uitsluiting Aftrek).';

  @override
  String get expensesCreated => 'Uitgave aangemaakt';

  @override
  String get expensesSaved => 'Uitgave opgeslagen';

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
  String get expenseCatMeals => 'Maaltijden & entertainment';

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
  String get hoursSelectOrNew => 'Selecteer een invoer of klik +';

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
  String get hoursFieldDate => 'Datum *';

  @override
  String get hoursFieldHours => 'Uren *';

  @override
  String get hoursFieldDescription => 'Omschrijving *';

  @override
  String get hoursFieldWorkType => 'Type werk *';

  @override
  String get hoursFieldClientProject => 'Klant / project';

  @override
  String get hoursFieldNotes => 'Notities';

  @override
  String get hoursNewEntry => 'Nieuwe invoer';

  @override
  String get hoursEditEntry => 'Bewerk invoer';

  @override
  String get hoursDeleteTitle => 'Ureninvoer verwijderen';

  @override
  String hoursDeleteMessage(String description) {
    return 'Weet je zeker dat je \"$description\" wilt verwijderen?';
  }

  @override
  String get hoursValidateHours =>
      'Voer een aantal uren in dat groter is dan 0';

  @override
  String get hoursValidateDescription => 'Omschrijf het uitgevoerde werk';

  @override
  String get hoursValidateWorkType => 'Selecteer een type werk';

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
  String get mileageSelectOrNew => 'Selecteer een rit of klik +';

  @override
  String get mileageBusiness => 'Zakelijk';

  @override
  String get mileageTotal => 'Totaal';

  @override
  String get mileageUnitKm => 'km';

  @override
  String mileageAllowance(String rate) {
    return 'Aftrek (€$rate/km)';
  }

  @override
  String get mileageFieldDate => 'Datum *';

  @override
  String get mileageFieldMakeModel => 'Merk / model *';

  @override
  String get mileageFieldPlate => 'Kenteken *';

  @override
  String get mileageFieldFrom => 'Vertrekadres *';

  @override
  String get mileageFieldTo => 'Aankomstadres *';

  @override
  String get mileageFieldOdoStart => 'Km-stand begin *';

  @override
  String get mileageFieldOdoEnd => 'Km-stand eind *';

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
  String get mileageValidateTripType => 'Selecteer het type rit';

  @override
  String get mileageValidatePurpose => 'Omschrijf het doel van de rit';

  @override
  String get mileageFieldDistance => 'Afstand';

  @override
  String get mileageFieldTripType => 'Type rit *';

  @override
  String get mileageFieldPurpose => 'Doel *';

  @override
  String get mileageFieldRouteDeviation => 'Omweg / geen directe route';

  @override
  String get mileageFieldNotes => 'Notities';

  @override
  String get mileageNewTrip => 'Nieuwe rit';

  @override
  String get mileageEditTrip => 'Bewerk rit';

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
  String get assetsSelectOrNew => 'Selecteer een activum of klik +';

  @override
  String get assetsKiaInvestments => 'KIA-investeringen';

  @override
  String get assetsKiaDeduction => 'KIA-aftrek';

  @override
  String get assetsDepreciationThisYear => 'Afschrijving dit jaar';

  @override
  String get assetsFieldName => 'Naam activum *';

  @override
  String get assetsFieldCost => 'Kosten excl. BTW *';

  @override
  String get assetsFieldPurchaseDate => 'Aankoopdatum *';

  @override
  String assetsFieldBusinessUse(int pct) {
    return 'Zakelijk gebruik: $pct% *';
  }

  @override
  String get assetsFieldUsefulLife => 'Levensduur *';

  @override
  String get assetsFieldUsefulLifeUnit => 'jaar';

  @override
  String get assetsFieldUsefulLifeMin => 'Minimaal 1 jaar';

  @override
  String get assetsValidateName => 'Voer de naam van het activum in';

  @override
  String get assetsValidateCost => 'Voer de aanschafwaarde exclusief BTW in';

  @override
  String get assetsFieldKia => 'KIA-aanspraak';

  @override
  String get assetsKiaBadge => 'KIA';

  @override
  String get assetsFieldEiaMia => 'EIA / MIA';

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
  String get assetsEditAsset => 'Bewerk activum';

  @override
  String assetsYears(int n) {
    return '$n jaar';
  }

  @override
  String get pensionTitle => 'Pensioen';

  @override
  String pensionLoadError(String error) {
    return 'Kan pensioengegevens niet laden: $error';
  }

  @override
  String get pensionJaarruimte => 'Jaarruimteberekening';

  @override
  String get pensionTaxableProfit => 'Belastbare winst';

  @override
  String get pensionAowFranchise => 'AOW-franchise';

  @override
  String get pensionPensioengrondslag => 'Pensioengrondslag';

  @override
  String get pensionJaarruimte30 => 'Jaarruimte (30%)';

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
  String get pensionFactorAHelper => 'Pensioenopbouw bij werkgever / BV';

  @override
  String get pensionReserveringsruimteLabel =>
      'Reserveringsruimte (ongebruikte jaren)';

  @override
  String get pensionPlannedSection => 'Voorgenomen inleg';

  @override
  String get pensionLijfrente => 'Lijfrentepremie / AOV-premie';

  @override
  String get pensionLijfrenteHelper =>
      'Wordt als aftrekpost meegenomen in belastingberekening';

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
  String vatReturnIcpDeadline(String date) {
    return 'Deadline gelijk aan BTW-aangifte: $date.';
  }

  @override
  String get vatReturnStatusSection => 'Afhandelstatus';

  @override
  String get vatReturnFiled => 'Aangifte ingediend';

  @override
  String get vatReturnPaid => 'BTW betaald';

  @override
  String vatReturnYtdRevenue(String amount) {
    return 'YTD omzet: $amount';
  }

  @override
  String vatReturnLoadError(String error) {
    return 'Kan BTW-aangiftegegevens niet laden: $error';
  }

  @override
  String get vatReturnDue => 'Te betalen BTW';

  @override
  String get vatReturnRefund => 'Terug te ontvangen BTW';

  @override
  String vatReturnKorWarning(String ytd, String max) {
    return 'KOR-drempel bereikt ($ytd van $max). Factureer BTW vanaf de volgende transactie.';
  }

  @override
  String get vatRow1a => '1a  Leveringen / diensten belast met 21%';

  @override
  String get vatRow1b => '1b  Leveringen / diensten belast met 9%';

  @override
  String get vatRow1c => '1c  Leveringen / diensten belast met 0% (export)';

  @override
  String get vatRow3a => '3a  Leveringen naar EU-ondernemers (ICP / RC)';

  @override
  String get vatRow5a => '5a  BTW over omzet';

  @override
  String get vatRow5b => '5b  Voorbelasting (terug te vragen)';

  @override
  String get plTaxTitle => 'W&V / Belasting';

  @override
  String plTaxLoadError(String error) {
    return 'Kan W&V / belastinggegevens niet laden: $error';
  }

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
    return 'Kilometervergoeding (${km}km × €$rate)';
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
  String get plTaxTaxableProfit => 'Belastbare winst';

  @override
  String get plTaxBox1Section => 'Inkomstenbelasting box 1';

  @override
  String plTaxBracket1(String pct) {
    return 'Schijf 1 ($pct%)';
  }

  @override
  String plTaxBracket2(String pct) {
    return 'Schijf 2 ($pct%)';
  }

  @override
  String plTaxBracket3(String pct) {
    return 'Schijf 3 ($pct%)';
  }

  @override
  String get plTaxAlgHeffing => 'Algemene heffingskorting';

  @override
  String get plTaxArbeidskorting => 'Arbeidskorting';

  @override
  String plTaxDeduct(String label) {
    return 'Af: $label';
  }

  @override
  String plTaxMax(String amount) {
    return '(max $amount)';
  }

  @override
  String get plTaxInkomsten => 'Inkomstenbelasting';

  @override
  String plTaxZvw(String pct) {
    return 'ZVW-bijdrage ($pct%)';
  }

  @override
  String get plTaxTotalTax => 'Totaal belasting';

  @override
  String get plTaxNetProfit => 'Netto winst na belasting';

  @override
  String plTaxEffectiveRate(String rate) {
    return 'Effectief tarief: $rate%';
  }

  @override
  String get plTaxSettingsSection => 'Instellingen';

  @override
  String get plTaxClaimZelfs => 'Zelfstandigenaftrek claimen';

  @override
  String get plTaxClaimStarters => 'Startersaftrek claimen';

  @override
  String plTaxUrenBanner(String hours, String suffix) {
    return 'Urencriterium: $hours / 1.225 uur gelogd$suffix.';
  }

  @override
  String get plTaxUrenBannerSuffixDone => ', zelfstandigenaftrek vervalt';

  @override
  String get plTaxUrenBannerSuffixPending => ', nog niet bereikt';

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
  String get actionOk => 'OK';

  @override
  String get settingsSaved => 'Bedrijfsgegevens opgeslagen';

  @override
  String get settingsDatabaseSection => 'Database';

  @override
  String settingsDatabaseLocation(String path) {
    return 'Locatie: $path';
  }

  @override
  String get settingsDatabaseNotSet => 'Niet ingesteld';

  @override
  String get settingsMoveDatabase => 'Database verplaatsen…';

  @override
  String settingsDatabaseMoved(String path) {
    return 'Database verplaatst naar $path';
  }

  @override
  String get settingsExportSection => 'Exporteren';

  @override
  String settingsExportDescription(int year) {
    return 'Exporteer alle gegevens van $year naar CSV-bestanden.';
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
    return 'Belastingparameters $year';
  }

  @override
  String settingsTaxNoParams(int year) {
    return 'Geen parameters gevonden voor $year. Start de app opnieuw na het aanmaken van een database.';
  }

  @override
  String get settingsTaxRates => 'Tarieven & schijven';

  @override
  String get settingsTaxZelfs => 'Zelfstandigenaftrek';

  @override
  String get settingsTaxStarters => 'Startersaftrek';

  @override
  String get settingsTaxMkb => 'MKB-winstvrijstelling (%)';

  @override
  String get settingsTaxMileage => 'Kilometervergoeding (€/km)';

  @override
  String get settingsTaxBrackets => 'Schijven inkomstenbelasting';

  @override
  String get settingsTaxB1Rate => 'Schijf 1 tarief (%)';

  @override
  String get settingsTaxB1Thresh => 'Schijf 1 grens';

  @override
  String get settingsTaxB2Rate => 'Schijf 2 tarief (%)';

  @override
  String get settingsTaxB2Thresh => 'Schijf 2 grens';

  @override
  String get settingsTaxB3Rate => 'Schijf 3 tarief (%)';

  @override
  String get settingsTaxKortingen => 'Kortingen & ZVW';

  @override
  String get settingsTaxAlgHeff => 'Alg. heffingskorting max';

  @override
  String get settingsTaxArbeids => 'Arbeidskorting max';

  @override
  String get settingsTaxZvwRate => 'ZVW-tarief (%)';

  @override
  String get settingsTaxZvwMax => 'ZVW max';

  @override
  String get settingsTaxUrencriterium => 'Urencriterium';

  @override
  String get settingsTaxKia => 'KIA-aftrek';

  @override
  String get settingsTaxKiaLowerThresh => 'Ondergrens';

  @override
  String get settingsTaxKiaUpperThresh => 'Bovengrens';

  @override
  String get settingsTaxKiaFlatThresh => 'Vlakke drempel';

  @override
  String get settingsTaxKiaRate => 'KIA-percentage (%)';

  @override
  String get settingsTaxKiaFlatAmount => 'Vast bedrag';

  @override
  String get settingsTaxKiaDecreaseRate => 'Afnamerate (%)';

  @override
  String get settingsTaxKor => 'KOR-drempel';

  @override
  String get settingsTaxKorThresh => 'KOR-drempel';

  @override
  String get settingsTaxSaveParams => 'Parameters opslaan';

  @override
  String settingsTaxParamsSaved(int year) {
    return 'Belastingparameters opgeslagen voor $year';
  }

  @override
  String get settingsTaxValidateField => 'Voer een geldig getal in.';

  @override
  String get firstLaunchWelcome => 'Welkom bij Florin';

  @override
  String get firstLaunchSubtitle => 'Stel je boekhoudwerkruimte in.';

  @override
  String get firstLaunchDbSection => 'Databaselocatie';

  @override
  String get firstLaunchDbDescription =>
      'Standaard: Application Support. Kies een andere map voor iCloud / Google Drive sync.';

  @override
  String get firstLaunchDbDefault => 'Application Support (standaard)';

  @override
  String get firstLaunchChooseFolder => 'Map kiezen';

  @override
  String get firstLaunchBusinessSection => 'Bedrijfsgegevens';

  @override
  String get firstLaunchStartersSubtitle =>
      'Eerste 3 jaar: €2.123 extra aftrek';

  @override
  String get firstLaunchGetStarted => 'Aan de slag';

  @override
  String firstLaunchSaveError(String error) {
    return 'Kan setup niet afronden: $error';
  }

  @override
  String get confirmDeleteTitle => 'Verwijderen';

  @override
  String get confirmDeleteCancel => 'Annuleren';

  @override
  String get confirmDeleteConfirm => 'Verwijderen';

  @override
  String get deadlineBadgeFiled => 'Ingediend';

  @override
  String get deadlineBadgeOverdue => 'Te laat';

  @override
  String deadlineBadgeDays(int days) {
    return '$days dagen';
  }

  @override
  String get vatRateSelectorLabel => 'BTW-tarief';

  @override
  String get vatRate21 => '21%';

  @override
  String get vatRate9 => '9%';

  @override
  String get vatRate0 => '0%';

  @override
  String get vatRateEuReverseCharge => '0% EU BTW verlegd';

  @override
  String get vatRateExempt => 'Vrijgesteld';

  @override
  String genericSaveError(String error) {
    return 'Kan niet opslaan: $error';
  }

  @override
  String get dbLocationChooseFolderDialog => 'Kies map voor de Florin-database';
}
