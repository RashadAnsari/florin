---
name: new-tax-year
description: Adds the verified statutory figures for a new Dutch tax year to Florin. Use when asked to "add tax year 2027", "update the tax rules for next year", "new year legal rules", or when the Belastingdienst publishes figures for a year Florin does not cover.
argument-hint: <year>
---

# Add a tax year

Year to add: `$ARGUMENTS`. If that is empty or left as written, take the year from the user's message; if there is none, ask for it.

A year exists in Florin when its `TaxYearRules` is in `taxYears` (`lib/services/tax_rules/tax_year_rules.dart`). Everything that depends on the law of a year reads that value: rates, thresholds, terms, the BTW rates, the deadlines and every figure a help text names. So a correct rules file and its sources are the whole job; no screen, service or text needs a change for a new year unless the law changed shape. Adding the year makes it selectable and bookable, so a missing year is never filled in from another year, and no value is carried over without a source that confirms it for the new year.

`docs/tax-years/README.md` lists every field: what it is, the article behind it, whether it changes every year or only when the law changes, and where to find the new value. Work from that list.

## Tools

The legal-review skill's scripts read the sources (run them with `python3 -I`):

- `.claude/skills/legal-review/scripts/statute.py BWBR0011353 <year>-01-01` downloads the official XML of the Wet IB 2001 in force on 1 January and lists every version that starts in that year. Do the same for the Wet OB 1968 (`BWBR0002629`), the AWR (`BWBR0002320`), the Zorgverzekeringswet (`BWBR0018450`) and the Besluit uitsluiting aftrek omzetbelasting 1968 (`BWBR0002636`).
- `.claude/skills/legal-review/scripts/articles.py <xml> 2.10 3.76` prints articles lid by lid; `--refers 3.127` finds the articles that refer to one, where transitional rules and exceptions sit.
- `.claude/skills/legal-review/scripts/verify_quotes.py docs/legal.md docs/tax-years/<year>.md` checks every quote word for word against its source.

## Steps

1. Read `docs/tax-years/README.md`, then `docs/tax-years/<previous year>.md` and `lib/services/tax_rules/tax_year_<previous year>.dart`.
2. Download the statutes in force on 1 January of the new year. Check the versions `statute.py` lists: a later version in the year, or a retroactive correction of 1 January (a `_1` label), may change a figure. Compare the articles behind every field with the previous year's version.
3. For each field in "What changes each year", find the new value in the Belastingdienst's Fiscale informatie `<year>` pages, the "veranderingen `<year>`" pages and the figure overviews, and confirm it in the statute. A value in the statute that still equals last year's can mean the indexation or the Belastingplan is not yet consolidated: find the law that sets it.
4. For each field in "What changes when the law changes", read its article in the new version and confirm the value or take the new one. Check chapter 10a of the Wet IB 2001 for transitional rules (as `factorAMultiplier` follows artikel 10a.25).
5. Search the Staatscourant (zoek.officielebekendmakingen.nl) for goedkeuringen and besluiten for the new year that apply a different figure than the statute; the 2026 kilometre allowance of € 0,25 came from one (Stcrt. 2026, 18302). When the statute and the Belastingdienst disagree, quote both and follow what the Belastingdienst applies, with its legal basis.
6. If a figure is not yet published, or sources conflict without a law that settles it, stop and report which ones. Do not add a partial year.
7. Write `docs/tax-years/<year>.md` in the layout of the previous year: each figure with a verbatim quote, a link and the retrieval date, and at the end the table "Every field of the `<year>` rules" with every field, its value and where it is sourced. Rules quoted in `docs/legal.md` are referenced there; quote any that changed.
8. Create `lib/services/tax_rules/tax_year_<year>.dart` with a `taxYear<year>` constant: amounts in cents, rates as fractions. Add it to `taxYears`.
9. If the law changed shape (a new bracket, a new segment, a new deduction or condition), extend `TaxYearRules` and the services rather than approximating, give every year a sourced value, add the field to `docs/tax-years/README.md`, and give any text that names it a placeholder.
10. Tests: add `test/services/tax_year_<year>_test.dart` modelled on the previous year's, with expected values worked by hand from the sourced tables. Update the test that asserts which years exist. `test/services/tax_year_docs_test.dart` fails until every field is in the year's doc.
11. Run `verify_quotes.py` on `docs/legal.md` and the new year's doc until only table rows remain to check by hand, and check those.
12. Check the non-yearly rules in `docs/legal.md` still hold: BTW rubrieken, invoice contents, the KOR, the ICP-opgaaf, artikel 3.30, the bewaarplicht. Quote the new year's row of the BTW deadlines table.
13. Update both READMEs and both guides (`docs/guide.md`, `docs/guide.nl.md`) where they name the covered tax years or a yearly figure, such as an amount or the urencriterium hours.
14. Run `make local` until it passes. Then run the app on the new year with the `ui-review` skill (`UI_REVIEW_YEAR=<year> .claude/skills/ui-review/scripts/start.sh en light`) and open the dashboard, BTW return, P&L & Tax, Pension, a new expense, an asset and Settings. Check the figures in the help texts show the new year's values.

## Report

List the figures that changed against the previous year with their source, any source conflicts and how they were settled, the Staatscourant decisions applied, and anything the new year's law adds that Florin does not model.
