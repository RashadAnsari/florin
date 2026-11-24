# Working on Florin

Read this before changing anything. It is how to work here; `docs/` is what
the law says and where the code implements it.

Florin is offline bookkeeping for Dutch freelancers (ZZP): invoices,
expenses, BTW returns, an income tax estimate, hours, mileage, assets and
pension room, in one desktop app built with Flutter for macOS, Windows and
Linux. **People file real tax returns and send real invoices with its
output.** A wrong rule costs them money or a fine, and no test notices a rule
that was invented.

## The one rule

**Never write a legal or tax rule without a primary source read now.**

Not from memory, not from a calculator site, not from the previous year. The
statute on wetten.overheid.nl, the Belastingdienst, or the Staatscourant. If
you cannot quote it and link where you read it, the rule does not exist and
the code shows nothing rather than a guess. Every rule lives with its quote,
link and retrieval date in [`docs/legal.md`](docs/legal.md), or for yearly
figures in [`docs/tax-years/<year>.md`](docs/tax-years/).

Two skills hold the procedures:

- `legal-review` (`.claude/skills/legal-review/`, with scripts that read the
  statutes and check every quote in the docs): run it before merging any
  change to invoices, BTW, the KOR, the ICP-opgaaf, income tax, depreciation,
  pension, receipts retention, Wet DBA or legal copy.
- `new-tax-year` (`.claude/skills/new-tax-year/`): the only way a tax year is
  added.
- `ui-review` (`.claude/skills/ui-review/`): run the app headless, click
  through the screens a change touches in both languages and themes, and
  check them against the Design and UI rules below.

## Non-negotiables

1. **Only years with verified rules exist in the app.** The year selector
   lists `supportedYears` and `DateField` only accepts dates in them, so no
   record lands in a year the user cannot see. Never copy figures from
   another year to make a year available. Asset purchase dates, client
   contract dates and the KOR start and end dates are the exceptions and
   pass their own range.
2. **Issued invoices are immutable.** Only drafts are edited or deleted. A
   correction is a credit note that references the invoice it corrects.
3. **Invoice PDFs and CSV exports stay in Dutch**, whatever the app language.
4. **Florin estimates; it does not advise.** Copy states what the law says
   and what Florin computed. It never promises compliance or a result.
5. **Unknown resolves to the cautious answer.** When the law cannot be read
   from the data, take the branch that overstates tax rather than understates
   it, and tell the user.
6. **Statutory figures are code, not settings.** Users cannot edit rates or
   thresholds; they live in the year's `TaxYearRules` in
   `lib/services/tax_rules/`, and nowhere else: not as a constant in a
   service, not in the BTW rate enum, not written into a help text. A text
   that names a figure takes it from the rules through a placeholder, so a
   new year needs only its rules file. `docs/tax-years/README.md` explains
   every field; `test/services/tax_year_docs_test.dart` checks it and the
   texts.
7. **Exports follow the form they feed.** A figure the user copies into a
   return is exported in the layout, codes, units and rounding of that
   return, sourced in `docs/legal.md`: the BTW return as one file per
   quarter (`btw_Q1` to `btw_Q4`, written even when a quarter is empty) with
   every rubriek in whole euros, the ICP-opgaaf per quarter, and the income
   tax estimate per year. A change to a return's rubrieken changes the export
   and its test in the same commit.
8. **Every estimate says it is one.** A figure Florin calculates rather than
   reads from the records (tax, net profit after tax, tax savings, private
   use of a car, BTW on private use) carries "estimated" in its label or
   section title, and its help text says so.

## Layout

