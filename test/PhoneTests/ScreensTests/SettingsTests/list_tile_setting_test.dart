//tests ok
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ski_resorts_app/phone/screens/settings/logout_logic/list_tiles_setting.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Create a Mock class for the FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  final mockFirebaseAuth = MockFirebaseAuth();

  setUpAll(() {
    // Register the mock for User class
    registerFallbackValue(MockUser());
  });

  setUp(() {
    // Set up the mock before each test
    when(() => mockFirebaseAuth.currentUser).thenReturn(MockUser());
  });

  group('CustomListTile', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'Title',
              icon: Icons.home,
              trailing: Icon(Icons.arrow_forward_ios),
              pageName: 'pageName',
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
    });

    testWidgets('onTap works for "Sign out" title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'Sign out',
              icon: Icons.logout,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Sign out'));
      await tester.pumpAndSettle();

      // Ensure the dialog is displayed
      expect(find.text('Confirm Log Out'), findsOneWidget);
      expect(find.text('Are you sure you want to log out?'), findsOneWidget);
    });
  });
}

// Create a Mock class for the User
class MockUser extends Mock implements User {}
