// integration_test/training_start_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ski_resorts_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Training Start Integration Test', () {
    testWidgets('Starting Training Session Test', (WidgetTester tester) async {
      // Start your app
      runApp(const MyApp());

      // Navigate to Training page
      final trainingPageButtonFinder =
          find.byKey(const Key('navigateToTrainingPageButton'));
      await tester.tap(trainingPageButtonFinder);
      await tester.pumpAndSettle();

      // Find and tap on the "Start Training" button
      final startTrainingButtonFinder =
          find.byKey(const Key('startTrainingButton'));
      await tester.tap(startTrainingButtonFinder);

      // Wait for the training initialization process
      await tester.pump(const Duration(seconds: 2));

      // Check if the timer widget is displayed (assuming a Text widget displays the timer)
      final timerTextFinder = find.byWidgetPredicate(
          (widget) => widget is Text && widget.data!.startsWith('00:00'));
      expect(timerTextFinder, findsOneWidget);
    });
    testWidgets('Set and Achieve Training Goal Test',
        (WidgetTester tester) async {
      // Start your app
      runApp(const MyApp());

      // Navigate to Training page
      final trainingPageButtonFinder =
          find.byKey(const Key('navigateToTrainingPageButton'));
      await tester.tap(trainingPageButtonFinder);
      await tester.pumpAndSettle();

      // Set the training goal to 5km
      final trainingGoalInputFinder =
          find.byKey(const Key('trainingGoalInput'));
      await tester.enterText(trainingGoalInputFinder, '5');
      await tester.pumpAndSettle();

      // Start the training
      final startTrainingButtonFinder =
          find.byKey(const Key('startTrainingButton'));
      await tester.tap(startTrainingButtonFinder);
      await tester.pumpAndSettle();

      // Simulate the training progressing. In a real scenario, this would be your app fetching and updating the distance covered in real-time.
      // You can mock this part if required.
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(
            minutes: 10)); // assuming the user covers 1km every 10 minutes
      }

      // At this point, the training goal should be achieved, and the app should show some indication of that.
      final goalAchievedFinder = find.text(
          'Goal Achieved!'); // assuming you're using a Text widget to display the message
      expect(goalAchievedFinder, findsOneWidget);
    });
  });
}
