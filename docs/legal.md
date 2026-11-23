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

## Kleineondernemersregeling

> 4 De ondernemer die de vrijstelling toepast, heeft geen recht op aftrek van belasting en mag op de factuur op geen enkele wijze melding maken van omzetbelasting. 5 De vrijstelling geldt voor de ondernemer die in Nederland is gevestigd, na een melding aan de inspecteur, vanaf het eerstvolgende belastingtijdvak dat minimaal vier weken na ontvangst van de melding aanvangt. […] 7 […] De beëindiging van de vrijstelling wordt van kracht op de eerste dag van het eerstvolgende kalenderkwartaal dat minimaal vier weken na ontvangst van de wederopzegging aanvangt. De ondernemer kan na de beëindiging door wederopzegging pas na het verstrijken van het kalenderjaar waarin de vrijstelling is beëindigd en het daaropvolgende kalenderjaar opnieuw de vrijstelling toepassen. […] 9 Een ondernemer komt niet in aanmerking voor de vrijstelling of mag deze niet langer toepassen indien de jaaromzet in Nederland het bedrag, genoemd in het eerste lid, overschrijdt. […] In de hiervoor bedoelde gevallen komt de ondernemer ook niet in aanmerking voor de vrijstelling in het daaropvolgende kalenderjaar of is de vrijstelling niet langer van toepassing voor de levering van het goed of de dienst waardoor die overschrijding tot stand komt, gedurende het resterende kalenderjaar en het daaropvolgende kalenderjaar.

