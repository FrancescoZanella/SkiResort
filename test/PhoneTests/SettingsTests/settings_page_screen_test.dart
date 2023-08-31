//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/phone/screens/settings/settings_page_screen.dart';
import 'package:ski_resorts_app/phone/screens/settings/theme_notifier.dart';
import 'package:ski_resorts_app/phone/screens/settings/single_section_setting.dart';

void main() {
  group('SettingsPage', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeNotifier()),
          ],
          child: const MaterialApp(
            home: SettingsPage(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.byType(SingleSection), findsNWidgets(3));
      expect(find.byType(Switch), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('toggles dark mode when switch is tapped',
        (WidgetTester tester) async {
      final themeNotifier = ThemeNotifier();
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: themeNotifier,
          child: const MaterialApp(
            home: SettingsPage(),
          ),
        ),
      );

      final switchFinder = find.byType(Switch);
      expect(themeNotifier.darkTheme, isTrue);

      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      expect(themeNotifier.darkTheme, isFalse);

      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      expect(themeNotifier.darkTheme, isTrue);
    });
  });
}
