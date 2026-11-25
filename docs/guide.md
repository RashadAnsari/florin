# Using Florin

[Nederlands](guide.nl.md)

This guide walks through every task Florin is made for, in the order a
freelancer meets them: setting up, the daily records, the BTW return, the
income tax return, the year end and keeping your records. For each task it
says what the law asks, where you do it in Florin and what Florin does with
it. The sources of every rule are in [`legal.md`](legal.md) and the yearly
figures in [`tax-years/`](tax-years/).

Florin prepares figures and estimates them; it does not file anything and
does not give advice. You file in Mijn Belastingdienst Zakelijk, or your
accountant does.

## 1. Setting up

1. **Choose where your records live.** On first start, pick a folder for
   `florin.db`. Receipts go into a `receipts` folder next to it. A folder in
   iCloud Drive, OneDrive or Dropbox gives you a backup; choosing a folder
   that already holds `florin.db` opens it.
2. **Enter your business details** in Settings, Business details: name, BTW
   number, KvK number, address and IBAN. Every invoice prints them, as the
   law asks.
3. **The KOR.** If you take part in the kleineondernemersregeling, enter the
   date the Belastingdienst confirmed under Settings, Kleineondernemersregeling.
   Leave it empty if you do not take part.
4. **Pick the year** in the sidebar. Only years whose rules Florin has
   checked can be chosen, and every date you enter falls in such a year.
5. **Language.** Settings, Language switches between English and Dutch.
   Invoices and exports stay in Dutch either way.

## 2. Daily records

### Clients

Clients holds who you work for. For each client:

- **Country and BTW number** decide which BTW treatment fits an invoice.
  Florin refuses a treatment that does not fit the country.
- **Private person, not a business**: tick this for a consumer. BTW is then
  never shifted to them and they are not on the ICP-opgaaf. For a private
  person in another EU country, the invoice form shows how far your
  supplies to such clients are from the € 10.000 threshold (2026) above
  which electronic services are taxed in their country.
- **Merchant of record**: for an app store or reseller that sells in its
  own name and issues the invoice to you (self-billing).
- **Wet DBA**: your own assessment of the working relationship, the
  contract date and whether it is signed. Florin does not assess the
  relationship. The client's page shows your hours for it, what you invoiced
  and the estimated hourly rate that follows, the facts such an assessment
  weighs.

A client with invoices or hours cannot be deleted; mark it inactive instead.

### Invoices

1. Invoices, **+**: choose the client. The BTW treatment follows the client;
   change it if another fits.
2. Fill in the dates, the payment term and the lines. Florin warns when the
   invoice is later than the 15th of the month after the supply, and when a
   payment term between businesses is longer than 60 days.
3. **Send** issues the invoice: it gets its number, is locked and its PDF is
   kept exactly as sent. An issued invoice cannot be changed; correct it
   with a **Credit note**, which names the invoice it corrects.
4. Mark it **Paid** with the date the money came in.

The invoice list shows what is open and overdue. An overdue invoice says
what the law gives you: from a business, statutory commercial interest and
at least € 40 collection costs without a reminder; from a private person,
a reminder with 14 days first. It also shows the last day the claim can go
to court.

### Expenses

1. Expenses, **+**: date, category, supplier, amount and BTW rate.
2. **Category matters for the tax**:
   - Food, drinks, representation and congresses: partly deductible.
   - Travel and stay for courses and congresses: up to € 1.500 a year.
   - Fines, clothing and personal care, a phone line at home and books other
     than professional literature: recorded but not deducted.
   - Business gifts: enter the recipient. Once a recipient's gifts pass
     € 227 in a year, Florin reclaims no BTW on them.
3. **BTW**: tick Reclaim VAT when you may deduct it. Choose how the BTW was
   charged when it was shifted to you (domestic, from the EU or from outside
   the EU). Under the KOR no BTW is reclaimed.
4. **Business use**: the slider sets the business share of a mixed cost. A
   cost of a business car always counts in full; the car's private use is
   corrected through the bijtelling.
5. Add the receipt (below).

### Receipts

Drop the PDF, photo, scan or e-invoice on the expense, asset or invoice.
Florin copies it unchanged, shows how long to keep it and checks under
Settings, Receipts that nothing went missing or changed. Florin never deletes
a receipt: one you remove stays under Removed receipts.

### Hours

Hours, **+**: date, hours, description, the kind of work and, if it was for
a client, the client. Hours count for the urencriterium (1.225 hours in
2026), which the zelfstandigenaftrek and other deductions need. Only logged
hours count.

Tick **Worked by my fiscal partner** for your partner's hours. They do not
count for your own urencriterium, but from 525 hours a year they give the
meewerkaftrek, as long as the partner is unpaid or earns less than € 5.000.

### Mileage

- **Private vehicle**: log business and commuting trips. Florin deducts the
  Belastingdienst rate per kilometre.
- **Business car**: log every trip in the car if you want to avoid the
  bijtelling. Florin checks that each trip starts where the one before
  ended and that a detour names its route. An incomplete log counts as
  none: the bijtelling and the BTW on private use then apply.

