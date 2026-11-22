import 'package:florin/theme/app_theme.dart';
import 'package:florin/widgets/help.dart';
import 'package:florin/widgets/value_row.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('a field\'s help tooltip opens on hover and tap', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(40),
            child: TextFormField(
              initialValue: 'x',
              decoration: fieldDecoration(
                label: 'VAT treatment',
                help: 'HELP TEXT',
              ),
            ),
          ),
        ),
      ),
    );
    final icon = find.byType(HelpIcon);
    expect(icon, findsOneWidget);
    final g = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await g.addPointer(location: tester.getCenter(icon));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('HELP TEXT'), findsOneWidget);
    await g.moveTo(Offset.zero);
    await tester.pump(const Duration(seconds: 2));
    await tester.tap(icon, warnIfMissed: false);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('HELP TEXT'), findsOneWidget);
  });

  for (final (name, widget) in [
    (
      'checkbox',
      HelpCheckbox(
        value: false,
        onChanged: (_) {},
        title: 'Title',
        help: 'HELP TEXT',
      ),
    ),
    (
      'value row',
      const ValueRow(label: 'Label', value: '1', help: 'HELP TEXT'),
    ),
  ]) {
    testWidgets('a $name help tooltip opens on hover', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Center(child: SizedBox(width: 400, child: widget)),
          ),
        ),
      );
      final g = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await g.addPointer(location: tester.getCenter(find.byType(HelpIcon)));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('HELP TEXT'), findsOneWidget);
    });
  }
}
