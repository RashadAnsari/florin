# Florin gebruiken

[English](guide.md)

Deze handleiding loopt langs elke taak waarvoor Florin is gemaakt, in de
volgorde waarin een zzp'er ze tegenkomt: instellen, de dagelijkse
administratie, de btw-aangifte, de aangifte inkomstenbelasting, de
jaarafsluiting en het bewaren van je administratie. Per taak staat wat de wet
vraagt, waar je het in Florin doet en wat Florin ermee doet. De bronnen van
elke regel staan in [`legal.md`](legal.md) en de bedragen per jaar in
[`tax-years/`](tax-years/).

Florin zet cijfers klaar en schat ze; het dient niets in en geeft geen advies.
Je doet aangifte in Mijn Belastingdienst Zakelijk, of je boekhouder doet dat.

## 1. Instellen

1. **Kies waar je administratie staat.** Kies bij de eerste start een map
   voor `florin.db`. Bonnen komen in een map `receipts` ernaast. Een map in
   iCloud Drive, OneDrive of Dropbox geeft je een back-up; kies je een map
   met al een `florin.db`, dan opent Florin die.
2. **Vul je bedrijfsgegevens in** onder Instellingen, Bedrijfsgegevens: naam,
   btw-nummer, KvK-nummer, adres en IBAN. Elke factuur toont ze, zoals de wet
   vraagt.
3. **De KOR.** Doe je mee aan de kleineondernemersregeling, vul dan de datum
   die de Belastingdienst bevestigde in onder Instellingen,
   Kleineondernemersregeling. Doe je niet mee, laat het leeg.
4. **Kies het jaar** in de zijbalk. Alleen jaren waarvan Florin de regels
   heeft gecontroleerd zijn te kiezen, en elke datum die je invult valt in
   zo'n jaar.
5. **Taal.** Instellingen, Taal wisselt tussen Nederlands en Engels.
   Facturen en exports blijven altijd Nederlands.

## 2. Dagelijkse administratie

### Klanten

Onder Klanten staat voor wie je werkt. Per klant:

- **Land en btw-nummer** bepalen welke btw-behandeling bij een factuur past.
  Florin weigert een behandeling die niet bij het land past.
- **Particulier, geen bedrijf**: vink dit aan voor een consument. Btw wordt
  dan nooit naar hem verlegd en hij staat niet op de opgaaf ICP. Voor een
  particulier in een ander EU-land laat het factuurformulier zien hoe ver je
  prestaties aan zulke klanten van de drempel van € 10.000 (2026) af zijn,
  waarboven elektronische diensten in hun land belast zijn.
- **Merchant of record**: voor een appwinkel of wederverkoper die op eigen
  naam verkoopt en de factuur aan jou uitreikt (self-billing).
- **Wet DBA**: je eigen inschatting van de arbeidsrelatie, de contractdatum
  en of het contract getekend is. Florin beoordeelt de relatie niet. De
  pagina van de klant toont je uren ervoor, wat je factureerde en het
  geschatte uurtarief dat daaruit volgt, de feiten die zo'n beoordeling
  weegt.

Een klant met facturen of uren kan niet worden verwijderd; zet hem op
inactief.

### Facturen

1. Facturen, **+**: kies de klant. De btw-behandeling volgt de klant; kies
   een andere als die beter past.
2. Vul de datums, de betalingstermijn en de regels in. Florin waarschuwt als
   de factuur later is dan de 15e van de maand na de levering, en als een
   betalingstermijn tussen bedrijven langer is dan 60 dagen.
3. **Verzenden** reikt de factuur uit: hij krijgt zijn nummer, wordt
   vergrendeld en de pdf wordt bewaard precies zoals verzonden. Een
   uitgereikte factuur kan niet meer veranderen; corrigeer hem met een
   **Creditnota**, die de gecorrigeerde factuur noemt.
4. Markeer hem **Betaald** met de datum waarop het geld binnenkwam.

De lijst toont wat openstaat en verlopen is. Een verlopen factuur zegt wat de
wet je geeft: bij een bedrijf de wettelijke handelsrente en minstens € 40
incassokosten zonder aanmaning; bij een particulier eerst een aanmaning met
14 dagen. Ook staat erbij tot wanneer de vordering naar de rechter kan.

### Uitgaven

1. Uitgaven, **+**: datum, categorie, leverancier, bedrag en btw-tarief.
2. **De categorie telt mee voor de belasting**:
   - Voedsel, drank, representatie en congressen: gedeeltelijk aftrekbaar.
   - Reizen en verblijf voor cursussen en congressen: tot € 1.500 per jaar.
   - Boetes, kleding en persoonlijke verzorging, een telefoonaansluiting
     thuis en literatuur die geen vakliteratuur is: vastgelegd maar niet
     afgetrokken.
   - Relatiegeschenken: vul de ontvanger in. Zodra de geschenken aan een
     ontvanger in een jaar boven € 227 komen, vraagt Florin er geen btw op
     terug.
