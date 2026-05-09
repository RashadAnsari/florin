import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'app.dart';
import 'providers/providers.dart';
import 'services/db_location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('nl_NL');

  await windowManager.ensureInitialized();
  await windowManager.waitUntilReadyToShow(
    const WindowOptions(
      minimumSize: Size(1100, 700),
      size: Size(1280, 800),
      center: true,
      title: 'Florin',
      titleBarStyle: TitleBarStyle.normal,
    ),
    () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );

  final prefs = await SharedPreferences.getInstance();

  // Ensure a valid DB path exists before the app renders.
  // Defaults to getApplicationSupportDirectory() which is always accessible
  // inside the macOS sandbox, no file-picker permission required.
  await DbLocationService(prefs).ensurePath();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const FlorinApp(),
    ),
  );
}
