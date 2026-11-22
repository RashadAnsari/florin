import 'package:flutter/widgets.dart';

/// The spacing scale. Use these instead of raw numbers.
abstract final class AppSpacing {
  /// Between text rows inside a list tile.
  static const tileRow = 2.0;

  /// Tight inline nudge: icon, badge, dense layout.
  static const tight = 4.0;

  /// Between a section heading and its first field.
  static const heading = 8.0;

  /// Between form fields, vertically and horizontally.
  static const field = 12.0;

  /// Between sub-groups within a section; between peer cards.
  static const group = 16.0;

  /// Between major sections on scrollable screens.
  static const section = 24.0;

  /// Between major sections on the dashboard.
  static const dashboardSection = 32.0;

  /// Between top-level sections in Settings.
  static const settingsSection = 40.0;

  static const screenPadding = EdgeInsets.all(section);
  static const settingsPadding = EdgeInsets.all(dashboardSection);
}
