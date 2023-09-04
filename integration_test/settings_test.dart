import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ski_resorts_app/main.dart';

void main() {
  setUp(() {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets("Edit first name", (tester) async {
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

    //Login Steps Done
    //https://stackoverflow.com/questions/53299088/how-to-open-a-drawer-in-flutter-tests
    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3));

    final settings = find.text("Settings");
    expect(settings, findsOneWidget);
    await tester.tap(settings);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3));

    final editFirstName = find.byIcon(Icons.edit_rounded).at(1);
    expect(editFirstName, findsOneWidget);
    await tester.tap(editFirstName);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));

    final firstName = find.bySemanticsLabel("First Name");
    expect(firstName, findsOneWidget);
    await tester.enterText(firstName, "test name");
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));

    final saveButton = find.byIcon(Icons.check_rounded);
    expect(saveButton, findsOneWidget);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));
  });

  testWidgets('Report a bug through Gmail', (WidgetTester tester) async {
    // Start your app
    runApp(const MyApp());

    // Navigate to Settings page
    final settingsPageButtonFinder =
        find.byKey(const Key('navigateToSettingsPageButton'));
    await tester.tap(settingsPageButtonFinder);
    await tester.pumpAndSettle();

    // Tap on the 'Report a Bug' option
    final reportBugButtonFinder = find.byKey(const Key('reportBugButton'));
    await tester.tap(reportBugButtonFinder);
    await tester.pumpAndSettle();

    // Assume there's a text field where users can describe the bug
    final bugDescriptionFieldFinder =
        find.byKey(const Key('bugDescriptionField'));
    await tester.enterText(
        bugDescriptionFieldFinder, 'This is a bug description for the test.');

    // Tap on submit or send report button
    final sendReportButtonFinder = find.byKey(const Key('sendReportButton'));
    await tester.tap(sendReportButtonFinder);
    await tester.pumpAndSettle();

    // Here, you'd normally open Gmail or send an intent to share via email.
    // You can't test this in the integration test environment. However, you can
    // check any other side-effects or behaviors in your app that occur as a result,
    // like showing a 'Thank you for the feedback' message or similar.

    final thankYouFinder = find.text('Thank you for the feedback!');
    expect(thankYouFinder, findsOneWidget);
  });
}
