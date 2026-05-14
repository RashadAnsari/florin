# Florin - Agent Instructions

These rules are the source of truth for working in this repository. Always read and follow this file before making code changes or refactors.

## General rules

- No duplicate components: reuse existing ones with props rather than creating variants.
- **No duplicate code**: before writing a constant, function, or utility, search the codebase first. If it already exists, import it, never redefine it. Shared logic belongs in `lib/services/`. Shared UI belongs in `lib/widgets/`. Shared constants live in the relevant service file.
- **Punctuation**: no period on short labels, headings, button text, and single-phrase descriptions. Use a period on full sentences, especially multi-clause ones (FAQs, warnings, longer descriptions).
- **Em dash**: never use the em dash character (—) in any user-facing text, copy, labels, or metadata. Use a colon, comma, or period instead.
- **Translations**: all user-facing strings must go through `AppLocalizations` — never hardcode text visible to the user. Add keys to both `app_en.arb` and `app_nl.arb`.
- **Required fields**: every required form field label must end with ` *` (e.g., `Name *`). No exceptions across all forms.
- **Theme**: always use the project theme defined in `lib/theme/`. Never invent colors, typography, spacing, or any design tokens. Never create a parallel design system. All UI decisions must reference `lib/theme/` exclusively.

## UI design rules

- **List screen structure**: `Column` with search bar + `Divider(height: 1)` + `Expanded(ListView)` — never put `ListView` directly as `body`. Match the invoices/expenses pattern.
- **Tile spacing**: use `SizedBox(height: 2)` between rows inside list tiles — consistent across all screens.
- **Checkboxes**: always use `controlAffinity: ListTileControlAffinity.leading` on `CheckboxListTile` — checkbox on left, label on right. Right-side checkbox looks like an unrelated section header.
- **maxLength fields**: always add `counterText: ''` to `InputDecoration` — hides the character counter that breaks vertical alignment with adjacent fields.
- **Destructive buttons**: delete `IconButton` must use `color: theme.colorScheme.error` — never a silent grey destructive action.
- **External link buttons**: use `OutlinedButton.icon` with `Icons.open_in_new` when a button opens a URL.
- **Primary action buttons**: use `FilledButton.icon` with `backgroundColor: theme.colorScheme.primaryContainer` and `foregroundColor: theme.colorScheme.onPrimaryContainer` — visible in both light and dark mode.
- **Detail/form pages fill the screen**: detail panels and forms must always fill all available width. Never wrap form content in `ConstrainedBox`, `SizedBox(width:)`, or any fixed-width container — let the `Column` expand to fill the `Expanded`/`SingleChildScrollView` naturally.
- **Form validation errors**: always show inline field errors, never toasts. Use `Form` + `GlobalKey<FormState>` + `validator` on each required field. For button-triggered checks (e.g., VIES), use a `String? _fieldError` state variable and wire it to `InputDecoration.errorText`, clearing it `onChanged`. No success toasts either — just navigate away or refresh silently.
- **Validation messages must be field-specific**: never use a generic "Required" message. Each field's `validator` must return a sentence that explains exactly what to enter and why (e.g. "Enter the client's name", "Enter a unique invoice number, e.g. F-2024-001", "Describe the business purpose of this trip"). Add a dedicated ARB key per field (e.g. `clientsValidateName`, `mileageValidatePurpose`) in both `app_en.arb` and `app_nl.arb`.
- **Optional field validators**: when a field is optional but has a format constraint, guard with `if (s.isEmpty) return null;` before the regex check — never reject an empty optional field.
- **Never mix `CheckboxListTile` and form fields in the same `Row`**: `CheckboxListTile` has a different minimum height model than `DropdownButtonFormField`/`InputDecorator`. They can never align in the same row. Put checkboxes on their own rows below.
- **`DropdownButtonFormField` in flexible parents**: always add `isExpanded: true` — prevents RenderFlex overflow when the dropdown sits inside `Expanded` or any flexible parent.
- **`Colors.grey` is banned**: use `theme.colorScheme.outline` for muted/secondary text and borders — `Colors.grey` ignores the theme and breaks dark mode.
- **DB/form field alignment**: form fields and DB columns must always be in sync — not just nullability but also data type, default values, and constraints. Required form field = NOT NULL column. Optional field = nullable column. If a field has a format constraint (regex), the DB type must be able to store any valid value. When adding a required field or changing nullability, bump `schemaVersion` and add a `MigrationStrategy` with `TableMigration` + `columnTransformer: { col: CustomExpression("COALESCE(col, '')") }` to handle existing nulls. In `_save()`, pass `Value(text.trim())` for NOT NULL columns, `Value(n(text))` for nullable ones. Before adding any validator, audit the matching DB column first.
- **Enum/dropdown DB values**: store English keys in the DB (e.g. `'Low'`, `'Medium'`, `'High'`). Never display raw DB values to the user — always map to localized labels via a helper or switch. This keeps DB queries simple while UI stays translated.
