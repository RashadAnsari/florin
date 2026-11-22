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

- `legal-review` (`.claude/skills/legal-review/`): run it before merging any
  change to invoices, BTW, income tax, depreciation, pension, Wet DBA or legal
  copy.
- `new-tax-year` (`.claude/skills/new-tax-year/`): the only way a tax year is
  added.

## Non-negotiables

1. **Only years with verified rules exist in the app.** The year selector
   lists `supportedYears` and `DateField` only accepts dates in them, so no
   record lands in a year the user cannot see. Never copy figures from
   another year to make a year available. Asset purchase dates and client
   contract dates are the exceptions and pass their own range.
2. **Issued invoices are immutable.** Only drafts are edited or deleted. A
   correction is a credit note that references the invoice it corrects.
3. **Invoice PDFs and CSV exports stay in Dutch**, whatever the app language.
4. **Florin estimates; it does not advise.** Copy states what the law says
   and what Florin computed. It never promises compliance or a result.
5. **Unknown resolves to the cautious answer.** When the law cannot be read
   from the data, take the branch that overstates tax rather than understates
   it, and tell the user.
6. **Statutory figures are code, not settings.** Users cannot edit rates or
   thresholds; they live in `lib/services/tax_rules/`.
7. **Every estimate says it is one.** A figure Florin calculates rather than
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
  screens/<feature>/     One folder per feature: list screen and detail page
  services/              Business logic: tax, assets, cars, BTW, pension, PDF,
                         CSV, domain
    tax_rules/           TaxYearRules, one sourced file per tax year, and the
                         car reductions by registration year
  theme/                 Colours, spacing scale, formatting
  widgets/               The shared component library
assets/fonts/            The invoice PDF font and its licence
tool/                    create_demo_database.dart, run by `make demo`
docs/
  images/                README images: the logo
  legal.md               Non-yearly rules with sources
  tax-years/<year>.md    Yearly figures with sources
drift_schemas/           Exported schema snapshot per schema version
test/                    Service, DAO, schema and theme contrast tests
.claude/skills/          legal-review, new-tax-year
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
- Each DAO mixes in `Crud` for `save` (insert or update by primary key) and
  `remove`. Add a query method to the DAO, not SQL in a screen.

## Design system and reuse

**Search before you write.** Before adding a widget, helper, service or
constant, look in `lib/widgets/`, `lib/services/` and `lib/theme/`. If it
exists, use it; if it almost fits, extend it with a parameter. Logic used in
two places is extracted at the second use; logic used once stays private to
its file.

The component library in `lib/widgets/`:

| Need | Use |
| --- | --- |
| Field label with required marker and help | `fieldDecoration`, `LabelWithHelp` |
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
| Money input | `AmountField` |
| Business use percentage | `BusinessUseSlider` |
| Label and value, amounts in cents | `ValueRow`, `ValueRow.cents`, `SectionLabel` |
| Warning or legal note | `NoticeBanner` |
| Status pill | `ToneBadge`, `InvoiceStatusBadge`, `DeadlineBadge` |
| Headline figures above a list | `SummaryBar` |
| Chips and search | `ChoiceChips`, `QuarterChips`, `SearchField` |
| Primary and delete actions | `PrimaryButton`, `DeleteIconButton` |
| Save or delete with error reporting | `guardSave` |
| Confirmation | `showConfirmationDialog` |
| Business profile fields | `BusinessProfileForm` |
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
  Settings. Screen padding is `screenPadding`, Settings uses
  `settingsPadding`.
- **List screens** use `ListScaffold`: controls, `Divider(height: 1)`, then
  the list.
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
| A tax year | Only through the `new-tax-year` skill: rules file, `taxYears`, `docs/tax-years/`, tests, both READMEs |
| A table | `schemaVersion`, `make migration`, the migration step and its test, and `tool/create_demo_database.dart` so `make demo` still runs |
| An enum in `lib/db/enums.dart` | `lib/l10n/labels.dart`, the Dutch mapping in `csv_export_service.dart`, and a migration if a stored value changed |
| A shared widget's behaviour | Every screen that uses it, and the table above |
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
