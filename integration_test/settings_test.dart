import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

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
}
