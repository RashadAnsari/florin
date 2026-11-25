# Tax year rules

Everything that depends on the law of a year lives in one `TaxYearRules`
value per year: `lib/services/tax_rules/tax_year_<year>.dart`, listed in
`taxYears` in `lib/services/tax_rules/tax_year_rules.dart`. Nothing else in
the app holds a statutory figure: rates, thresholds, terms and the figures in
help texts all come from these rules, so a year works once its rules exist.
Each year's values are sourced in `docs/tax-years/<year>.md`, which ends with
a table of every field. `test/services/tax_year_docs_test.dart` fails when a
field is missing from this page or from a year's page.

Add a year only with the `new-tax-year` skill. Every field below needs a
value read from a primary source now; a value is never copied from the
previous year without a source that confirms it for the new year.

## What changes each year

These are indexed or set again every year. Expect a new value.

| Field | What it is | Law | Where to find the new value |
| --- | --- | --- | --- |
| `box1Brackets` | Box 1 brackets: upper bound and combined rate of each | Wet IB 2001 art. 2.10 lid 1, with the premies volksverzekeringen | Belastingdienst, Fiscale informatie `<year>`, tarieven; the statute version of 1 January |
| `algemeneHeffingskorting` | Maximum, phase-out start, rate and end | Wet IB 2001 art. 8.10 lid 2 | Fiscale informatie, Heffingskortingen |
| `arbeidskorting` | Segments with their caps | Wet IB 2001 art. 8.11 lid 2 | Fiscale informatie, Heffingskortingen; follow the statute's caps |
| `tariefaanpassingRate` | Rate at which deductions above the top bracket are taxed back | Wet IB 2001 art. 2.10 lid 2 | The statute text; it is the top rate minus the rate below it |
| `zvwRate` | Inkomensafhankelijke bijdrage Zvw for ondernemers | Zvw art. 45, ministeriële regeling | Fiscale informatie, Inkomensafhankelijke bijdrage Zvw |
| `zvwMaxIncome` | Maximum bijdrage-inkomen | Zvw art. 43 lid 3, ministeriële regeling | Same page |
| `kia` | Kleinschaligheidsinvesteringsaftrek table | Wet IB 2001 art. 3.41 lid 2 | Fiscale informatie, Ondernemersaftrek en investeringsaftrek |
| `desinvesteringDrempel` | Sales at or below which no desinvesteringsbijtelling applies | Wet IB 2001 art. 3.47 lid 1 | Same page |
| `soAftrek` | S&O-aftrek | Wet IB 2001 art. 3.77 lid 1 | Same page |
| `soStarterIncrease` | S&O-aftrek increase for starters | Wet IB 2001 art. 3.77 lid 2 | Same page |
| `gemengdeKostenDrempel` | Threshold for food, drinks, representation and congresses | Wet IB 2001 art. 3.15 lid 1 | Fiscale informatie, Winst-en-verliesrekening; Drempel beperkt aftrekbare kosten `<year>` |
| `mileageCentsPerKm` | Deduction per business kilometre in a private vehicle | Wet IB 2001 art. 3.17 lid 1 b and any Staatscourant goedkeuring | Belastingdienst, Zakelijk gebruik privévervoermiddel `<year>`; search the Staatscourant when it differs from the statute |
| `aowFranchise` | AOW-franchise for the jaarruimte | Wet IB 2001 art. 3.127 lid 3 | Belastingdienst, Overzicht cijfers leven `<year>` |
| `premiegrondslagMaxIncome` | Most income of the previous year that counts for the premiegrondslag; the most jaarruimte follows from it | Wet IB 2001 art. 3.127 lid 3 | Statute; same overview |
| `reserveringsruimteMax` | Most reserveringsruimte | Wet IB 2001 art. 3.127 lid 2 | Same overview |

## What changes when the law changes

The law sets these until it is amended, often by the Belastingplan. Check
the statute version of 1 January of the new year, its transitional articles
(chapter 10a of the Wet IB 2001) and the Belastingdienst's "veranderingen
`<year>`" pages.

