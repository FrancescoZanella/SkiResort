// integration_test/login_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ski_resorts_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Integration Test', () {
    testWidgets('Enter email and password and login',
        (WidgetTester tester) async {
      // Start your app
      runApp(const MyApp());
      // Find widgets by type, key or text.
      final emailFieldFinder = find.byKey(const Key('emailField'));
      final passwordFieldFinder = find.byKey(const Key('passwordField'));
      final loginButtonFinder = find.byKey(const Key('loginButton'));

      // Interact with the widgets
      await tester.tap(emailFieldFinder);
      await tester.enterText(emailFieldFinder, 'test@example.com');

      await tester.tap(passwordFieldFinder);
      await tester.enterText(passwordFieldFinder, 'password123');

      await tester.tap(loginButtonFinder);

      // Let the framework process the tap and send the route
      await tester.pumpAndSettle();

      // Verify if login was successful
      final welcomeTextFinder = find.text('Welcome to SkiSage');
      expect(
          find.descendant(
              of: welcomeTextFinder, matching: find.text('Welcome to SkiSage')),
          findsOneWidget);
    });
  });

  testWidgets("Logout", (tester) async {
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));

    final emailForm = find.byKey(const Key("loginmail"));

    expect(emailForm, findsOneWidget);

    final passwordForm = find.byKey(const Key("loginpassword"));
    expect(passwordForm, findsOneWidget);

    await tester.enterText(emailForm, "testmail@mail.it");
    await tester.enterText(passwordForm, "password");

    final loginButton = find.byKey(const Key("signInButton"));
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));

    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3));

    final logout = find.text("Logout");
    expect(logout, findsOneWidget);
    await tester.tap(logout);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3));

    final check = find.byKey(const Key("loginmail"));

    expect(check, findsOneWidget);
  });
}