```
lib/
  app.dart, main.dart    Router, theme, startup
  constants/             Device preference keys (path, year, language)
  db/                    Drift: enums, tables, DAOs, database
  l10n/                  ARB files, generated localizations, enum labels
  providers/             Riverpod providers, including the tax and BTW estimates
  screens/<feature>/     One folder per feature: list screen and detail page;
                         receipts/ holds the receipts section the expense,
                         asset and invoice pages share
  services/              Business logic: tax, assets, cars, BTW, KOR, pension,
                         PDF, CSV, receipts, domain, and the format checks
                         and parsers
    tax_rules/           TaxYearRules, one sourced file per tax year, and the
                         car reductions by registration year
  theme/                 Colours, spacing scale, formatting
  widgets/               The shared component library
assets/fonts/            The invoice PDF font and its licence
tool/                    create_demo_database.dart, run by `make demo`
docs/
  images/                README images: the logo
  screenshots/           README screenshots of the dashboard, one per language
  legal.md               Non-yearly rules with sources
  tax-years/README.md    Every field of TaxYearRules: meaning, law, where
                         to find the value for a new year
  tax-years/<year>.md    Yearly figures with sources, ending in a table of
                         every field
drift_schemas/           Exported schema snapshot per schema version
test/                    Service, DAO, schema and theme contrast tests
.claude/skills/          legal-review, new-tax-year, ui-review
```

Layers depend downwards only: screens use widgets, providers and services;
services use the database; widgets never use providers except through
arguments.

## Database and migrations

Drift with SQLite. Every schema change is a versioned migration:

1. Change the tables in `lib/db/tables/`.
2. Bump `schemaVersion` in `lib/db/database.dart`.
3. Run `make migration`. It exports `drift_schemas/florin/drift_schema_v<n>.json`,
   generates the step-by-step migration helpers next to the database and the
   migration tests under `test/drift/`.
4. Write the step in `onUpgrade` with `stepByStep`, running each step in a
   transaction with foreign keys off, then check `PRAGMA foreign_key_check`.
5. Fill in the generated data-integrity test and run `make local`.

`test/drift/florin/schema_test.dart` fails when the tables and the latest
snapshot differ, so a forgotten step is caught. Never edit an exported
snapshot or a released migration step.

Data rules:

- **Enums are stored by name** through `textEnum<T>()` from
  `lib/db/enums.dart`. Renaming or removing a value is a schema migration.
  Raw keys are never shown; labels come from `lib/l10n/labels.dart`.
- **Money is integer cents.** Rates are fractions. Format with `AppFormat`.
- **Required form fields map to `NOT NULL` columns, optional ones to nullable
  columns.** Save `Value(text.trim())` for required text and `null` for empty
  optional text.
- **Do not store what a row already implies.** Year, quarter, due date and
  distance are computed from the row (`lib/services/domain.dart`); queries
  filter by date range. Calculated amounts that depend on rates, such as
  invoice totals and BTW, are computed once on save and stored.
- **Foreign keys are on.** Invoice lines cascade with their invoice; a client
  or invoice that is referenced cannot be deleted.
- **Bookkeeping data lives in the database**, including the business profile
  and BTW filing status. Shared preferences hold only the database path, the
  selected year and the language.
- **Receipt files live next to the database**, in
  `receipts/<year>/<uuid>.<extension>`, with a row in `receipts` for each.
  Go through `ReceiptService`, which keeps the two in step: a file is copied
  byte for byte and only kept with its row, and follows its record to
  another year folder. **Florin never deletes a receipt**, its row or its
  file: removing one, or deleting its record, marks the row removed with
  what it belonged to and moves the file to `receipts/removed/`. Nothing
  empties that folder. Anything that moves or exports the database takes the
  receipts folder with it, removed receipts included.
- Each DAO mixes in `Crud` for `save` (insert or update by primary key) and
  `remove`. Add a query method to the DAO, not SQL in a screen.

## Design system and reuse

**Search before you write.** Before adding a widget, helper, service or
constant, look in `lib/widgets/`, `lib/services/` and `lib/theme/`. If it
exists, use it; if it almost fits, extend it with a parameter. Logic used in
two places is extracted at the second use; logic used once stays private to
its file.

**No second copy.** A rule, formula, mapping, pattern or parser exists once.
Before you call a change done, search for what you wrote (a regex, a
`tryParse`, a `switch` over an enum, a formula) and remove any copy you
find, older ones included. These are shared:

