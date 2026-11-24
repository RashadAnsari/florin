---
name: ui-review
description: Runs Florin with the demo data on a virtual display, clicks through the screens and checks them against the design rules in AGENTS.md, in English and Dutch, light and dark. Use when asked to "click through the app", "check the UI", "take screenshots", "is the spacing right", or after any change a user can see.
---

# UI review

Look at the real app, not only the tests. A screen passes when it follows the Design, UI rules and Forms sections of AGENTS.md in both languages and both themes.

## Start the app

```sh
make demo
flutter build linux --release
.claude/skills/ui-review/scripts/start.sh en light    # or: nl dark
.claude/skills/ui-review/scripts/shot.sh dashboard    # saves the screen
.claude/skills/ui-review/scripts/shot.sh invoices 80 143   # clicks, then saves
```

`start.sh` opens the demo's year, or `UI_REVIEW_YEAR` when set. It copies `demo/` to a work folder (`UI_REVIEW_DIR`, default `/tmp/florin-ui-review`), so clicks never change the demo, sets the language and the GTK colour scheme, and opens a 1440 x 900 window at the left top of display `:99`. Read each screenshot with the Read tool. Use `xdotool key Escape` to close a dialog and `xdotool click 5` over a page to scroll it. At 1440 x 900 the sidebar items sit at x 80 and y 101 (Dashboard) to 479 (Pension) in steps of 42, Settings at y 866, a page's back button at (257, 28) and its add button at (1411, 28).

## What to open

For a full review, every one of these in English light and Dutch dark; for a change, the screens it touches in both:

- Dashboard, and each list: Invoices, Clients, Expenses, Hours, Mileage, Assets.
- A detail page from each list: a draft invoice, a sent one, one issued by the customer, a credit note; a client, a merchant of record; an expense with and without receipts; a car asset and a sold one.
- Each new-record form, saved empty to see every validation message.
- BTW return for every quarter, P&L & Tax scrolled to the end, Pension, Settings scrolled to the end, Removed receipts.
- A delete confirmation, and the first launch screen (start without a saved database path).

## Check

- **One left edge**: title, controls, rows and content start at the same x. Right edges line up with the save button.
- **Same thing, same look**: every list row has the same title, details and figure style; every heading inside a page is a `SectionLabel`; every field, dropdown and read-only value has the same height and text size.
- **Nothing cut off**: Dutch labels are longer. A cut label shows a tooltip; a figure shrinks rather than wraps.
- **Status in words**: every badge has a word; no meaning carried by colour or strikethrough alone.
- **Help**: every field, checkbox and tax term has a help icon that opens; locked forms still explain themselves.
- **Feedback**: validation appears under the field that is wrong; a locked record says why and what to do; a confirm button names its action.
- **Spacing** from `AppSpacing` only, the same gap between the same kinds of things on every screen.
- **Dark mode**: no text or border that disappears; `test/theme/contrast_test.dart` covers every colour.
- **Professional**: files as icon, name, type, size and date, never a preview.

## Fix and report

Fix a problem where it starts: the theme, a shared widget or `AppSpacing`, not one screen, so every screen gets it. When a rule was missing, add it to AGENTS.md. Run `make local`, rebuild, and shoot the same screens again to compare. Report what changed per screen and send the before and after screenshots that show it.
