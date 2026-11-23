---
name: legal-review
description: Reviews Florin for legal and tax correctness against primary Dutch sources. Use when asked to "legal review", "check the law", "verify tax figures", "is this legally correct", "do I still have to file", or before merging any change to invoices, BTW, the KOR, the ICP-opgaaf, income tax, depreciation, pension, receipts retention, Wet DBA or user-facing legal copy.
---

# Legal review

Every legal or tax rule in Florin must trace to a primary source read during the review. Nothing is assumed, recalled from memory or taken from a blog, calculator or accountant's site. A rule that cannot be sourced is reported as unverified, and the code takes the cautious branch: the one that files or pays more, or shows no figure rather than a guessed one, and says so.

## Primary sources, in order

1. The statute in the version in force for the year under review: Wet op de omzetbelasting 1968 (BWBR0002629), Wet inkomstenbelasting 2001 (BWBR0011353), Besluit uitsluiting aftrek omzetbelasting 1968 (BWBR0002636), Algemene wet inzake rijksbelastingen (BWBR0002320), Zorgverzekeringswet.
2. belastingdienst.nl: Fiscale informatie (`/fisin/fisin<year>/`), the "veranderingen <year>" pages, the topic pages for BTW, the KOR and the ICP-opgaaf, and the Belastingdienst's published figure overviews.
3. Staatscourant and Staatsblad on officielebekendmakingen.nl for decrees and approvals the statute text does not show yet.

Secondary sites (KvK, banks, accounting blogs) may point to a source but never count as one. When two primary sources disagree, record both in the docs and follow the one the Belastingdienst applies, saying so. When the statute and a Belastingdienst page differ in detail, quote both.

## Reading the sources

- wetten.overheid.nl refuses scripted requests (a browser check, or an HTTP/2 error). Read the official XML of the consolidated text instead and extract articles by number:
  `https://repository.officiele-overheidspublicaties.nl/bwb/<BWB id>/<yyyy-mm-dd>_0/xml/<BWB id>_<yyyy-mm-dd>_0.xml`, for example `BWBR0002629/2026-01-01_0/xml/BWBR0002629_2026-01-01_0.xml`. Each `<artikel>` has `kop/nr` and `lid` children. Link the wetten.overheid.nl page for the same date in the docs and say the text came from the official XML.
- Belastingdienst pages: `curl --http1.1 -L`, then strip the HTML of `<main>` to text.
- Save downloads in the session scratchpad and run any parser with `python3 -I`.
- A summary of a page is not a source, including one written by a subagent or a search tool. Read the exact sentences yourself before writing a rule. A search summary once concluded that KOR participants file an ICP-opgaaf; Wet OB art. 37a lid 1 exempts them.
- Search the statute for every article that refers to the one you are checking (for example every mention of `25a`): exceptions often sit in another article.

## Scope

Check each area the change touches, or all of them for a full review. Pin the file, the docs section and the test for each.

- **Invoices** against Wet OB art. 35a: every required item, «btw verlegd», customer BTW number on reverse charge, amount per rate, exemption wording, credit note reference to the corrected invoice, KOR invoices without any BTW mention (art. 25a lid 4). `lib/services/invoice_pdf_service.dart`.
- **Merchant of record and self-billing**: place of supply for services to a non-EU business (art. 6 lid 1), the customer issuing the invoice (art. 35 lid 2) and «factuur uitgereikt door afnemer» (art. 35a lid 1 k). Clients, invoice form, PDF.
- **BTW return**: rubrieken, rounding, deadlines, and who must file what. `lib/services/vat_service.dart`, `ReturnDuty`.
- **Filing duties, not only amounts**: for every period and every situation, which form is due. A return every quarter, a nil return when nothing happened, an incidental return when BTW is owed in a quarter the KOR covers, the ICP-opgaaf and who is exempt from it. A threshold or low turnover never removes a filing duty unless the law says so; check what the app shows below every threshold.
- **KOR** (art. 25a and the articles that refer to it): start and end dates, turnover that counts, the supply that passes the limit, no BTW deducted, invoices, the return duty and the ICP exception. `lib/services/kor_service.dart`.
- **BTW rates and reclaim rules**, including art. 15 lid 5 for food and drinks and BTW shifted to the user (2a, 4a, 4b). `lib/db/enums.dart`, the expense form.
- **Income tax**: ondernemersaftrek order and caps, mkb-winstvrijstelling, KIA, heffingskortingen, Zvw, gemengde kosten, depreciation limits, private use of a car. `lib/services/tax_service.dart`, `lib/services/tax_rules/`.
- **Pension**: jaarruimte basis year, franchise, caps. `lib/services/pension_service.dart`.
- **Receipts**: the bewaarplicht (7 years, 10 for real estate), kept in the form received, and the cautious start of the term. `ReceiptService`.
- **Exports**: each file follows the form it feeds (layout, codes, units, rounding), as AGENTS.md non-negotiable 7 says.
- **Copy** in both ARB files and both READMEs: every claim matches a source, every estimate says it is one, nothing promises compliance. Statutory outputs (invoice PDF, CSV export) stay in Dutch.

## Process

1. List every rule, figure, filing duty and legal claim in scope, with file and line.
2. For each, read the primary source and copy the exact text.
3. Compare. Classify as correct, wrong, unverified or not modelled.
4. Fix what is wrong. A changed rule gets a test that names the article it pins, written before the fix.
5. Make the demo show the rule: `tool/create_demo_database.dart` and `test/demo_coverage_test.dart`. Run `make demo`, open the screens it affects and check the badges, notices and figures read right in both languages.
6. Record each rule with its verbatim quote, link and retrieval date in `docs/legal.md`, or in `docs/tax-years/<year>.md` for yearly figures, with a short "Where Florin implements it" list. State the cautious choice wherever the sources are silent. Remove entries for rules the code no longer implements.
7. Update both READMEs when what Florin does for the user changes.
8. Run `make local` until it passes.

## Report

Lead with what is wrong and what was changed, in plain words: which screen, which figure, which form is now due. Then one line per remaining unverified or unmodelled rule. Say how each finding was verified: the source and the date read.
