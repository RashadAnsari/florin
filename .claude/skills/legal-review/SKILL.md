---
name: legal-review
description: Reviews Florin for legal and tax correctness against primary Dutch sources. Use when asked to "legal review", "check the law", "verify tax figures", "is this legally correct", "do I still have to file", or before merging any change to invoices, BTW, the KOR, the ICP-opgaaf, income tax, depreciation, pension, receipts retention, Wet DBA or user-facing legal copy.
---

# Legal review

Every legal or tax rule in Florin must trace to a primary source read during the review. Nothing is assumed, recalled from memory or taken from a blog, calculator or accountant's site. A rule that cannot be sourced is reported as unverified, and the code takes the cautious branch: the one that files or pays more, or shows no figure rather than a guessed one, and says so. Florin never promises compliance; the review makes every rule it applies match a source.

## Primary sources, in order

1. The statute in the version in force for the year under review: Wet op de omzetbelasting 1968 (BWBR0002629), Wet inkomstenbelasting 2001 (BWBR0011353), Besluit uitsluiting aftrek omzetbelasting 1968 (BWBR0002636), Algemene wet inzake rijksbelastingen (BWBR0002320), Zorgverzekeringswet (BWBR0018450).
2. belastingdienst.nl: Fiscale informatie (`/fisin/fisin<year>/`), the "veranderingen <year>" pages, the topic pages for BTW, the KOR and the ICP-opgaaf, and the Belastingdienst's published figure overviews.
3. Staatscourant and Staatsblad on zoek.officielebekendmakingen.nl for decrees, goedkeuringen and amendments the consolidated statute does not show yet.

Secondary sites (KvK, banks, accounting blogs) may point to a source but never count as one. When two primary sources disagree, quote both and follow the one the Belastingdienst applies, with its legal basis. The consolidated statute can lag: in 2026 it still read € 0,23 per kilometre while a Staatscourant goedkeuring (Stcrt. 2026, 18302) applied € 0,25 back to 1 January. Search the Staatscourant before calling such a difference an error.

## Tools

Scripts in `.claude/skills/legal-review/scripts/`. Run them with `python3 -I`; they cache downloads in `/tmp/florin-legal-sources`.

- `statute.py <BWB id> <date>`: wetten.overheid.nl refuses scripted requests, so this reads the official repository. It downloads the XML of the version in force on the date, prints its path, and lists every version that starts in that year, including retroactive corrections (`_1`). Link the wetten.overheid.nl page for the same date in the docs and say the text came from the official XML.
- `articles.py <xml> <article> ...`: prints articles lid by lid. `--refers <article>` prints every article that mentions it: exceptions and transitional rules often sit elsewhere (art. 37a lid 1 exempts KOR participants from the ICP-opgaaf; art. 10a.25 keeps factor A for the jaarruimte).
- `verify_quotes.py docs/legal.md docs/tax-years/<year>.md`: checks every quote in the docs word for word against its source and reports the ones that do not match. Quotes of one source share the link after them. Table rows written as "label: value · label: value" cannot match a page's table: check those by hand.

Belastingdienst pages also read well with `curl --http1.1 -L`, stripping the HTML of `<main>` to text. A summary of a page is not a source, including one written by a subagent or a search tool: read the exact sentences yourself before writing a rule. A search summary once concluded that KOR participants file an ICP-opgaaf; the statute exempts them.

## Scope

Check each area the change touches, or all of them for a full review. Pin the file, the docs section and the test for each.