[Wet op de omzetbelasting 1968, artikel 25a](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23. The limit of lid 1 is in [`tax-years/2026.md`](tax-years/2026.md).

> 2 In afwijking van het eerste lid, onderdeel a, wordt bij de vaststelling van de jaaromzet in Nederland niet in aanmerking genomen de vergoeding voor de levering van door de ondernemer in zijn bedrijf gebruikte: a. onroerende zaken […]; en b. roerende zaken waarop de ondernemer voor de inkomstenbelasting […] afschrijft

[Wet op de omzetbelasting 1968, artikel 25 lid 2](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23

> Dit zijn leveringen belast met 21%, 9% en 0% btw (uitvoer en intracommunautaire leveringen) en leveringen belast met Nederlandse btw die u verlegt naar een andere Nederlandse ondernemer (nationale verlegging). […] Ook telt btw-vrijgestelde omzet mee van leveringen van goederen en diensten die betrekking hebben op onroerende zaken, betaalmiddelen en effecten, financiële diensten en verzekeringsdiensten in Nederland (overige vrijgestelde omzet telt niet mee voor de omzetgrens). […] prestaties die belast zijn in een ander land […] De hiermee behaalde omzet telt niet mee voor de omzetgrens van de KOR.

[Belastingdienst, Voorwaarden voor deelname aan de KOR](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/kor-voorwaarden), read 2026-11-23

> U berekent geen btw aan uw klanten. […] Als u zelf facturen wilt versturen, of als uw klanten daarom vragen, kunt u dat wel doen. U vermeldt dan op de factuur dat een vrijstelling van toepassing is. U doet geen btw-aangifte meer. Behalve in een aantal gevallen, dan moet u toch incidentele aangifte doen. U trekt de btw over uw zakelijke kosten en investeringen niet af.

[Belastingdienst, Wat betekent meedoen met de KOR?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/hoe_werkt_de_btw/kleineondernemersregeling/wat-betekent-meedoen-met-de-kleineondernemersregeling/wat-betekent-meedoen-met-de-kleineondernemersregeling), read 2026-11-23

> Zodra uw omzet boven de € 20.000 in 1 kalenderjaar komt, mag u namelijk geen gebruik meer maken van de KOR. U moet zich op dat moment direct afmelden. Ook de omzetoverschrijdende handeling zelf valt niet meer onder de btw-vrijstelling.

[Belastingdienst, Afmelden voor de KOR](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/afmelden-kor), read 2026-11-23

> Koopt of verkoopt u goederen en/of diensten binnen de EU én maakt u gebruik van de KOR? Dan gelden er aangepaste regels en is het soms lastig om te bepalen wat u met de btw moet doen. Vaak moet u dan incidenteel btw-aangifte doen.

[Belastingdienst, Kleineondernemersregeling (KOR)](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/hoe_werkt_de_btw/kleineondernemersregeling/kleineondernemersregeling), read 2026-11-23

Where Florin implements it: `KorService` and `KorStatus` in
`lib/services/kor_service.dart`, the KOR dates on the business profile, and
`VatTreatment.kor`.

- The KOR applies from the start date the user enters, which must be the
  first of a month as a return period starts then, until a voluntary end
  date (also the first of a month) or the invoice that takes the year's
  turnover past the limit, whichever comes first. After passing the limit it
  does not apply for the rest of that year and the next year.
- Turnover counts issued invoices with Dutch BTW, domestic reverse charge,
  export and intra-Community supplies, and KOR-exempt invoices; credit notes
  reduce it. Services taxed in another country (`euServices`,
  `servicesOutsideEu`) do not count. Florin cannot tell which exemption an
  exempt line has, so it counts every exempt line: the cautious reading.
  A sale recorded on an asset does not count (art. 25 lid 2); an invoice for
  it does, as Florin cannot tell it apart: the cautious reading.
- While the KOR applies, an invoice for a supply in the Netherlands must use
  `VatTreatment.kor`; services taxed abroad keep their treatment. The invoice
  that passes the limit must carry BTW. The KOR PDF shows no BTW column, no
  BTW totals and no seller BTW number, following lid 4, and states that the
  exemption applies, as the Belastingdienst asks.
- No BTW on purchases is reclaimed on KOR dates: the expense form blocks it,
  and the calculations treat that BTW as cost even for expenses saved before
  the KOR dates were entered.
- BTW shifted to the user (2a, 4a, 4b) is owed in KOR quarters and not
  deducted; a KOR quarter with BTW owed needs an incidental return. See
  Filing a return.
- Supplies on KOR dates are left off the ICP list (art. 37a lid 1, under
  ICP-opgaaf).
- The EU-KOR (art. 25c and further) and the eligibility test on the previous
  year's turnover before the first year Florin holds are not modelled; the
  user's start date stands for the Belastingdienst's confirmation.

## Receipts

> Alle facturen die u verstuurt of ontvangt, bewaart u in uw administratie. Dat is verplicht, want wij moeten uw administratie kunnen controleren. U bewaart de facturen in de vorm waarin u ze hebt verstuurd of ontvangen. Digitale facturen drukt u dus niet af, maar slaat u digitaal op. U bewaart de facturen 7 jaar. Facturen over onroerende zaken bewaart u 10 jaar. […] U mag facturen en bonnetjes ook scannen en digitaal bewaren. Er moet dan wel sprake zijn van een juiste en volledige weergave van het origineel. Belangrijk hierbij is dat de echtheidskenmerken ook worden opgeslagen. […] Als u aan de voorwaarden voldoet, hoeft u de originele facturen en bonnetjes niet te bewaren. Ook deze digitale administratie moet 7 of 10 jaar worden bewaard en binnen een redelijke termijn controleerbaar zijn.

[Belastingdienst, Uw facturen bewaren](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/administratie_bijhouden/facturen_maken/uw_facturen_bewaren), read 2026-11-23

> Voor het bepalen van de start van de bewaartermijn gebruikt u de actuele waarde van een gegeven. Zolang gegevens actueel blijven, horen zij bij de administratie. Vervalt de actualiteitswaarde? Dan begint de bewaartermijn.

[Belastingdienst, Hoelang moet u gegevens bewaren?](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/ondernemen/administratie/hoelang-moet-u-gegevens-bewaren), read 2026-11-23

Where Florin implements it: `ReceiptStore` and `ReceiptService`.

- Receipt files are copied into `receipts/<year>/<uuid>.<extension>` next to
  the database, byte for byte: never printed, converted or compressed, so a
  file received digitally is kept in the form it was received. A SHA-256 of
  each file is stored, and Settings checks that every file is still there
  and unchanged.
- Florin accepts PDF, JPEG, PNG, HEIC, TIFF and UBL e-invoices, recognised by
  their content, up to 25 MB a file. Whether a scan or photo is a complete
  and faithful copy, with its authenticity marks, is up to the user; the
  help text says what the Belastingdienst asks.
- The keep-until date is the end of the seventh year after the record's
  year, the cautious reading of when the term starts. An asset's purchase
  invoice stays current while the asset is in use, so it shows "while in
  use, then 7 years" until the asset is sold. Florin never deletes a
  receipt: one removed from its record, or whose record is deleted, keeps
  its row with what it belonged to and its file moves to
  `receipts/removed/`, listed under Removed receipts in Settings and in
  every export. Property records (10 years) and OSS records (10 years) are
  not kept in Florin.
- When an invoice is issued, Florin stores its PDF at that moment and hands
  out that file on every later export, so the invoice stays in the form it
  was sent. A self-billed invoice keeps the customer's document instead.

## ICP-opgaaf

> De opgaaf ICP over goederen mag u per maand, per kwartaal of per jaar doen. Als u per kwartaal opgaaf ICP wilt doen, mag u niet meer dan € 50.000 aan goederen leveren per kwartaal.

[Belastingdienst, Tijdvak opgaaf ICP](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_naar_andere_eu_landen/opgaaf_icp/tijdvak_opgaaf_icp/tijdvak_opgaaf_icp)

> 1 De ondernemer, uitgezonderd die bedoeld in artikel 7, zesde lid, of artikel 25a, eerste lid, is verplicht uiterlijk de laatste dag van de maand volgend op een kalendermaand bij de inspecteur op de daartoe opengestelde wijze een formulier langs elektronische weg in te dienen met een lijst voor dat tijdvak waarop zijn vermeld de afnemers: […] c. voor wie hij diensten heeft verricht die met toepassing van artikel 6, eerste lid, niet belastbaar zijn in Nederland en waarover de belasting ingevolge artikel 196 van BTW-richtlijn 2006 in de lidstaat van de afnemer wordt geheven van de afnemer, tenzij het verrichten van die dienst in die lidstaat is vrijgesteld; […] 4 In afwijking in zoverre van het eerste lid geldt naar keus van de ondernemer als tijdvak een kalenderkwartaal indien de ondernemer de onder het eerste lid onderdeel c genoemde diensten verricht.

[Wet op de omzetbelasting 1968, artikel 37a](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23 from the official XML of the version in force on 1 January 2026

Florin lists the EU supplies per quarter. It states no ICP deadline: the
Belastingdienst pages read for this review do not give one for Dutch filers.
Supplies dated while the KOR applies are left off the list: lid 1 exempts the
ondernemer of artikel 25a, eerste lid. They stay in rubriek 3b.

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
not occur in the supplies Florin records. Services to businesses outside the
EU are in no rubriek; see Services to businesses outside the EU above.

## BTW return rounding

> Als je de btw-aangifte invult, rond je alle bedragen af op hele euro’s. Dit mag je in het voordeel van de stichting of vereniging doen. Zet bij negatieve bedragen een minteken (-) vóór het bedrag.

[Belastingdienst, Invullen rubrieken](https://stichtingenvereniging.belastingdienst.nl/aangifte/aangifte-omzetbelasting/invullen-rubrieken/), read 2026-11-22

> In de btw-aangifte rondt u de btw-bedragen af op hele euro’s. Dit mag u in uw voordeel doen.

[Belastingdienst, Btw-bedrag afronden](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/administratie_bijhouden/facturen_maken/btw-bedrag_afronden), read 2026-11-22

> Op het scherm 'Voorbelasting' staat bij 5a, 'Verschuldige btw (rubrieken 1 t/m 4)', het totaal aan verschuldigde btw uit de vorige rubrieken.

[Belastingdienst, Ik moet btw-aangifte doen: hoe vul ik die in?](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/ik-moet-btw-aangifte-doen-hoe-vul-ik-die-in), read 2026-11-22

Where Florin implements it: `CsvExportService.btwReturnRows` writes one file
per quarter, `florin_<year>_btw_Q1.csv` to `Q4`, inside a new folder
`florin_<year>_export_<date>_<time>` for each export, with every rubriek of the form
in whole euros. Amounts owed and their bases round down, voorbelasting (5b)
rounds up, and 5a is the sum of the rounded BTW amounts, as the form adds
them. Negative amounts keep their minus sign. The ICP list per quarter,
`florin_<year>_icp_Q<n>.csv`, totals the supplies per customer BTW number with
goods and services apart, in euros and cents: the pages read for this review
state no rounding rule for the ICP-opgaaf.

Filing from Florin directly is not possible: the Belastingdienst accepts
returns from software only over SBR and Digipoort, signed with a PKIoverheid
certificate.

> If you file a tax return using Standard Business Reporting (SBR), you use Digipoort, the secure digital channel of the public authorities. To be able to send and receive messages via Digipoort, you need a PKIoverheid services server certificate.

[Belastingdienst, Filing tax returns using accounting software](https://www.belastingdienst.nl/wps/wcm/connect/bldcontenten/belastingdienst/business/tax_return/filing_digital_tax_returns/filing-tax-returns-using-accounting-software/), read 2026-11-22

## BTW deadlines

> Ik doe aangifte per kwartaal: 4e kwartaal 2025 | 31 januari 2026 · 1e kwartaal 2026 | 30 april 2026 · 2e kwartaal 2026 | 31 juli 2026 · 3e kwartaal 2026 | 31 oktober 2026 · 4e kwartaal 2026 | 31 januari 2027

[Belastingdienst, Uiterste aangifte- en betaaldatums](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/uiterste-aangifte-en-betaaldatums)

Where Florin implements it: `VatService.filingDeadline`, the last day of the
month after the quarter.

## Filing a return

> 1 De in een tijdvak verschuldigd geworden belasting moet op aangifte worden voldaan.

[Wet op de omzetbelasting 1968, artikel 14](https://wetten.overheid.nl/BWBR0002629/2026-01-01), read 2026-11-23

> Ja, als ondernemer voor de btw moet u altijd btw-aangifte doen, ook als u in de periode van de aangifte geen btw in rekening hebt gebracht of aan u geen btw is berekend. Dit heet een 0-aangifte of nihilaangifte. Doet u de btw-aangifte niet of niet op tijd? Dan ontvangt u van ons een naheffingsaanslag en een boete. […] Over vrijgestelde omzet doet u normaal gesproken geen btw-aangifte. Hiervan is sprake als u uitsluitend vrijgestelde goederen of diensten levert. Of als u deelneemt aan de kleineondernemersregeling (KOR). Maar ook dan kan het voorkomen dat u toch een keer btw-aangifte moet doen. […] Hebt u al een btw-aangifte gekregen, dien hem dan altijd in.

[Belastingdienst, Moet ik altijd btw-aangifte doen?](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/moet-ik-altijd-btw-aangifte-doen), read 2026-11-23

> U blijft btw-aangifte doen tot u de definitieve ingangsdatum van de KOR van ons hebt gekregen.

[Belastingdienst, Aanmelden voor de KOR](https://www.belastingdienst.nl/wps/wcm/connect/nl/btw/content/aanmelden-kor), read 2026-11-23

> Is uw omzet vrijgesteld van btw? Dan hoeft u meestal geen aangifte te doen. Neemt u diensten af waarbij de btw naar u wordt verlegd? Dan moet u wél btw-aangifte doen. Hierin geeft u de btw aan die aan u is verlegd. U hebt dan geen recht om deze btw af te trekken.

[Belastingdienst, Btw-aangifte als u diensten afneemt van leveranciers uit landen buiten de EU](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/zakendoen_buiten_de_eu/aangifte_doen_als_u_zakendoet_buiten_de_eu/aangifte_doen_als_u_diensten_afneemt_van_leveranciers_uit_niet_eu_landen), read 2026-11-23

> Voert een ondernemer uit een ander EU-land werkzaamheden voor u uit? Of hebt u goederen uit andere EU-landen laten afleveren in Nederland? Dan ontvangt u in de meeste gevallen een factuur met 0% btw of met 'btw verlegd'. U moet de verschuldigde btw zelf berekenen en opgeven in uw btw-aangifte. […] Als u btw moet betalen over intracommunautaire verwervingen en diensten, moet u in het juiste tijdvak aangifte doen.

[Belastingdienst, Aangifte doen van goederen en diensten uit een ander EU-land](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/zakendoen_met_het_buitenland/goederen_en_diensten_afnemen_uit_andere_eu_landen/aangifte_doen/aangifte-doen-van-goederen-en-diensten-uit-andere-eu-landen), read 2026-11-23

> Het kan dan toch zijn dat u incidenteel btw-aangifte moet doen. U bent dan zelf verantwoordelijk voor het aanvragen van de aangifte. […] Blijkt dat u inderdaad incidenteel btw-aangifte moet doen? Vraag de aangifte dan zelf schriftelijk aan bij uw belastingkantoor. Dat kan na afloop van het kwartaal waarin de goederen zijn geleverd of de dienst is verricht waarvoor u btw-aangifte moet doen.

[Belastingdienst, Incidenteel btw-aangifte doen](https://www.belastingdienst.nl/wps/wcm/connect/bldcontentnl/belastingdienst/zakelijk/btw/btw_aangifte_doen_en_betalen/btw-aangifte-waar-moet-u-aan-denken/incidentele-btw-aangifte), read 2026-11-23

Where Florin implements it: `ReturnDuty` and `VatQuarterResult.duty` in
`lib/services/vat_service.dart`, shown by `DeadlineBadge`, the dashboard's
BTW deadlines and the notices on the BTW return screen.

- Without the KOR every quarter needs a return, however low the turnover,
  and an empty quarter needs a nil return; the BTW return screen says so.
  Low turnover alone never removes a return.
- A quarter the KOR covers in full needs no return when no BTW is owed in it.
- A quarter the KOR covers in full with BTW owed in it, such as BTW shifted
  to the user in 2a, 4a or 4b or BTW on a car's private use, needs an
  incidental return. The user asks for it in writing after the quarter. The
  pages name no deadline for it; Florin shows the regular deadline, the
  cautious answer. Domestic reverse charge (2a) is not named on the pages
  read; Florin treats it like 4a and 4b, as art. 14 lid 1 makes any BTW owed
  payable on a return.
- A quarter the KOR covers in part needs a regular return.
- Until the figures have loaded, a quarter shows a return as due.

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
