# Legal rules

The rules Florin implements that do not change every tax year, each with its
source, a verbatim quote and the date it was read. Yearly figures are in
[`tax-years/`](tax-years/). Retrieved 2026-11-22 unless stated otherwise.

## Invoice contents

> 1 Op de factuur zijn de volgende vermeldingen verplicht: a. de datum van uitreiking van de factuur; b. een opeenvolgend nummer, met één of meer reeksen, waardoor de factuur eenduidig wordt geïdentificeerd; c. het btw-identificatienummer waaronder de ondernemer de goederenleveringen of de diensten heeft verricht; d. het btw-identificatienummer van de afnemer waaronder hij een goederenlevering of een dienst heeft afgenomen waarvoor hij tot voldoening van de belasting is gehouden […]; e. de volledige naam en het volledige adres van de ondernemer en zijn afnemer; f. de hoeveelheid en de aard van de geleverde goederen of de omvang en de aard van de verrichte diensten; g. de datum waarop de goederenlevering of de dienst heeft plaatsgevonden of voltooid is […], voor zover die datum vastgesteld is en verschilt van de uitreikingsdatum van de factuur; h. de vergoeding voor elk tarief of elke vrijstelling, de eenheidsprijs, belasting niet inbegrepen […]; i. het toegepast tarief van de belasting; j. het te betalen bedrag van de belasting […]; l. in geval van een vrijstelling […] enige aanduiding daarvan; m. wanneer de afnemer tot voldoening van de belasting is gehouden, de vermelding «btw verlegd»;

[Wet op de omzetbelasting 1968, artikel 35a lid 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01)

> e. wanneer de uitgereikte factuur een document of bericht is dat overeenkomstig artikel 34f als factuur geldt, een specifieke en ondubbelzinnige verwijzing naar de oorspronkelijke factuur, met specifieke vermelding van de aangebrachte wijzigingen.

