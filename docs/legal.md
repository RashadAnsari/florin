# Legal rules

The rules Florin implements that do not change every tax year, each with its
source, a verbatim quote and the date it was read. Yearly figures are in
[`tax-years/`](tax-years/). Retrieved 2026-11-22 unless stated otherwise.

## Invoice contents

> 1 Op de factuur zijn de volgende vermeldingen verplicht: a. de datum van uitreiking van de factuur; b. een opeenvolgend nummer, met één of meer reeksen, waardoor de factuur eenduidig wordt geïdentificeerd; c. het btw-identificatienummer waaronder de ondernemer de goederenleveringen of de diensten heeft verricht; d. het btw-identificatienummer van de afnemer waaronder hij een goederenlevering of een dienst heeft afgenomen waarvoor hij tot voldoening van de belasting is gehouden […]; e. de volledige naam en het volledige adres van de ondernemer en zijn afnemer; f. de hoeveelheid en de aard van de geleverde goederen of de omvang en de aard van de verrichte diensten; g. de datum waarop de goederenlevering of de dienst heeft plaatsgevonden of voltooid is […], voor zover die datum vastgesteld is en verschilt van de uitreikingsdatum van de factuur; h. de vergoeding voor elk tarief of elke vrijstelling, de eenheidsprijs, belasting niet inbegrepen […]; i. het toegepast tarief van de belasting; j. het te betalen bedrag van de belasting […]; l. in geval van een vrijstelling […] enige aanduiding daarvan; m. wanneer de afnemer tot voldoening van de belasting is gehouden, de vermelding «btw verlegd»;