| Field | What it is | Law | Where to check |
| --- | --- | --- | --- |
| `zelfstandigenaftrek` | Zelfstandigenaftrek under the AOW age | Wet IB 2001 art. 3.76 lid 2 | Statute; Ondernemersaftrek `<year>` |
| `startersaftrek` | Increase for starters | Wet IB 2001 art. 3.76 lid 3 | Statute |
| `mkbWinstvrijstelling` | MKB-winstvrijstelling rate | Wet IB 2001 art. 3.79a | Statute; Mkb-winstvrijstelling `<year>` |
| `urencriterium` | Hours a year for the urencriterium | Wet IB 2001 art. 3.6 lid 1 | Statute |
| `reducedUrencriterium` | Verlaagd urencriterium | Wet IB 2001 art. 3.78a lid 3 | Statute |
| `kiaMinAssetCost` | Smallest asset that counts for the KIA | Wet IB 2001 art. 3.45 lid 2 b | Statute |
| `eiaRate` | Energie-investeringsaftrek rate | Wet IB 2001 art. 3.42a | Fiscale informatie; Investeringsaftrek `<year>` |
| `eiaMiaMinAssetCost` | Smallest asset for EIA and MIA | Wet IB 2001 art. 3.45 lid 4 b | Statute |
| `miaRates` | MIA rate per category | Wet IB 2001 art. 3.42 | Fiscale informatie |
| `eiaMiaReportMonths` | Months to report an EIA or MIA investment to RVO | RVO rules | Fiscale informatie |
| `soMinHours` | S&O hours for the S&O-aftrek | Wet IB 2001 art. 3.77 lid 1 | Statute |
| `soStarterMaxYears` | Years with an S&O-verklaring a starter may have | Wet IB 2001 art. 3.77 lid 2 | Statute |
| `meewerkaftrek` | Partner hours and share of profit | Wet IB 2001 art. 3.78 lid 2 | Statute |
| `meewerkMaxPartnerPay` | Partner pay below which the partner counts as unpaid | Fiscale informatie, meewerkaftrek | Fiscale informatie |
| `stakingsaftrekMax` | Most stakingsaftrek over a lifetime | Wet IB 2001 art. 3.79 lid 2 | Statute |
| `disabilityStartersaftrek` | Startersaftrek bij arbeidsongeschiktheid by times used | Wet IB 2001 art. 3.78a lid 4 | Statute |
| `unrealisedZelfstandigenaftrekYears` | Years unrealised zelfstandigenaftrek carries forward | Wet IB 2001 art. 3.76 lid 7 | Statute |
| `starterLookbackYears` | Previous years in which a starter was not an ondernemer; also the years of the urencriterium exception for someone with a job | Wet IB 2001 art. 3.76 lid 3, art. 3.6 lid 1 b | Statute |
| `starterMaxZelfstandigenaftrek` | Times a starter may have had the zelfstandigenaftrek | Wet IB 2001 art. 3.76 lid 3 | Statute |
| `courseTravelMax` | Travel and stay for courses and congresses deductible a year | Wet IB 2001 art. 3.16 lid 2 f | Statute |
| `gemengdeKostenPct` | Deductible share of food, drinks, representation and congresses | Wet IB 2001 art. 3.15 lid 5 | Statute |
| `carBijtellingRate` | Addition for private use of a business car | Wet IB 2001 art. 3.20 lid 1 a | Statute; Bijtelling privégebruik auto `<year>` |
| `carOldBijtellingRate` | Addition for a car older than `carOldAfterYears` | Wet IB 2001 art. 3.20 lid 1 b | Statute |
| `carZeroEmissionReduction` | Zero-emission reduction and its maximum; later years use it for cars registered in this year | Wet IB 2001 art. 3.20 lid 2 and 11 | Statute; Bijtelling privégebruik auto `<year>` |
| `carPrivateKmLimit` | Private kilometres a year without an addition | Wet IB 2001 art. 3.20 lid 1 and 3 | Statute |
| `carMarketValueAfterYears` | Age after which the market value replaces the catalogue value | Wet IB 2001 art. 3.20 lid 5 b | Statute |
| `carOldAfterYears` | Age after which `carOldBijtellingRate` applies | Wet IB 2001 art. 3.20 lid 1 b | Statute |
| `carReductionFreezeMonths` | Months a registration year's reduction holds | Wet IB 2001 art. 3.20 lid 11 | Statute |
| `maxDepreciationRate` | Most depreciation a year, which sets the shortest useful life | Wet IB 2001 art. 3.30 lid 2 | Statute |
| `reinvestmentReserveYears` | Years to use a herinvesteringsreserve | Wet IB 2001 art. 3.54 lid 5 | Statute |
| `desinvesteringYears` | Years in which a sale leads to a desinvesteringsbijtelling | Wet IB 2001 art. 3.47 lid 2 | Statute |
| `jaarruimtePct` | Share of the premiegrondslag | Wet IB 2001 art. 3.127 lid 1 | Statute |
| `factorAMultiplier` | Factor A multiplier of the transitional jaarruimte rule | Wet IB 2001 art. 10a.25 lid 1 with art. 3.127 lid 4 as of 31 December 2023 | Statute; Overzicht cijfers leven `<year>` |
| `vatRates` | BTW rate per category | Wet OB 1968 art. 9 | Statute |
| `vatRevisionYears` | Years deducted BTW on a movable asset is followed | Belastingdienst, Herziening btw-aftrek bij investeringsdiensten | That page |
| `vatRevisionMinShift` | Share of the first year's taxed use a change must exceed for a revision | Same | That page |
| `korRevisionMin` | Yearly revision below which joining or leaving the KOR revises nothing on older assets | Belastingdienst, herziening vanwege de KOR | That page |
| `btwPrivateCarRate` | BTW on private use of a car without a trip log | Belastingdienst, Btw en privégebruik auto van de zaak | That page |
| `btwPrivateCarReducedRate` | The reduced rate of the same rule | Same | That page |
| `btwPrivateCarReducedAfterYears` | Years after the year in use before the reduced rate | Same | That page |
| `btwPrivateCarPurchaseYears` | Years the purchase BTW counts over in the cap | Same | That page |
| `korThreshold` | Most turnover in the Netherlands for the KOR | Wet OB 1968 art. 25a lid 1 | Statute; Belastingdienst, KOR |
| `euConsumerSalesThreshold` | Electronic services and distance sales to consumers in other member states above which they are taxed there | Wet OB 1968 art. 6k lid 1 c | Statute |
| `icpQuarterlyGoodsMax` | Goods a quarter above which the ICP-opgaaf is monthly | Wet OB 1968 art. 37a lid 3, ministeriële regeling | Belastingdienst, Tijdvak opgaaf ICP |
| `icpGoodsLookbackQuarters` | Previous quarters that must also stay at or below `icpQuarterlyGoodsMax` for a quarterly opgaaf | Wet OB 1968 art. 37a lid 3 | Statute; Belastingdienst, Tijdvak opgaaf ICP |
| `icpDueMonths` | Months after its period in which the ICP-opgaaf is due | Wet OB 1968 art. 37a lid 1 | Statute |
| `buaGiftThreshold` | Gifts to one person a year at or below which their BTW stays deductible | Besluit uitsluiting aftrek omzetbelasting 1968 art. 4 | Statute |
| `invoiceDueDay` | Day of the next month by which an invoice is due | Wet OB 1968 art. 34g | Statute |
| `vatYearlyReturnDueMonths` | Months after the year in which a yearly return and payment are due | Belastingdienst practice | Belastingdienst, Uiterste aangifte- en betaaldatums |
| `yearlyFilingMaxVat` | BTW a year below which a yearly return may be asked for | Belastingdienst practice | Belastingdienst, Over welk tijdvak moet ik btw-aangifte doen? |
| `yearlyFilingMaxEu` | Each kind of EU transaction a year below which a yearly return may be asked for | Belastingdienst practice | Same page |
| `vatReturnDueMonths` | Months after a quarter in which its return and payment are due | AWR art. 19 lid 1 | Statute; Belastingdienst, Uiterste aangifte- en betaaldatums |
| `provisionalAssessmentMonth` | Month of the next year on whose first day a voorlopige aanslag can last be asked for or changed without a letter asking for a return | Belastingdienst practice | Belastingdienst, Tot wanneer kan ik een voorlopige aanslag aanvragen of wijzigen? |
| `statutoryPaymentDays` | Days after receiving an invoice from which commercial interest runs without an agreed term | BW 6:119a lid 2 | Statute |
| `maxAgreedPaymentDays` | Longest term between businesses without stating it explicitly | BW 6:119a lid 5 | Statute |
| `largeDebtorMaxPaymentDays` | Longest term a large legal person may agree with a small supplier | BW 6:119a lid 6 | Statute |
| `minCollectionCosts` | Least collection costs between businesses | BW 6:96 lid 4 | Statute |
| `consumerReminderDays` | Days a private person gets in a reminder before collection costs | BW 6:96 lid 6 | Statute |
| `claimLimitationYears` | Years in which a claim can be brought to court | BW 3:307 lid 1 | Statute |
| `retentionYears` | Years records are kept | AWR art. 52 lid 4 | Statute |
| `navorderingYears` | Years after the tax became due in which the Belastingdienst can raise it afterwards | AWR art. 16 lid 3 | Statute |
| `navorderingForeignYears` | The same for income or assets abroad | AWR art. 16 lid 4 | Statute |

## Not in the rules

- `year`: the year itself.
- `carReductionByRegistrationYear` in `car_reductions.dart` holds the
  zero-emission reductions of registration years before Florin's first tax
  year. A year with rules supplies its own, so a new year adds nothing there.
- The shape of the rules is code: the number of brackets, the segments of a
  heffingskorting, how the ondernemersaftrek is ordered. When the law changes
  shape, change `TaxYearRules` and the services, and give every year a value.
- Non-yearly rules without a figure, such as the rubrieken of the BTW return
  and the contents of an invoice, are in `docs/legal.md`. Check they still
  hold for the new year.
