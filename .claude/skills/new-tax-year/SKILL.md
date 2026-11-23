---
name: new-tax-year
description: Adds the verified statutory figures for a new Dutch tax year to Florin. Use when asked to "add tax year 2027", "update the tax rules for next year", "new year legal rules", or when the Belastingdienst publishes figures for a year Florin does not cover.
argument-hint: <year>
---

# Add a tax year

Year to add: `$ARGUMENTS`. If that is empty or left as written, take the year from the user's message; if there is none, ask for it.

Florin shows and accepts only years listed in `taxYears` in `lib/services/tax_rules/tax_year_rules.dart`: adding a year makes it selectable and bookable. A missing year is never filled in from another year. Every figure for the new year must come from a primary source read now; the previous year's value is never carried over without a source confirming it is unchanged.

## Steps

1. Read `docs/tax-years/<previous year>.md` and `lib/services/tax_rules/tax_year_<previous year>.dart` to get the list of figures.
2. For every field of `TaxYearRules`, find the new year's value in a primary source (see the legal-review skill for the order of sources and how to read them). Prefer the Belastingdienst's "Fiscale informatie <year>" pages and the statute text in force on 1 January of the year, read from the official XML because wetten.overheid.nl refuses scripted requests. A summary of a page is not a source: copy the exact sentence.
3. If a figure is not yet published, or primary sources conflict and the law that settles it is not yet enacted, stop and report which ones. Do not add a partial year. Check the version of wetten.overheid.nl for 1 January of the year: amounts still equal to the previous year can mean the inflation correction or the Belastingplan is not consolidated yet.
4. Create `docs/tax-years/<year>.md` in the same layout as the previous year: each figure with a verbatim quote, a link and the retrieval date. Note any conflict between sources and which one Florin follows.
5. Create `lib/services/tax_rules/tax_year_<year>.dart` with a `taxYear<year>` constant, amounts in cents, rates as fractions. Add it to `taxYears`.
6. If the law changed shape (a new bracket, a new segment in a korting, a new deduction), extend `TaxYearRules` and `TaxService` rather than approximating, and update every existing year to the new shape with sourced values.
7. Add `test/services/tax_year_<year>_test.dart` modelled on the previous year's test, with expected values worked by hand from the sourced tables. Update the "years without verified rules" test.
8. Check the non-yearly rules in `docs/legal.md` still hold for the new year: BTW rates, rubrieken, the return deadlines for the new year's quarters, who must file what (Filing a return), the KOR (art. 25a and its limit) and the ICP-opgaaf, art. 35a, art. 3.30, the bewaarplicht. Update them if not.
9. Update both READMEs where they name the covered tax years.
10. Check that `make demo` still runs and that the demo's year is a supported year, so the screenshots and `test/demo_coverage_test.dart` still cover every feature.
11. Run `make local` until it passes, then open the app on the new year (`make run`) and check the dashboard, BTW return and P&L & Tax screens show its figures.

## Report

List the figures that changed against the previous year, any source conflicts, and anything the new year's law adds that Florin does not model.
