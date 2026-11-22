---
name: legal-review
description: Reviews Florin for legal and tax correctness against primary Dutch sources. Use when asked to "legal review", "check the law", "verify tax figures", "is this legally correct", or before merging any change to invoices, BTW, income tax, depreciation, pension, Wet DBA or user-facing legal copy.
---

# Legal review

Every legal or tax rule in Florin must trace to a primary source read during the review. Nothing is assumed, recalled from memory or taken from a blog, calculator or accountant's site. A rule that cannot be sourced is reported as unverified, and the code takes the conservative branch: show no figure rather than a guessed one.

## Primary sources, in order

1. The statute on wetten.overheid.nl, in the version in force for the year under review: Wet op de omzetbelasting 1968 (BWBR0002629), Wet inkomstenbelasting 2001 (BWBR0011353), Besluit uitsluiting aftrek omzetbelasting 1968 (BWBR0002636), Zorgverzekeringswet.
2. belastingdienst.nl: Fiscale informatie (`/fisin/fisin<year>/`), the "veranderingen <year>" pages, and the Belastingdienst's published figure overviews.
3. Staatscourant and Staatsblad on officielebekendmakingen.nl for decrees and approvals the statute text does not show yet.

Secondary sites (KvK, banks, accounting blogs) may point to a source but never count as one. When two primary sources disagree, record both in the docs and follow the one the Belastingdienst applies, saying so.

wetten.overheid.nl pages are large; fetch the page with curl and extract the article text instead of relying on a summarised fetch. Save downloads in the session scratchpad.

## Scope

Check each area the change touches, or all of them for a full review:

- Invoice PDF against Wet OB art. 35a: every required item, «btw verlegd», customer BTW number on reverse charge, amount per rate, exemption wording, credit note reference to the corrected invoice. `lib/services/invoice_pdf_service.dart`.
- BTW return rubrieken and deadlines. `lib/services/vat_service.dart`.
- BTW rates and reclaim rules, including Wet OB art. 15 lid 5 for food and drinks. `lib/db/enums.dart`, the expense form.
- Income tax: ondernemersaftrek order and caps, mkb-winstvrijstelling, KIA, heffingskortingen, Zvw, gemengde kosten, depreciation limits. `lib/services/tax_service.dart`, `lib/services/tax_rules/`.
- Pension: jaarruimte basis year, franchise, caps. `lib/services/pension_service.dart`.
- User-facing legal copy in both ARB files and both READMEs: every claim must match a source. No promises of compliance.
- Statutory outputs (invoice PDF, CSV export) stay in Dutch.

## Process

1. List every rule, figure and legal claim in scope, with file and line.
2. For each, fetch the primary source and quote the exact text.
3. Compare. Classify as correct, wrong, unverified or not modelled.
4. Fix what is wrong. A changed rule gets a test that names the article it pins, written before the fix.
5. Record each rule with its verbatim quote, link and retrieval date in `docs/legal.md`, or in `docs/tax-years/<year>.md` for yearly figures. Remove entries for rules the code no longer implements.
6. Run `make local` until it passes.

## Report

Lead with what is wrong and what was changed. Then one line per remaining unverified or unmodelled rule. Say how each finding was verified: the source and the date read.
