# Run formatter and linter together (use before committing)
local: gen-l10n format lint

# Generate localization files (e.g., .arb) from the source code
gen-l10n:
	flutter gen-l10n

# Auto-format all Dart source files in lib/
format:
	dart format lib/

# Check for analysis issues and verify formatting is clean (used in CI)
lint:
	flutter analyze
	dart format --set-exit-if-changed lib/

# Run the app on macOS
run:
	flutter run -d macos
