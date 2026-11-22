import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:florin/app.dart';
import 'package:florin/db/database.dart';
import 'package:florin/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tool/create_demo_database.dart';

/// Every route, opened with the demo business, must lay out without errors.
const _routes = [
  '/dashboard',
  '/invoices',
  '/invoices/1',
  '/invoices/new',
  '/invoices/new?creditFor=1',
  '/clients',
  '/clients/new',
  '/expenses',
  '/expenses/new',
  '/vat',
  '/tax',
  '/hours',
  '/hours/new',
  '/mileage',
  '/mileage/new',
  '/assets',
  '/assets/new',
  '/pension',
  '/settings',
];

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  for (final locale in ['en', 'nl']) {
    for (final brightness in Brightness.values) {
      testWidgets('all screens in $locale, ${brightness.name}', (tester) async {
        tester.view.physicalSize = const Size(1280, 800);
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.platformBrightnessTestValue = brightness;
        addTearDown(tester.view.reset);
        addTearDown(tester.platformDispatcher.clearAllTestValues);

        // The router only needs a database file to exist at the saved path.
        final dir = Directory.systemTemp.createTempSync('florin_smoke');
        addTearDown(() => dir.deleteSync(recursive: true));
        final marker = File('${dir.path}/florin.db')..createSync();
        SharedPreferences.setMockInitialValues({
          'db_path': marker.path,
          'app_locale': locale,
          'fiscal_year': 2026,
        });
        final prefs = await SharedPreferences.getInstance();

        final db = AppDatabase(NativeDatabase.memory());
        await tester.runAsync(() => fillDemo(db));

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(prefs),
              databaseProvider.overrideWithValue(db),
            ],
            child: const FlorinApp(),
          ),
        );
        await _settle(tester);

        for (final route in _routes) {
          GoRouter.of(tester.element(find.byType(Navigator).first)).go(route);
          await _settle(tester);
          expect(tester.takeException(), isNull, reason: route);
        }

        // Unmount so the stream queries are cancelled before the test ends.
        await tester.pumpWidget(const SizedBox());
        await tester.pump(const Duration(seconds: 1));
      });
    }
  }
}

/// Lets database streams deliver and transitions finish, without waiting for
/// endless animations such as progress indicators.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 5; i++) {
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump(const Duration(milliseconds: 100));
  }
}