### Assets

Assets, **+** for anything you use for several years: cost, purchase date,
useful life, residual value and business share. Florin depreciates by the
day and applies the KIA, EIA and MIA. For a business car, enter the
catalogue value, first registration and zero emission, and whether you keep
a trip log. When you sell an asset, enter the date and proceeds or link the
sale invoice; Florin computes the gain and, if you choose, the
herinvesteringsreserve.

## 3. The BTW return

### Filing period

Choose the period of your returns on the VAT Return screen: per quarter,
per month or per year, as your aangiftebrief says. With a yearly period,
Florin warns when the year breaks the conditions for it.

### Each return

1. Open VAT Return and pick the period. Florin fills in every rubriek from
   your records and shows the deadline.
2. A period without anything to report still needs a nil return. Under the
   KOR there is no regular return, except an incidental one when BTW is
   owed, such as BTW shifted to you; Florin says which.
3. Copy the figures into Mijn Belastingdienst Zakelijk. The export (Settings,
   Export) has one file per period with every rubriek in whole euros.
4. Tick **Return filed**, and **VAT paid** once you paid. Florin keeps the figures you
   filed.

### Corrections

When you change a record in a period you already filed, the period shows
what changed. A change of at most € 1.000 is added to your following
return, and filing that return settles it. A larger change needs the form
Suppletie btw, within 8 weeks after you found the error; tick **I filed the
suppletie** afterwards.

### ICP-opgaaf

Supplies to EU businesses are listed per quarter on the VAT Return screen
and in the export. When goods pass € 50.000 in a quarter or one of the
four before it, the opgaaf over goods is monthly; Florin warns and writes
the monthly lists too.

### KOR

With the KOR, invoices carry no BTW and no BTW is reclaimed. Florin follows
your turnover against the € 20.000 limit and ends the KOR at the invoice
that passes it. When the KOR starts, BTW reclaimed earlier on assets is
partly repaid (herziening): Florin estimates it per asset and adds it to the
last return of the year.

### Private use of a business car

The BTW on private use goes into the last return of the year, rubriek 1d.
With a complete trip log it follows the private and commuting kilometres;
without one Florin uses the Belastingdienst's fixed rate.

## 4. The income tax return

### P&L and estimated tax

The P&L & Tax screen shows revenue, costs, profit, every deduction and the
estimated tax, line by line, as the return computes them. Below it:

- **Facts for the year**: whether you were a business owner before and are
  a starter, partner hours not in the log and pay to your partner, an
  S&O-verklaring, stopping the business, a disability benefit, unused
  zelfstandigenaftrek, losses from earlier years and a job next to the
  business. Enter what applies.
- **Voorlopige aanslag and toeslagen (estimated)**: the belastbare winst,
  box 1 income and tax to pay to use when you ask for or change a voorlopige
  aanslag, and when you estimate your income for toeslagen, with the last
  day to do so.
- **Balance sheet on 31 December (estimated)**: enter your bank and cash
  balances, unpaid supplier invoices, loans, the ondernemingsvermogen on
  1 January and your private withdrawals and deposits. Florin adds the
  assets, open invoices and open BTW, and computes the equity comparison of
  the return (vraag 19). A difference with the estimated profit points to a
  missing balance or record.

### Pension and AOV

The Pension screen computes your jaarruimte from last year's income from
work and your factor A, adds the reserveringsruimte, and shows the deductible
premium and the estimated tax saving. Premiums for disability insurance
(AOV) are deducted in full.

### Filing

Florin does not file the return. Copy the figures from the P&L & Tax screen
and the export into Mijn Belastingdienst, or give the export to your
accountant.

## 5. The year end

1. Check that every invoice, expense, receipt, trip and hour of the year is
   in Florin, and mark paid invoices as paid.
2. Mark each BTW return filed and paid; handle any correction.
3. Fill in the year's facts and the balance sheet on the P&L & Tax screen.
4. Export the year (Settings, Export) and keep the folder with your records.
   Put the balance sheet and the statement of income and expenses on paper
   within six months, as the Civil Code asks of every business.

## 6. Keeping your records

- **Seven years.** Invoices, receipts and records are kept for seven years.
  The Belastingdienst can raise a year's tax for five years after it, longer
  with uitstel, and twelve years for income or assets abroad; keep such a
  year's records at least that long.
- **The export** holds every record, the BTW returns, the ICP lists, the
  estimated income tax and balance sheet, the business details, pension
  figures, the year's facts, the filed status of each return and the
  receipts, in Dutch.
- **Moving or backing up.** Settings, Database copies the database and the
  receipts folder to another folder. Copy the folder only while Florin is
  closed.

## 7. What Florin does not do

- File returns or send invoices for you.
- A fiscal partner's income, other work, benefits, box 2 and box 3.
- The OSS return, the EU-KOR, real estate and stock.
- Options you may choose that lower the profit, such as willekeurige
  afschrijving for starters.
- Assess a working relationship under the Wet DBA.

[`legal.md`](legal.md) lists, rule by rule, what Florin applies and what it
leaves out.