3. **Btw**: vink BTW terugvragen aan als je die mag aftrekken. Kies hoe de
   btw werd berekend als die naar jou is verlegd (binnenland, uit de EU of
   van buiten de EU). Onder de KOR wordt geen btw teruggevraagd.
4. **Zakelijk gebruik**: de schuif bepaalt het zakelijke deel van gemengde
   kosten. Kosten van een auto van de zaak tellen altijd helemaal; het
   privégebruik van de auto loopt via de bijtelling.
5. Voeg de bon toe (hieronder).

### Bonnen

Sleep de pdf, foto, scan of e-factuur op de uitgave, het bedrijfsmiddel of de
factuur. Florin kopieert hem ongewijzigd, laat zien hoe lang je hem bewaart en
controleert onder Instellingen, Bonnen dat niets ontbreekt of veranderd is.
Florin verwijdert nooit een bon: een bon die je weghaalt blijft onder
Verwijderde bonnen.

### Uren

Uren, **+**: datum, uren, omschrijving, het soort werk en, als het voor een
klant was, de klant. Uren tellen voor het urencriterium (1.225 uur in 2026),
dat de zelfstandigenaftrek en andere aftrekposten vragen. Alleen vastgelegde
uren tellen.

Vink **Gewerkt door mijn fiscale partner** aan voor de uren van je partner.
Ze tellen niet voor jouw urencriterium, maar vanaf 525 uur per jaar geven ze
de meewerkaftrek, zolang je partner onbetaald is of minder dan € 5.000
krijgt.

### Kilometers

- **Privévervoermiddel**: leg zakelijke ritten en woon-werkritten vast.
  Florin trekt het tarief per kilometer van de Belastingdienst af.
- **Auto van de zaak**: leg elke rit in de auto vast als je de bijtelling
  wilt voorkomen. Florin controleert dat elke rit begint waar de vorige
  eindigde en dat een omweg zijn route noemt. Een onvolledige registratie
  telt als geen: dan gelden de bijtelling en de btw op privégebruik.

### Activa

Activa, **+** voor alles wat je meerdere jaren gebruikt: kosten,
aankoopdatum, levensduur, restwaarde en zakelijk deel. Florin schrijft per
dag af en past de KIA, EIA en MIA toe. Vul voor een auto van de zaak de
cataloguswaarde, de datum van eerste toelating en of hij emissievrij is in,
en of je een rittenregistratie bijhoudt. Verkoop je een bedrijfsmiddel, vul
dan datum en opbrengst in of koppel de verkoopfactuur; Florin berekent de
boekwinst en, als je dat kiest, de herinvesteringsreserve.

## 3. De btw-aangifte

### Aangiftetijdvak

Kies het tijdvak van je aangiftes op het scherm BTW-aangifte: per kwartaal,
per maand of per jaar, zoals in je aangiftebrief staat. Bij een jaaraangifte
waarschuwt Florin als het jaar niet aan de voorwaarden voldoet.

### Elke aangifte

1. Open BTW-aangifte en kies het tijdvak. Florin vult elke rubriek in vanuit
   je administratie en toont de uiterste datum.
2. Een tijdvak zonder iets aan te geven vraagt toch een nihilaangifte. Onder
   de KOR is er geen gewone aangifte, behalve een incidentele als er btw
   verschuldigd is, zoals verlegde btw; Florin zegt welke.
3. Neem de cijfers over in Mijn Belastingdienst Zakelijk. De export
   (Instellingen, Exporteren) heeft per tijdvak een bestand met elke rubriek
   in hele euro's.
4. Vink **Aangifte ingediend** aan, en **BTW betaald** zodra je hebt betaald.
   Florin bewaart de cijfers die je aangaf.

### Correcties

Wijzig je een boeking in een tijdvak waarvoor je al aangifte deed, dan toont
dat tijdvak wat er veranderde. Een wijziging van maximaal € 1.000 gaat mee in
je volgende aangifte, en die aangifte doen sluit de correctie af. Een grotere
wijziging vraagt het formulier Suppletie btw, binnen 8 weken nadat je de fout
ontdekte; vink daarna **Ik heb de suppletie ingediend** aan.

### Opgaaf ICP

Prestaties aan EU-bedrijven staan per kwartaal op het scherm BTW-aangifte en
in de export. Komen goederen in een kwartaal of een van de vier ervoor boven
€ 50.000, dan is de opgaaf over goederen maandelijks; Florin waarschuwt en
schrijft ook de maandlijsten.

### KOR

