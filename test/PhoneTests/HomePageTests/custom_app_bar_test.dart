import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/profile_screen.dart';
import 'package:ski_resorts_app/phone/screens/settings/settings_page_screen.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';
import 'package:ski_resorts_app/phone/screens/homepage/custom_app_bar.dart';

void main() {
  group('CustomAppBar', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserModel(),
            ),
          ],
          child: const MaterialApp(
            home: CustomAppBar(),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(5));
      expect(find.byType(Row), findsNWidgets(3));
      expect(find.byType(Stack), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(2));
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(Icon), findsNWidgets(2));
    });

    testWidgets('navigates to profile page when avatar is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserModel(),
            ),
          ],
          child: const MaterialApp(
            home: CustomAppBar(),
          ),
        ),
      );

      expect(find.byType(CustomAppBar), findsOneWidget);

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      expect(find.byType(CustomAppBar), findsNothing);
      expect(find.byType(ProfilePageScreen), findsOneWidget);
    });

    testWidgets('navigates to settings page when settings icon is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserModel(),
            ),
          ],
          child: const MaterialApp(
            home: CustomAppBar(),
          ),
        ),
      );

      expect(find.byType(CustomAppBar), findsOneWidget);

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(find.byType(CustomAppBar), findsNothing);
      expect(find.byType(SettingsPage), findsOneWidget);
    });
  });
}
