.PHONY: local gen migration format lint test run demo


# Everything CI checks: generated code, formatting, analysis and tests
local: gen format lint test

# Regenerate localizations and Drift code
gen:
	flutter gen-l10n
	dart run build_runner build

# Export the schema snapshot and step-by-step migration code after a schema change
migration:
	dart run drift_dev make-migrations

format:
	dart format lib test tool

lint:
	flutter analyze
	dart format --set-exit-if-changed lib test tool

test:
	flutter test

run:
	flutter run -d macos

# Create demo/florin.db with a fictional business to try the app
demo:
	dart run tool/create_demo_database.dart demo
