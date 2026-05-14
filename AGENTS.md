# Florin - Agent Instructions

These rules are the source of truth for working in this repository. Always read and follow this file before making code changes or refactors.

## General rules

- **Reuse before creating**: before adding a component, helper, constant, service, or utility, search the codebase first. If an equivalent already exists, import and reuse it.
- **No duplicate components**: extend existing components with props or small local composition before creating variants.
- **No duplicate code**: shared business logic belongs in `lib/services/`. Shared UI belongs in `lib/widgets/`. Shared constants belong in the relevant service or domain file.
- **Abstractions**: only add a helper, service, widget, or shared constant when logic is reused across files or clearly belongs to an existing shared module. If logic is local to one screen or form, keep it as a private local helper.
- **Scope control**: make the requested change at the layer where it belongs. Do not update downstream readers, exports, reports, or unrelated screens unless the request requires it.
- **Translations**: all user-facing strings must go through `AppLocalizations`. Never hardcode visible text. Add or update keys in both `app_en.arb` and `app_nl.arb`.
- **Dutch statutory outputs**: invoice PDFs and CSV exports must always stay in Dutch. Do not localize invoice PDF copy, CSV headers, or export file content unless the user explicitly changes this product requirement.
- **Punctuation**: no period on short labels, headings, button text, or single-phrase descriptions. Use a period on full sentences, especially multi-clause text such as FAQs, warnings, and longer descriptions.
- **Slash spacing**: in user-facing labels and copy, put spaces around slashes between words, such as `Make / model`. Do not apply this to paths, URLs, units, or technical tokens such as `€/km`.
- **Em dash**: never use the em dash character (`—`) in user-facing text, copy, labels, or metadata. Use a colon, comma, or period instead.
- **Theme**: always use the project theme defined in `lib/theme/`. Never invent colors, typography, spacing, or design tokens. Never create a parallel design system.

## Formatting and verification rules

- **Required check**: after every code, localization, configuration, or documentation change, run `make local`.
- **Fix before finishing**: if `make local` reports formatting, analysis, or generated-code issues, fix them and rerun `make local` until it passes.
- **Generated localization**: after changing ARB files, regenerate localization output before running `make local`.

## UI rules

- **List screen structure**: list screens use a stable structure: controls/search area, `Divider(height: 1)`, then `Expanded(ListView)`. Do not put `ListView` directly as the page body when the screen has controls above it.
- **Tile spacing**: use `SizedBox(height: 2)` between text rows inside list tiles.
- **Field spacing**: keep standard vertical spacing between adjacent form fields. When removing fields, checkboxes, buttons, banners, or other UI elements, re-check the surrounding layout and restore the spacing between the remaining elements.
- **Detail/form width**: detail panels and forms must fill all available width. Do not wrap form content in `ConstrainedBox`, `SizedBox(width:)`, or fixed-width containers unless there is a domain-specific layout requirement.
- **Checkboxes**: use `controlAffinity: ListTileControlAffinity.leading` on `CheckboxListTile`. Put checkboxes on their own rows, not in a `Row` with form fields.
- **Dropdowns in flexible layouts**: add `isExpanded: true` to `DropdownButtonFormField` when it is inside `Expanded`, `Flexible`, or any flexible parent.
- **maxLength fields**: add `counterText: ''` to `InputDecoration` when using `maxLength`.
- **Destructive actions**: delete `IconButton` widgets must use `color: theme.colorScheme.error`.
- **External links**: buttons that open URLs must use `OutlinedButton.icon` with `Icons.open_in_new`.
- **Primary actions**: primary save/submit actions must use `FilledButton.icon` with `backgroundColor: theme.colorScheme.primaryContainer` and `foregroundColor: theme.colorScheme.onPrimaryContainer`.
- **Muted colors**: do not use `Colors.grey`. Use `theme.colorScheme.outline` for muted text and borders.

## Form and validation rules

- **Required labels**: every required form field label must end with ` *`.
- **Optional labels**: never add `(optional)` or similar wording to field labels. A field without the required ` *` marker is already optional.
- **Inline errors**: show validation errors inline with the field. Do not use toasts for validation errors or success states.
- **Required validation**: use `Form` plus `GlobalKey<FormState>` plus `validator` for required fields.
- **Button-triggered validation**: for checks triggered by a button, use a field-specific `String? _fieldError`, wire it to `InputDecoration.errorText`, and clear it in `onChanged`.
- **Field-specific messages**: validation messages must explain exactly what to enter and why. Do not use generic messages such as "Required". Add a dedicated ARB key per validation message in both languages.
- **Optional format validators**: when an optional field has a format constraint, allow empty values before checking the format.

## Data and persistence rules

- **DB/form alignment**: form fields and DB columns must stay in sync for nullability, type, default values, and constraints.
- **Required fields in DB**: required form fields must map to `NOT NULL` columns.
- **Optional fields in DB**: optional form fields must map to nullable columns.
- **Nullability changes**: when adding a required field or changing nullability, bump `schemaVersion` and add a `MigrationStrategy` with `TableMigration` plus an appropriate `columnTransformer`, such as `CustomExpression("COALESCE(col, '')")`, for existing nulls.
- **Companion values**: in `_save()`, pass `Value(text.trim())` for `NOT NULL` text columns and `Value(n(text))` for nullable text columns.
- **Validator audits**: before adding any validator, audit the matching DB column.
- **Derived persisted fields**: when a stored field is derived from form input, calculate it once during insert/update and persist it. Other readers should use the stored DB value unless the requested change explicitly moves that derivation elsewhere.
- **Enum/dropdown storage**: store stable English keys in the DB, such as `Low`, `Medium`, and `High`. Never display raw DB values to the user. Map stored keys to localized labels through a helper or switch.