[Wet op de omzetbelasting 1968, artikel 35a lid 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28 from the official XML

> Ieder document of bericht dat wijzigingen aanbrengt in, en specifiek en ondubbelzinnig verwijst naar de oorspronkelijke factuur, geldt als factuur.

[Wet op de omzetbelasting 1968, artikel 34f](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28 from the official XML

> e. wanneer de uitgereikte factuur een document of bericht is dat overeenkomstig artikel 34f als factuur geldt, een specifieke en ondubbelzinnige verwijzing naar de oorspronkelijke factuur, met specifieke vermelding van de aangebrachte wijzigingen.

[Wet op de omzetbelasting 1968, artikel 35a lid 2](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28 from the official XML

> 2 Een vereenvoudigde factuur wordt niet uitgereikt indien de factuur moet worden uitgereikt overeenkomstig artikel 34c, eerste lid, onderdelen b en c, of indien de belastbare goederenlevering of de belastbare dienst wordt verricht door een ondernemer die niet is gevestigd in de lidstaat waar de belasting verschuldigd is […] en de tot de voldoening van de belasting gehouden persoon degene is voor wie de goederenlevering of dienst wordt verricht.

[Wet op de omzetbelasting 1968, artikel 34d lid 2](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28

Where Florin implements it: `lib/services/invoice_pdf_service.dart`. An issued
invoice cannot be edited or deleted; a correction is a credit note that names
the invoice it corrects (`InvoicePdfService.creditReference`). Artikel 35a
lid 2 lists the items of a simplified invoice; Florin's credit note carries
every item of lid 1 as well as the reference, so it also meets artikel 34d
lid 2, which allows no simplified invoice for an intra-Community supply or EU
reverse charge.

> 1 De volgende in het handelsregister ingeschreven ondernemingen of rechtspersonen zorgen ervoor dat op alle van die onderneming of die rechtspersoon uitgaande brieven, orders, facturen, offertes en andere aankondigingen, met uitzondering van reclames, is vermeld onder welk nummer deze in het handelsregister is ingeschreven

[Handelsregisterwet 2007, artikel 27 lid 1](https://wetten.overheid.nl/BWBR0021777/2025-07-16), read 2026-11-28 from the official XML

> als u bij de KVK bent ingeschreven: uw KVK-nummer

[Belastingdienst, Factuureisen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/administratie_bijhouden/facturen_maken/factuureisen/factuureisen), read 2026-11-28

Where Florin implements it: every invoice prints the KvK number of the
business profile (`InvoicePdfService.sellerRows`). The IBAN is not a
required item; it is printed in the payment instructions.

> Gebruik opeenvolgende nummers voor uw facturen, met 1 of meer reeksen. Elk factuurnummer mag maar 1 keer voorkomen.

[Belastingdienst, Factuureisen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/administratie_bijhouden/facturen_maken/factuureisen/factuureisen), read 2026-11-24

Where Florin implements it: invoice numbers are unique in the database. A
draft gets a number in the series `F-<year>-<nnn>` when it is made; when it is
sent, Florin checks it follows the last number issued in that series and
otherwise sends it as that next number (`InvoiceDao.nextIssuedNumber`,
`renumberDraft`), swapping numbers with the draft that held it. A series with
nothing issued yet keeps the number the user gave, so a series carried over
from other software continues.

> De factuur wordt uitgereikt uiterlijk op de vijftiende dag van de maand volgende op die waarin de goederenlevering of de dienst is verricht.

[Wet op de omzetbelasting 1968, artikel 34g](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-24

Where Florin implements it: `TaxYearRules.latestInvoiceDate`, from
`invoiceDueDay`; the invoice form warns when
the invoice date is after that day for the supply date entered.

> Verlegt u btw naar een andere ondernemer? Dan brengt u geen btw in rekening, maar zet u op de factuur 'btw verlegd'. Daarnaast vermeldt u het btw-identificatienummer van de afnemer op de factuur. […] Op de factuur vermeldt u de vergoeding per btw-tarief, zoals deze zou gelden als de btw niet zou zijn verlegd.

[Belastingdienst, Hoe werkt btw verleggen?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_berekenen_aan_uw_klanten/waarover_btw_berekenen/verleggingsregeling/hoe_werkt_btw_verleggen), read 2026-11-24

Where Florin implements it: `VatTreatment.lineRates`. A line of a domestic
reverse charge invoice takes 21% or 9%, and the PDF shows the rate per line
and the amount per rate marked verlegd (`InvoicePdfService.rateCell`,
`vatRows`).

> In geval van vooruitbetalingen als bedoeld in artikel 34c, eerste lid, onderdelen d en e, moet de factuur telkens worden uitgereikt vóór het tijdstip van de opeisbaarheid daarvan.

[Wet op de omzetbelasting 1968, artikel 34g](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28

> h. de vergoeding voor elk tarief of elke vrijstelling, de eenheidsprijs, belasting niet inbegrepen, evenals de eventuele vooruitbetalingskortingen, prijskortingen en -rabatten indien die niet in de eenheidsprijs zijn begrepen;

[Wet op de omzetbelasting 1968, artikel 35a lid 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28

Not modelled: invoices for vooruitbetalingen (artikel 34c lid 1 d and e,
34g second sentence); discounts and rebates not included in the unit price
(artikel 35a lid 1 h); continuous intra-Community supplies. Florin's invoice
lines carry a unit price that includes any discount.

## Invoices to EU businesses

> Op uw facturen aan klanten die btw-aangifte doen in andere EU-landen moeten de btw-identificatienummers van u én uw klant staan. […] U factureert met 0% btw. Daarom moet op uw factuur een aanduiding staan waaruit blijkt dat het een intracommunautaire levering is. Vermeld op de factuur in elke gewenste taal: 'tabel II, onderdeel a, post 6, Wet OB '68' of 'artikel 138, lid 1, Richtlijn 2006/112'

[Belastingdienst, Extra factuureisen bij goederen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_naar_andere_eu_landen/factureren/extra_factuureisen_bij_goederen), read 2026-11-28

> U stuurt een factuur zonder btw en vermeldt daarop: de btw-identificatienummers van u én uw klant. […] 'btw verlegd'.

[Belastingdienst, Extra factuureisen bij diensten](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_naar_andere_eu_landen/factureren/extra_factuureisen_bij_diensten), read 2026-11-28

> Bij sommige diensten moet u wel btw in rekening brengen.

[Belastingdienst, Extra factuureisen bij diensten](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_naar_andere_eu_landen/factureren/extra_factuureisen_bij_diensten), read 2026-11-28

Where Florin implements it: `VatTreatment.euGoods` and `VatTreatment.euServices`,
and the treatment note in `InvoicePdfService.treatmentNote`. Both require the
customer's BTW number before the invoice can be saved. The specific
place-of-supply rules of artikel 6a and later (for example property,
passenger transport and events) are not modelled: for such a service the
user picks the treatment that applies.

## Services to businesses outside the EU

> De plaats van een dienst, verricht voor een als zodanig handelende ondernemer, is de plaats waar die ondernemer de zetel van zijn bedrijfsuitoefening heeft gevestigd.

[Wet op de omzetbelasting 1968, artikel 6 lid 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23

> Levert u diensten aan een ondernemer die is gevestigd in een land buiten de EU? Dan hoeft u deze dienst niet aan te geven in uw btw-aangifte, als de dienst is belast in het land buiten de EU. […] Ook omzet die u hebt gemaakt en belast is in het land buiten de EU is belaste omzet.

[Belastingdienst, Btw-aangifte doen als u diensten levert aan afnemers in landen buiten de EU](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/zakendoen_buiten_de_eu/aangifte_doen_als_u_zakendoet_buiten_de_eu/aangifte_doen_als_u_diensten_levert_aan_afnemers_in_niet_eu_landen), read 2026-11-23

> In afwijking van het eerste lid gelden voor facturering: a. de regels die van toepassing zijn in de lidstaat waar de leverancier of dienstverrichter de zetel van zijn bedrijfsuitoefening […] heeft gevestigd […], wanneer: […] 2°. de goederenlevering of de dienst overeenkomstig het bepaalde in hoofdstuk II van deze wet, niet geacht wordt in de Unie te zijn verricht

[Wet op de omzetbelasting 1968, artikel 34b lid 2](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23

Where Florin implements it: `VatTreatment.servicesOutsideEu`. The invoice
follows the Dutch invoice rules above and carries no BTW. `VatService` leaves
it out of every rubriek and the ICP list, and the BTW return screen shows the
amount apart so the revenue stays visible. BTW on purchases stays deductible,
as the quote says. The specific place-of-supply rules of artikel 6a and later
(for example property, passenger transport and events) are not modelled: for
such a service the user picks the treatment that applies.

## Treatment and client country

> Click on the map and filters below to explore the countries of the European Union. […] Pages (27)

[European Union, EU countries](https://european-union.europa.eu/principles-countries-history/eu-countries_en), read 2026-11-23: Austria, Belgium, Bulgaria, Croatia, Cyprus, Czechia, Denmark, Estonia, Finland, France, Germany, Greece, Hungary, Ireland, Italy, Latvia, Lithuania, Luxembourg, Malta, Netherlands, Poland, Portugal, Romania, Slovakia, Slovenia, Spain, Sweden.

Where Florin implements it: `euCountries` and `VatTreatment.fitsCountry` in
`lib/services/domain.dart`. An invoice is only saved when its treatment fits
the client's country: btw verlegd binnenland for a Dutch client (rubriek 1e
above), the EU treatments for a client in another member state (rubriek 3b
and the ICP-opgaaf), and export or services outside the EU for a client
outside it. Dutch BTW fits every country. Greece's BTW prefix EL is accepted
next to its country code GR.

## Private persons as clients

> 2 De plaats van een dienst, verricht voor een andere dan ondernemer, is de plaats waar de dienstverrichter de zetel van zijn bedrijfsuitoefening heeft gevestigd.

[Wet op de omzetbelasting 1968, artikel 6 lid 2](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-25 from the official XML

> 1 De plaats van dienst van de volgende diensten, die worden verricht voor een andere dan ondernemer, is de plaats waar deze persoon gevestigd is of zijn woonplaats of gebruikelijke verblijfplaats heeft: a. telecommunicatiediensten; b. radio- en televisieomroepdiensten; c. elektronische diensten.

[Wet op de omzetbelasting 1968, artikel 6h lid 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-25

> De plaats van de volgende diensten, verricht voor een andere dan ondernemer die buiten de Unie gevestigd is of aldaar zijn woonplaats of gebruikelijke verblijfplaats heeft, is de plaats waar deze persoon gevestigd is of zijn woonplaats of gebruikelijke verblijfplaats heeft: a. de overdracht en het verlenen van auteursrechten, octrooien, licentierechten, handelsmerken en soortgelijke rechten; b. diensten op het gebied van de reclame; c. diensten verricht door raadgevende personen, ingenieurs, adviesbureaus, advocaten, accountants en andere soortgelijke diensten, alsmede gegevensverwerking en informatieverschaffing; […] f. het beschikbaar stellen van personeel; g. de verhuur van roerende lichamelijke zaken, met uitzondering van alle vervoermiddelen;

[Wet op de omzetbelasting 1968, artikel 6i](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28 from the official XML

> Indien de diensten en de daarmee samenhangende diensten betrekking hebben op activiteiten die worden gestreamd of anderszins virtueel ter beschikking worden gesteld, is de plaats van de dienst evenwel de plaats waar de andere dan een als zodanig handelende ondernemer is gevestigd of zijn woonplaats of gebruikelijke verblijfplaats heeft.

[Wet op de omzetbelasting 1968, artikel 6e lid 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28

> Onder de naam 'omzetbelasting' wordt een belasting geheven ter zake van: a. leveringen van goederen en diensten, welke in Nederland door een als zodanig handelende ondernemer onder bezwarende titel worden verricht;

[Wet op de omzetbelasting 1968, artikel 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28

> 1 Artikel 5a, eerste lid, onderdeel a, en artikel 6h, eerste lid, zijn niet van toepassing wanneer aan de volgende voorwaarden is voldaan: a. de leverancier of dienstverrichter is gevestigd of, bij gebreke van een vestiging, heeft zijn woonplaats of gebruikelijke verblijfplaats in slechts één lidstaat; b. de diensten worden verleend aan andere dan ondernemers die gevestigd zijn, hun woonplaats of gebruikelijke verblijfplaats hebben in een andere dan de lidstaat, bedoeld in onderdeel a, of de goederen worden verzonden of vervoerd naar een andere dan de lidstaat bedoeld in onderdeel a; en c. het totale bedrag van de leveringen van diensten of goederen, bedoeld in onderdeel b, de belasting niet inbegrepen, is in het lopende kalenderjaar niet hoger dan € 10 000 of de tegenwaarde daarvan in de nationale munteenheid, en heeft dit bedrag ook niet overschreden in de loop van het voorafgaande kalenderjaar. 2 Wanneer de drempel, genoemd in het eerste lid, onderdeel c, in de loop van een kalenderjaar wordt overschreden, zijn artikel 5a, eerste lid, onderdeel a, en artikel 6h vanaf die datum van toepassing.

[Wet op de omzetbelasting 1968, artikel 6k](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-25

> 1 Iedere ondernemer zorgt ervoor dat door hemzelf dan wel, in zijn naam en voor zijn rekening, door zijn afnemer of een derde, in de volgende gevallen een factuur wordt uitgereikt ter zake van: a. de goederenleveringen of diensten die hij heeft verricht voor een andere ondernemer of een rechtspersoon, andere dan ondernemer;

[Wet op de omzetbelasting 1968, artikel 34c lid 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-25

Where Florin implements it: a client can be marked as a private person
(`Clients.isConsumer`). For such a client Dutch BTW, the KOR and export of
goods fit, and for a client outside the EU also services taxed outside the
EU (`VatTreatment.fitsConsumer`, `fitsClient`): the reverse charge and EU
treatments need a business customer. A service to a private person is taxed
where the user is established (artikel 6 lid 2), except that artikel 6h
(telecommunication, broadcasting and electronic services), artikel 6i
(advice, advertising, licences, data processing and the other services it
lists) and artikel 6e lid 1 (streamed or virtual activities) place it where a
private person outside the EU lives; such a service is not supplied in the
Netherlands (artikel 1), so it carries no Dutch BTW and stays out of the
Dutch return, as for a business outside the EU. Its PDF states «Niet in
Nederland belast: dienst aan een afnemer buiten de EU (artikel 6e, 6h of 6i,
Wet OB 1968)» (`InvoicePdfService.treatmentNote`). Florin cannot tell which
services artikel 6e, 6h or 6i covers, so a new invoice to a private person
starts with Dutch BTW or the KOR, the cautious choice, and the user picks
services taxed outside the EU where it applies. On an invoice with Dutch BTW to a private person in another
member state, the form shows the threshold of artikel 6k
(`euConsumerSalesThreshold`) against the year's supplies with Dutch BTW to
such clients (`VatService.euConsumerSales`), and warns once this year or the
previous year passes it.

Cautious choice: Florin cannot tell which services are electronic in the
sense of artikel 6h or which goods are distance sales, so it counts every
supply with Dutch BTW to a private person in another member state. Not
modelled: the OSS (Unieregeling) return, the BTW rates of other member
states and the choice of artikel 6k lid 3; past the threshold Florin keeps
charging Dutch BTW and says so. Also not modelled: streamed or virtual
activities for private persons in other member states (artikel 6e lid 1),
which are taxed there from the first euro; Florin offers Dutch BTW for them
and says so in the help of the private person field. Invoices to private persons in the
Netherlands remain possible; artikel 34c does not require them.

## Merchant of record and self-billing

> 1 Voor verscheidene afzonderlijke leveringen of diensten kan een periodieke factuur worden opgemaakt, mits de periode waarop de factuur betrekking heeft niet langer is dan een kalendermaand. 2 Facturen mogen door de afnemer worden opgemaakt voor goederenleveringen of diensten die door een ondernemer voor hem worden verricht, indien beide partijen dat vooraf onderling zijn overeengekomen en op voorwaarde dat iedere factuur het voorwerp uitmaakt van een procedure van aanvaarding door de ondernemer die de goederenleveringen of de diensten verricht.

[Wet op de omzetbelasting 1968, artikel 35](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23

> k. wanneer de afnemer die een prestatie afneemt de factuur uitreikt in plaats van degene die de prestatie verricht, de vermelding «factuur uitgereikt door afnemer»;

> 4 Op een factuur kunnen bedragen in willekeurig welke munteenheid voorkomen, mits het te betalen of te herziene bedrag van de belasting is uitgedrukt in euro’s en daarbij gebruik wordt gemaakt van het in artikel 91 van de BTW-richtlijn 2006 bedoelde wisselkoersmechanisme.

[Wet op de omzetbelasting 1968, artikel 35a leden 1 en 4](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23

> 1 Iedere ondernemer zorgt ervoor dat door hemzelf dan wel, in zijn naam en voor zijn rekening, door zijn afnemer of een derde, in de volgende gevallen een factuur wordt uitgereikt ter zake van: a. de goederenleveringen of diensten die hij heeft verricht voor een andere ondernemer of een rechtspersoon, andere dan ondernemer;

[Wet op de omzetbelasting 1968, artikel 34c lid 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23

A merchant of record is a reseller that sells the user's product to end
customers in its own name and pays the user. The user then supplies the
reseller, a business, and an invoice is required for that supply, made by the
user or by the reseller.

Where Florin implements it: `Clients.isMerchantOfRecord` marks the reseller;
the client form hides the Wet DBA fields for it, and new invoices to it start
with the treatment that fits its country. The invoice form explains the
one-month limit for an invoice that covers several sales.
`Invoices.selfBilled` records an invoice the customer issued: it keeps the
customer's number, is recorded instead of sent, and gets no PDF from Florin,
because the customer's document is the invoice and carries «factuur
uitgereikt door afnemer». Florin keeps amounts in euros. For a payout in
another currency the user enters the euro amounts; Florin does not convert.

> U bent als leverancier verantwoordelijk voor de betaling van de btw aan ons, ook als dat bedrag te hoog is.

[Belastingdienst, Uw afnemer maakt de factuur op (selfbilling)](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/administratie_bijhouden/facturen_maken/factuureisen/aangepaste_regels_facturen/factuur_uitgereikt_door_afnemer), read 2026-11-28

> 1 Voor facturering gelden de regels die van toepassing zijn in de lidstaat waar de goederenlevering of de dienst geacht wordt te zijn verricht, zoals deze plaats van verrichting is vastgesteld overeenkomstig het bepaalde in hoofdstuk II van deze wet. 2 In afwijking van het eerste lid gelden voor facturering: a. de regels die van toepassing zijn in de lidstaat waar de leverancier of dienstverrichter de zetel van zijn bedrijfsuitoefening […] heeft gevestigd […], wanneer: 1°. de leverancier of dienstverrichter die niet gevestigd is in de lidstaat waar de goederenlevering of de dienst overeenkomstig het bepaalde in hoofdstuk II van deze wet geacht wordt te zijn verricht, […] en de tot voldoening van de belasting gehouden persoon degene is voor wie de goederenlevering of de dienst wordt verricht, tenzij de afnemer zelf de factuur uitreikt («self-billing»);

[Wet op de omzetbelasting 1968, artikel 34b](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28

The self-billing help asks the user to enter the amounts and BTW exactly as
the customer's invoice states them, as the supplier owes the BTW it shows,
even when that amount is too high. For a customer in another member state
that self-bills a supply with BTW verlegd, artikel 34b lid 1 applies the
invoicing rules of the customer's member state instead of the Dutch ones;
Florin does not check the customer's document against them.

## Kleineondernemersregeling

> 1 Een ondernemer die in Nederland is gevestigd en van wie de jaaromzet in Nederland niet meer bedraagt dan € 20.000 kan kiezen voor toepassing van vrijstelling van belasting ter zake van door de ondernemer in Nederland verrichte leveringen van goederen en diensten. […] 3 De vrijstelling is niet van toepassing op de levering van: a. nieuwe vervoermiddelen die door of voor rekening van de verkoper of afnemer worden verzonden of vervoerd naar een andere lidstaat; en b. onroerende zaken en rechten waaraan deze zijn onderworpen die de ondernemer in zijn bedrijf heeft gebruikt. 4 De ondernemer die de vrijstelling toepast, heeft geen recht op aftrek van belasting en mag op de factuur op geen enkele wijze melding maken van omzetbelasting. 5 De vrijstelling geldt voor de ondernemer die in Nederland is gevestigd, na een melding aan de inspecteur, vanaf het eerstvolgende belastingtijdvak dat minimaal vier weken na ontvangst van de melding aanvangt. […] 7 […] De beëindiging van de vrijstelling wordt van kracht op de eerste dag van het eerstvolgende kalenderkwartaal dat minimaal vier weken na ontvangst van de wederopzegging aanvangt. De ondernemer kan na de beëindiging door wederopzegging pas na het verstrijken van het kalenderjaar waarin de vrijstelling is beëindigd en het daaropvolgende kalenderjaar opnieuw de vrijstelling toepassen. […] 9 Een ondernemer komt niet in aanmerking voor de vrijstelling of mag deze niet langer toepassen indien de jaaromzet in Nederland het bedrag, genoemd in het eerste lid, overschrijdt. […] In de hiervoor bedoelde gevallen komt de ondernemer ook niet in aanmerking voor de vrijstelling in het daaropvolgende kalenderjaar of is de vrijstelling niet langer van toepassing voor de levering van het goed of de dienst waardoor die overschrijding tot stand komt, gedurende het resterende kalenderjaar en het daaropvolgende kalenderjaar.

[Wet op de omzetbelasting 1968, artikel 25a](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28 from the official XML of the version in force on 1 January 2026. The limit of lid 1 is in [`tax-years/2026.md`](tax-years/2026.md).

> 1 In deze afdeling wordt verstaan onder: a. jaaromzet in Nederland: het totaal van de vergoedingen ter zake van de volgende leveringen van goederen en diensten verricht door een ondernemer binnen Nederland gedurende een kalenderjaar: […] 2 In afwijking van het eerste lid, onderdeel a, wordt bij de vaststelling van de jaaromzet in Nederland niet in aanmerking genomen de vergoeding voor de levering van door de ondernemer in zijn bedrijf gebruikte: a. onroerende zaken […]; en b. roerende zaken waarop de ondernemer voor de inkomstenbelasting […] afschrijft

[Wet op de omzetbelasting 1968, artikel 25 lid 1 and 2](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28

> 1 Een ondernemer die in Nederland is gevestigd kan de vrijstelling toepassen zonder de melding te doen, bedoeld in artikel 25a, vijfde lid, indien aan de volgende voorwaarden is voldaan: a. de jaaromzet in Nederland bedraagt niet meer dan het bij ministeriële regeling vastgestelde bedrag; b. de ondernemer heeft zich voor de omzetbelasting niet gemeld bij de inspecteur of de Kamer van Koophandel en is daartoe ook niet verplicht;

[Wet op de omzetbelasting 1968, artikel 25b](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28

> Het bedrag, bedoeld in artikel 25b, eerste lid, onderdeel a, van de wet, bedraagt € 2.200.

[Uitvoeringsbeschikking omzetbelasting 1968, artikel 25](https://wetten.overheid.nl/BWBR0002634/2026-04-01), read 2026-11-28 from the official XML of the version in force from 1 April 2026

> Dit zijn leveringen belast met 21%, 9% en 0% btw (uitvoer en intracommunautaire leveringen) en leveringen belast met Nederlandse btw die u verlegt naar een andere Nederlandse ondernemer (nationale verlegging). […] Ook telt btw-vrijgestelde omzet mee van leveringen van goederen en diensten die betrekking hebben op onroerende zaken, betaalmiddelen en effecten, financiële diensten en verzekeringsdiensten in Nederland (overige vrijgestelde omzet telt niet mee voor de omzetgrens). […] prestaties die belast zijn in een ander land […] De hiermee behaalde omzet telt niet mee voor de omzetgrens van de KOR.

> De maximale omzet van € 20.000 geldt voor het kalenderjaar waarin u zich aanmeldt, én voor het kalenderjaar daarvóór.

[Belastingdienst, Voorwaarden voor deelname aan de KOR](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/kor-voorwaarden), read 2026-11-28

> U berekent geen btw aan uw klanten. […] Als u zelf facturen wilt versturen, of als uw klanten daarom vragen, kunt u dat wel doen. U vermeldt dan op de factuur dat een vrijstelling van toepassing is. U doet geen btw-aangifte meer. Behalve in een aantal gevallen, dan moet u toch incidentele aangifte doen. U trekt de btw over uw zakelijke kosten en investeringen niet af. […] Wilt u niet meer deelnemen aan de KOR? Dan mag u zich op elk moment afmelden. Uw afmelding gaat dan in op de 1e dag van het volgende kwartaal.

[Belastingdienst, Wat betekent meedoen met de KOR?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/hoe_werkt_de_btw/kleineondernemersregeling/wat-betekent-meedoen-met-de-kleineondernemersregeling/wat-betekent-meedoen-met-de-kleineondernemersregeling), read 2026-11-28

> Zodra uw omzet boven de € 20.000 in 1 kalenderjaar komt, mag u namelijk geen gebruik meer maken van de KOR. U moet zich op dat moment direct afmelden. Ook de omzetoverschrijdende handeling zelf valt niet meer onder de btw-vrijstelling. […] Een dag later krijgt u een voorschot van € 500 voor een nieuwe opdracht. Uw omzet voor 2024 komt nu boven de € 20.000, waardoor de vrijstelling vervalt. U past vanaf 16 september dan ook de normale btw-regels toe en het voorschot van € 500 is dus volledig belast met btw. […] Deze vrijwillige afmelding kan alleen met ingang van de 1e dag van uw aangiftetijdvak. […] Als uw afmelding is verwerkt, ontvangt u binnen 8 weken een brief van ons met daarin uw definitieve beëindigingsdatum van uw deelname aan de KOR. […] Na de definitieve beëindigingsdatum gaat een periode in waarin u tijdelijk niet kunt deelnemen aan de KOR. Het gaat om de rest van het kalenderjaar waarin u bent afgemeld, en het jaar erop. Zodra die periode is afgelopen, kunt u zich weer opnieuw aanmelden.

[Belastingdienst, Afmelden voor de KOR](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/afmelden-kor), read 2026-11-28

> Wel moet u elk kwartaal een opgaaf kwartaalomzet bij ons indienen. Dat is een overzicht van de omzet die u in een kwartaal in de hele EU hebt behaald.

[Belastingdienst, Toelichting bij de btw-aangifte 2026, p. 7](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28

> Koopt of verkoopt u goederen en/of diensten binnen de EU én maakt u gebruik van de KOR? Dan gelden er aangepaste regels en is het soms lastig om te bepalen wat u met de btw moet doen. Vaak moet u dan incidenteel btw-aangifte doen.

[Belastingdienst, Kleineondernemersregeling (KOR)](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/hoe_werkt_de_btw/kleineondernemersregeling/kleineondernemersregeling), read 2026-11-23

Where Florin implements it: `KorService` and `KorStatus` in
`lib/services/kor_service.dart`, the KOR dates on the business profile, and
`VatTreatment.kor`.

- The profile holds one participation. The KOR applies from the start date
  the user enters, which must be the first of a month as a return period
  starts then, until a voluntary end date or the supply that takes the
  year's turnover past the limit, whichever comes first
  (`KorStatus.appliesOn`). Passing the limit ends that participation: the
  KOR applies again only from a new start date (lid 5), and the form
  refuses a start after the passing and before 1 January of the second year
  after it (lid 9, `KorStatus.startBlockedUntil`). Several participation
  periods are not modelled, and neither is the block after a voluntary end
  (lid 7, second sentence), which one start and end pair cannot hold.
- The voluntary end date: lid 7 makes it the first day of a calendar
  quarter, and Wat betekent meedoen met de KOR agrees, but Afmelden voor de
  KOR says the first day of the aangiftetijdvak, and the Belastingdienst
  confirms the date by letter. The sources disagree, and forcing a quarter
  could treat more days as KOR than the letter does, so the form accepts the
  first of any month and asks for the date in the letter: the cautious
  choice.
- A supply counts for the turnover on the day it was made, in the year it
  was made: the supply date when it precedes the invoice date, else the
  invoice date (art. 25 lid 1 a, `InvoiceDomain.suppliedOn`). The
  Belastingdienst dates the passing at an advance payment; payments received
  before the supply or the invoice are not in Florin's data and are not
  counted.
- Turnover counts issued invoices with Dutch BTW, domestic reverse charge,
  export and intra-Community supplies, and KOR-exempt invoices; credit notes
  reduce it. Services taxed in another country (`euServices`,
  `servicesOutsideEu`) do not count. Florin cannot tell which exemption an
  exempt line has, so it counts every exempt line: the cautious reading.
  A sale recorded on an asset does not count (art. 25 lid 2), and neither
  does an invoice an asset names as its sale invoice, or a credit note that
  corrects one. An invoice for a sale that no asset names does count, as
  Florin cannot tell it apart: the cautious reading.
- While the KOR applies, an invoice for a supply in the Netherlands must use
  `VatTreatment.kor`; services taxed abroad keep their treatment. The invoice
  that passes the limit must carry BTW. The KOR PDF shows no BTW column, no
  BTW totals and no BTW number, the seller's or the customer's, following
  lid 4, and states that the exemption applies, as the Belastingdienst asks
  (`InvoicePdfService.sellerRows`, `clientRows`, `columnHeads`, `totalRows`).
- No BTW on purchases is reclaimed on KOR dates: the expense and asset forms
  block it, and the calculations treat that BTW as cost even for records
  saved before the KOR dates were entered. For an asset that cost is what
  depreciation and the investment deductions use. A sale of an asset without
  an invoice on a KOR date carries no BTW.
- BTW shifted to the user (2a, 4a, 4b) is owed in KOR quarters and not
  deducted; a KOR quarter with BTW owed needs an incidental return. See
  Filing a return.
- Supplies on KOR dates are left off the ICP list (art. 37a lid 1, under
  ICP-opgaaf).
- Not modelled: the EU-KOR (art. 25c and further), including the quarterly
  turnover report (opgaaf kwartaalomzet) its participants file; the
  exceptions of lid 3 (new means of transport to another member state, real
  estate used in the business), which Florin does not record; the KOR
  without registration of art. 25b, which needs a business that is not
  registered with the inspecteur or the KvK and turnover of at most the
  amount of Uitvoeringsbeschikking art. 25; and the eligibility test on the
  turnover of the year before the first year Florin holds, which the start
  date's help states. The user's start date stands for the Belastingdienst's
  confirmation.

## Receipts

> Alle facturen die u verstuurt of ontvangt, bewaart u in uw administratie. Dat is verplicht, want wij moeten uw administratie kunnen controleren. U bewaart de facturen in de vorm waarin u ze hebt verstuurd of ontvangen. Digitale facturen drukt u dus niet af, maar slaat u digitaal op. U bewaart de facturen 7 jaar. Facturen over onroerende zaken bewaart u 10 jaar. […] U mag facturen en bonnetjes ook scannen en digitaal bewaren. Er moet dan wel sprake zijn van een juiste en volledige weergave van het origineel. Belangrijk hierbij is dat de echtheidskenmerken ook worden opgeslagen. […] Als u aan de voorwaarden voldoet, hoeft u de originele facturen en bonnetjes niet te bewaren. Ook deze digitale administratie moet 7 of 10 jaar worden bewaard en binnen een redelijke termijn controleerbaar zijn.

[Belastingdienst, Uw facturen bewaren](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/administratie_bijhouden/facturen_maken/uw_facturen_bewaren), read 2026-11-23

> Voor het bepalen van de start van de bewaartermijn gebruikt u de actuele waarde van een gegeven. Zolang gegevens actueel blijven, horen zij bij de administratie. Vervalt de actualiteitswaarde? Dan begint de bewaartermijn.

[Belastingdienst, Hoelang moet u gegevens bewaren?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/ondernemen/administratie/hoelang-moet-u-gegevens-bewaren), read 2026-11-23

> 4 Voorzover bij of krachtens de belastingwet niet anders is bepaald, zijn administratieplichtigen verplicht de in de voorgaande leden bedoelde gegevensdragers gedurende zeven jaar te bewaren.

[Algemene wet inzake rijksbelastingen, artikel 52 lid 4](https://wetten.overheid.nl/BWBR0002320/2026-10-01), read 2026-11-24 from the official XML of the version in force from 1 October 2026

> De ondernemer is verplicht boeken, bescheiden en andere gegevensdragers of de inhoud daarvan – zulks ter keuze van de inspecteur – betreffende onroerende zaken en rechten waaraan deze zijn onderworpen gedurende negen jaren, volgende op het jaar waarin hij het goed is gaan gebruiken, te bewaren.

[Wet op de omzetbelasting 1968, artikel 34a](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28 from the official XML

> 2 Desgevraagd moet de in het eerste lid bedoelde boekhouding langs elektronische weg aan de lidstaat van verbruik en aan de lidstaat van identificatie beschikbaar worden gesteld. De boekhouding wordt bewaard gedurende tien jaar na afloop van het jaar waarin de handeling is verricht.

[Wet op de omzetbelasting 1968, artikel 28sj lid 2](https://wetten.overheid.nl/BWBR0002629/2026-01-01) (Unieregeling), read 2026-11-28 from the official XML; artikel 28rl lid 2 (niet-Unieregeling) and 28tn lid 2 (invoerregeling) set the same ten years, and artikel 28w lid 2 ten years after the year of the return for the regeling post- en koeriersdiensten

> 3 De bevoegdheid tot het vaststellen van een navorderingsaanslag vervalt door verloop van vijf jaren na het tijdstip waarop de belastingschuld is ontstaan. Artikel 11, vierde lid, is te dezen van toepassing. Indien voor het doen van aangifte uitstel is verleend, wordt de navorderingstermijn met de duur van dit uitstel verlengd.

> 4 Indien te weinig belasting is geheven over een bestanddeel van het voorwerp van enige belasting dat in het buitenland wordt gehouden of is opgekomen, vervalt, in afwijking in zoverre van het derde lid, eerste volzin, de bevoegdheid tot navorderen door verloop van twaalf jaren na het tijdstip waarop de belastingschuld is ontstaan.

[Algemene wet inzake rijksbelastingen, artikel 16](https://wetten.overheid.nl/BWBR0002320/2026-10-01), read 2026-11-25 from the official XML of the version in force from 1 October 2026

The retention term is not the end of the risk: the navordering term of
article 16 can run past it, with uitstel or for items abroad. The keep-until
help names both terms (`navorderingYears`, `navorderingForeignYears`) as
what the law says, without advising a term. Florin itself never deletes a
record.

Where Florin implements it: `ReceiptStore` and `ReceiptService`.

- Receipt files are copied into `receipts/<year>/<uuid>.<extension>` next to
  the database, byte for byte: never printed, converted or compressed, so a
  file received digitally is kept in the form it was received. A SHA-256 of
  each file is stored, and Settings checks that every file is still there
  and unchanged.
- Florin accepts PDF, JPEG, PNG, HEIC, TIFF and UBL e-invoices, recognised by
  their content, up to 25 MB a file. Whether a scan or photo is a complete
  and faithful copy, with its authenticity marks, is up to the user; the
  help text says what the Belastingdienst asks. A file Florin refuses is not
  to be converted: the message says to keep it as received in the user's
  own records ("Digitale facturen drukt u dus niet af").
- The keep-until date is the end of the seventh year after the record's
  year. The Belastingdienst starts the term when a record stops being
  current, which can be later, as for a contract that still runs; Florin
  shows the earlier date as a minimum, says so in its help, and never
  deletes a record. An asset's purchase
  invoice stays current while the asset is in use, so it shows "while in
  use, then 7 years" until the asset is sold. Florin never deletes a
  receipt: one removed from its record, or whose record is deleted, keeps
  its row with what it belonged to and its file moves to
  `receipts/removed/`, listed under Removed receipts in Settings and in
  every export. Florin does not compute the terms for real estate (art. 34a)
  or OSS records (art. 28sj): an asset's receipt help says the real estate
  term is longer and that Florin does not show its date.
- When an invoice is issued, Florin stores its PDF at that moment and hands
  out that file on every later export, so the invoice stays in the form it
  was sent. A self-billed invoice keeps the customer's document instead.

## ICP-opgaaf

> 1 De ondernemer, uitgezonderd die bedoeld in artikel 7, zesde lid, of artikel 25a, eerste lid, is verplicht uiterlijk de laatste dag van de maand volgend op een kalendermaand bij de inspecteur op de daartoe opengestelde wijze een formulier langs elektronische weg in te dienen met een lijst voor dat tijdvak waarop zijn vermeld de afnemers: a. aan wie goederen zijn geleverd met toepassing van de bij deze wet behorende Tabel II, onderdeel a, post 6; […] c. voor wie hij diensten heeft verricht die met toepassing van artikel 6, eerste lid, niet belastbaar zijn in Nederland en waarover de belasting ingevolge artikel 196 van BTW-richtlijn 2006 in de lidstaat van de afnemer wordt geheven van de afnemer, tenzij het verrichten van die dienst in die lidstaat is vrijgesteld; […] 3 In afwijking in zoverre van het eerste lid geldt als tijdvak in plaats van een kalendermaand naar keus van de ondernemer een kalenderkwartaal indien het totaalbedrag van de in het eerste lid, onderdelen a en b genoemde leveringen noch voor het desbetreffende kalenderkwartaal, noch in één van de vier daaraan voorafgaande kalenderkwartalen, hoger is dan het daartoe bij ministeriële regeling vastgestelde bedrag. Deze afwijking geldt niet meer vanaf het einde van de maand waarin dit bedrag wordt overschreden, in welk geval uiterlijk de volgende maand een lijst moet worden opgesteld en ingediend voor alle maanden die sinds de aanvang van dat kwartaal zijn verlopen. […] 4 In afwijking in zoverre van het eerste lid geldt naar keus van de ondernemer als tijdvak een kalenderkwartaal indien de ondernemer de onder het eerste lid onderdeel c genoemde diensten verricht.

[Wet op de omzetbelasting 1968, artikel 37a](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28 from the official XML of the version in force on 1 January 2026

> Het bedrag, bedoeld in artikel 37a, derde lid, van de wet, is € 50.000.

[Uitvoeringsbeschikking omzetbelasting 1968, artikel 33b](https://wetten.overheid.nl/BWBR0002634/2026-01-01), read 2026-11-28 from the official XML of the version in force on 1 January 2026

> De opgaaf ICP over goederen mag u per maand, per kwartaal of per jaar doen. Als u per kwartaal opgaaf ICP wilt doen, mag u niet meer dan € 50.000 aan goederen leveren per kwartaal. […] Als u per jaar opgaaf ICP wilt doen, moet u daarvoor een vergunning hebben.

> U mag uw opgaaf ICP per kwartaal doen, als u in het kwartaal waarover u opgaaf ICP wilt doen, en in elk van de vorige 4 kwartalen het drempelbedrag niet hebt overschreden. Als u in een kwartaal wel meer dan het drempelbedrag aan goederen levert, moet u vanaf dat kwartaal uw opgaaf ICP per maand doen. Hoe u opgaaf doet over het kwartaal waarin u het drempelbedrag overschrijdt, is afhankelijk van het moment waarop u het drempelbedrag overschrijdt: U overschrijdt het drempelbedrag in de 1e maand van het kwartaal. Uw opgaaf ICP over dit kwartaal doet u in 3 afzonderlijke opgaven ICP: 1 per maand. U overschrijdt het drempelbedrag in de 2e maand van het kwartaal. Uw opgaaf ICP over dit kwartaal doet u in 2 afzonderlijke opgaven ICP: 1 over de eerste 2 maanden van het kwartaal en 1 over de laatste maand. U overschrijdt het drempelbedrag in de 3e maand van het kwartaal. U doet dit kwartaal een opgaaf ICP over het hele kwartaal. Daarna doet u opgaaf ICP per maand.

> Maar u kunt uw goederen en diensten ook in 1 opgaaf ICP doen. U volgt dan de regels die gelden voor de opgaaf ICP over goederen.

[Belastingdienst, Tijdvak opgaaf ICP](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_naar_andere_eu_landen/opgaaf_icp/tijdvak_opgaaf_icp/tijdvak_opgaaf_icp), read 2026-11-28

> Uw opgaaf moet binnen 1 maand na afloop van het gekozen tijdvak bij ons binnen zijn. Als u uw opgaaf niet juist of niet op tijd doet, kunt u daarvoor een boete krijgen en mag u het 0%-tarief niet toepassen.

> Tijdvak opgaaf tweemaandelijks ICP uiterlijk binnen januari/februari 31 maart april/mei 30 juni

> Tijdvak opgaaf kwartaal ICP uiterlijk binnen 1e kwartaal 30 april 2e kwartaal 31 juli 3e kwartaal 31 oktober 4e kwartaal 31 januari van het volgende jaar

> Het totaalbedrag van rubriek 3 van de opgaaf of opgaven moet gelijk zijn aan het totaal van vraag 3b van de btw-aangifte(n) over dezelfde periode. Denk er daarbij aan dat het tijdvak waarover u uw btw-aangifte moet doen, niet gelijk hoeft te zijn aan de periode waarover u deze opgaaf ICP doet.

> Creditnota’s (bijvoorbeeld door annulering of prijsvermindering) vermeldt u in rubriek 3 ‘Gegevens intracommunautaire prestaties’.

[Belastingdienst, Toelichting bij de opgaaf ICP 2026, p. 5, 8 and 9](https://download.belastingdienst.nl/belastingdienst/docs/toelichting-digitale-opgaaf-intracomm-pres-ob1291t62fd.pdf), read 2026-11-28

> Intracommunautaire leveringen geeft u aan in het tijdvak van de factuurdatum. Intracommunautaire diensten geeft u aan in het tijdvak waarin u de dienst hebt geleverd. U hoeft geen opgaaf ICP te doen als u in een tijdvak niets hebt geleverd.

> Het totaal van de opgaaf ICP moet dus gelijk zijn aan het bedrag dat u over dezelfde periode invult in uw btw-aangifte bij Rubriek 3b 'Leveringen naar/diensten in landen binnen de EU'.

> Hebt u een fout gemaakt? U corrigeert die door in de volgende opgaaf ICP de juiste gegevens in te vullen.

[Belastingdienst, Opgaaf ICP](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_naar_andere_eu_landen/opgaaf_icp/opgaaf_icp), read 2026-11-28

> De opgaaf ICP vindt u in Mijn Belastingdienst Zakelijk. U krijgt geen uitnodiging om de opgaaf te doen.

> Deze diensten mag u niet opnemen in uw btw-aangifte en opgaaf ICP: – diensten die in het land van uw afnemer zijn vrijgesteld van btw – diensten die in het land van uw afnemer belast zijn met 0% […] – diensten die te maken hebben met onroerende zaken, bijvoorbeeld verhuur en onderhoud – personenvervoer – diensten die te maken hebben met het verlenen van toegang tot evenementen

[Belastingdienst, Toelichting bij de btw-aangifte 2026, p. 7 and 13](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28

Where Florin implements it: `VatService.onIcpList`, `icpList`,
`icpPeriods`, `icpMonthlyByLookback`, `icpGoodsPassedIn` and
`icpLookbackWithoutRecords`, the ICP section of the BTW return screen, and
`CsvExportService.icpFiles`.

- Florin lists the EU supplies per ICP period, goods by invoice date and
  services by supply date, or by invoice date when the invoice gives none
  (`InvoiceDomain.vatDate`). A credit note counts by its own date, in a
  later opgaaf, as a negative amount.
- The ICP-opgaaf has its own period, not the BTW return's
  (`VatService.icpPeriods`). A quarter is one period while the goods on the
  list stay at or below `icpQuarterlyGoodsMax` in it and in each of the
  `icpGoodsLookbackQuarters` quarters before it; after a quarter that passed
  the limit, each month is a period. In the quarter goods pass the limit, the
  months from the start of the quarter through the month of passing are one
  period, then each later month is one (lid 3, second sentence). Every
  period is due on the last day of the month `icpDueMonths` after it ends:
  goods of € 30.000 in April and € 30.000 in May 2026 give one opgaaf over
  April and May due 30 June and one over June due 31 July. Passing in the
  last month of a quarter gives one opgaaf over the quarter, due as a
  quarter.
- The BTW return screen groups the supplies of its period by the ICP periods
  they fall in, each with its deadline, also when the return is per month
  or per year, and says when and why a quarter's goods are per month.
- Florin keeps services in the same periods as goods, which the
  Belastingdienst allows; lid 4 allows a quarter for services alone.
- The export writes one file per ICP period of the year, `icp_Q1`,
  `icp_M07-M08`, `icp_M09` and so on, each also when it is empty, though no
  opgaaf is due for a period without supplies.
- Supplies dated while the KOR applies are left off the list: lid 1 exempts
  the ondernemer of artikel 25a, eerste lid. They stay in rubriek 3b.
- Rubriek 3b uses the same dates, so over the same period it equals the ICP
  total except for the rounding of 3b to whole euros, and except for EU
  services on KOR dates in a period the KOR covers in part, which stay in 3b
  but not on the list; no source read settles either. The last row of each
  ICP file gives its total in whole euros, rounded as 3b, to compare.
- Not modelled, and stated on screen: goods in the quarters before the first
  year Florin holds, which the lookback of lid 3 needs. When a quarter's
  lookback reaches into such a year, the screen says that Florin holds no
  records of it and what follows if goods passed the limit there.
- Not modelled, and stated in the help on the BTW treatment of an invoice:
  services that are exempt or 0% in the customer's country, or tied to real
  estate, passenger transport, events or catering, belong in neither 3b nor
  the ICP-opgaaf; Florin puts every EU service to a business in both.
- Not modelled: a yearly ICP-opgaaf, which needs a vergunning; triangular
  supplies (lid 1 b) and call-off stock (lid 1 d), which Florin does not
  record; and corrections of a filed ICP-opgaaf. Florin keeps no copy of a
  filed ICP list and does not flag a changed EU invoice in a filed ICP
  period; the section's help says so.

## BTW rates

> 1 De belasting bedraagt 21 percent. 2 In afwijking van het eerste lid bedraagt de belasting: a. 9 percent voor leveringen van goederen en diensten, genoemd in de bij deze wet behorende tabel I; b. nihil voor leveringen van goederen en diensten, genoemd in de bij deze wet behorende tabel II, mits is voldaan aan bij algemene maatregel van bestuur vast te stellen voorwaarden.

[Wet op de omzetbelasting 1968, artikel 9](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-24

Where Florin implements it: `VatRate` is the category of a line or expense;
its percentage is a yearly rule, `TaxYearRules.vatRates`, so labels, BTW
amounts, the PDF and the export take the rate of the record's year. Exempt
supplies (artikel 11) carry no BTW and are not reported in the return.

## BTW return rubrieken

> Hebt u de btw verlegd naar een Nederlandse afnemer? Dan vult u de omzet in bij rubriek 1e ('Leveringen/diensten belast met 0% of niet bij u belast'). Hebt u de btw verlegd naar een ondernemer uit een ander EU-land? Dan vult u de omzet in bij rubriek 3b ('Leveringen naar of diensten in landen binnen de EU') of bij onderdeel 3c ('Installatie/afstandsverkopen binnen de EU').

[Belastingdienst, Hoe werkt btw verleggen?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_berekenen_aan_uw_klanten/waarover_btw_berekenen/verleggingsregeling/hoe_werkt_btw_verleggen), read 2026-11-28

> Voert u goederen uit naar landen buiten de EU? Dan hanteert u het 0%-tarief. […] U doet hiervan aangifte bij rubriek 3a van uw btw-aangifte.

[Belastingdienst, Aangifte als u goederen uitvoert naar niet-EU-landen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/zakendoen_buiten_de_eu/aangifte_doen_als_u_zakendoet_buiten_de_eu/aangifte_en_als_u_goederen_uitvoert_naar_niet_eu_landen), read 2026-11-28

> 1e Leveringen/diensten belast met 0% of niet bij u belast Vul hier de omzet in van goederen en diensten die u in Nederland levert tegen het 0%-tarief of die niet bij u belast zijn. […] behalve export (vraag 3a) of intracommunautaire leveringen (vraag 3b) […] Leveringen van goederen en diensten die onder een vrijstelling vallen, hoeft u niet aan te geven.

[Belastingdienst, Toelichting bij de btw-aangifte 2026, p. 11](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28

> Er is btw naar u verlegd. In uw btw-aangifte vult u in hoeveel btw er naar u is verlegd. […] U vult de vergoeding en het btw-bedrag in bij rubriek 2 ('Verleggingsregelingen binnenland') of rubriek 4 ('Prestaties vanuit het buitenland aan u verricht').

[Belastingdienst, Hoe werkt btw verleggen?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_berekenen_aan_uw_klanten/waarover_btw_berekenen/verleggingsregeling/hoe_werkt_btw_verleggen), read 2026-11-23

> U geeft het totaal aan geleverde goederen en diensten aan in uw btw-aangifte. Dat doet u bij rubriek 4b. U berekent zelf de btw die u hierover in Nederland moet betalen. […] De btw kunt u in uw btw-aangifte weer aftrekken als voorbelasting […]. Dat doet u bij rubriek 5b.

[Belastingdienst, Aangifte doen van goederen en diensten uit andere EU-landen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_afnemen_uit_andere_eu_landen/aangifte_doen/aangifte-doen-van-goederen-en-diensten-uit-andere-eu-landen), read 2026-11-28

> Als u diensten afneemt van een ondernemer die is gevestigd in een land buiten de EU, dan wordt de btw meestal verlegd naar u. […] U geeft deze diensten aan in uw btw-aangifte bij rubriek 4a.

[Belastingdienst, Btw-aangifte als u diensten afneemt van leveranciers uit landen buiten de EU](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/zakendoen_buiten_de_eu/aangifte_doen_als_u_zakendoet_buiten_de_eu/aangifte_doen_als_u_diensten_afneemt_van_leveranciers_uit_niet_eu_landen), read 2026-11-28

> 2a Leveringen/diensten waarbij de btw naar u is verlegd […] 3a Leveringen naar landen buiten de EU (uitvoer) […] 3b Leveringen naar of diensten in landen binnen de EU

> U hebt diensten afgenomen van een ondernemer uit een ander EU-land, die de btw naar u heeft verlegd. U moet dan in Nederland btw aangeven. Dit geldt niet voor diensten aan onroerende zaken. Die vult u in bij vraag 2a.

[Belastingdienst, Toelichting bij de btw-aangifte 2026, p. 11, 12 and 14](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28

Where Florin implements it: `VatService.calculateQuarter` fills 1a, 1b, 1d,
1e, 2a, 3a, 3b, 4a, 4b, 5a and 5b; the export names each rubriek as the
form does. An expense and the purchase of an asset
count alike (`asPurchase`): `PurchaseVat` decides 2a, 4a or 4b, and the BTW
reclaimed goes in 5b in the quarter of the purchase date. The sale of an
asset without an invoice in Florin goes in 1a, 1b or 1e by its rate; see BTW
on an asset. Rubriek 1c (other rates) and 3c (installation and distance sales) do
not occur in the supplies Florin records. Services taxed outside the EU are
in no rubriek; see Services to businesses outside the EU and Private persons
as clients above. Not modelled: a service to real estate from an EU supplier
belongs in 2a, not 4b; Florin cannot tell such a purchase apart, so the help
on the BTW of an expense and an asset says to choose the 2a option for it.

## BTW return rounding

> Rond alle bedragen af op hele euro’s. Dit mag u in uw voordeel doen. Zet bij negatieve bedragen een minteken (-) voor het bedrag.

[Belastingdienst, Toelichting bij de btw-aangifte 2026, p. 9](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28

> In de btw-aangifte rondt u de btw-bedragen af op hele euro’s. Dit mag u in uw voordeel doen.

[Belastingdienst, Btw-bedrag afronden](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/administratie_bijhouden/facturen_maken/btw-bedrag_afronden), read 2026-11-22

> Op het scherm 'Voorbelasting' staat bij 5a, 'Verschuldige btw (rubrieken 1 t/m 4)', het totaal aan verschuldigde btw uit de vorige rubrieken.

[Belastingdienst, Ik moet btw-aangifte doen: hoe vul ik die in?](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/ik-moet-btw-aangifte-doen-hoe-vul-ik-die-in), read 2026-11-22

Where Florin implements it: `CsvExportService.btwReturnRows` writes one file
per period of the year's filing period, `florin_<year>_btw_Q1.csv` to `Q4`,
`btw_M01` to `btw_M12` or `btw_jaar`, also when a period is empty, inside a
new folder `florin_<year>_export_<date>_<time>` for each export, with every
rubriek of the form in whole euros. Amounts owed and their bases round down, voorbelasting (5b)
rounds up, and 5a is the sum of the rounded BTW amounts, as the form adds
them. Negative amounts keep their minus sign. The ICP list per ICP period,
`florin_<year>_icp_<code>.csv` (`CsvExportService.icpFiles`, see
ICP-opgaaf), totals the supplies per customer BTW number with goods and
services apart, in euros and cents: the pages read for this review state no
rounding rule for the ICP-opgaaf. Its last row adds them up in whole euros,
rounded down as 3b, to compare with 3b.

Filing from Florin directly is not possible: the Belastingdienst accepts
returns from software only over SBR and Digipoort, signed with a PKIoverheid
certificate.

> If you file a tax return using Standard Business Reporting (SBR), you use Digipoort, the secure digital channel of the public authorities. To be able to send and receive messages via Digipoort, you need a PKIoverheid services server certificate.

[Belastingdienst, Filing tax returns using accounting software](https://www.belastingdienst.nl/wps/wcm/connect/bldcontenten/belastingdienst/business/tax_return/filing_digital_tax_returns/filing-tax-returns-using-accounting-software/), read 2026-11-22

## BTW deadlines

> 2 Heeft de aangifte betrekking op een tijdvak, dan wordt zij gedaan binnen een door de inspecteur gestelde termijn van ten minste een maand na het einde van het tijdvak.

[Algemene wet inzake rijksbelastingen, artikel 10 lid 2](https://wetten.overheid.nl/BWBR0002320/2026-10-01), read 2026-11-28 from the official XML of the version in force from 1 October 2026

> 1 In de gevallen waarin de belastingwet voldoening van in een tijdvak verschuldigd geworden of afdracht van in een tijdvak ingehouden belasting op aangifte voorschrijft, is de belastingplichtige, onderscheidenlijk de inhoudingsplichtige, gehouden de belasting binnen één maand na het einde van dat tijdvak overeenkomstig de aangifte aan de ontvanger te betalen. […] 5 De Algemene termijnenwet is niet van toepassing op de in het eerste en in het derde lid gestelde termijn van één maand.

[Algemene wet inzake rijksbelastingen, artikel 19](https://wetten.overheid.nl/BWBR0002320/2026-10-01), read 2026-11-28 from the official XML of the version in force from 1 October 2026

> Ik doe aangifte per maand Tijdvak Uw aangifte en betaling moeten binnen zijn op november 2026 31 december 2026 december 2026 31 januari 2027

> Ik doe aangifte per kwartaal Tijdvak Uw aangifte en betaling moeten binnen zijn op 4e kwartaal 2026 31 januari 2027

[Belastingdienst, Uiterste aangifte- en betaaldatums](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/uiterste-aangifte-en-betaaldatums), read 2026-11-28. The table rolls on each period; these rows are an example of the rule above.

> Houd er rekening mee dat het enkele dagen kan duren voordat de bank uw betaling heeft verwerkt. Als betaaldatum geldt de datum waarop uw betaling is bijgeschreven op onze rekening.

[Belastingdienst, Toelichting bij de btw-aangifte 2026, p. 5](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28

Where Florin implements it: `VatService.filingDeadline`, the last day of the
month `TaxYearRules.vatReturnDueMonths` after a month or quarter, for the
return (AWR artikel 10 lid 2, with the term the Belastingdienst sets in the
aangiftebrief) and the payment (artikel 19 lid 1), and
`vatYearlyReturnDueMonths` after a yearly period (see Filing period). The
Algemene termijnenwet does not apply to the month of artikel 19 (lid 5), so
Florin does not move a deadline that falls on a weekend: 31 January 2027 is
a Sunday and stays the deadline. The help on "Paid" states that a payment
counts on the day it reaches the Belastingdienst's account.

## Correcting a filed return

> Hebt u bij uw btw-aangifte een bedrag van maximaal €1000 te veel of te weinig ingevuld? Dan geeft u dat bedrag op in uw eerstvolgende btw-aangifte. U verwerkt dat bedrag in uw eerstvolgende btw-aangifte. Dus u corrigeert of vult het in bij de rubriek waar u het normaal ook opgeeft.

> Dan bent u verplicht dit zo snel mogelijk te corrigeren. U doet dit met het correctieformulier Suppletie btw (correctie btw-aangifte).

> U kunt correcties indienen tot en met 5 jaar na het jaar waarop de correctie betrekking heeft.

> Ontdekt u een fout en gaat het om een btw-bedrag van meer dan € 1.000? Verzend het correctieformulier dan zo snel mogelijk, maar in elk geval binnen 8 weken nadat u de fout ontdekte. Komen wij achter de fout, ook binnen de 8 weken-termijn? In dat geval kunt u een boete krijgen.

[Belastingdienst, Btw-aangifte corrigeren](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aangifte_doen_en_betalen/aangifte_corrigeren/aangifte_corrigeren), read 2026-11-25

> Hebt u een fout in uw btw-aangifte gemaakt? En gaat het om een bedrag van € 1.000 of minder? Dan kunt u dit bedrag zelf verwerken in uw eerstvolgende btw-aangifte. Hebt u meer dan € 1.000 te veel of te weinig btw aangegeven? Dan moet u dit corrigeren met het formulier ‘Suppletie btw’ in Mijn Belastingdienst Zakelijk.

[Belastingdienst, Toelichting bij de btw-aangifte 2026, p. 6](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28

> Gaat het om een btw-bedrag van € 1.000 of minder? Dan hoeft u dit formulier niet in te vullen. Geef dit bedrag dan op in uw eerstvolgende btw-aangifte.

[Belastingdienst, Toelichting bij de Suppletie btw](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_suppletie_btw_ob1431t21pl.pdf), read 2026-11-28

> 1 In bij algemene maatregel van bestuur aan te wijzen gevallen kunnen belastingplichtigen of inhoudingsplichtigen worden gehouden de inspecteur eigener beweging mededeling te doen van onjuistheden of onvolledigheden in voor de belastingheffing van belang zijnde gegevens en inlichtingen die hun bekend zijn of zijn geworden.

[Algemene wet inzake rijksbelastingen, artikel 10a lid 1](https://wetten.overheid.nl/BWBR0002320/2026-10-01), read 2026-11-25 from the official XML

> 1 Zodra de belastingplichtige constateert dat hij een aangifte over een tijdvak in de afgelopen vijf kalenderjaren onjuist of onvolledig heeft gedaan waardoor te veel of te weinig belasting is betaald, is hij gehouden alsnog bij wijze van suppletie de juiste en volledige inlichtingen, gegevens of aanwijzingen te verstrekken. 2 De suppletie moet gedaan worden voordat de belastingplichtige weet of redelijkerwijs moet vermoeden dat de inspecteur met de desbetreffende onjuistheid of onvolledigheid bekend is of zal worden, maar niet later dan acht weken nadat de belastingplichtige de onjuistheid of onvolledigheid heeft geconstateerd.

[Uitvoeringsbesluit omzetbelasting 1968, artikel 15](https://wetten.overheid.nl/BWBR0002633/2026-01-01), read 2026-11-28 from the official XML of the version in force on 1 January 2026. Its artikel 1 lid 1 names artikel 10a of the AWR among the provisions it carries out.

Artikel 15 is the AMvB of artikel 10a: it requires a suppletie for every
error in a return of the last five calendar years, within eight weeks, and
names no amount. The route of `correctionNextReturnMax` through the next
return is the Belastingdienst's practice, as the Toelichting and the page
above state it.

Where Florin implements it: marking a return filed keeps its figures per
rubriek (`VatFiledFigures`). A filed period whose records changed since then
shows the change per rubriek and its net BTW (`VatService.difference`,
`netVatOf`), and `VatService.correctionRoute` decides where it goes. A
change within `correctionNextReturnMax` is added to the rubrieken of the
next return of the same year and filing period not yet filed, on screen and
in the export, and filing that return counts the earlier one as corrected.
For the last period of the year that return falls in the next year, which
Florin does not carry a correction into: the screen says so and asks the
user to add the figures to that return. A larger change
is not carried: the screen names the Suppletie btw form, `suppletieWeeks`
and `correctionYears`, and "I filed the suppletie" counts the period's
figures as filed.

Cautious choice: the page does not say how changes in several rubrieken add
up, so a change goes to the next return only when both its net BTW and the
BTW of each rubriek stay within the amount (`VatService.fitsNextReturn`).
Not modelled: when the user found the error, which starts the 8 weeks;
carrying corrections across a change of year or filing period;
belastingrente. Returns marked filed before Florin kept figures show no
change, as there is nothing to compare with.

## Filing period

> Btw-aangifte doet u meestal per kwartaal. Maar er zijn uitzonderingen mogelijk.

> Ontvangen wij uw btw-aangifte of betaling niet op tijd? Dan kunnen wij u verplichten om maandelijks btw-aangifte te doen. U ontvangt daarvan altijd schriftelijk bericht.

> Wilt u per maand aangifte doen? Dan kunt u hier om verzoeken met een brief aan uw belastingkantoor.

> Wilt u per jaar aangifte doen? Dan kunt u hier om verzoeken met een brief aan uw belastingkantoor. U moet dan voldoen aan alle volgende voorwaarden: U betaalt per jaar minder dan € 1.883 btw. U hebt geen vergunning artikel 23 U bent een natuurlijk persoon (eenmanszaak) of een samenwerkingsverband van uitsluitend natuurlijke personen.

> Het drempelbedrag van € 10.000 geldt voor elk van deze activiteiten afzonderlijk.

[Belastingdienst, Over welk tijdvak moet ik btw-aangifte doen?](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/wijziging-aangiftetijdvak-btw), read 2026-11-28

> Ik doe aangifte per jaar Tijdvak Uw aangifte en betaling moeten binnen zijn op 2026 31 maart 2027

[Belastingdienst, Uiterste aangifte- en betaaldatums](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/uiterste-aangifte-en-betaaldatums), read 2026-11-28

> 1 Het tijdvak waarover de omzetbelasting, de vliegbelasting, de belasting van personenauto’s en motorrijwielen en de assurantiebelasting moeten worden betaald, is het kalenderkwartaal of, indien de inspecteur zulks vordert, dan wel de belastingplichtige over een kalendermaand aangifte doet, de kalendermaand. 2 Ten aanzien van de belastingplichtige met een boekjaar van twaalf maanden dat niet samenvalt met het kalenderjaar, treden de boekjaarkwartalen en de boekjaarmaanden in de plaats van de kalenderkwartalen, onderscheidenlijk de kalendermaanden. 3 In bijzondere gevallen kan de inspecteur een ander tijdvak dan een kwartaal of een maand aanwijzen als tijdvak waarover de in het eerste lid bedoelde belastingen moeten worden betaald.

[Uitvoeringsregeling Algemene wet inzake rijksbelastingen 1994, artikel 25](https://wetten.overheid.nl/BWBR0006736/2026-01-01), read 2026-11-28 from the official XML of the version in force on 1 January 2026

Where Florin implements it: the filing period is chosen per year on the BTW
return screen (`TaxYearInputs.vatFilingPeriod`), a quarter by default. A
return covers a `VatPeriod`: a month, a quarter or the year. A month or
quarter is due one month after it ends (AWR artikel 19 lid 1), a yearly
return `vatYearlyReturnDueMonths` after the year. The yearly period rests on
lid 3 of artikel 25 above; no statutory text giving it three months was
found, so the 31 March follows the Belastingdienst's table and the
aangiftebrief. Private use of a car and
the yearly herziening go in the last return of the year, the herziening of a
sale under the KOR in the return of the sale's period. The ICP-opgaaf has
its own period, not the return's: a quarter, or months from the month goods
pass `icpQuarterlyGoodsMax` (see ICP-opgaaf). The export writes one BTW file
per period of the year's filing period (`btw_M01` to `btw_M12`, `btw_Q1` to `btw_Q4`, or `btw_jaar`). With a
yearly period, the screen warns when the year's BTW to pay reaches
`yearlyFilingMaxVat` or its EU supplies or EU purchases reach
`yearlyFilingMaxEu`. Florin adds goods and services together there, so it
warns sooner than the Belastingdienst would: the cautious side.

Not modelled: the vergunning artikel 23 and partnerships, which Florin does
not record (the help on the filing period names the vergunning as a
condition); a boekjaar that differs from the calendar year (lid 2), as
Florin keeps calendar years; and the legal basis of the yearly figures,
which was not read beyond the Belastingdienst page.

## Filing a return

> 1 De in een tijdvak verschuldigd geworden belasting moet op aangifte worden voldaan.

[Wet op de omzetbelasting 1968, artikel 14](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23

> Ja, als ondernemer voor de btw moet u altijd btw-aangifte doen, ook als u in de periode van de aangifte geen btw in rekening hebt gebracht of aan u geen btw is berekend. Dit heet een 0-aangifte of nihilaangifte. Doet u de btw-aangifte niet of niet op tijd? Dan ontvangt u van ons een naheffingsaanslag en een boete. […] Over vrijgestelde omzet doet u normaal gesproken geen btw-aangifte […] Hiervan is sprake als u uitsluitend vrijgestelde goederen of diensten levert. Of als u deelneemt aan de kleineondernemersregeling (KOR). Maar ook dan kan het voorkomen dat u toch een keer btw-aangifte moet doen. […] Hebt u al een btw-aangifte gekregen, dien hem dan altijd in.

[Belastingdienst, Moet ik altijd btw-aangifte doen?](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/moet-ik-altijd-btw-aangifte-doen), read 2026-11-23

> U blijft btw-aangifte doen tot u de definitieve ingangsdatum van de KOR van ons hebt gekregen.

[Belastingdienst, Aanmelden voor de KOR](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/aanmelden-kor), read 2026-11-23

> Is uw omzet vrijgesteld van btw? Dan hoeft u meestal geen aangifte te doen. Neemt u diensten af waarbij de btw naar u wordt verlegd? Dan moet u wél btw-aangifte doen. Hierin geeft u de btw aan die aan u is verlegd. U hebt dan geen recht om deze btw af te trekken.

[Belastingdienst, Btw-aangifte als u diensten afneemt van leveranciers uit landen buiten de EU](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/zakendoen_buiten_de_eu/aangifte_doen_als_u_zakendoet_buiten_de_eu/aangifte_doen_als_u_diensten_afneemt_van_leveranciers_uit_niet_eu_landen), read 2026-11-23

> Voert een ondernemer uit een ander EU-land werkzaamheden voor u uit? Of hebt u goederen uit andere EU-landen laten afleveren in Nederland? Dan ontvangt u in de meeste gevallen een factuur met 0% btw of met 'btw verlegd'. U moet de verschuldigde btw zelf berekenen en opgeven in uw btw-aangifte. […] Als u btw moet betalen over intracommunautaire verwervingen en diensten, moet u in het juiste tijdvak aangifte doen.

[Belastingdienst, Aangifte doen van goederen en diensten uit een ander EU-land](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_afnemen_uit_andere_eu_landen/aangifte_doen/aangifte-doen-van-goederen-en-diensten-uit-andere-eu-landen), read 2026-11-23

> Het kan dan toch zijn dat u incidenteel btw-aangifte moet doen. U bent dan zelf verantwoordelijk voor het aanvragen van de aangifte. […] Blijkt dat u inderdaad incidenteel btw-aangifte moet doen? Vraag de aangifte dan zelf schriftelijk aan bij uw belastingkantoor. Dat kan na afloop van het kwartaal waarin de goederen zijn geleverd of de dienst is verricht waarvoor u btw-aangifte moet doen.

[Belastingdienst, Incidenteel btw-aangifte doen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aangifte_doen_en_betalen/btw-aangifte-waar-moet-u-aan-denken/incidentele-btw-aangifte), read 2026-11-28

> incidentele aangevers Doe aangifte op papier. Uw btw-aangifte vraagt u schriftelijk aan bij uw belastingkantoor.

[Belastingdienst, Toelichting bij de btw-aangifte 2026, p. 3](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28

Where Florin implements it: `ReturnDuty` and `VatReturnResult.duty` in
`lib/services/vat_service.dart`, shown by `DeadlineBadge`, the dashboard's
BTW deadlines and the notices on the BTW return screen.

- Without the KOR every period needs a return, however low the turnover,
  and an empty period needs a nil return; the BTW return screen says so.
  Low turnover alone never removes a return.
- A period the KOR covers in full needs no return when no BTW is owed in it.
- A period the KOR covers in full with BTW owed in it, such as BTW shifted
  to the user in 2a, 4a or 4b or BTW on a car's private use, needs an
  incidental return. The user asks for it in writing per calendar quarter,
  after the quarter, and files it on paper; the notice says so, also with a
  monthly filing period, where Florin shows the duty per month. The
  BTW on a car's private use in a year the KOR covers is Florin's cautious
  reading, see BTW on private use of a business car. The
  pages name no deadline for it; Florin shows the regular deadline, the
  cautious answer. Domestic reverse charge (2a) is not named on the pages
  read; Florin treats it like 4a and 4b, as art. 14 lid 1 makes any BTW owed
  payable on a return.
- A period the KOR covers in part needs a regular return.
- Until the figures have loaded, a period shows a return as due.

## BTW on food and drinks

> 5 Geen aftrek vindt plaats van belasting welke in rekening is gebracht ter zake van het verstrekken van spijzen en dranken voor gebruik ter plaatse binnen het kader van het hotel-, café-, restaurant-, pension- en aanverwant bedrijf aan personen die daar slechts voor een korte periode verblijf houden. De vorige zin is niet van toepassing als de belasting in rekening wordt gebracht aan een ondernemer die deze dienst vervolgens onder bezwarende titel verricht aan een ander.

[Wet op de omzetbelasting 1968, artikel 15 lid 5](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28 from the official XML

Where Florin implements it: choosing the category for food, drinks,
representation and congresses turns BTW reclaim off by default and shows
this rule (`expensesFoodNotice`). Non-reclaimable BTW counts as a cost for
income tax.

Not modelled: a meal the user supplies on for a fee (the second sentence);
the user ticks Reclaim VAT for such an expense.

## BTW on gifts

> 1 De in artikel 15, eerste lid, van de Wet op de omzetbelasting 1968 bedoelde aftrek wordt uitgesloten in de gevallen waarin en voor zover de goederen en diensten worden gebezigd voor: a. het voeren van een zekere staat; b. het geven van relatiegeschenken of het doen van andere giften aan degenen bij wie, indien aan hen ter zake omzetbelasting in rekening is of zou zijn gebracht, deze in het geheel niet of hoofdzakelijk niet voor aftrek in aanmerking komt of zou komen;

> 2 Onder relatiegeschenken of andere giften worden verstaan alle prestaties welke de ondernemer in verband met zakelijke verhoudingen of uit vrijgevigheid ten behoeve van anderen verricht zonder vergoeding of tegen een vergoeding welke lager is dan de aanschaffings- of voortbrengingskosten dan wel, in geval van diensten, de kostprijs van die prestaties de omzetbelasting niet daaronder begrepen.

[Besluit uitsluiting aftrek omzetbelasting 1968, artikel 1](https://wetten.overheid.nl/BWBR0002636/2019-02-23), read 2026-11-25 from the official XML of the version in force since 23 February 2019

> 1 Indien het totaal van de aanschaffings- of voortbrengingskosten dan wel de kostprijs, de omzetbelasting niet daaronder begrepen, van alle door de ondernemer in een boekjaar ten behoeve van eenzelfde belanghebbende verrichte prestaties als zijn bedoeld in artikel 1, eerste lid, letters b en c, en het op die belanghebbende betrekking hebbende deel van het in artikel 3, eerste lid, bedoelde verschil niet meer bedraagt dan € 227, blijven die prestaties en dat deel van bedoeld verschil voor de toepassing van dit besluit buiten aanmerking.

[Besluit uitsluiting aftrek omzetbelasting 1968, artikel 4](https://wetten.overheid.nl/BWBR0002636/2019-02-23), read 2026-11-25

> U telt alleen de uitgaven mee waarover u btw hebt betaald. Contante betalingen zoals een 13 e maand of winstdeling tellen niet mee.

[Belastingdienst, Btw aftrekken en drempelbedrag giften, relatiegeschenken en personeelsvoorzieningen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/personeelsvoorzieningen_en_relatiegeschenken/drempelbedrag_personeelsvoorzieningen_giften_en_relatiegeschenken), read 2026-11-28

> Geeft u goederen of diensten cadeau, of tegen een symbolisch bedrag? Bijvoorbeeld een gift aan een stichting of een relatiegeschenk? U kunt dan de btw niet aftrekken als: de ontvangers van uw geschenk, als zij het zelf zouden kopen, minder dan 30% btw kunnen aftrekken, én u over het drempelbedrag heengaat

[Belastingdienst, Btw aftrekken bij giften, relatiegeschenken en personeelsvoorzieningen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/personeelsvoorzieningen_en_relatiegeschenken), read 2026-11-28

Where Florin implements it: the expense category Business gifts asks who
received the gift (`Expenses.giftRecipient`). `GiftService` adds up the cost
excl. BTW of the year's gifts per recipient, by the name as typed without
case or surrounding spaces. Gifts without BTW do not count toward the total.
Above `buaGiftThreshold` no BTW on that recipient's gifts is reclaimed, in
the form and in every figure through `effectiveExpensesProvider` and in the
CSV export, and the BTW not reclaimed counts as a cost. A gift keeps the
user's Reclaim VAT choice on its record, so it regains its BTW when the
recipient's total drops back to the threshold.

Cautious choice: whether the recipient could deduct BTW, which keeps the
deduction under artikel 1 lid 1 b ("in het geheel niet of hoofdzakelijk
niet"), is not in the records, so Florin assumes they cannot. A gift without
a recipient is treated as above the threshold.

Not modelled: gifts recorded in another category, a contribution the
recipient pays (artikel 2), and the staff provisions of artikel 1 lid 1 c
and artikel 3, since Florin has no staff.

## Depreciation

> Het gedeelte van de nog niet afgeschreven aanschaffings- of voortbrengingskosten dat aan het kalenderjaar kan worden toegerekend bedraagt op jaarbasis met betrekking tot goodwill ten hoogste 10% en met betrekking tot andere bedrijfsmiddelen ten hoogste 20% van de aanschaffings- of voortbrengingskosten van het bedrijfsmiddel.

[Wet inkomstenbelasting 2001, artikel 3.30 lid 2](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

> De aanschafwaarde van een computer is € 1.000. De levensduur van de computer is 3 jaar. De restwaarde is € 100. De economische afschrijving is (€ 1.000 -/- € 100) / 3 = € 300 per jaar. De fiscale afschrijving is echter maximaal 20% van € 1.000 = € 200 per jaar. De beperking van de afschrijving geldt op jaarbasis. Op een bedrijfsmiddel dat halverwege een jaar wordt aangeschaft, kan daarom slechts de helft van het maximale afschrijvingsbedrag worden afgeschreven.

[Belastingdienst, Fiscale informatie 2026, Winst-en-verliesrekening en balans, 7.4.1](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_en_verliesrekening_en_balans), read 2026-11-28

> min kortingen en subsidies, ook als u die achteraf krijgt

> Hebt u recht op aftrek van btw bij de aanschaf van het bedrijfsmiddel? Dan schrijft u voor uw winstberekening af over de aanschafkosten exclusief btw. Want de btw vraagt u apart terug. Hebt u geen recht op btw-aftrek? Dan schrijft u af over de aanschafkosten inclusief btw.

[Belastingdienst, Hoe berekent u het bedrag van de afschrijving?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/winst/inkomstenbelasting/inkomstenbelasting_voor_ondernemers/afschrijving/hoe_berekent_u_het_bedrag_van_de_afschrijving), read 2026-11-28

> Houd bij de afschrijving rekening met de restwaarde.

> Net als bij gewone afschrijving, mag de boekwaarde van het bedrijfsmiddel niet lager worden dan de restwaarde.

[Belastingdienst, Fiscale informatie 2026, Winst-en-verliesrekening en balans](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_en_verliesrekening_en_balans), read 2026-11-28

Where Florin implements it: `AssetService`. A useful life of one year or
more is accepted, and every asset has a residual value below which it is
not depreciated. Depreciation is spread by day over the useful life, and is
at most `maxDepreciationRate` of the cost (after any herinvesteringsreserve
booked off on it) for each year in use, counted by the share of days of
each calendar year: a life shorter than the cap allows is spread over more
years, as in the example above. Florin depreciates the business-use share
of an asset, which equals full depreciation minus a proportional
private-use correction. A car counts in full and uses the private-use
addition below instead. Depreciation starts on the purchase date,
time-proportionally; an asset bought but not yet in use is not
distinguished. The cost is the price excl. BTW, plus BTW not reclaimed, and
the cost help asks for it minus discounts and subsidies. Goodwill and
buildings are not recorded as assets in Florin.

> kosten van zaken met een geringe waarde Als regel kunt u aanhouden dat dit zaken zijn met een kostprijs van minder dan € 450. Kunt u de btw op de kosten terugkrijgen, dan neemt u de kostprijs exclusief btw.

[Belastingdienst, Kosten die u in 1 jaar mag aftrekken](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/winst/inkomstenbelasting/inkomstenbelasting_voor_ondernemers/zakelijke_kosten/kosten_die_u_in_1_jaar_mag_aftrekken), read 2026-11-28

The guide says items of small value, as a rule of thumb below € 450, are an
expense in the year of purchase, not an asset (art. 3.30 lid 4 names no
amount; the € 450 is the Belastingdienst's rule of thumb).

Not modelled: a discount or subsidy received after purchase; enter the cost
net of it. A later one is a vervreemding for the desinvesteringsbijtelling
(art. 3.47 lid 5), which Florin does not compute.

## Selling an asset

> U mag boekwinst op bedrijfsmiddelen opnemen in de herinvesteringsreserve. De voorwaarde hiervoor is dat u op de balansdatum een voornemen hebt om te herinvesteren in een bedrijfsmiddel. U neemt dan de boekwinst van het verkochte bedrijfsmiddel niet op in de fiscale winst, maar voegt deze toe aan de herinvesteringsreserve.

> Gaat u vervolgens herinvesteren? U moet dan de gereserveerde boekwinst meteen afboeken op de aanschafprijs van het aangeschafte bedrijfsmiddel. […] De afboeking verlaagt de afschrijving van het nieuwe bedrijfsmiddel.

> De reserve (of het restant daarvan) valt ook vrij als er 3 jaar verstreken zijn na het boekjaar waarin u de reserve hebt gevormd en u nog niet een herinvestering hebt gedaan.

[Belastingdienst, Fiscale informatie 2026, Winst-en-verliesrekening en balans, 7.7.1.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_en_verliesrekening_en_balans), read 2026-11-28

Where Florin implements it: `AssetService.disposalResult` adds the proceeds
minus the book value to the profit in the year of sale, unless the gain is put
in the herinvesteringsreserve. When the sale was invoiced in Florin, the
asset names that invoice: its amount less the credit notes on it is the
proceeds (`AssetService.withSaleInvoices`), and it is left out of revenue so
the sale is not counted twice. `AssetService.reserveLedger` books reserves off
on later purchases, oldest first, and releases what is left after 3 years or
when the business stops. The rule that a booked-off asset may not drop below
the book value of the one sold, and the exception for assets not depreciated
or depreciated over more than 10 years, are left to the user.

> U moet de herinvesteringsreserve (of het restant daarvan) toevoegen aan de winst op het moment dat u niet meer van plan bent om te herinvesteren.

[Belastingdienst, Fiscale informatie 2026, Winst-en-verliesrekening en balans, 7.7.1.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_en_verliesrekening_en_balans), read 2026-11-28

Not modelled: Florin does not force booking the reserve off on a
reinvestment, which the Belastingdienst requires; enter it on the purchase.
Nor does it release the reserve when the intention to reinvest ends.

## BTW on an asset

> Kiest u ervoor om investeringsgoederen gedeeltelijk tot uw bedrijfsvermogen te rekenen? Dan maakt u een verdeling tussen zakelijk gebruik en privégebruik. De btw voor het zakelijke gedeelte is aftrekbaar voor zover dat gedeelte voor belaste omzet wordt gebruikt.

> Verkoopt u de goederen later weer? Dan mag u over het deel dat u tot uw privévermogen rekent, geen btw in rekening brengen. Gaat het over een roerend goed? Dan berekent u btw over het deel dat u als bedrijfsvermogen hebt aangemerkt.

[Belastingdienst, Btw aftrekken als u investeringsgoederen gedeeltelijk tot bedrijfsvermogen rekent](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/privegebruik/gemengd_gebruik/investeringsgoederen/gedeeltelijk_bedrijfsvermogen), read 2026-11-24

> 3 Met een levering onder bezwarende titel als bedoeld in artikel 1, onderdeel a, worden gelijkgesteld: a. het door een ondernemer aan zijn bedrijf onttrekken van een goed dat hij voor eigen privé-doeleinden of voor privé-doeleinden van zijn personeel bestemt, dat hij om niet verstrekt of, meer in het algemeen, dat hij voor andere dan bedrijfsdoeleinden bestemt, ingeval met betrekking tot dat goed of de bestanddelen daarvan recht op volledige of gedeeltelijke aftrek van de belasting is ontstaan;

[Wet op de omzetbelasting 1968, artikel 3 lid 3](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-24

> 3 Ten aanzien van de handelingen, bedoeld in artikel 3, derde lid, en artikel 3a, eerste lid, wordt de vergoeding gesteld op de aankoopprijs van de goederen of van soortgelijke goederen of, indien er geen aankoopprijs is, de kostprijs, berekend op het tijdstip waarop deze handelingen worden uitgevoerd.

> 5 Bij of krachtens algemene maatregel van bestuur kan worden bepaald in hoever: […] d. bij levering anders dan met toepassing van artikel 28b of 28d, van gebruikte personenauto's, gebruikte motorrijwielen en gebruikte bestelauto's in de zin van artikel 10 van de Wet op de belasting van personenauto’s en motorrijwielen 1992, de vergoeding wordt verminderd met de op de voet van die wet geheven belasting.

[Wet op de omzetbelasting 1968, artikel 8 leden 3 en 5](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-24

> r. de levering van een roerende zaak die in het bedrijf van de ondernemer uitsluitend is gebruikt ten behoeve van vrijgestelde prestaties of voor doeleinden als zijn bedoeld in artikel 16, ingeval ter zake van de voorafgaande levering van die zaak geen belasting in aftrek is gebracht;

[Wet op de omzetbelasting 1968, artikel 11 lid 1](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-24

> De levering van gebruikte roerende bedrijfsmiddelen is vrijgesteld van btw, als u die uitsluitend hebt gebruikt voor:

[Belastingdienst, Vrijstelling roerende bedrijfsmiddelen gebruikt binnen eigen bedrijf](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/tarieven_en_vrijstellingen/vrijstellingen/vrijstelling_voor_levering_roerende_bedrijfsmiddelen_die_binnen_het_eigen_bedrijf_gebruikt_zijn), read 2026-11-24

> En hebt u bij aanschaf van die goederen btw afgetrokken? Dan moet u over de aankoop- of voortbrengingskosten btw berekenen.

> Zijn de goederen al wel gebruikt in uw onderneming? Dan betaalt u btw over de actuele prijs van een vergelijkbaar goed. Dit is de prijs (exclusief btw) die u betaalt voor goederen in dezelfde staat als de goederen die u privé gaat gebruiken.

[Belastingdienst, Btw aftrekken als u bedrijfsgoederen alleen privé gebruikt](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/privegebruik/uitsluitend_privegebruik), read 2026-11-28

Where Florin implements it: the asset form, `FixedAssetDomain` in
`lib/services/domain.dart`, `VatService.calculateQuarter` and
`KorService.applyToAssets`.

- An asset holds the BTW of its purchase as an expense does: the rate, who
  accounts for it (`PurchaseVat`), and whether it is reclaimed. The BTW back
  is the business share (`PurchaseMath.vatToReclaim`), in 5b of the quarter
  of purchase, with shifted BTW in 2a, 4a or 4b. A car is wholly in the
  business, so all its purchase BTW is reclaimed and private use is paid in
  1d. For a purchase year without rules in Florin the BTW is entered as an
  amount, as no return of that year is made in Florin.
- A sale, or taking the asset out of the business with its market value as
  proceeds, carries BTW over the business share of the proceeds at the rate
  the user picks: the general rate by default, exempt for the case of
  artikel 11 lid 1 r. Taking an asset into private use carries no BTW when
  no BTW was deducted on it (artikel 3 lid 3 a); the help of the rate says
  to choose exempt then. For the proceeds of a withdrawal the help asks
  what a similar asset in the same state costs now, as quoted above. It goes in 1a, 1b or 1e of the quarter of the disposal
  date. A sale invoiced in Florin is named on the asset and carries its BTW
  in that invoice only.
- Not modelled: the reduction of the base by the rest-BPM of a used car
  (artikel 8 lid 5 d), so Florin counts BTW over the whole proceeds, the
  cautious reading; the revision of deducted BTW when the business share
  changes in later years; and private use of an asset kept wholly in the
  business, other than a car. The business share entered is the share in
  the business for BTW and income tax alike.

## Herziening of BTW on assets

> bij roerende goederen wordt de btw-aftrek nog 5 jaar gevolgd (het jaar van ingebruikname en de 4 jaar daaropvolgend)

> Bepaal nu 10 % van percentage 1. In dit voorbeeld is dat 10 %. Is percentage 3 kleiner dan of gelijk aan 10 % van percentage 1? Dan vindt er geen herziening van de btw plaats en hoeft u niets te doen. Is percentage 3 groter dan 10 % van percentage 1? Dan moet u herzien.

> Is percentage 2 kleiner dan percentage 1? Dan kunt u de herziening aangeven als een extra bedrag aan af te dragen btw, in rubriek 1 van uw btw-aangifte.

> In dit voorbeeld is percentage 2 (30) kleiner dan percentage 1 (100), dus u telt € 20.580 op bij rubriek 1a, in uw laatste btw-aangifte van het jaar.

> Door de verkoop wordt de herziening voor deze 2 jaar nu in 1 keer uitgevoerd.

[Belastingdienst, Herziening btw-aftrek bij investeringsdiensten](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/btw-aftrek-investeringsdiensten), read 2026-11-25

> Als u te veel voorbelasting hebt afgetrokken, dan kunt u de herziening aangeven als een extra bedrag aan btw bij rubriek 1 van de aangifte.

[Belastingdienst, Toelichting bij de btw-aangifte 2026, p. 6](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28: the rubriek the herziening goes in.

> Er vindt geen herziening voor aftrek bij investeringsgoederen en -diensten plaats als: het gaat om investeringsgoederen die in de jaren voor dat boekjaar in gebruik zijn genomen én de herziening het gevolg is van het aanmelden of beëindigen van uw deelname aan de KOR en het totale bedrag van de herziening in dat boekjaar minder is dan € 500

> Eind 2025 controleert u of u de btw-aftrek moet herzien. De herzieningsperiode voor investeringsgoederen, zoals deze auto, is 5 jaar (het jaar van ingebruikname en de 4 jaren daarna). Hierdoor is € 4.500 / 5 = € 900 van de btw die u eerder hebt afgetrokken, toe te wijzen aan 2025.

> Eind 2024 gaat u controleren of u uw btw-aftrek moet herzien. Het gaat hier om het 1e jaar van ingebruikname van de auto. Voor de herziening moet u daarom kijken naar het volledige bedrag dat u eerder in uw aangifte hebt afgetrokken. En niet maar 1/5 van dat bedrag.

> Moet u tijdens uw deelname aan de KOR uw btw herzien? Dan vraagt u daarvoor zelf schriftelijk een aangifte omzetbelasting aan bij uw belastingkantoor.

[Belastingdienst, Moet ik mijn btw-aftrek herzien vanwege de kleineondernemersregeling (KOR)?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/hoe_werkt_de_btw/kleineondernemersregeling/wat-betekent-meedoen-met-de-kleineondernemersregeling/moet-ik-mijn-btw-aftrek-herzien-vanwege-de-kleineondernemersregeling), read 2026-11-25

> Gebruikt u de goederen meteen na aankoop? Dan bekijkt u aan het einde van het jaar of de bij aankoop afgetrokken btw ook juist is op basis van de omzetverhoudingen van het gehele boekjaar.

> In deze periode bekijkt u elk jaar of de verhouding tussen belast en vrijgesteld gebruik nog hetzelfde is als in het jaar dat u de investeringsgoederen in gebruik hebt genomen. Is dat niet zo? En is het verschil groter dan 10%? Dan moet u een deel van de afgetrokken btw herzien.

[Belastingdienst, Herziening btw-aftrek bij investeringsgoederen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/belaste_en_vrijgestelde_omzet/inschatting_van_het_gebruik2/herziening_aftrek_bij_investeringsgoederen2/herziening_aftrek_bij_investeringsgoederen), read 2026-11-28

> U meldt zich per 1 juli 2024 aan voor de KOR.

> Omdat u deelneemt aan de KOR zijn uw prestaties dat jaar voor 50% belast en voor 50% vrijgesteld.

[Belastingdienst, Moet ik mijn btw-aftrek herzien vanwege de kleineondernemersregeling (KOR)?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/hoe_werkt_de_btw/kleineondernemersregeling/wat-betekent-meedoen-met-de-kleineondernemersregeling/moet-ik-mijn-btw-aftrek-herzien-vanwege-de-kleineondernemersregeling), read 2026-11-28

> 1 De aftrek van de in artikel 15 van de wet bedoelde belasting (voorbelasting) geschiedt, ingeval de ondernemer zowel handelingen verricht waarvoor recht op aftrek van voorbelasting bestaat als handelingen verricht waarvoor geen recht op aftrek van voorbelasting bestaat, met inachtneming van het volgende: a. van goederen en diensten, die uitsluitend worden gebruikt voor handelingen waarvoor recht op aftrek van voorbelasting bestaat, komt de voorbelasting geheel voor aftrek in aanmerking;

[Uitvoeringsbeschikking omzetbelasting 1968, artikel 11](https://wetten.overheid.nl/BWBR0002634/2026-04-01), read 2026-11-28 from the official XML of the version in force since 1 April 2026

> 3 Bij de aangifte over het laatste belastingtijdvak van het boekjaar vindt herziening van de aftrek plaats op basis van de voor het gehele boekjaar geldende gegevens.

[Uitvoeringsbeschikking omzetbelasting 1968, artikel 12](https://wetten.overheid.nl/BWBR0002634/2026-04-01), read 2026-11-28

> 1 In afwijking van artikel 11 worden voor de toepassing van de aftrek afzonderlijk in aanmerking genomen: a. onroerende zaken en rechten waaraan deze zijn onderworpen; b. roerende zaken waarop de ondernemer voor de inkomstenbelasting of de vennootschapsbelasting afschrijft, of waarop hij zou kunnen afschrijven indien hij aan een zodanige belasting zou zijn onderworpen;

> 3 Met betrekking tot de roerende zaken, bedoeld in het eerste lid, onderdeel b, en de investeringsdiensten, bedoeld in het eerste lid, onderdeel c, wordt de aftrek herzien in elk van de vier boekjaren, volgende op dat waarin de ondernemer het goed of de investeringsdienst is gaan gebruiken. De herziening geschiedt telkens voor een vijfde gedeelte van de voorbelasting op basis van de voor het boekjaar geldende gegevens bij de aangifte over het laatste belastingtijdvak van dat boekjaar.

> 4 De herziening blijft achterwege in het boekjaar waarin de belasting welke op basis van de voor dat boekjaar geldende gegevens voor aftrek in aanmerking komt, niet meer dan tien percent verschilt van de in aftrek gebrachte belasting, met dien verstande dat wanneer de herziening het gevolg is van aanvang of beëindiging van de vrijstelling, bedoeld in artikel 25a, eerste of tweede lid, of artikel 25c, eerste lid, van de wet, deze in ieder geval achterwege blijft wanneer het bedrag van de herziening in dat boekjaar minder is dan € 500.

[Uitvoeringsbeschikking omzetbelasting 1968, artikel 13](https://wetten.overheid.nl/BWBR0002634/2026-04-01), read 2026-11-28

> 1 In geval van levering door de ondernemer van de goederen, bedoeld in artikel 13, eerste lid, onderdelen a en b, binnen de termijn waarin de aftrek voor het goed of de aan het goed verrichte investeringsdienst, bedoeld in artikel 13, eerste lid, onderdeel c, wordt herzien, is artikel 13, tweede en derde lid, van overeenkomstige toepassing. Daarbij wordt de ondernemer geacht tot het einde van elk van die termijnen het gebruik van het goed, onderscheidenlijk de dienst, voor bedrijfsdoeleinden voort te zetten uitsluitend ten behoeve van: a. belaste handelingen, indien ter zake van de levering van het goed belasting verschuldigd is dan wel geen belasting verschuldigd is omdat het gaat om een handeling als bedoeld in artikel 15, tweede lid, van de wet; b. handelingen waarvoor geen recht op aftrek van voorbelasting bestaat, indien ter zake van de levering van het goed geen belasting verschuldigd is en het niet gaat om een handeling als bedoeld in artikel 15, tweede lid, van de wet.

> 2 De herziening geschiedt in één keer bij de aangifte over het belastingtijdvak waarin de levering plaatsvindt.

[Uitvoeringsbeschikking omzetbelasting 1968, artikel 13a](https://wetten.overheid.nl/BWBR0002634/2026-04-01), read 2026-11-28

Where Florin implements it: `KorService.revision`, for every asset whose
purchase BTW was deducted, in the years of `vatRevisionYears`, and
`VatService.fromRecords`, which puts each part in its return. The taxed
share of a year is the share of the whole year's invoiced turnover that is
not exempt under the KOR, or, in a year without turnover, the share of its
days the KOR does not cover (`KorService.taxedShare`); in the year of sale
it runs to the sale. The year of purchase also counts from 1 January, as
artikel 12 lid 3 takes "de voor het gehele boekjaar geldende gegevens". An
asset that is not in the business on any day the KOR applies in a year,
such as one bought after the KOR ended that year, served only taxed
supplies and is not revised for that year (artikel 11 lid 1 a).

- In the year of purchase the whole deduction follows that year's share,
  without a margin (artikel 12 lid 3).
- In a later year one fifth a year follows the change from the first year's
  share (artikel 13 lid 3). A change of at most `vatRevisionMinShift` of the
  first year's share is not revised in a later year (artikel 13 lid 4), and
  a later years' total below `korRevisionMin` is not revised.
- Both go into the BTW of rubriek 1a in the last return of the year.
- A sale while the KOR applies settles the remaining years at once as exempt
  use (artikel 13a lid 1 b), in the BTW of rubriek 1a of the return over the
  period of the sale (artikel 13a lid 2). A sale under the KOR in the year of
  purchase repays the whole deduction there.
- Every amount is listed per asset on the BTW return screen and per asset
  and return in `btw_herziening`, and makes a quarter the KOR covers need an
  incidental return.

Cautious choice: artikel 13 lid 4 does not say whether its margin reaches
the revision of artikel 12 lid 3; the Belastingdienst names it for the
later years only, so Florin revises the year of purchase without it.

Not modelled: the revision in the user's favour when the KOR ends, which the
user may claim but Florin does not compute (the cautious side); a sale with
BTW after a year under the KOR (artikel 13a lid 1 a), which would give BTW
back; intangible assets, which artikel 13 lid 1 b does not cover and which
Florin still revises (the cautious side); the year of first use, which
Florin takes as the year of purchase; real estate (10 years), which Florin
does not record; the revision of goods and services that are not
investment goods; and changes in taxed use other than the KOR. The asset's
income tax cost does not follow the repaid BTW.

## Investeringsaftrek and desinvesteringsbijtelling

> U kunt voor een bedrijfsmiddel niet tegelijk gebruikmaken van de energie-investeringsaftrek en de milieu-investeringsaftrek.

> investeringen in personenauto's die niet bestemd zijn voor beroepsvervoer

> Verkoopt u een bedrijfsmiddel binnen 5 jaar na het begin van het jaar waarin u de investering deed? Dan moet u (een deel van) de investeringsaftrek die u voor die investering kreeg, terugnemen. […] Deze bijtelling kan niet hoger zijn dan de investeringsaftrek die u eerder hebt toegepast. […] Neem voor de bijtelling het percentage dat u bij de investeringsaftrek hebt toegepast. U berekent het percentage door de aftrek die u kreeg in het jaar van aanschaf, te delen door het totale investeringsbedrag waarover u in dat jaar de aftrek kreeg

[Belastingdienst, Fiscale informatie 2026, Ondernemersaftrek en investeringsaftrek, 8.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/ondernemersaftrek_en_investeringsaftrek), read 2026-11-28

> 1 Voor de investeringsaftrek behoren niet tot de bedrijfsmiddelen: […] d. personenauto's als bedoeld in artikel 3 van de Wet op de belasting van personenauto's en motorrijwielen 1992, die niet zijn bestemd voor het beroepsvervoer over de weg; […] 3 Voor de milieu-investeringsaftrek is het eerste lid, onderdelen c en d, niet van toepassing.

[Wet inkomstenbelasting 2001, artikel 3.45](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24

> 1 Onder investeren wordt verstaan het aangaan van verplichtingen ter zake van de aanschaffing of de verbetering van een bedrijfsmiddel, alsmede het maken van voortbrengingskosten ter zake van een bedrijfsmiddel, voorzover die verplichtingen en kosten op de belastingplichtige drukken.

[Wet inkomstenbelasting 2001, artikel 3.43](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24

> 1 Indien bij het einde van het kalenderjaar het bedrijfsmiddel nog niet in gebruik is genomen en de investeringsaftrek zou uitgaan boven wat bij het einde van dat kalenderjaar ter zake van de investering is betaald, wordt in afwijking in zoverre van de artikelen 3.41, 3.42 en 3.42a een bedrag gelijk aan de betaling in aanmerking genomen en wordt het meerdere in aanmerking genomen in de volgende kalenderjaren en wel voorzover betalingen plaatsvinden, maar niet later dan in het kalenderjaar waarin het bedrijfsmiddel in gebruik wordt genomen.

[Wet inkomstenbelasting 2001, artikel 3.44](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

> 2 Voor de kleinschaligheidsinvesteringsaftrek behoren tot de bedrijfsmiddelen mede niet: a. bedrijfsmiddelen die zijn bestemd om – direct of indirect – hoofdzakelijk ter beschikking te worden gesteld aan derden en b. bedrijfsmiddelen waarvan het investeringsbedrag minder bedraagt dan € 450.

[Wet inkomstenbelasting 2001, artikel 3.45 lid 2](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

> 1 Voor de investeringsaftrek worden niet in aanmerking genomen verplichtingen aangegaan tussen: a. de belastingplichtige en personen die tot zijn huishouden behoren; b. bloed- of aanverwanten in de rechte lijn of personen die behoren tot hun huishouden; c. gerechtigden tot een nalatenschap waartoe het bedrijfsmiddel behoort of d. degene die voor ten minste een derde gedeelte belang heeft in een lichaam en dat lichaam.

[Wet inkomstenbelasting 2001, artikel 3.46 lid 1](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

> 3 Met vervreemding wordt gelijkgesteld: a. het onttrekken van een goed aan de onderneming; b. het wijzigen van de bestemming van een goed zodanig dat dit gaat voldoen aan de omschrijving van artikel 3.45, tweede lid, onderdeel a, en vierde lid, onderdeel a, en c. het wijzigen van de bestemming van een goed zodanig dat dit gaat voldoen aan de omschrijving van artikel 3.45, eerste lid, onderdeel a, onder 2°. 4 Voor de toepassing van het derde lid geldt de waarde in het economische verkeer van het goed als overdrachtsprijs. 5 Indien een investering ongedaan wordt gemaakt, of voor een investering een vermindering, teruggaaf of vergoeding wordt genoten, geldt dat als vervreemding van een goed en geldt het bedrag van die investering, vermindering, teruggaaf of vergoeding als overdrachtsprijs.

[Wet inkomstenbelasting 2001, artikel 3.47](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

> bedrijfsmiddelen die u van uw privévermogen overbrengt naar het vermogen van uw onderneming

> U kunt kiezen voor de energie-investeringsaftrek als u hebt geïnvesteerd in nieuwe bedrijfsmiddelen

> een verhuurbestemming krijgt Deze situatie geldt alleen voor de kleinschaligheidsinvesteringsaftrek, niet voor de milieu- of energie-investeringsaftrek.

[Belastingdienst, Fiscale informatie 2026, Ondernemersaftrek en investeringsaftrek, 8.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/ondernemersaftrek_en_investeringsaftrek), read 2026-11-28

Where Florin implements it: `AssetService`, on the investment
`FixedAsset.cost`: the price excl. BTW plus BTW that is not reclaimed, which
stays a burden on the ondernemer (`PurchaseMath.cost`, shared with
expenses). The KIA, EIA and MIA, their minimum per asset, depreciation and
the desinvesteringsbijtelling all use it. A car never counts for the KIA
or the EIA, and the asset form hides those options for a car: Florin cannot
tell a passenger car from a van, so it takes the cautious reading. The MIA
applies to a car, as lid 3 allows.
The deduction received for an asset is computed when Florin has the rules of
its purchase year, and entered by the user otherwise. Gifting an asset and
moving it to private property are recorded as a sale with the market value
as proceeds (art. 3.47 lid 3 a and lid 4). The KIA help names the
exclusions of artikel 3.45 and 3.46 and of assets moved from private
property, and the EIA and MIA help that the asset must be new.

Not modelled: art. 3.44, an asset not in use on 31 December and not fully
paid, as Florin records neither the date of use nor the payments; the
section help says so and the full deduction is given in the purchase year.
A KIA asset that comes to be rented out mainly to third parties, which adds
back the KIA without a sale (art. 3.47 lid 3 b), and an investment not
taken into use within 3 years or less than 25% paid within 12 months
(lid 6).

## Private use of a business car

> Indien aan de belastingplichtige ook voor privédoeleinden een auto ter beschikking staat, wordt op jaarbasis ten minste: a. 22% van de waarde van de auto als onttrekking in aanmerking genomen indien de auto niet meer dan 16 jaar geleden voor het eerst in gebruik is genomen; b. 35% van de waarde van de auto […] indien de auto meer dan 16 jaar geleden voor het eerst in gebruik is genomen. […] tenzij blijkt dat de auto op jaarbasis voor niet meer dan 500 kilometer voor privédoeleinden wordt gebruikt.

> Na de eerste wijziging van de CO2-uitstootgrens of het percentage in het tweede lid na de datum van eerste toelating van de auto, is voor een periode van 60 maanden te rekenen vanaf de eerste dag van de maand volgend op de datum van eerste toelating, de verlaging, bedoeld in het tweede lid, van toepassing overeenkomstig de bepalingen die gelden direct voorafgaand aan die wijziging.

> 5 Voor de toepassing van dit artikel en de daarop berustende bepalingen wordt verstaan onder: […] b. waarde van de auto: catalogusprijs in de zin van artikel 9 van de Wet op de belasting van personenauto’s en motorrijwielen 1992 vermeerderd met de belasting van personenauto’s en motorrijwielen ingevolge de artikelen 9 tot en met 9c van die wet, met dien verstande dat de waarde van een auto die meer dan vijftien jaar geleden voor het eerst in gebruik is genomen, wordt gesteld op de waarde in het economische verkeer.

> 4 De onttrekking wordt in aanmerking genomen voorzover zij uitgaat boven de bedragen die de belastingplichtige ter zake van de kosten en lasten van de auto voor eigen rekening heeft genomen.

[Wet inkomstenbelasting 2001, artikel 3.20 leden 1, 4, 5 en 11](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML; the version from 21 February 2026 reads the same

> 1 In afwijking van artikel 3.20, eerste lid, eerste volzin, aanhef en onderdeel a, wordt voor een auto met een datum van eerste toelating van uiterlijk 31 december 2016 als onttrekking als bedoeld in artikel 3.20, eerste lid, eerste volzin, onderdeel a, op jaarbasis ten minste 25% van de waarde van de auto in aanmerking genomen.

[Wet inkomstenbelasting 2001, artikel 10a.4 lid 1](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

> Is uw personenauto of bestelauto ouder dan 16 jaar? Dan geldt vanaf het moment dat de auto ouder is dan 16 jaar de waarde in het economisch verkeer.

> Krijgt u in de loop van het jaar een andere auto van uw onderneming? Dan is de bijtelling alleen € 0 als u op jaarbasis met de auto's in totaal niet meer dan 500 kilometer privé rijdt.

[Belastingdienst, Fiscale informatie 2026, Winst uit onderneming, 6.4.1.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_uit_onderneming), read 2026-11-28

> Voor auto’s die in 2026 de jaargrens van 15 jaar bereiken geldt dat de youngtimerregeling nog niet van toepassing is geweest. Voor deze groep verandert er per 1 januari 2026 niets: de bijtelling werd en wordt berekend op grond van de catalogusprijs.

> Artikel 3.20, eerste lid, eerste volzin, aanhef en onderdeel b, Wet IB 2001 zoals dat luidde op 31 december 2025 mag gedurende het jaar 2026 worden toegepast als de auto: a. in de loop van het kalenderjaar 2025 meer dan 15 jaar maar minder dan 16 jaar geleden voor het eerst in gebruik is genomen; en b. uiterlijk 31 december 2025 ter beschikking staat aan de betreffende belastingplichtige.

[Staatscourant 2026, 6596](https://zoek.officielebekendmakingen.nl/stcrt-2026-6596.html), toelichting and artikel 2.2, read 2026-11-28

The sources differ on the value of a car more than 15 but not more than 16
years old: lid 5 b takes the market value, the Belastingdienst and the
Staatssecretaris the catalogue price. Florin takes the higher of the two in
that window, the cautious answer, and the market value once the car is more
than 16 years old, where both agree.

The zero-emission reduction of artikel 3.20 lid 2 in each version, used for
cars first registered in that year (`car_reductions.dart`):

| Version | Reduction | Maximum |
| --- | --- | --- |
| [2021-01-01](https://wetten.overheid.nl/BWBR0011353/2021-01-01) | 10% | € 4.000 |
| [2022-01-01](https://wetten.overheid.nl/BWBR0011353/2022-01-01) | 6% | € 2.100 |
| [2023-01-01](https://wetten.overheid.nl/BWBR0011353/2023-01-01) | 6% | € 1.800 |
| [2024-01-01](https://wetten.overheid.nl/BWBR0011353/2024-01-01) | 6% | € 1.800 |
| [2025-01-01](https://wetten.overheid.nl/BWBR0011353/2025-01-01) | 5% | € 1.500 |

> Rijdt u in een (bestel)auto van uw onderneming? En gebruikt u deze auto ook privé? Dan telt u voor dat privégebruik een bedrag bij de winst. Dit bedrag is maximaal het bedrag van de autokosten.

[Belastingdienst, Fiscale informatie 2026, Winst uit onderneming, 6.4.1.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_uit_onderneming), read 2026-11-28

Where Florin implements it: `CarService.privateUseAddition`, day by day over
the days the car is in the business. A car is "meer dan vijftien" or "meer
dan 16 jaar" old from the day after that anniversary of its first
registration; on the anniversary itself exactly that many years have passed.
A car first registered in or before `carTransitionalLastYear` gets
`carTransitionalBijtellingRate` instead of `carBijtellingRate` until it is
older than `carOldAfterYears`. The addition is capped at the costs linked
to the car plus its depreciation; a car cost not linked to the car does not
raise the cap, and the help says to link every car cost. As the addition is how private use counts, a car and
the costs linked to it count in full: the asset and expense forms store a
business share of 100% for them and hide the slider. The 500 km test adds the private
kilometres of every business car in the year and annualises them over the
days on which the business had at least one car, and holds only when the
user keeps a trip log for each car that passes the check under Trip log.

Not modelled: the optional transition of Stcrt. 2026, 6596 for a car that
passed 15 years in 2025 and was in the business on 31 December 2025, which
may count at 35% of its market value for all of 2026; Florin applies the
statutory rule and the market value help names the choice. Also not
modelled: car costs paid privately or a contribution, which lower the
addition (lid 4); actual private costs above the bijtelling; and vans fit
only for goods (lid 5 a).

## Trip log

> Als u op jaarbasis 500 kilometer of minder privé rijdt, dan geldt geen bijtelling voor privégebruik. U moet dit wel kunnen aantonen, bijvoorbeeld door een rittenregistratie bij te houden.

> De rittenregistratie moet vermelden: het merk van de auto het type van de auto het kenteken van de auto de periode waarin u de mogelijkheid had om de auto te gebruiken Vermeld per rit: de datum de begin- en eindstand van de kilometerteller het vertrek- en aankomstadres

> de route die u hebt gereden Dit doet u alleen als dit niet de meest gebruikelijke route was. of het een privérit of een zakelijke rit was

> Voldoet uw rittenregistratie niet aan deze eisen of hebt u geen rittenregistratie bijgehouden? Dan verrekent u de bijtelling privégebruik auto met de autokosten van uw onderneming.

> Hebt u tijdens uw werk een privébezoek gebracht (bijvoorbeeld aan de dokter) en gebruikte u daarvoor de auto om tijd te besparen? Dan geldt dit als een privérit.

[Belastingdienst, Fiscale informatie 2026, Winst uit onderneming, 6.4.1.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_uit_onderneming), read 2026-11-25; the last quote read 2026-11-28

Where Florin implements it: `CarService.checkTripLog`. A trip in a business
car stores the date, the odometer at start and end, both addresses, private
or business, the make and type and the plate; the car's record holds the
period it is in the business. Florin sorts a car's trips of the year by
odometer and checks that each trip starts where the one before ended: a
higher start means kilometres not in the log, a lower one an overlap. A trip
marked as not the usual route must name the route in its notes. A year with
no trips, a gap, an overlap or a missing route counts as no trip log
(`CarService.hasCompleteTripLog`): the addition and the BTW on private use
are then computed as without one, and the mileage list and the car's form
say why. The trip type help says a private stop during work is a private
trip.

Not modelled: the eenvoudige rittenregistratie with business addresses from
a project administration, the rules for driving instructors and the
verklaring uitsluitend zakelijk gebruik bestelauto. Florin cannot check that
the log covers the first and last kilometre of the period, only that it has
no gaps between trips.

## BTW on private use of a business car

> Hebt u geen administratie waaruit het privégebruik van de auto blijkt? Dan stelt u de btw die u moet betalen voor het privégebruik vast op 2,7% van de catalogusprijs van de auto, inclusief btw en bpm. […] Als u de auto in de loop van het jaar koopt, kunt u het percentage van 2,7% naar evenredigheid verlagen. […] U betaalt de btw voor het privégebruik auto via de laatste btw-aangifte van het boekjaar. […] En vindt het privégebruik plaats later dan 4 jaar na het jaar waarin u de auto in gebruik hebt genomen? Dan neemt u 1,5% in plaats van 2,7% […] Hebt u bij aankoop van een auto geen btw afgetrokken […]? Dan gebruikt u […] 1,5% in plaats van 2,7%. […] Valt uw afgetrokken btw voor de auto gedurende de 4 jaren na het jaar van aankoop van de auto lager uit dan het bedrag dat u zou moeten betalen voor privégebruik? Dan is de correctie voor privégebruik niet hoger dan de som van de volgende 2 bedragen: het btw-bedrag voor onderhoud en gebruik dat u in dat jaar hebt afgetrokken 1/5 deel van de afgetrokken btw bij aankoop

> In de rechterkolom 'Omzetbelasting' van de rubriek privégebruik geeft u de btw aan die u moet betalen. Hebt u geen administratie waaruit het privégebruik blijkt? In de linkerkolom 'Bedrag waarover omzetbelasting wordt berekend' vult u dan '0' in. Hebt u deze administratie wel? Vul dan in de linkerkolom het bedrag in waarover de btw wordt berekend.

[Belastingdienst, Btw en privégebruik auto van de zaak](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/btw_en_de_auto/privegebruik_auto_van_de_zaak/privegebruik_auto_van_de_zaak), read 2026-11-28

> Woon-werkverkeer valt voor de btw onder privégebruik. […] Deze privékilometers vergelijkt u aan het einde van het jaar met het totale aantal kilometers […]. De verhouding hiertussen gebruikt u om de btw te berekenen die u voor het privégebruik moet betalen.

[Belastingdienst, Btw en privégebruik auto van de zaak: woon-werkverkeer](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/btw_en_de_auto/privegebruik_auto_van_de_zaak/woon_werkverkeer), read 2026-11-28

> Rekent u de auto volledig tot uw bedrijfsvermogen? Dan kunt u de btw als voorbelasting aftrekken over de aanschaf, het onderhoud en het gebruik. U kunt de btw alleen aftrekken over het gedeelte dat voor belaste omzet wordt gebruikt. Gebruikt u of een werknemer een auto van de zaak privé? Dan moet u over dit privégebruik btw betalen.

[Belastingdienst, Btw aftrekken over een auto die u zakelijk en privé gebruikt](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/btw_en_de_auto/btw_en_de_auto), read 2026-11-24

> De catalogusprijs is de officiële nieuwprijs van de auto of bestelauto die geldt op de datum dat het kenteken deel 1 is afgegeven. Deze prijs is inclusief: btw bpm accessoires die door of namens de fabrikant of importeur zijn aangebracht voordat deel 1 van het kenteken is afgegeven

[Belastingdienst, Catalogusprijs voor berekening correctie privégebruik auto](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aftrekken/btw_en_de_auto/privegebruik_auto_van_de_zaak/catalogusprijs), read 2026-11-28

> De waarde van de auto is de oorspronkelijke catalogusprijs inclusief btw en bpm (belasting van personenauto's en motorrijwielen) en inclusief de accessoires die de dealer of de importeur vóór de tenaamstelling kenteken heeft aangebracht.

[Belastingdienst, Fiscale informatie 2026, Winst uit onderneming, 6.4.1.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_uit_onderneming), read 2026-11-28

> 2 Met een dienst verricht onder bezwarende titel als bedoeld in artikel 1, onderdeel a, worden gelijkgesteld: a. het gebruiken van een tot het bedrijf behorend goed voor privé-doeleinden van de ondernemer of van zijn personeel, of, meer in het algemeen, voor andere dan bedrijfsdoeleinden, wanneer voor dit goed recht op volledige of gedeeltelijke aftrek van de belasting is ontstaan;

[Wet op de omzetbelasting 1968, artikel 4](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28 from the official XML

> 1 Een ondernemer die in Nederland is gevestigd en van wie de jaaromzet in Nederland niet meer bedraagt dan € 20.000 kan kiezen voor toepassing van vrijstelling van belasting ter zake van door de ondernemer in Nederland verrichte leveringen van goederen en diensten.

[Wet op de omzetbelasting 1968, artikel 25a](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-28

> U hoeft een fictieve levering van goederen of diensten alleen aan te geven, als u de btw over deze goederen of diensten geheel of gedeeltelijk hebt afgetrokken.

[Belastingdienst, Toelichting bij de btw-aangifte (omzetbelasting) 2026, p. 11](https://download.belastingdienst.nl/belastingdienst/docs/toelichting_bij_btw_aangifte_ob0731t63fd.pdf), read 2026-11-28

Where Florin implements it: `CarService.btwPrivateUse`, reported in rubriek 1d
of the last return of the year, with the base of its left column in the
BTW return screen's figures and the `btw_<period>` export. The purchase BTW
is the BTW the car's record reclaims, counted in 5b in the quarter of
purchase; a car bought while the KOR applies reclaims none, so it counts as
one bought without BTW.

- Without a trip log Florin applies 2,7% or 1,5% by whole months, capped as
  quoted: in the 4 years after the year of purchase at the upkeep BTW plus
  one fifth of the purchase BTW, later or without purchase BTW at the upkeep
  BTW alone. The left column of 1d is 0.
- With a complete trip log it takes the private and commuting share of the
  BTW deducted that year, counting the purchase BTW as one fifth a year for
  the year of purchase and the four years after. The left column is the
  same share of the costs that BTW was deducted on: the business share of
  the car's expenses with BTW reclaimed, and one fifth of the purchase price
  excl. BTW in those five years.
- The catalogue value help names accessories fitted by the manufacturer,
  importer or dealer: the two pages name different parties, and the wider
  list gives the higher value.

Florin's readings, which the pages do not settle: in the year of purchase
the page names no cap below the BTW deducted that year, so the cap is the
upkeep BTW plus all purchase BTW; the one-fifth spread of the purchase BTW
on the trip-log route follows the spread the page uses for the cap; and in
the year of sale the forfait counts the whole months the car was in the
business, as for the year of purchase.

Cautious choice, sources in conflict: a car whose purchase BTW was deducted
before the KOR keeps its BTW on private use in a year the KOR covers,
alongside the herziening of that purchase BTW. Artikel 4 lid 2 a makes private use
a service only where a right to deduct arose, and artikel 25a lid 1 exempts
the supplies of a KOR participant, which points to no charge; the
Toelichting asks for a fictitious supply wherever BTW was deducted, which
points to one; no Belastingdienst page read addresses a KOR year. Florin
charges it, the branch that pays more, and the BTW return screen says so
(`vatReturnKorPrivateUseNotice`) when a car charged was in the business on
a day the KOR applied.

Not modelled: showing private use other than with a trip log, use of the
car for exempt supplies, and a contribution paid for private use.

## Urencriterium

The zelfstandigenaftrek requires the urencriterium (Wet IB 2001 artikel 3.76
lid 1). The hours threshold is a yearly figure in `TaxYearRules`. Florin
counts only the hours logged, in every year: until they reach the threshold
the estimate leaves out the zelfstandigenaftrek and the other deductions that
need it, and the P&L screen says so (AGENTS.md rule 5). The startersaftrek bij
arbeidsongeschiktheid (artikel 3.78a) needs the urencriterium not to be met,
so Florin applies it only once the year is over.

## Starters

> 3 Indien de ondernemer in een of meer van de vijf voorafgaande kalenderjaren geen ondernemer was en bij hem in die periode niet meer dan tweemaal zelfstandigenaftrek is toegepast, wordt de zelfstandigenaftrek verhoogd met € 2123.

[Wet inkomstenbelasting 2001, artikel 3.76 lid 3](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24 from the official XML of the version in force on 1 January 2026

> 1 De startersaftrek bij arbeidsongeschiktheid geldt voor de ondernemer die in een of meer van de vijf voorafgaande kalenderjaren geen ondernemer was, in het kalenderjaar recht heeft op een arbeidsongeschiktheidsuitkering als bedoeld in het tweede lid, of in het kalenderjaar recht heeft op arbeidsondersteuning op grond van de Wet arbeidsongeschiktheidsvoorziening jonggehandicapten, niet voldoet aan het urencriterium maar wel aan het verlaagde-urencriterium, bedoeld in het derde lid, en bij het begin van het kalenderjaar de pensioengerechtigde leeftijd, bedoeld in artikel 7a, eerste lid, van de Algemene Ouderdomswet, nog niet heeft bereikt.

[Wet inkomstenbelasting 2001, artikel 3.78a lid 1](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24 from the official XML of the version in force on 1 January 2026

Both conditions look back from the year itself, so they hold for some years
and not for later ones. Florin asks them per year under Your situation on the
P&L screen (`TaxYearInputs.notOndernemerBefore` and `isStarter`), never once
for the business: the startersaftrek of one year does not carry into the
next. The startersaftrek can only be ticked when the user was not an
ondernemer in one of the previous years. That fact alone lifts the time
condition of the urencriterium (artikel 3.6 lid 1 b) and is the starter
condition of the startersaftrek bij arbeidsongeschiktheid
(`TaxService.notOndernemerBefore`).

> Indien de zelfstandigenaftrek ingevolge de eerste volzin op nihil wordt gesteld, wordt er voor de toepassing van het derde lid van uit gegaan dat de zelfstandigenaftrek in dat kalenderjaar toepassing heeft gevonden.

> 7 De niet gerealiseerde zelfstandigenaftrek wordt in de volgende negen kalenderjaren verrekend door in die jaren een verhoging van de zelfstandigenaftrek in aanmerking te nemen. Deze verhoging bedraagt maximaal het bedrag waarmee de winst de zelfstandigenaftrek van dat jaar overtreft.

[Wet inkomstenbelasting 2001, artikel 3.76 leden 5 en 7](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

The help of the startersaftrek says that a year with a nil zelfstandigenaftrek
counts as a year it was applied (lid 5). Unused zelfstandigenaftrek from
earlier years is used only with the urencriterium and up to the profit above
this year's zelfstandigenaftrek (lid 7; `TaxService.calculate`).

## Tariefaanpassing

> 2 Indien bij het bepalen van het belastbare inkomen uit werk en woning een of meer bedragen ter zake van grondslagverminderende posten als bedoeld in het derde lid in aftrek zijn gebracht, bedraagt de belasting op het belastbare inkomen uit werk en woning het op basis van het eerste lid bepaalde bedrag vermeerderd met 11,94% van het bedrag waarmee de som van het belastbare inkomen uit werk en woning en de in aftrek gebrachte bedragen ter zake van grondslagverminderende posten als bedoeld in het derde lid, het in de eerste kolom van de in het eerste lid opgenomen tabel laatstvermelde bedrag te boven gaat, doch ten hoogste met 11,94% van de in aftrek gebrachte bedragen ter zake van grondslagverminderende posten als bedoeld in het derde lid. 3 De grondslagverminderende posten, bedoeld in het tweede lid, zijn: a. de ondernemersaftrek, bedoeld in artikel 3.74; b. de MKB-winstvrijstelling, bedoeld in artikel 3.79a, mits het gezamenlijke bedrag van de met de ondernemersaftrek verminderde winst, bedoeld in artikel 3.79a, positief is;

[Wet inkomstenbelasting 2001, artikel 2.10 lid 2 en 3](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24

Where Florin implements it: `TaxService.calculate` adds the tariefaanpassing
to box 1 tax before the heffingskortingen, shown on the P&L screen and in the
income tax export. The rate is a yearly figure (`tariefaanpassingRate`); the
threshold is where the top bracket starts. Florin has no eigen woning or
persoonsgebonden aftrek (lid 3 d and e), so only a and b apply.

## Income from employment

A user who also works as an employee enters the year's figures from the
jaaropgaven under Employment on the P&L screen (`TaxYearInputs`): the loon,
the loonheffing withheld and the loon Zvw. The hours in employment and other
work are asked with or without a job (see Urencriterium with a job).

> 2 Inkomen uit werk en woning is het gezamenlijke bedrag van: a. de belastbare winst uit onderneming (afdeling 3.2); b. het belastbare loon (afdeling 3.3);

[Wet inkomstenbelasting 2001, artikel 3.1 lid 2](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24

> Belastbaar loon is loon verminderd met de reisaftrek (paragraaf 3.3.2).

[Wet inkomstenbelasting 2001, artikel 3.80](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24

> Werkt u in loondienst of hebt u een ziektewetuitkering? Dan krijgt u van uw werkgever of uitkeringsinstantie een jaaropgaaf. Hierop staan de bedragen die u moet invullen in uw aangifte.

[Belastingdienst, Fiscale informatie 2026, Loon, pensioen, uitkeringen en afkoopsommen, 2.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/loon_pensioen_uitkeringen_en_afkoopsommen), read 2026-11-24

Florin adds the loon to the belastbare winst in box 1, so the brackets, the
tariefaanpassing and the algemene heffingskorting (on the verzamelinkomen,
artikel 2.18, before losses from earlier years are offset) apply to both
together. Florin has no reisaftrek: leaving it
out overstates the tax.

> e. arbeidsinkomen: het gezamenlijke bedrag van hetgeen door de belastingplichtige met tegenwoordige arbeid is genoten als winst uit een of meer ondernemingen, loon en resultaat uit een of meer werkzaamheden.

[Wet inkomstenbelasting 2001, artikel 8.1 lid 1](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24

The arbeidskorting is computed on the profit and the loon together. Artikel
8.11 lid 2 also sets a minimum: the arbeidskorting the employer applied.
Florin does not apply that minimum, which can only overstate the tax.

> 1 De voorheffingen zijn: a. de geheven loonbelasting met uitzondering van de als eindheffing geheven loonbelasting;

> 6 Indien artikel 9.1, derde lid, toepassing vindt, wordt ook als voorheffing aangemerkt de bij wijze van inhouding geheven premie voor de volksverzekeringen met uitzondering van de bij wijze van eindheffing geheven premie voor de volksverzekeringen.

[Wet inkomstenbelasting 2001, artikel 9.2 leden 1 en 6](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24

> Loonheffing wordt door uw werkgever of uitkeringsinstantie ingehouden op uw loon, pensioen en sommige uitkeringen en afkoopsommen. Deze wordt verrekend met de inkomstenbelasting die u moet betalen. U vult zowel uw loon als de ingehouden loonheffing in uw aangifte in.

[Belastingdienst, Fiscale informatie 2026, Te verrekenen belasting, 24.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/te_verrekenen_belasting), read 2026-11-24

Florin subtracts the loonheffing withheld from the estimated tax and shows
what is left to pay, or the refund. Payments on a voorlopige aanslag are also
settled in the return; Florin does not record them and says so.

> 5 Ingeval de inkomensafhankelijke bijdrage ingevolge artikel 49, derde lid, bij wege van aanslag wordt geheven, wordt daarbij als bijdrage-inkomen ten hoogste in aanmerking genomen een bedrag gelijk aan het in het derde lid bedoelde bedrag, verminderd met het loon, bedoeld in artikel 42, van de verzekeringsplichtige en met het door de verzekeringsplichtige van een inhoudingsplichtige genoten loon, bedoeld in het tweede lid, onderdeel a.

[Zorgverzekeringswet, artikel 43 lid 5](https://wetten.overheid.nl/BWBR0018450/2026-01-01), read 2026-11-24

> Hebt u loon, pensioen of een uitkering waarover de werkgever of uitkeringsinstantie al werkgeversheffing of bijdrage Zvw inhoudt? En hebt u ook andere inkomsten, bijvoorbeeld als freelancer? Dan berekenen wij de bijdrage Zvw van 4,85% alleen nog over uw andere inkomsten.

> Het loon Zorgverzekeringswet staat op de jaaropgaaf die u krijgt van uw werkgever of uitkeringsinstantie.

[Belastingdienst, Fiscale informatie 2026, Inkomensafhankelijke bijdrage Zorgverzekeringswet, 28.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/inkomensafhankelijke_bijdrage_zorgverzekeringswet), read 2026-11-24

Florin levies the Zvw contribution on the belastbare winst up to the maximum
bijdrage-inkomen minus the loon Zvw the user enters. The employer pays the
werkgeversheffing on the loon itself.

Where Florin implements it: `TaxService.calculate` (wages, arbeidskorting,
Zvw, `wageTaxWithheld`, `taxToPay`), the P&L screen rows and Employment
inputs, the dashboard's estimated tax, and the income tax export rows "Loon
uit dienstbetrekking", "Ingehouden loonheffing" and "Te betalen (negatief:
terug te ontvangen)". The estimated net profit after tax and the effective
rate subtract only the tax the business adds: the total tax minus the box 1
tax on the loon alone after its own heffingskortingen
(`TaxService.wageOnlyTax`). That split is Florin's arithmetic, not a rule of
law.

## Meewerkende partner

> 1 De meewerkaftrek geldt voor de ondernemer die aan het urencriterium voldoet en van wie de partner zonder enige vergoeding arbeid verricht in een onderneming waaruit de belastingplichtige als ondernemer winst geniet.

[Wet inkomstenbelasting 2001, artikel 3.78 lid 1](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-25 from the official XML

> 4 Bij het bepalen van de winst komen mede niet in aftrek kosten en lasten die verband houden met vergoeding van arbeid door de partner van de belastingplichtige, indien de vergoeding lager is dan € 5000.

[Wet inkomstenbelasting 2001, artikel 3.16 lid 4](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-25

> Uw fiscale partner werkt 525 uren of meer zonder vergoeding in uw onderneming, of de vergoeding die u hiervoor betaalt is minder dan € 5.000. U moet het aantal meegewerkte uren aannemelijk kunnen maken

[Belastingdienst, Fiscale informatie 2026, 8.7](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/ondernemersaftrek_en_investeringsaftrek), read 2026-11-25

The statute says "zonder enige vergoeding"; the Belastingdienst also counts
pay below € 5.000 as unpaid, the amount below which artikel 3.16 lid 4 makes
the pay not deductible. Florin follows the Belastingdienst.

Where Florin implements it: an hour entry can be marked as worked by the
fiscal partner (`HourEntries.byPartner`). Such hours never count for the
user's urencriterium or S&O hours (`ownHours`). The meewerkaftrek uses the
logged partner hours plus the yearly total of partner hours not in the log
(`TaxYearInputs.partnerHours`). The pay to the partner
(`TaxYearInputs.partnerPay`) is not deducted below `meewerkMaxPartnerPay`;
from it, Florin deducts it as a cost and gives no meewerkaftrek.

## Urencriterium with a job

> 1 In deze afdeling en de daarop berustende bepalingen wordt verstaan onder urencriterium: het gedurende het kalenderjaar besteden van ten minste 1225 uren aan werkzaamheden voor een of meer ondernemingen waaruit de belastingplichtige als ondernemer winst geniet, indien: a. de tijd die in totaal wordt besteed aan die ondernemingen en het verrichten van werkzaamheden in de zin van de afdelingen 3.3 en 3.4, grotendeels wordt besteed aan die ondernemingen of b. de ondernemer in een of meer van de vijf voorafgaande kalenderjaren geen ondernemer was.

[Wet inkomstenbelasting 2001, artikel 3.6 lid 1](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-24

> U besteedt meer tijd aan uw onderneming dan aan andere werkzaamheden (bijvoorbeeld in loondienst). Was u in 1 van de jaren 2021 tot en met 2025 geen ondernemer? Dan hoeft u niet te voldoen aan deze voorwaarde.

[Belastingdienst, Fiscale informatie 2026, Ondernemersaftrek en investeringsaftrek, 8.9](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/ondernemersaftrek_en_investeringsaftrek), read 2026-11-24

Florin requires the business hours logged to be more than the hours in
employment and other work the user enters, with or without a job; equal
hours do not meet it. The
condition does not apply when the user ticks for the year that they were not
an ondernemer in one or more of the five previous years, which eligibility
for the startersaftrek includes (artikel 3.76 lid 3; see Starters). The help
asks for the employment hours of the whole year while only logged business
hours count, so during the year the estimate leaves the deductions out rather
than assume them (AGENTS.md rule 5). The hours field asks for employment
(afdeling 3.3) and other work such as resultaat uit overige werkzaamheden
(afdeling 3.4) together.

Not modelled: hours during pregnancy and maternity leave that count as
worked (lid 5), and the hours for a samenwerkingsverband with related persons
that do not count (lid 2). Florin counts the hours logged as they are.

> 2 Voor de toepassing van het eerste lid, aanhef, komen niet in aanmerking werkzaamheden ten behoeve van een onderneming waaruit de belastingplichtige als ondernemer winst geniet en die deel uitmaakt van een samenwerkingsverband met een of meer met hem verbonden personen,

> 5 Indien de werkzaamheden, bedoeld in het eerste lid, worden onderbroken vanwege zwangerschap van de belastingplichtige, worden deze tijdens de periode die overeenkomt met het zwangerschaps- en bevallingsverlof zoals dat geldt voor werkneemsters, voor de bepaling van het aantal gewerkte uren geacht niet te zijn onderbroken.

[Wet inkomstenbelasting 2001, artikel 3.6 leden 2 en 5](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

Where Florin implements it: `TaxService.meetsUrencriterium` and
`TaxService.timeTestHours`, the P&L banner, and `UrencriteriumProgress` on
the dashboard and the Hours screen.

## Costs that are not deductible

> 1 Bij het bepalen van de winst komen niet in aftrek kosten en lasten die verband houden met de volgende posten: […] c. geldboeten opgelegd door een strafrechter en geldsommen betaald aan een staat of een onderdeel daarvan ter voorkoming van strafvervolging, in het kader van een strafbeschikking of daarmee vergelijkbare buitenlandse wijze van bestraffing, dan wel ter voldoening aan een voorwaarde verbonden aan een besluit tot gratieverlening, bestuurlijke boeten en daarmee vergelijkbare buitenlandse boeten, geldboeten opgelegd op basis van bij wet geregeld tuchtrecht, geldboeten opgelegd door een instelling van de Europese Unie, alsmede kosten als bedoeld in artikel 234, vijfde lid, en artikel 235, derde lid, van de Gemeentewet;

[Wet inkomstenbelasting 2001, artikel 3.14 lid 1](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-25

> 2 Bij het bepalen van de winst komen mede niet in aftrek kosten en lasten ten behoeve van de belastingplichtige zelf die verband houden met de volgende posten: a. telefoonabonnementen met betrekking tot telefoonaansluitingen in zijn woonruimte; b. literatuur, met uitzondering van vakliteratuur; c. kleding, met uitzondering van werkkleding; d. persoonlijke verzorging; e. geheven inkomensafhankelijke bijdragen als bedoeld in artikel 43 van de Zorgverzekeringswet, of een buitenlandse regeling die naar aard en strekking daarmee overeenkomt en f. reizen en verblijf in verband met cursussen en opleidingen voor studie en beroep, alsmede in verband met congressen, seminars, symposia, excursies, studiereizen en dergelijke, voorzover deze meer bedragen dan € 1500.

> 5 Voor de toepassing van het tweede lid, onderdeel c, wordt kleding als werkkleding aangemerkt indien zij: a. uitsluitend of nagenoeg uitsluitend geschikt is om in het kader van de onderneming te worden gedragen of b. is voorzien van zodanige uiterlijke kenmerken dat daaruit blijkt dat deze uitsluitend is bestemd om bij het behalen van de winst te worden gedragen.

> 7 Het tweede lid, onderdelen c en d, is niet van toepassing ten aanzien van de belastingplichtige die optreedt als artiest of als presentator of die als beroep een tak van sport beoefent.

> 8 Het tweede lid, onderdeel f, is niet van toepassing indien de aard van de door de belastingplichtige verrichte werkzaamheden noodzaakt tot het bijwonen van de desbetreffende cursussen, opleidingen, congressen, seminars, symposia, excursies en dergelijke respectievelijk het maken van de desbetreffende studiereizen.

[Wet inkomstenbelasting 2001, artikel 3.16](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-25 from the official XML

Where Florin implements it: the expense categories Fines, Clothing and
personal care, Phone line at home and Books other than professional
literature are barred (`ExpenseCategoryDomain.barredForIncomeTax`); the
estimate deducts nothing for them and the P&L shows their total as not
deductible. Travel and stay for courses and congresses is its own category,
limited to `courseTravelMax` a year (`TaxService.courseTravelDeductible`).
What is left counts with the gemengde kosten, because artikel 3.15 lid 2 puts
travel for congresses there; Florin cannot tell course travel from congress
travel, so it does the same for both, which overstates the tax for courses.

> 2 Onder de in het eerste lid bedoelde posten worden mede verstaan de desbetreffende reizen en het desbetreffende verblijf.

[Wet inkomstenbelasting 2001, artikel 3.15 lid 2](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

> Hierbij horen ook uw reis- en verblijfskosten voor congressen en dergelijke. U mag voor deze reis- en verblijfskosten maximaal € 1.500 aftrekken.

[Belastingdienst, Fiscale informatie 2026, Winst- en verliesrekening en balans, 7.5.2](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_en_verliesrekening_en_balans), read 2026-11-28

The BTW on these costs follows the user's choice on the form; these articles
are income tax rules only.

Cautious choices: lid 7 (artists, presenters and professional sportspeople
may deduct clothing and personal care) and lid 8 (no limit on course travel
when the work makes attending necessary) depend on facts Florin does not
hold, so Florin applies the bar and the limit, which overstates tax. Werkkleding
in the sense of lid 5 is booked under Other and deducted. Not modelled: the
home office rule of lid 1, the equipment of lid 3 and the Zvw bijdrage of
lid 2 e, which Florin never books as a cost.

## Voorlopige aanslag and toeslagen

> Meestal kunt u tot 1 mei van het volgende jaar een voorlopige aanslag aanvragen of wijzigen. De exacte datum hangt af van of u aangifte moet doen.

> Hebt u al aangifte gedaan? Dan kunt u over dat jaar geen voorlopige aanslag meer aanvragen. U kunt uw bestaande voorlopige aanslag ook niet meer wijzigen.

> Dan kunt u een voorlopige aanslag aanvragen of wijzigen tot de uiterste datum waarop uw aangifte binnen moet zijn. Die datum staat op uw aangiftebrief.

> Hebt u uitstel gekregen voor uw aangifte? Dan is de uitsteldatum ook de uiterste datum dat u een voorlopige aanslag kunt aanvragen of wijzigen.

[Belastingdienst, Tot wanneer kan ik een voorlopige aanslag aanvragen of wijzigen?](https://www.belastingdienst.nl/wps/wcm/connect/nl/voorlopige-aanslag/content/tot-wanneer-voorlopige-aanslag-aanvragen-wijzigen), read 2026-11-25

> Voor de toeslagen kijken we naar uw toetsingsinkomen. Dat is uw verzamelinkomen voor de belasting. Het toetsingsinkomen is niet uw winst.

> Hebt u een toeslagpartner? Dan tellen we het toetsingsinkomen van die persoon ook mee.

> Vindt u het moeilijk om uw inkomen te berekenen? Schat het dan liever iets te hoog in. U krijgt dan mogelijk nog geld terug. Als u een te laag inkomen doorgeeft, kan het zijn dat u te veel toeslag krijgt. U moet dan mogelijk geld terugbetalen.

> Als u recht hebt op ondernemersaftrekposten, dan mag u dit bedrag aftrekken van uw brutowinst.

[Belastingdienst, Ik heb een wisselend inkomen - heb ik recht op toeslagen?](https://www.belastingdienst.nl/wps/wcm/connect/nl/toeslagen/content/ik-heb-een-wisselend-inkomen-heb-ik-recht-op-toeslagen), read 2026-11-25

Where Florin implements it: the P&L and tax screen ends with a section
"Voorlopige aanslag and toeslagen (estimated)" that repeats the estimated
belastbare winst, the verzamelinkomen from box 1, before losses from earlier
years (artikel 2.18 and 3.1 lid 1), and the tax to pay, and names
the last day (`provisionalAssessmentDeadline`, 1 May of the next year) with
the letter and uitstel exceptions. The help says the toetsingsinkomen is the
verzamelinkomen plus a toeslagpartner's, that Florin's figure is box 1 from
its records only, and that the Belastingdienst advises estimating high.
Florin computes only the box 1 part of the verzamelinkomen, and no toeslag.

## Payment terms and late payment

> 1 De schadevergoeding, verschuldigd wegens vertraging in de voldoening van een geldsom, bestaat in het geval van een handelsovereenkomst in de wettelijke rente van die som met ingang van de dag volgend op de dag die is overeengekomen als de uiterste dag van betaling tot en met de dag waarop de schuldenaar de geldsom heeft voldaan.

> 2 Indien geen uiterste dag van betaling is overeengekomen, is de wettelijke rente van rechtswege verschuldigd: a. vanaf 30 dagen na de aanvang van de dag, volgende op die waarop de schuldenaar de factuur heeft ontvangen,

> 5 Partijen kunnen een uiterste dag van betaling overeenkomen van ten hoogste 60 dagen, tenzij zij uitdrukkelijk een langere termijn van betaling in de overeenkomst opnemen en deze termijn niet kennelijk onbillijk is jegens de schuldeiser,

> 6 In afwijking van lid 5 kunnen partijen geen uiterste dag van betaling overeenkomen van meer dan 30 dagen indien de schuldenaar een rechtspersoon is die op twee opeenvolgende balansdata, zonder onderbreking nadien op twee opeenvolgende balansdata, niet heeft voldaan aan ten minste twee van de vereisten, bedoeld in artikel 397, leden 1 en 2 van Boek 2, en de schuldeiser een natuurlijk persoon is die handelt in de uitoefening van een beroep of bedrijf of een rechtspersoon, die gedurende die periode aan ten minste twee van die vereisten heeft voldaan. Een beding in een overeenkomst in strijd met de vorige zin is nietig.

[Burgerlijk Wetboek Boek 6, artikel 119a](https://wetten.overheid.nl/BWBR0005289/2026-07-16), read 2026-11-25 from the official XML

> 5 Bij overeenkomst kan niet van een uiterste dag van betaling van ten hoogste 30 dagen, overeenkomstig het tweede lid, worden afgeweken, tenzij partijen uitdrukkelijk een langere termijn van betaling in de overeenkomst opnemen en de bijzondere aard of eigenschappen van de overeenkomst dit objectief rechtvaardigen. De betalingstermijn bedraagt in dat geval ten hoogste 60 dagen.

[Burgerlijk Wetboek Boek 6, artikel 119b](https://wetten.overheid.nl/BWBR0005289/2026-07-16), read 2026-11-28 from the official XML

> Indien geen tijd voor de nakoming is bepaald, kan de verbintenis terstond worden nagekomen en kan terstond nakoming worden gevorderd.

[Burgerlijk Wetboek Boek 6, artikel 38](https://wetten.overheid.nl/BWBR0005289/2026-07-16), read 2026-11-28

> 4 In geval van een handelsovereenkomst als bedoeld in artikel 119a lid 1 of artikel 119b lid 1 bestaat de vergoeding van kosten bedoeld in lid 2 onder c uit ten minste een bedrag van 40 euro. Dit bedrag is zonder aanmaning verschuldigd vanaf de dag volgende op de dag waarop de wettelijke of overeengekomen uiterste dag van betaling is verstreken.

> 6 De vergoeding volgens de nadere regels kan indien de schuldenaar een natuurlijk persoon is, die niet handelt in de uitoefening van een beroep of bedrijf, eerst verschuldigd worden nadat de schuldenaar na het intreden van het verzuim, bedoeld in artikel 81, onder vermelding van de gevolgen van het uitblijven van betaling, waaronder de vergoeding die in overeenstemming met de nadere regels wordt gevorderd, vruchteloos is aangemaand tot betaling binnen een termijn van veertien dagen, aanvangende de dag na aanmaning.

> 7 Indien een schuldenaar voor meer dan een vordering door een schuldeiser kan worden aangemaand als bedoeld in lid 6, dan dient dit in één aanmaning te geschieden.

[Burgerlijk Wetboek Boek 6, artikel 96](https://wetten.overheid.nl/BWBR0005289/2026-07-16), read 2026-11-25

> 1 Een rechtsvordering tot nakoming van een verbintenis uit overeenkomst tot een geven of een doen verjaart door verloop van vijf jaren na de aanvang van de dag, volgende op die waarop de vordering opeisbaar is geworden.

[Burgerlijk Wetboek Boek 3, artikel 307](https://wetten.overheid.nl/BWBR0005291/2025-07-01), read 2026-11-25 from the official XML of the version in force from 1 July 2025

Where Florin implements it: the figures are rules fields
(`statutoryPaymentDays`, `maxAgreedPaymentDays`, `largeDebtorMaxPaymentDays`,
`governmentPaymentDays`, `governmentMaxPaymentDays`, `minCollectionCosts`,
`consumerReminderDays`, `claimLimitationYears`). The due date is the invoice
date plus the payment term in calendar days (`dueDateOf`,
`Invoice.dueDate`), on the PDF and in the form. The payment term help names
lid 2 and lid 5; a term above lid 5 on an invoice to a business shows a
warning with lid 6 and artikel 119b lid 5. An issued invoice is overdue from
the day after its due date (`Invoice.isOverdueOn`), as interest and the
collection costs run from then. It then shows, for a business client, that
interest and at least the minimum collection costs are owed without a
reminder from the day after the agreed payment day, or, when none was
agreed, from the term of artikel 119a lid 2 after the client received the
invoice; for a private person, that a reminder with the term of artikel 96
lid 6 comes first. Both name the last day of the limitation term
(`Invoice.claimLapsesOn`). The invoice list shows what is open and overdue
(`openReceivables`, `Invoice.isOpenOn`).

Cautious choice: the records do not show whether the payment term printed
on the invoice was agreed. A claim falls due on the agreed payment day, or
at once when none was agreed (artikel 38), so Florin counts the limitation
term from the earliest day it knows, the supply date or else the invoice
date, and ends it on the same date five years on; 29 February ends on
28 February.

Not modelled: the interest itself, whose rate Florin does not hold, and the
staffel of the Besluit vergoeding voor buitengerechtelijke incassokosten.
Florin cannot tell whether a client is a large legal person in the sense of
lid 6, or an overheidsinstantie, for which a term above 30 days needs
objective justification and never exceeds 60 (artikel 119b lid 5), so it
states these rules instead of applying them. A claim against a
private person for the price of consumer goods lapses sooner (BW 7:28);
Florin shows the general term of artikel 307 only.

## Wet DBA

> Sinds 1 januari 2025 hanteren we weer de normale regels. Dit betekent dat we geen aanwijzingen meer geven. Stellen we schijnzelfstandigheid vast? Dan kunnen we dus direct correctieverplichtingen en naheffingsaanslagen loonheffingen opleggen. In 2025 legden we nog geen verzuim- en vergrijpboetes op. Vanaf 1 januari 2026 kunnen we wel vergrijpboetes opleggen. We leggen in 2026 nog geen verzuimboetes op.

[Belastingdienst, Arbeidsrelaties en handhaving door de Belastingdienst](https://www.belastingdienst.nl/wps/wcm/connect/nl/arbeidsrelaties/content/handhaving), read 2026-11-25

> 1. Hij die ten behoeve van een ander tegen een beloning door die ander van ten hoogste € 36,– per uur, arbeid verricht, wordt vermoed deze arbeid te verrichten krachtens arbeidsovereenkomst.

> 3. Dit artikel is niet van toepassing indien de ander een natuurlijke persoon is die niet handelt in de uitoefening van een beroep of bedrijf.

> 2. Voor de eerste toepassing na inwerkingtreding van deze wet wordt, in afwijking van het in artikel I, onderdeel B, voorgestelde artikel 610aa van Boek 7 van het Burgerlijk wetboek, eerste lid, bij ministeriële regeling het toepasselijke bedrag gegeven.

[Staatsblad 2026, 158](https://zoek.officielebekendmakingen.nl/stb-2026-158.html), artikel I onderdeel B and artikel III, read 2026-11-25

> treedt in werking met ingang van 31 december 2026.

[Staatsblad 2026, 207](https://zoek.officielebekendmakingen.nl/stb-2026-207.html), read 2026-11-25

> Of een overeenkomst moet worden aangemerkt als arbeidsovereenkomst, hangt af van alle omstandigheden van het geval in onderling verband bezien. Van belang kunnen onder meer zijn de aard en duur van de werkzaamheden, de wijze waarop de werkzaamheden en de werktijden worden bepaald, de inbedding van het werk en degene die de werkzaamheden verricht in de organisatie en de bedrijfsvoering van degene voor wie de werkzaamheden worden verricht, het al dan niet bestaan van een verplichting het werk persoonlijk uit te voeren, de wijze waarop de contractuele regeling van de verhouding van partijen is tot stand gekomen, de wijze waarop de beloning wordt bepaald en waarop deze wordt uitgekeerd, de hoogte van deze beloningen, en de vraag of degene die de werkzaamheden verricht daarbij commercieel risico loopt. Ook kan van belang zijn of degene die de werkzaamheden verricht zich in het economisch verkeer als ondernemer gedraagt of kan gedragen, bijvoorbeeld bij het verwerven van een reputatie, bij acquisitie, wat betreft fiscale behandeling, en gelet op het aantal opdrachtgevers voor wie hij werkt of heeft gewerkt en de duur waarvoor hij zich doorgaans aan een bepaalde opdrachtgever verbindt.

[Hoge Raad 24 maart 2023, ECLI:NL:HR:2023:443, rov. 3.2.5](https://data.rechtspraak.nl/uitspraken/content?id=ECLI:NL:HR:2023:443), read 2026-11-28

Where Florin implements it: the Wet DBA risk on a client is the user's own
assessment, shown as such; Florin does not assess a working relationship.
The help on hourly rate and the client's share of your time rests on the
Hoge Raad's "de hoogte van deze beloningen" and "het aantal opdrachtgevers
… en de duur waarvoor hij zich doorgaans aan een bepaalde opdrachtgever
verbindt". The presumption excludes only a private person not acting in a
business or profession (lid 3), so the help says "anyone other than a
private person". The warning on a high risk states what the Belastingdienst
page says it can impose on the client: corrections and naheffingsaanslagen
back to 1 January 2025, and vergrijpboetes since 2026.
Hours can be linked to a client (`HourEntries.clientId`), and a client's page
shows the year's own hours for it, what it was invoiced excl. BTW and the
hourly rate that follows, labelled as an estimate.

Not modelled: the ministerial regulation that sets the amount for the first
application of artikel 7:610aa was not found, so Florin names no hourly
amount and compares the rate with nothing. The statute's € 36 is not the
amount that applies first, and a figure Florin cannot source stays out.
The client page shows hours, invoiced amount and estimated hourly rate;
none of the other circumstances above are assessed.

## Balance sheet

> 1 Een ieder die een bedrijf of zelfstandig een beroep uitoefent, is verplicht van zijn vermogenstoestand en van alles betreffende zijn bedrijf of beroep, naar de eisen van dat bedrijf of beroep, op zodanige wijze een administratie te voeren en de daartoe behorende boeken, bescheiden en andere gegevensdragers op zodanige wijze te bewaren, dat te allen tijde zijn rechten en verplichtingen kunnen worden gekend. 2 De leden 2 tot en met 4 van artikel 10 van Boek 2 zijn van overeenkomstige toepassing.

[Burgerlijk Wetboek Boek 3, artikel 15i](https://wetten.overheid.nl/BWBR0005291/2025-07-01), read 2026-11-25 from the official XML

> 2 Onverminderd het bepaalde in de volgende titels is het bestuur verplicht jaarlijks binnen zes maanden na afloop van het boekjaar de balans en de staat van baten en lasten van de rechtspersoon te maken en op papier te stellen.

[Burgerlijk Wetboek Boek 2, artikel 10 lid 2](https://wetten.overheid.nl/BWBR0003045/2026-07-01), read 2026-11-25

> Als u ondernemer bent voor de inkomstenbelasting berekent u de fiscale winst aan de hand van de winst-en-verliesrekening en balans van uw onderneming.

> Bedrijfsmiddelen en andere bezittingen waardeert u tegen de aanschafprijs min de afschrijving: de boekwaarde.

[Belastingdienst, Fiscale informatie 2026, Winst-en-verliesrekening en balans](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_en_verliesrekening_en_balans), read 2026-11-25

> Vorderingen Openstaande verkoopfacturen en eventueel btw die u nog moest terugkrijgen. Liquide middelen Banksaldo van uw bedrijf en de kas van uw bedrijf.

> Ondernemingsvermogen Het eigen vermogen van uw bedrijf, plus de reserves, op 1 januari en 31 december van het afgelopen jaar.

> Langlopende schulden Bedragen die u hebt geleend, bij de bank of bij familie of vrienden, met een looptijd langer dan 1 jaar. Kortlopende schulden Openstaande facturen van uw leveranciers en belasting die u nog moet betalen.

[Belastingdienst, Ondernemer: bekijk welke cijfers u nodig hebt voor uw aangifte inkomstenbelasting](https://www.belastingdienst.nl/wps/wcm/connect/nl/belastingaangifte/content/ondernemer-bekijk-welke-cijfers-u-nodig-hebt-voor-uw-aangifte-inkomstenbelasting), read 2026-11-25

The paper return for 2025 (M-biljet, version 0.90, read 2026-11-25 as PDF)
asks in vraag 19 for the ondernemingsvermogen at the end of the year (19a),
the privéonttrekkingen (19b), the ondernemingsvermogen at the start (19d)
and the privéstortingen (19e), and computes 19g as 19a plus 19b, minus the sum of 19d and 19e: the saldo
fiscale winstberekening.

Where Florin implements it: `BalanceService.yearEnd` and the balance sheet
section of the P&L and tax screen, exported as `balans_schatting`. Florin
takes the book value of the assets still in the business, the invoices open
on 31 December incl. BTW (`openReceivables`), and the BTW of the year's
periods not settled then: the last period of the year always, as it falls
due after 31 December, and earlier ones the user did not mark paid. The user
enters the bank and cash balances, unpaid supplier invoices, loans longer
than a year, the ondernemingsvermogen on 1 January and the private
withdrawals and deposits (`TaxYearInputs`). Florin compares 19g with the
estimate's profit before investeringsaftrek, without the
desinvesteringsbijtelling and the herinvesteringsreserve released, plus a
gain kept in the reserve and minus the reserve booked off new assets
(`BalanceService.comparableProfit`): each of these changes the profit or the
ondernemingsvermogen Florin computes, not both. It warns on a difference,
labelled as an estimate.

> U neemt dan de boekwinst van het verkochte bedrijfsmiddel niet op in de fiscale winst, maar voegt deze toe aan de herinvesteringsreserve.

> U moet de winst voortschrijdend nemen. Dit betekent dat u niet mag wachten met winstneming tot het werk of de opdracht is afgerond.

[Belastingdienst, Fiscale informatie 2026, Winst-en-verliesrekening en balans, 7.7.1.2 and 7.3](https://www.belastingdienst.nl/wps/wcm/connect/fisin/fisin2026/winst_en_verliesrekening_en_balans), read 2026-11-28

Not modelled: stock, financial assets, provisions, the egalisatiereserve and
onderhanden werk (work done but not invoiced on 31 December, Fiscale
informatie 7.3). An asset with a business share below 100% is shown at its
business share; on the fiscal balance a business asset is shown in full and
its private use is a withdrawal.
the herinvesteringsreserve is part of the equity Florin computes but is not
shown apart. Whether a PDF or printed export counts as "op papier gesteld"
was not checked, so Florin leaves putting the balance on paper to the user.
The online return may number the questions differently from the paper one.

## Income tax estimate scope

The estimate covers one ondernemer under the AOW age, with wages from
employment when the user enters them.

Facts the bookkeeping cannot show are entered per year in the P&L screen
(`TaxYearInputs`): whether the user was an ondernemer before and is a
starter, the partner's hours, an S&O-verklaring, stopping the business, a
disability benefit, unused zelfstandigenaftrek, losses from earlier years and
employment.

Florin does not collect other income outside the business: a fiscal
partner's income, resultaat uit overige werkzaamheden, benefits and pensions,
box 2, box 3, or an oudedagsreserve built up before 2023. The estimate leaves
them out and says so.

Heffingskortingen other than the algemene heffingskorting and the
arbeidskorting, such as the inkomensafhankelijke combinatiekorting (artikel
8.14a), are not computed; leaving them out overstates the tax. The P&L
notice says so.

> 2 De inkomensafhankelijke combinatiekorting bedraagt 11,45% van het arbeidsinkomen, voor zover dat bij de belastingplichtige meer beloopt dan € 6.239, doch niet meer dan € 3.032.

[Wet inkomstenbelasting 2001, artikel 8.14a lid 2](https://wetten.overheid.nl/BWBR0011353/2026-01-01), read 2026-11-28 from the official XML

Options that lower the profit by the user's choice are not modelled, so the
estimate never assumes them: willekeurige afschrijving for starters (Florin
depreciates by the straight line only) and the release of an existing
oudedagsreserve.
