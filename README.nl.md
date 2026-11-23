<div align="center">

<img src="docs/images/logo.png" alt="Florin-logo" width="112" height="112">

# Florin

**Boekhouding voor zzp'ers. Gratis, offline en op je eigen computer.**

[![Build](https://github.com/RashadAnsari/florin/actions/workflows/build.yml/badge.svg)](https://github.com/RashadAnsari/florin/actions/workflows/build.yml)
[![Nieuwste versie](https://img.shields.io/github/v/release/RashadAnsari/florin?label=versie)](https://github.com/RashadAnsari/florin/releases/latest)
[![Licentie: MIT](https://img.shields.io/badge/licentie-MIT-blue.svg)](LICENSE)
[![Platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20Windows%20%7C%20Linux-lightgrey.svg)](#installeren)
[![Belastingjaar](https://img.shields.io/badge/belastingjaar-2026-orange.svg)](docs/tax-years/2026.md)
[![Talen](https://img.shields.io/badge/talen-Nederlands%20%7C%20English-green.svg)](#)

[English](README.md) | Nederlands

[**Download voor macOS, Windows of Linux**](https://github.com/RashadAnsari/florin/releases/latest)

<img src="docs/screenshots/dashboard-nl.png" alt="Florin-dashboard" width="800">

</div>

Florin houdt je facturen, uitgaven, btw-aangiftes, uren, kilometers, bedrijfsmiddelen en pensioenruimte bij in één desktop-app, en laat gaandeweg zien wat je aan de Belastingdienst gaat betalen. Geen abonnement, geen account, geen cloud: je administratie is één bestand op je eigen computer.

## Waarom Florin

- **Gebouwd op de Nederlandse belastingwet, met bronnen.** Elk tarief, elke grens en elke factuurregel in Florin is gecontroleerd in de wettekst op wetten.overheid.nl of bij de Belastingdienst. Het citaat en de link staan in [`docs/legal.md`](docs/legal.md) en [`docs/tax-years/`](docs/tax-years/).
- **Het hele jaar inzicht in je cijfers.** Het dashboard toont omzet, kosten, te betalen btw en een schatting van je inkomstenbelasting terwijl je facturen en uitgaven invoert. Elke schatting staat als schatting aangegeven.
- **Uitleg waar je hem nodig hebt.** Elk veld en elk fiscaal begrip heeft een korte uitleg onder de muisaanwijzer.
- **Facturen opgebouwd volgens de btw-regels.** Pdf-facturen bevatten de vermeldingen uit artikel 35a van de Wet op de omzetbelasting, met btw verlegd, intracommunautaire leveringen, diensten buiten de EU en creditnota's die de gecorrigeerde factuur noemen.
- **Jouw gegevens blijven van jou.** Eén lokaal databasebestand, in een map die je zelf kiest. Zet het in iCloud Drive, OneDrive of Dropbox als back-up.
- **Klaar voor je aangiftes en je boekhouder.** Exporteer een volledig jaar met één klik naar CSV-bestanden, in een nieuwe map met de exportdatum in de naam: alle gegevens, de btw-aangifte van elk kwartaal per rubriek in hele euro's zoals het formulier vraagt, het ICP-overzicht van elk kwartaal en de geschatte inkomstenbelasting.
- **Gratis en open source** onder de MIT-licentie.

## Functies

| | |
|---|---|
| **Facturen** | Nederlandse pdf-facturen met automatische nummering. Nederlandse btw, btw verlegd naar Nederlandse en EU-ondernemers, intracommunautaire leveringen van goederen, uitvoer buiten de EU en diensten aan ondernemers buiten de EU, met de btw-behandeling getoetst aan het land van de klant. Verkoop via een merchant of record, zoals een app store of wederverkoper: markeer die als zodanig en leg de facturen vast die hij aan jou uitreikt (self-billing). Verzonden facturen liggen vast; correcties gaan met een creditnota. Status van concept tot betaald, inclusief verlopen facturen. |
| **Bonnen** | Voeg de pdf, foto, scan of e-factuur van elke uitgave en elk bedrijfsmiddel toe door hem erin te slepen. Florin kopieert hem ongewijzigd naar een map met bonnen naast je database, toont hoe lang je hem bewaart, controleert of er niets ontbreekt en bewaart de pdf van elke factuur die je uitreikt precies zoals je hem verstuurde. Exports bevatten ze allemaal. |
| **Uitgaven** | Kosten per categorie met btw-teruggave, zakelijk gebruikspercentage en bonnetjesregistratie, ook voor aankopen waarbij de btw naar jou is verlegd. Voor voedsel, drank en representatie neemt Florin wat het meest aftrekt: de 80%-regeling of de drempel van € 5.700. Btw op restaurantmaaltijden wordt niet teruggevraagd. |
| **Btw-aangifte** | Elk kwartaal vooraf ingevuld vanuit je administratie: rubrieken 1a, 1b, 1d, 1e, 2a, 3a, 3b, 4a, 4b, 5a en 5b, plus de prestaties voor de ICP-opgaaf. Aangifte en betaling per kwartaal bijgehouden, met de deadline erbij. |
| **Kleineondernemersregeling** | Vul in wanneer je KOR begon en Florin volgt hem: KOR-facturen zonder btw, geen btw terugvragen op inkopen, geen gewone aangifte voor kwartalen die de KOR dekt, en je omzet tegenover de grens van € 20.000. De factuur die de grens overschrijdt is weer belast met btw en Florin beëindigt de KOR vanaf daar. |
| **Schatting inkomstenbelasting** | Zelfstandigenaftrek, startersaftrek, S&O-aftrek, meewerkaftrek, stakingsaftrek, startersaftrek bij arbeidsongeschiktheid, mkb-winstvrijstelling, KIA, EIA, MIA, desinvesteringsbijtelling, herinvesteringsreserve, afschrijvingen, winst op verkochte bedrijfsmiddelen, lijfrente, arbeidsongeschiktheidsverzekering, verliezen uit eerdere jaren, algemene heffingskorting, arbeidskorting en de Zvw-bijdrage. |
| **Urencriterium** | Uren per klant en project, met je voortgang naar de 1.225 uur die je nodig hebt voor de zelfstandigenaftrek. |
| **Kilometers** | Zakelijke ritten en woon-werkritten met kilometerstanden en doel, afgetrokken tegen het tarief van de Belastingdienst voor dat jaar. |
| **Bedrijfsmiddelen** | Lineaire afschrijving per dag tot de restwaarde, zakelijk gebruikspercentage, KIA, EIA, MIA en de herinvesteringsreserve. |
| **Auto van de zaak** | De bijtelling voor privégebruik met de korting voor emissievrije auto's en de 500 km-regel, en de btw over privégebruik in de laatste aangifte van het jaar. |
| **Pensioen** | Je jaarruimte op basis van het inkomen van vorig jaar, AOW-franchise en factor A, plus reserveringsruimte. |
| **Klanten** | Contactgegevens, btw- en KvK-nummer en het Wet DBA-risico per klant. |

Florin dekt het belastingjaar **2026**. Alleen gedekte jaren zijn te kiezen en te boeken; een nieuw jaar komt in een update zodra de bedragen zijn gepubliceerd en gecontroleerd.

## Installeren

Download het bestand voor jouw systeem bij de [nieuwste versie](https://github.com/RashadAnsari/florin/releases/latest).

### macOS

Met [Homebrew](https://brew.sh):

```sh
brew tap rashadansari/florin https://github.com/RashadAnsari/florin
brew trust --cask rashadansari/florin/florin
brew install --cask florin
```

Of handmatig:

1. Pak `florin-macos.zip` uit
2. Zet `Florin.app` in je map Apps
3. Open `Florin.app`

Florin is ondertekend en genotariseerd door Apple. Vereist macOS 12 of nieuwer.

### Windows

1. Download en start `florin-windows-x64-setup.exe`
2. Verschijnt Windows SmartScreen, klik dan op **Meer informatie** en daarna op **Toch uitvoeren**
3. Volg de installatie. Florin komt in het Startmenu en is te verwijderen via **Instellingen > Apps**, net als andere apps.

Wil je Florin gebruiken zonder te installeren, pak dan `florin-windows-x64.zip` uit en start `florin.exe`.

### Linux

Op Ubuntu, Debian, Linux Mint en andere Debian-gebaseerde systemen download je `florin-linux-amd64.deb` en open je het bestand om te installeren. Florin verschijnt daarna in je appmenu.

Op andere distributies pak je `florin-linux-x64.tar.gz` uit in een map en start je `./florin`.

## Veelgestelde vragen

**Waar worden mijn gegevens opgeslagen?**
In één bestand, `florin.db`, inclusief je bedrijfsgegevens. Je kiest de map bij de eerste start van Florin en kunt de database later via Instellingen naar een andere map kopiëren. Kies je bij de eerste start een map waarin al `florin.db` staat, dan opent Florin die.

**Hoe maak ik een back-up?**
Zet de databasemap in een gesynchroniseerde map of een map waarvan een back-up wordt gemaakt, of kopieer `florin.db` naar een veilige plek. Sluit Florin voordat je het bestand kopieert.

**Kan Florin mijn btw-aangifte of inkomstenbelasting indienen?**
Nee. Florin zet de cijfers klaar; je dient ze zelf in via Mijn Belastingdienst Zakelijk, of je boekhouder doet dat.

**Voor welke situaties geldt de schatting van de inkomstenbelasting?**
Eén ondernemer onder de AOW-leeftijd zonder ander inkomen. Loon, een fiscale partner, box 2 en box 3 tellen niet mee. [`docs/legal.md`](docs/legal.md) noemt wat Florin niet berekent.

**Heeft Florin een internetverbinding nodig?**
Nee. Florin maakt nooit verbinding met internet: je gegevens blijven op je computer en de lettertypen zitten in de app.

## Zelf bouwen

Florin is een Flutter-app. Installeer de Flutter-versie die onder `environment.flutter` in `pubspec.yaml` staat en voer dan uit:

```sh
git clone https://github.com/RashadAnsari/florin.git
cd florin
flutter pub get
flutter run -d macos   # of windows / linux
```

Wil je Florin uitproberen met een verzonnen onderneming? Voer `make demo` uit en kies bij de eerste start de nieuwe map `demo`.

Voer vóór elke commit `make local` uit. Dat genereert vertalingen en databasecode opnieuw, formatteert, analyseert en draait de tests. [`AGENTS.md`](AGENTS.md) beschrijft hoe het project is opgebouwd.

### Een versie uitbrengen

Eén workflow, `.github/workflows/build.yml`, lint, test en bouwt elke push en pull request. Verhoog voor een nieuwe versie `version` in `pubspec.yaml` naar de volgende `MAJOR.MINOR.PATCH` (bijvoorbeeld `1.2.0`, zonder buildnummer) en push naar `master`. Als de controles en builds slagen, maakt de workflow pakketten voor macOS, Windows en Linux, tagt de commit als `v1.2.0`, publiceert de GitHub-release en werkt de Homebrew-cask bij. Pushes waarvan de versie al een release heeft, worden alleen gelint, getest en gebouwd.

## Disclaimer

Florin is gratis open-source software, geleverd zoals hij is, zonder enige garantie. Het helpt je je financiële administratie bij te houden en is geen vervanging voor professioneel fiscaal of juridisch advies.

Alle bedragen en regels in Florin zijn gecontroleerd in de wet en bij de Belastingdienst, en de bronnen zijn met de code gepubliceerd. Toch zijn de berekeningen schattingen. Ze kunnen fouten bevatten, achterlopen op wetswijzigingen en niet passen bij jouw situatie. Laat je belastingverplichtingen controleren door een boekhouder of belastingadviseur voordat je aangifte doet bij de Belastingdienst.

De makers zijn niet aansprakelijk voor fouten in berekeningen, gemiste deadlines, onjuiste aangiftes, financieel verlies of andere gevolgen van het gebruik van deze software. Gebruik Florin op eigen risico.

## Licentie

[MIT](LICENSE)