| Need | Use |
| --- | --- |
| Format checks: BTW numbers, KvK, IBAN, email, phone, country | `isValid*` in `lib/services/formats.dart` |
| Parsing typed numbers and optional text | `parseWholeNumber`, `parseDecimal`, `optionalText`, `normalizeId` in `formats.dart`; `AppFormat.parseCents` for money |
| Credit notes in totals | `Invoice.sign`, `signedExclVat`, `signedInclVat` in `lib/services/domain.dart` |
| An expense's cost and BTW back | `ExpenseMath` in `domain.dart` |
| Dutch text for the PDF and CSV | `VatRate.dutchLabel(rules)` and the other helpers in `domain.dart`; enum labels in the CSV mapping |
| A statutory figure, a BTW amount, a term or a deadline | The year's `TaxYearRules` (`taxRulesProvider`, `taxRulesFor`): `vatOn`, `keepUntil`, `latestInvoiceDate`, `minUsefulLifeYears` and its fields |
| A rate or amount in a text | `AppFormat.percentLabel` and `AppFormat.euros`, passed into a placeholder |
| Whether a treatment fits a country | `VatTreatment.fitsCountry`, `euCountries` |
| KOR status, turnover and its effect on expenses | `KorService`, `KorStatus`, `korStatusProvider`, `effectiveExpensesProvider` |
| Combining several provider streams | `waitForAll` in `lib/providers/providers.dart` |
| Showing money, dates and rates | `AppFormat.cents`, `euros`, `date`, `number`, `percent`, `percentLabel`, `hours`, `fileSize` in `lib/theme/app_format.dart`, plain Dart so services and tools can use it |
| Storing, checking, removing and exporting receipt files | `ReceiptService`, `ReceiptStore`, `receiptsProvider`; `CsvExportService.receiptExportPath` for names in an export |

The component library in `lib/widgets/`:

| Need | Use |
| --- | --- |
| Field label with required marker and help | `fieldDecoration`, `LabelWithHelp` |
| The text inside a field, for dropdowns | `fieldTextStyle` |
| A value Florin works out, shown as a field | `ReadOnlyField` |
| Help icon for a term | `HelpIcon` |
| Text that may be cut off | `EllipsisText` |
| Checkbox | `HelpCheckbox` |
| Business car choice | `carPicker` |
| List screen with add button, controls and list | `ListScaffold` |
| Detail or form page with back, delete and save | `DetailScaffold` |
| Loading, error and data states | `AsyncBody` |
| Fields side by side | `FormRow` |
| Date input | `DateField` |
| Enum dropdown | `EnumDropdown` |
| Money input, with `positive` for amounts above zero | `AmountField` |
| Inline validators | `Validate` in `validators.dart` |
| An error that belongs to the form, not one field | `FormErrorText` |
| A figure against a target | `TargetProgress`, `UrencriteriumProgress`, `KorProgress` |
| Business use percentage | `BusinessUseSlider` |
| Label and value, amounts in cents | `ValueRow`, `ValueRow.cents`, `SectionLabel` |
| Warning or legal note | `NoticeBanner` |
| Status pill | `ToneBadge`, `InvoiceStatusBadge`, `DeadlineBadge` |
| Headline figures above a list | `SummaryBar` |
| Chips and search | `ChoiceChips`, `QuarterChips`, `SearchField` |
| Primary and delete actions | `PrimaryButton`, `DeleteIconButton` |
| Save or delete with error reporting | `guardSave` |
| An error in words the user can act on | `describeError`, `showSaveError` |
| Confirmation, with the button named after the action | `showConfirmationDialog` |
| Business profile fields | `BusinessProfileForm` |
| Receipts of an expense, asset or invoice | `ReceiptsSection` with a `ReceiptDraft` for unsaved records, `ReceiptTile` for one file, `RemovedReceiptsPage` (`lib/screens/receipts/`) |
| Hours against the urencriterium | `UrencriteriumProgress` |
| Dashboard figure | `StatCard` |