- **Invoices** against Wet OB art. 34c to 35a: every required item, «btw verlegd», the customer's BTW number on reverse charge, the amount per rate (also with domestic reverse charge, as without it), exemption wording, credit note reference to the corrected invoice, KOR invoices without any BTW mention (art. 25a lid 4), numbers that follow on in their series (art. 35a lid 1 b), and the invoicing deadline (art. 34g). `lib/services/invoice_pdf_service.dart`, the invoice form.
- **Merchant of record and self-billing**: place of supply for services to a non-EU business (art. 6 lid 1), the customer issuing the invoice (art. 35 lid 2) and «factuur uitgereikt door afnemer» (art. 35a lid 1 k).
- **BTW return**: rubrieken, rounding, deadlines (AWR art. 19), and who must file what. `lib/services/vat_service.dart`, `ReturnDuty`.
- **Filing duties, not only amounts**: for every period and situation, which form is due. A return every quarter, a nil return when nothing happened, an incidental return when BTW is owed in a quarter the KOR covers, the ICP-opgaaf and who is exempt from it. A threshold or low turnover never removes a filing duty unless the law says so.
- **KOR** (art. 25a and every article that refers to it): dates, turnover that counts, the supply that passes the limit, no BTW deducted, invoices, the return duty, the ICP exception.
- **BTW rates and reclaim**: art. 9, art. 15 lid 5 for food and drinks in horeca, the Besluit uitsluiting aftrek (gifts above its threshold), BTW shifted to the user (2a, 4a, 4b), private use of a car.
- **Income tax**: the box 1 table and the tariefaanpassing (art. 2.10 lid 2 and 3), ondernemersaftrek order, conditions and caps (art. 3.74 to 3.79a), mkb-winstvrijstelling, KIA, EIA and MIA and what they exclude (art. 3.45), desinvesteringsbijtelling, herinvesteringsreserve, heffingskortingen, Zvw, gemengde kosten including congresses and study trips (art. 3.15), depreciation limits, private use of a car (art. 3.20), and with a job: wages in box 1 (art. 3.1), the arbeidsinkomen (art. 8.1), loonheffing as voorheffing (art. 9.2), loon Zvw against the maximum (Zvw art. 43 lid 5) and the urencriterium's time condition (art. 3.6 lid 1). `lib/services/tax_service.dart`, `asset_service.dart`, `car_service.dart`.
- **Pension**: jaarruimte basis year, franchise, caps, and the transitional rules of chapter 10a for pension schemes. `lib/services/pension_service.dart`.
- **Receipts**: the bewaarplicht (AWR art. 52 lid 4; 10 years for real estate), kept in the form received, and the cautious start of the term.
- **Exports**: each file follows the form it feeds (layout, codes, units, rounding), as AGENTS.md non-negotiable 7 says.
- **Yearly rules**: every statutory figure lives in the year's `TaxYearRules` and nowhere else, including the figures help texts name (`test/services/tax_year_docs_test.dart` checks the texts and the docs). A constant in a service or a figure typed into a text is a finding.
- **Assumptions about the future**: an estimate made during the year must not assume a fact that lowers tax before it is true. The urencriterium counts only logged hours; a deduction that needs the year to end waits for it.
- **Copy** in both ARB files and both READMEs: every claim matches a source, every estimate says it is one, nothing advises (no "consult an adviser"), nothing promises compliance, and nothing cites an article, lid, statute, Staatscourant or ruling: the source goes in `docs/legal.md` or `docs/tax-years/`, the copy says what the law does. The invoice PDF keeps the legal wording invoices require. Statutory outputs (invoice PDF, CSV export) stay in Dutch.

## Process

1. Run `verify_quotes.py` over `docs/legal.md` and every `docs/tax-years/<year>.md`. Fix quotes that do not match, have no link, or point to the wrong page.
2. List every rule, figure, filing duty and legal claim in scope, with file and line. Keep the list in the session scratchpad as findings: wrong, missing, not modelled, verified.
3. For each, read the primary source with the scripts and copy the exact text. Use `--refers` on the articles involved.
4. Compare. Classify as correct, wrong, unverified or not modelled.
5. Fix what is wrong. A changed rule gets a test that names the article it pins, written before the fix. A rule Florin cannot model from its data gets help text that states it and an entry in `docs/legal.md` that says it is not modelled.
6. Make the demo show the rule: `tool/create_demo_database.dart` and `test/demo_coverage_test.dart`. Run `make demo`, open the screens it affects with the `ui-review` skill, and check badges, notices, figures and the PDF in both languages.
7. Record each rule with its verbatim quote, link and retrieval date in `docs/legal.md`, or in `docs/tax-years/<year>.md` for yearly figures, with a short "Where Florin implements it" list. State the cautious choice wherever the sources are silent. Remove entries for rules the code no longer implements. Run `verify_quotes.py` again.
8. Update both READMEs when what Florin does for the user changes.
9. Run `make local` until it passes.

## Report

Lead with what was wrong and what changed, in plain words: which screen, which figure, which form is now due. Then one line per remaining unverified or unmodelled rule. Say how each finding was verified: the source and the date read.
