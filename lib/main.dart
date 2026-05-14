import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'app.dart';
import 'providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = FlutterError.presentError;
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Unhandled error: $error\n$stack');
    return true;
  };

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

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const FlorinApp(),
    ),
  );
}