[Wet op de omzetbelasting 1968, artikel 35a lid 2](https://wetten.overheid.nl/BWBR0002629/2026-01-01)

Where Florin implements it: `lib/services/invoice_pdf_service.dart`. An issued
invoice cannot be edited or deleted; a correction is a credit note that names
the invoice it corrects. The KvK number on the invoice follows the
Belastingdienst's list of factuureisen ("Uw KvK-nummer, als u ingeschreven
bent bij de KvK").

[Belastingdienst, Factuureisen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/administratie_bijhouden/facturen_maken/factuureisen/factuureisen)

## Invoices to EU businesses

> Op uw facturen aan klanten die btw-aangifte doen in andere EU-landen moeten de btw-identificatienummers van u én uw klant staan. […] U factureert met 0% btw. Daarom moet op uw factuur een aanduiding staan waaruit blijkt dat het een intracommunautaire levering is. Vermeld op de factuur in elke gewenste taal: 'tabel II, onderdeel a, post 6, Wet OB '68' of 'artikel 138, lid 1, Richtlijn 2006/112'

[Belastingdienst, Extra factuureisen bij goederen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_naar_andere_eu_landen/factureren/extra_factuureisen_bij_goederen)

> U stuurt een factuur zonder btw en vermeldt daarop: de btw-identificatienummers van u én uw klant. […] 'btw verlegd'.

[Belastingdienst, Extra factuureisen bij diensten](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_naar_andere_eu_landen/factureren/extra_factuureisen_bij_diensten)

Where Florin implements it: `VatTreatment.euGoods` and `VatTreatment.euServices`,
and the treatment note in `InvoicePdfService`. Both require the customer's BTW
number before the invoice can be saved.

## ICP-opgaaf

> De opgaaf ICP over goederen mag u per maand, per kwartaal of per jaar doen. Als u per kwartaal opgaaf ICP wilt doen, mag u niet meer dan € 50.000 aan goederen leveren per kwartaal.

[Belastingdienst, Tijdvak opgaaf ICP](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_naar_andere_eu_landen/opgaaf_icp/tijdvak_opgaaf_icp/tijdvak_opgaaf_icp)

Florin lists the EU supplies per quarter. It states no ICP deadline: the
Belastingdienst pages read for this review do not give one for Dutch filers.

## BTW rates

`VatRate` in `lib/db/enums.dart` holds 21% and 9%, the general and reduced
rates of Wet OB 1968 artikel 9. Exempt supplies (artikel 11) carry no BTW and
are not reported in the return.

## BTW return rubrieken

> Hebt u de btw verlegd naar een Nederlandse afnemer? Dan vult u de omzet in bij rubriek 1e ('Leveringen/diensten belast met 0% of niet bij u belast'). Hebt u de btw verlegd naar een ondernemer uit een ander EU-land? Dan vult u de omzet in bij rubriek 3b ('Leveringen naar of diensten in landen binnen de EU') of bij onderdeel 3c ('Installatie/afstandsverkopen binnen de EU').

[Belastingdienst, Hoe werkt btw verleggen?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_berekenen_aan_uw_klanten/waarover_btw_berekenen/verleggingsregeling/hoe_werkt_btw_verleggen)

> Voert u goederen uit naar landen buiten de EU? Dan hanteert u het 0%-tarief. […] U doet hiervan aangifte bij rubriek 3a van uw btw-aangifte.

[Belastingdienst, Aangifte als u goederen uitvoert naar niet-EU-landen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/zakendoen_buiten_de_eu/aangifte_doen_als_u_zakendoet_buiten_de_eu/aangifte_en_als_u_goederen_uitvoert_naar_niet_eu_landen)

> Vermeld hier niet export (dit komt in rubriek 3a) of intracommunautaire leveringen (deze komen in rubriek 3b). Leveringen van goederen en diensten die onder een btw-vrijstelling vallen, hoef je hier ook niet aan te geven.

[Belastingdienst, Invullen rubrieken](https://stichtingenvereniging.belastingdienst.nl/aangifte/aangifte-omzetbelasting/invullen-rubrieken/)

> Hebt u de btw verlegd naar een Nederlandse afnemer? […] Er is btw naar u verlegd. In uw btw-aangifte vult u in hoeveel btw er naar u is verlegd. […] U vult de vergoeding en het btw-bedrag in bij rubriek 2 ('Verleggingsregelingen binnenland') of rubriek 4 ('Prestaties vanuit het buitenland aan u verricht').

> U geeft het totaal aan geleverde goederen en diensten aan in uw btw-aangifte. Dat doet u bij rubriek 4b. U berekent zelf de btw die u hierover in Nederland moet betalen. […] De btw kunt u in uw btw-aangifte weer aftrekken als voorbelasting […]. Dat doet u bij rubriek 5b.

[Belastingdienst, Aangifte doen van goederen en diensten uit andere EU-landen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_afnemen_uit_andere_eu_landen/aangifte_doen/aangifte-doen-van-goederen-en-diensten-uit-andere-eu-landen)

> Als u diensten afneemt van een ondernemer die is gevestigd in een land buiten de EU, dan wordt de btw meestal verlegd naar u. […] U geeft deze diensten aan in uw btw-aangifte bij rubriek 4a.

[Belastingdienst, Btw-aangifte als u diensten afneemt van leveranciers uit landen buiten de EU](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/zakendoen_buiten_de_eu/aangifte_doen_als_u_zakendoet_buiten_de_eu/aangifte_doen_als_u_diensten_afneemt_van_leveranciers_uit_niet_eu_landen)

Where Florin implements it: `VatService.calculateQuarter` fills 1a, 1b, 1d,
1e, 2a, 3a, 3b, 4a, 4b, 5a and 5b. `PurchaseVat` on an expense decides 2a, 4a
or 4b. Rubriek 1c (other rates) and 3c (installation and distance sales) do
not occur in the supplies Florin records.

## BTW deadlines

> Ik doe aangifte per kwartaal: 4e kwartaal 2025 | 31 januari 2026 · 1e kwartaal 2026 | 30 april 2026 · 2e kwartaal 2026 | 31 juli 2026 · 3e kwartaal 2026 | 31 oktober 2026 · 4e kwartaal 2026 | 31 januari 2027

[Belastingdienst, Uiterste aangifte- en betaaldatums](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/uiterste-aangifte-en-betaaldatums)

Where Florin implements it: `VatService.filingDeadline`, the last day of the
month after the quarter.

## BTW on food and drinks

> Geen aftrek vindt plaats van belasting welke in rekening is gebracht ter zake van het verstrekken van spijzen en dranken voor gebruik ter plaatse binnen het kader van het hotel-, café-, restaurant-, pension- en aanverwant bedrijf aan personen die daar slechts voor een korte periode verblijf houden.

[Wet op de omzetbelasting 1968, artikel 15 lid 5](https://wetten.overheid.nl/BWBR0002629/2026-01-01)

Where Florin implements it: choosing the food, drinks and representation
category turns BTW reclaim off by default and shows this rule. Non-reclaimable
BTW counts as a cost for income tax.

## Depreciation

> Het gedeelte van de nog niet afgeschreven aanschaffings- of voortbrengingskosten dat aan het kalenderjaar kan worden toegerekend bedraagt op jaarbasis met betrekking tot goodwill ten hoogste 10% en met betrekking tot andere bedrijfsmiddelen ten hoogste 20% van de aanschaffings- of voortbrengingskosten van het bedrijfsmiddel.

[Wet inkomstenbelasting 2001, artikel 3.30 lid 2](https://wetten.overheid.nl/BWBR0011353)

> Houd bij de afschrijving rekening met de restwaarde.

> Net als bij gewone afschrijving, mag de boekwaarde van het bedrijfsmiddel niet lager worden dan de restwaarde.

[Belastingdienst, Fiscale informatie 2026, Winst-en-verliesrekening en balans](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_en_verliesrekening_en_balans)

Where Florin implements it: `AssetService.minUsefulLifeYears` is 5, and every
asset has a residual value below which it is not depreciated. Depreciation is
spread by day over the useful life, so the year of purchase and the year of
disposal are time-proportional. Florin depreciates the business-use share of
an asset, which equals full depreciation minus a proportional private-use
correction. Cars use the private-use addition below instead. Goodwill and
buildings are not recorded as assets in Florin.

## Selling an asset

> U mag boekwinst op bedrijfsmiddelen opnemen in de herinvesteringsreserve. U neemt dan de boekwinst van het verkochte bedrijfsmiddel niet op in de fiscale winst

[Belastingdienst, Fiscale informatie 2026, Winst uit onderneming](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_uit_onderneming)

> Gaat u vervolgens herinvesteren? U moet dan de gereserveerde boekwinst meteen afboeken op de aanschafprijs van het aangeschafte bedrijfsmiddel. […] De afboeking verlaagt de afschrijving van het nieuwe bedrijfsmiddel.

> De reserve (of het restant daarvan) valt ook vrij als er 3 jaar verstreken zijn na het boekjaar waarin u de reserve hebt gevormd en u nog niet een herinvestering hebt gedaan.

[Belastingdienst, Fiscale informatie 2026, Winst-en-verliesrekening en balans, 7.7.1.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_en_verliesrekening_en_balans)

Where Florin implements it: `AssetService.disposalResult` adds the proceeds
minus the book value to the profit in the year of sale, unless the gain is put
in the herinvesteringsreserve. `AssetService.reserveLedger` books reserves off
on later purchases, oldest first, and releases what is left after 3 years or
when the business stops. The rule that a booked-off asset may not drop below
the book value of the one sold, and the exception for assets not depreciated
or depreciated over more than 10 years, are left to the user.

## Investeringsaftrek and desinvesteringsbijtelling

> U kunt voor een bedrijfsmiddel niet tegelijk gebruikmaken van de energie-investeringsaftrek en de milieu-investeringsaftrek.

> investeringen in personenauto's die niet bestemd zijn voor beroepsvervoer

> Verkoopt u een bedrijfsmiddel binnen 5 jaar na het begin van het jaar waarin u de investering deed? Dan moet u (een deel van) de investeringsaftrek die u voor die investering kreeg, terugnemen. […] Deze bijtelling kan niet hoger zijn dan de investeringsaftrek die u eerder hebt toegepast. […] Neem voor de bijtelling het percentage dat u bij de investeringsaftrek hebt toegepast. U berekent het percentage door de aftrek die u kreeg in het jaar van aanschaf, te delen door het totale investeringsbedrag waarover u in dat jaar de aftrek kreeg

[Belastingdienst, Fiscale informatie 2026, Ondernemersaftrek en investeringsaftrek, 8.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/ondernemersaftrek_en_investeringsaftrek)

Where Florin implements it: `AssetService`. A car never counts for the KIA.
The deduction received for an asset is computed when Florin has the rules of
its purchase year, and entered by the user otherwise. The other events the
Belastingdienst treats as a sale (renting out, gifting, moving to private
use) are recorded as a sale with the market value as proceeds.

## Private use of a business car

> Indien aan de belastingplichtige ook voor privédoeleinden een auto ter beschikking staat, wordt op jaarbasis ten minste: a. 22% van de waarde van de auto als onttrekking in aanmerking genomen indien de auto niet meer dan 16 jaar geleden voor het eerst in gebruik is genomen; b. 35% van de waarde van de auto […] indien de auto meer dan 16 jaar geleden voor het eerst in gebruik is genomen. […] tenzij blijkt dat de auto op jaarbasis voor niet meer dan 500 kilometer voor privédoeleinden wordt gebruikt.

> Na de eerste wijziging van de CO2-uitstootgrens of het percentage in het tweede lid na de datum van eerste toelating van de auto, is voor een periode van 60 maanden te rekenen vanaf de eerste dag van de maand volgend op de datum van eerste toelating, de verlaging, bedoeld in het tweede lid, van toepassing overeenkomstig de bepalingen die gelden direct voorafgaand aan die wijziging.

[Wet inkomstenbelasting 2001, artikel 3.20 leden 1 en 11](https://wetten.overheid.nl/BWBR0011353)

The zero-emission reduction of artikel 3.20 lid 2 in each version, used for
cars first registered in that year (`car_reductions.dart`):

| Version | Reduction | Maximum |
| --- | --- | --- |
| [2021-01-01](https://wetten.overheid.nl/BWBR0011353/2021-01-01) | 10% | € 4.000 |
| [2022-01-01](https://wetten.overheid.nl/BWBR0011353/2022-01-01) | 6% | € 2.100 |
| [2023-01-01](https://wetten.overheid.nl/BWBR0011353/2023-01-01) | 6% | € 1.800 |
| [2024-01-01](https://wetten.overheid.nl/BWBR0011353/2024-01-01) | 6% | € 1.800 |
| [2025-01-01](https://wetten.overheid.nl/BWBR0011353/2025-01-01) | 5% | € 1.500 |

> Dit bedrag is maximaal het bedrag van de autokosten.

[Belastingdienst, Fiscale informatie 2026, Winst uit onderneming, 6.4.1.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_uit_onderneming)

Where Florin implements it: `CarService.privateUseAddition`, day by day over
the days the car is in the business, capped at the costs linked to the car
plus its depreciation. The 500 km test uses the trips logged in that car,
annualised, and only when the user keeps a complete trip log for it.

## BTW on private use of a business car

> Hebt u geen administratie waaruit het privégebruik van de auto blijkt? Dan stelt u de btw die u moet betalen voor het privégebruik vast op 2,7% van de catalogusprijs van de auto, inclusief btw en bpm. […] Als u de auto in de loop van het jaar koopt, kunt u het percentage van 2,7% naar evenredigheid verlagen. […] U betaalt de btw voor het privégebruik auto via de laatste btw-aangifte van het boekjaar. […] En vindt het privégebruik plaats later dan 4 jaar na het jaar waarin u de auto in gebruik hebt genomen? Dan neemt u 1,5% in plaats van 2,7% […] Hebt u bij aankoop van een auto geen btw afgetrokken […]? Dan gebruikt u […] 1,5% in plaats van 2,7%. […] Dan is de correctie voor privégebruik niet hoger dan de som van de volgende 2 bedragen: het btw-bedrag voor onderhoud en gebruik dat u in dat jaar hebt afgetrokken; 1/5 deel van de afgetrokken btw bij aankoop

[Belastingdienst, Btw en privégebruik auto van de zaak](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/btw_en_de_auto/privegebruik_auto_van_de_zaak/privegebruik_auto_van_de_zaak)

> Woon-werkverkeer valt voor de btw onder privégebruik. […] Deze privékilometers vergelijkt u aan het einde van het jaar met het totale aantal kilometers […]. De verhouding hiertussen gebruikt u om de btw te berekenen die u voor het privégebruik moet betalen.

[Belastingdienst, Btw en privégebruik auto van de zaak: woon-werkverkeer](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/btw_en_de_auto/privegebruik_auto_van_de_zaak/woon_werkverkeer)

Where Florin implements it: `CarService.btwPrivateUse`, reported in rubriek 1d
of the fourth quarter. Without a trip log Florin applies 2,7% or 1,5% by whole
months, capped as quoted. With a trip log it takes the private and commuting
share of the BTW deducted that year, counting the purchase BTW as one fifth a
year for the year of purchase and the four years after, the same spread the
Belastingdienst uses for the cap.

## Urencriterium

The zelfstandigenaftrek requires the urencriterium (Wet IB 2001 artikel 3.76
lid 1). The hours threshold is a yearly figure in `TaxYearRules`. For the
current year Florin assumes the user reaches it and warns until the hours are
logged; for a past year it applies only what is logged.

## Income tax estimate scope

The estimate covers one ondernemer under the AOW age with no other income.
The urencriterium's second condition (Wet IB 2001 artikel 3.6 lid 1: most
working time goes to the business, unless the user was not an ondernemer in one
of the five previous years) only matters with other work, which the estimate
excludes.

Facts the bookkeeping cannot show are entered per year in the P&L screen
(`TaxYearInputs`): the partner's hours, an S&O-verklaring, stopping the
business, a disability benefit, unused zelfstandigenaftrek and losses from
earlier years.

Florin does not collect income outside the business: wages, a fiscal
partner's income, box 2, box 3, or an oudedagsreserve built up before 2023.
The estimate leaves them out and says so.