Shared business logic belongs in `lib/services/`; anything that combines
several data streams for a screen is a provider in `lib/providers/`, like
`taxEstimateProvider`.

## Design

Florin follows Apple's Human Interface Guidelines on every platform: the
platform's own font, white or near-black content beside a quiet sidebar,
thin separators instead of shadows, and one accent colour for interactive
elements and primary actions.

- **Colours come from the theme only:** `Theme.of(context).colorScheme` and
  `context.colors` (`AppColors` in `lib/theme/app_theme.dart`). Semantic
  colours are Apple's system colours in their increased-contrast form; the
  accent is the logo teal. No raw colours in widgets, no `Colors.grey`.
- **Never choose a colour by eye.** Every text colour, the accent and field
  borders are measured in `test/theme/contrast_test.dart` against the
  surfaces they appear on, in light, dark and both increased-contrast
  themes: 4.5:1 for text, 3:1 for borders. A new colour or surface gets a
  test there first.
- **Colour never carries meaning alone.** A status also has a word or icon.
- **Nothing is downloaded at runtime.** No web fonts; the PDF font is
  bundled in `assets/fonts/` with its licence registered in `main.dart`.
- **Motion is short and interruptible**, and respects the platform's reduce
  motion setting.

The [apple-design skill](https://github.com/emilkowalski/skills/blob/main/skills/apple-design/SKILL.md)
holds the principles behind these rules. For a desktop bookkeeping app these
apply most:

- **The common path first, the rest one level deeper.** Show an option where
  it is relevant, not on every form: self-billing appears for a merchant of
  record, the KOR end date only matters once a start date exists. An option
  that is hidden may not stay set.
- **Group a control with what it affects.** A field's error sits under that
  field; a rule across fields sits under the part it limits. Related fields
  share a section with a heading that names them.
- **Four kinds of feedback**: status (badges, progress), completion (the saved
  screen closes or shows the result), warning (`NoticeBanner` before a
  problem) and error (inline, never only on submit).
- **Confirm only what cannot be undone**, such as issuing an invoice or
  deleting a record. Everything else saves or reverts without a dialog. The
  confirm button names the action ("Delete", "Send"), never "Confirm".
- **Show what cannot change.** A record that is locked, such as an issued
  invoice, says so in a `NoticeBanner` at the top, names the way to correct
  it, and hides its edit controls.
- **Specific labels over safe ones.** Name an action after its result ("I do
  not take part in the KOR", "Record"), and a section after its contents.
- **Wayfinding.** Every page has a title saying where the user is and a back
  action; nothing traps the user in a state they cannot leave.
- **Numbers keep one shape.** Amounts, hours and rates use `AppFormat`, stay
  on one line and shrink rather than wrap.
- **A professional tool, not a gallery.** Files show as an icon for their
  kind with name, type, size and date; Open shows them in the system viewer.
  No thumbnails or image previews.

## UI rules

- **Help on everything a user fills in or must understand.** Every input,
  dropdown and checkbox has a help tooltip, and so does every tax or legal
  term shown as a label, row or section title. Use `fieldDecoration`,
  `AmountField`, `DateField`, `EnumDropdown` and `HelpCheckbox` (their `help`
  is required), `ValueRow(help:)` and `SectionLabel(help:)`. The help text is
  its own ARB key named after the label with `Help` added, explains what to
  enter or what the term means and why, and states no rule without a source.
  In fields the icon sits at the end of the field (`fieldSuffix`), never in
  the label: a floating label receives no pointer events.
  `test/widgets/help_tooltip_test.dart` checks that tooltips open.
- **Nothing is cut off silently.** Never use `TextOverflow.ellipsis`
  directly: use `EllipsisText`, which shows the full text in a tooltip when
  it does not fit. Error and helper texts wrap (`errorMaxLines` in the
  theme) and are never shortened.
- **Spacing and text styles from the theme.** Spacing from `AppSpacing`; no
  off-scale numbers.
- **Spacing** (`AppSpacing`): `tileRow` between rows in a tile, `tight` for an
  inline nudge, `heading` after a section heading, `field` between fields
  (both directions), `group` between sub-groups and cards, `section` between
  sections, `dashboardSection` on the dashboard, `settingsSection` in
  Settings. Every screen, Settings included, uses `screenPadding`.
- **One left edge.** The page title, a list's controls, its rows and a
  page's content all start `AppSpacing.section` from the sidebar. The theme
  sets this for app bars and list rows; `ListScaffold` and `DetailScaffold`
  set it for the rest. Do not pad controls or rows in a screen.
- **List screens** use `ListScaffold`: controls, `Divider(height: 1)`, then
  the list.
- **List rows are plain `ListTile`s.** The theme gives every row the same
  name, details and figure styles, with tabular digits so amounts line up.
  Do not set a weight, size or colour on a row's title, subtitle or trailing
  figure in a screen. A status is a `ToneBadge` with a word, never only a
  colour or a strikethrough; a figure that is not obvious gets a tooltip.
- **Headings inside a page or form are `SectionLabel`s.** Only the
  dashboard's sections and the top-level sections of Settings and the first
  launch screen use title styles.
- **Fields share one size.** Dropdowns set `style: fieldTextStyle(context)`;
  a value Florin computes is a `ReadOnlyField`, never a bare
  `InputDecorator`.
- **Forms fill the available width.** No fixed-width wrappers unless the
  layout needs one.
- **Checkboxes**: `CheckboxListTile` with
  `controlAffinity: ListTileControlAffinity.leading` and
  `contentPadding: EdgeInsets.zero`, on their own rows. `field` before the
  first and after the last; none between consecutive checkboxes.
- **Dropdowns** in a flexible parent set `isExpanded: true` (`EnumDropdown`
  does).
- **Address fields** use `minLines: 3, maxLines: 4`.
- **`maxLength` fields** set `counterText: ''`.
- **Delete** uses `DeleteIconButton`; **primary save** uses `PrimaryButton`
  (the accent fill, as Apple does for prominent buttons); **external links**
  use `OutlinedButton.icon` with `Icons.open_in_new`.
- When you remove an element, re-check the spacing of what remains.

## Forms and validation

- Required labels end with ` *`, added in code, never inside the ARB text.
  Optional fields carry no marker and no "(optional)".
- Validation is inline: `Form` with `validator`, or a field error wired to
  `InputDecoration.errorText`. Snackbars are only for failed saves.
- Every validation message says what to enter and why, with its own ARB key.
- Optional fields with a format accept empty input before checking format.
- Audit the matching column before adding a validator.
- **Every input is validated.** Each text, number, amount, date and choice
  that is saved has a validator that matches its column and the rule behind
  it: required text is not blank, numbers parse and stay in range, amounts
  that cannot be zero use `AmountField(positive: true)`, dates fall in the
  range the record allows. Optional free text, such as notes and payment
  references, accepts anything and needs none.
- **Validators come from the shared code.** Use `Validate` and the checks in
  `formats.dart`; never write a regex, `tryParse` or blank check in a screen.
  A new format goes into `formats.dart` with a test in
  `test/services/formats_test.dart`.
- **Rules across fields are validated too**: an end after its start, a credit
  note within what is left of its invoice, hours per day at most 24, a
  treatment that fits the client's country. Put the check on the field the
  user changes to fix it, or in a `FormErrorText` when no single field owns
  it.
- Fields that save as you type (Pension, P&L inputs) show their error at
  once and save only valid values; `AmountField` does both.

## Error handling

- Every save, delete, file action and database read started by the user runs
  inside `guardSave`, or catches its error and shows it. Nothing awaits the
  database outside one of them.
- Messages come from `describeError`, which turns database constraint and file
  errors into what to do. Add a case there for a new kind of failure; never
  show a raw exception or stack trace.
- Loads show their error where the data would be: `AsyncBody` for provider
  data, a `NoticeBanner` for a page that loads by hand. A spinner never runs
  forever.
- Never swallow an error (`catch (_) {}`, `.then` without `onError`). When an
  error must not stop the screen, take the cautious fallback, such as keeping
  delete blocked, and say why in a comment.
- Errors no screen caught reach `showUnhandledError` through `main.dart`; do
  not rely on that for expected failures.
- A button whose action needs data that is still loading is disabled until
  the data is there.

## Language and copy

- English and Dutch. Every user-facing string goes through `AppLocalizations`
  with the key in both `app_en.arb` and `app_nl.arb`. `app_en.arb` is the
  template and the only place `@` metadata lives. Run `make gen` after
  changing ARB files. Delete keys nothing uses.
- No em dash (`—`) anywhere a user can read it. Use a colon, comma or period.
- No period on short labels, headings and buttons; a period on full
  sentences.
- Spaces around a slash between words (`Make / model`), not in paths, units
  or tokens (`€/km`).
- Dutch tax terms stay Dutch in both languages when the Belastingdienst uses
  them as names: zelfstandigenaftrek, urencriterium, jaarruimte.

## Documentation and comments

- Code, docs and READMEs describe the system as it is. No history, no
  "previously", no ticket numbers, no plans or timing words ("yet", "until",
  "next").
- A comment says why in one or two lines, or cites the article it implements.
  Delete comments that restate the code.

## Keep these in step

Nothing fails when these drift, so check them whenever you touch the left
side.

| When you change | Also update |
| --- | --- |
| Anything in `README.md` | `README.nl.md` with the same content, and the reverse |
| A feature, supported platform, OS minimum or install step | Both READMEs and the release notes body in `.github/workflows/build.yml` |
| A legal rule or legal copy | `docs/legal.md`, and run the `legal-review` skill |
| A tax year | Only through the `new-tax-year` skill: rules file, `taxYears`, `docs/tax-years/<year>.md` with its table of every field, tests, both READMEs |
| A field of `TaxYearRules` | Its value in every year's rules file, `docs/tax-years/README.md`, every `docs/tax-years/<year>.md`, and the texts that name it |
| A table | `schemaVersion`, `make migration`, the migration step and its test, and `tool/create_demo_database.dart` so `make demo` still runs |
| An enum in `lib/db/enums.dart` | `lib/l10n/labels.dart`, the Dutch mapping in `csv_export_service.dart`, and a migration if a stored value changed |
| A shared widget's behaviour | Every screen that uses it, and the table above |
| An input field | Its validator and message keys in both ARB files, per Forms and validation |
| A rule, formula or mapping | The shared place in the No second copy table, and every copy removed |
| A colour or surface | `test/theme/contrast_test.dart` |
| A bundled font or asset | Its licence in `assets/` and the `LicenseRegistry` entry in `main.dart` |
| A directory or owning file | The Layout section above |
| The Flutter version in `pubspec.yaml` | The macOS minimum in both READMEs and `Casks/florin.rb` if Flutter raised it |

## Versioning and releases

- `version` in `pubspec.yaml` is `MAJOR.MINOR.PATCH` with no build number.
  Semantic versioning: patch for fixes, minor for features or changed
  behaviour, major for breaking changes such as a data format users must act
  on.
- Pushing a new version to `master` makes CI tag the commit `v<version>`,
  publish the release and update `Casks/florin.rb`. Never create tags or
  releases by hand.
- Any change that ships to users bumps the version in the same commit.

## Before you call anything done

```sh
make local    # generated code, formatting, analysis and tests: what CI runs
```

Fix every issue and rerun until it passes. For a change on screen, run the
app (`make run`) with the demo data (`make demo`, then choose the `demo`
folder on first start) and look at it in both languages and in light and
dark mode. Never finish on failing
analysis, unformatted code or generated files that drifted.

## Git

- The main branch is `master`.
- Commit messages explain why, in prose. Commit or push only when asked.

## Talking to the maintainer

Start with the answer in one or two plain sentences. Explain what changes
for the user: which screen, which figure, what Florin does now. Say what was
verified and how, in one line. Never present a guess as a finding.
