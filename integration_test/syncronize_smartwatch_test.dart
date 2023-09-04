// integration_test/smartwatch_connection_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ski_resorts_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Smartwatch Connection Integration Test', () {
    testWidgets('Connect with Smartwatch', (WidgetTester tester) async {
      // Start your app
      runApp(
          const MyApp()); // MyApp should be the name of your app's main widget

      // Assuming there's a button to initiate connection with the smartwatch.
      final connectionButtonFinder =
          find.byKey(const Key('connectSmartwatchButton'));

      // Tap on the button to initiate connection
      await tester.tap(connectionButtonFinder);
      await tester.pumpAndSettle();

      // Here, you might want to emulate a successful connection by mocking the method that checks the connection.

      // After emulating connection, verify if the connection was successful
      final connectionStatusFinder = find.text(
          'Connected'); // Assuming you display a 'Connected' text when smartwatch is connected
      expect(connectionStatusFinder, findsOneWidget);
    });

    testWidgets('Smartwatch disconnection Test', (WidgetTester tester) async {
      // Start your app
      runApp(const MyApp());

      // Navigate to Smartwatch Sync page (assuming you're starting from the home page and have a navigation button)
      final syncPageButtonFinder =
          find.byKey(const Key('navigateToSyncPageButton'));
      await tester.tap(syncPageButtonFinder);
      await tester.pumpAndSettle();

      // Find and tap on the "Start Sync" button
      final startSyncButtonFinder = find.byKey(const Key('startSyncButton'));
      await tester.tap(startSyncButtonFinder);

      // Wait for the synchronization process to complete
      // This duration might vary depending on your app.
      // Adjust accordingly or, ideally, mock the sync process to be instant for testing.
      await tester.pump(const Duration(seconds: 5));

      // Check if the "Sync Successful" message is displayed
      final syncSuccessMessageFinder = find.text('disconnected Successfully');
      expect(syncSuccessMessageFinder, findsOneWidget);
    });
  });
}
