import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/profile_screen.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('ProfilePageScreen', () {
    late UserModel userModel;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() async {
      mockSharedPreferences = MockSharedPreferences();
      when(() => mockSharedPreferences.getString('userId')).thenReturn('123');
      SharedPreferences.setMockInitialValues({'userId': '123'});
      userModel = UserModel();
    });

    testWidgets('renders ProfilePageScreen', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: userModel),
          ],
          child: const MaterialApp(
            home: ProfilePageScreen(),
          ),
        ),
      );

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Personal Information'), findsOneWidget);
      expect(find.text('Name: '), findsOneWidget);
      expect(find.text('Surname: '), findsOneWidget);
      expect(find.text('Email: '), findsOneWidget);
      expect(find.text('Phone Number: '), findsOneWidget);
    });

    testWidgets('taps on Name ListTile', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: userModel),
          ],
          child: const MaterialApp(
            home: ProfilePageScreen(),
          ),
        ),
      );

      await tester.tap(find.text('Name: '));
      await tester.pumpAndSettle();

      expect(find.text('Edit Name'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('taps on Surname ListTile', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: userModel),
          ],
          child: const MaterialApp(
            home: ProfilePageScreen(),
          ),
        ),
      );

      await tester.tap(find.text('Surname: '));
      await tester.pumpAndSettle();

      expect(find.text('Edit Surname'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('taps on Email ListTile', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: userModel),
          ],
          child: const MaterialApp(
            home: ProfilePageScreen(),
          ),
        ),
      );

      await tester.tap(find.text('Email: '));
      await tester.pumpAndSettle();

      expect(find.text('Edit Email'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('taps on Phone Number ListTile', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: userModel),
          ],
          child: const MaterialApp(
            home: ProfilePageScreen(),
          ),
        ),
      );

      await tester.tap(find.text('Phone Number: '));
      await tester.pumpAndSettle();

      expect(find.text('Edit Phone Number'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('taps on avatar', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: userModel),
          ],
          child: const MaterialApp(
            home: ProfilePageScreen(),
          ),
        ),
      );

      await tester.tap(find.byType(CircleAvatar));
      await tester.pumpAndSettle();

      expect(find.text('Change Profile Picture'), findsOneWidget);
      expect(find.text('Take a Photo'), findsOneWidget);
      expect(find.text('Choose from Gallery'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });
  });
}