Met de KOR staat er geen btw op je facturen en vraag je geen btw terug.
Florin volgt je omzet tegenover de grens van € 20.000 en beëindigt de KOR bij
de factuur die erover gaat. Als de KOR begint, betaal je eerder
teruggevraagde btw op bedrijfsmiddelen deels terug (herziening): Florin schat
dat per bedrijfsmiddel en telt het op bij de laatste aangifte van het jaar.

### Privégebruik van een auto van de zaak

De btw op privégebruik gaat in de laatste aangifte van het jaar, rubriek 1d.
Met een volledige rittenregistratie volgt die de privé- en
woon-werkkilometers; zonder rekent Florin met het vaste percentage van de
Belastingdienst.

## 4. De aangifte inkomstenbelasting

### Winst en geschatte belasting

Het scherm W&V & Belasting toont omzet, kosten, winst, elke aftrekpost en de
geschatte belasting, regel voor regel, zoals de aangifte ze berekent.
Daaronder:

- **Gegevens van het jaar**: of je eerder ondernemer was en starter bent,
  partneruren buiten de urenregistratie en de vergoeding aan je partner, een
  S&O-verklaring, het staken van de onderneming, een
  arbeidsongeschiktheidsuitkering, niet-gerealiseerde zelfstandigenaftrek,
  verliezen uit eerdere jaren en een baan naast de onderneming. Vul in wat
  geldt.
- **Voorlopige aanslag en toeslagen (geschat)**: de belastbare winst, het
  inkomen in box 1 en de te betalen belasting voor als je een voorlopige
  aanslag aanvraagt of wijzigt en als je je inkomen voor toeslagen schat, met
  de laatste dag waarop dat kan.
- **Balans op 31 december (geschat)**: vul je bank- en kassaldo,
  onbetaalde leveranciersfacturen, leningen, het ondernemingsvermogen op
  1 januari en je privéonttrekkingen en -stortingen in. Florin telt de
  bedrijfsmiddelen, openstaande facturen en openstaande btw erbij en berekent
  de vermogensvergelijking van de aangifte (vraag 19). Een verschil met de
  geschatte winst wijst op een ontbrekend saldo of een ontbrekende boeking.

### Pensioen en AOV

Het scherm Pensioen berekent je jaarruimte uit je inkomen uit arbeid van
vorig jaar en je factor A, telt de reserveringsruimte erbij op, en toont de
aftrekbare premie en de geschatte belastingbesparing. Premies voor een
arbeidsongeschiktheidsverzekering (AOV) worden helemaal afgetrokken.

### Aangifte doen

Florin doet de aangifte niet. Neem de cijfers van het scherm W&V & Belasting
en de export over in Mijn Belastingdienst, of geef de export aan je
boekhouder.

## 5. De jaarafsluiting

1. Controleer dat elke factuur, uitgave, bon, rit en elk uur van het jaar in
   Florin staat, en markeer betaalde facturen als betaald.
2. Markeer elke btw-aangifte als gedaan en betaald; verwerk een correctie.
3. Vul de gegevens van het jaar en de balans in op het scherm W&V &
   Belasting.
4. Exporteer het jaar (Instellingen, Exporteren) en bewaar de map bij je
   administratie. Stel de balans en de staat van baten en lasten binnen zes
   maanden op papier, zoals het Burgerlijk Wetboek van elk bedrijf vraagt.

## 6. Je administratie bewaren

- **Zeven jaar.** Facturen, bonnen en administratie bewaar je zeven jaar. De
  Belastingdienst kan over een jaar nog vijf jaar belasting navorderen,
  langer met uitstel, en twaalf jaar voor inkomen of vermogen in het
  buitenland; bewaar de administratie van zo'n jaar minstens zo lang.
- **De export** bevat alle boekingen, de btw-aangiftes, de ICP-lijsten, de
  geschatte inkomstenbelasting en balans, de bedrijfsgegevens, de
  pensioencijfers, de gegevens van het jaar, de status van elke aangifte en
  de bonnen, in het Nederlands.
- **Verhuizen of back-up maken.** Instellingen, Database kopieert de database
  en de bonnenmap naar een andere map. Kopieer de map alleen als Florin
  gesloten is.

## 7. Wat Florin niet doet

- Aangiftes doen of facturen voor je versturen.
- Het inkomen van een fiscale partner, overig werk, uitkeringen, box 2 en
  box 3.
- De OSS-aangifte, de EU-KOR, onroerende zaken en voorraden.
- Keuzes die de winst verlagen, zoals willekeurige afschrijving voor
  starters.
- Een arbeidsrelatie beoordelen onder de Wet DBA.

[`legal.md`](legal.md) noemt per regel wat Florin toepast en wat het
weglaat.
