import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_screen_1.dart';

class MockLocation extends Mock implements Location {}

class MockBuildContext extends Mock implements BuildContext {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  setUpAll(() {
    registerFallbackValue(LocationData.fromMap({}));
    registerFallbackValue(MockSharedPreferences());
    registerFallbackValue(MockBuildContext());
  });

  testWidgets('Renders StopwatchPage correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: StopwatchPage()));

    // Verify if "Training" text is shown
    expect(find.text('Training'), findsOneWidget);
  });

  testWidgets('Displays loading indicator', (WidgetTester tester) async {
    // Assuming you've mocked _runDataList to delay
    await tester.pumpWidget(const MaterialApp(
        home:
            StopwatchPage())); // Replace `YourWidget` with your actual widget name

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays error when snapshot has error',
      (WidgetTester tester) async {
    // Mock _runDataList to return an error

    await tester.pumpWidget(const MaterialApp(home: StopwatchPage()));
    await tester.pumpAndSettle(); // Let the Future complete

    expect(find.text('not found'), findsOneWidget);
  });

  testWidgets('Displays main content when data is loaded',
      (WidgetTester tester) async {
    // Mock _runDataList to return some data

    await tester.pumpWidget(const MaterialApp(home: StopwatchPage()));
    await tester.pumpAndSettle(); // Let the Future complete

    // Now test for specific widgets and their content
    expect(find.text('Training'), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2)); // Adjust the expected number
    expect(find.byType(Icon), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsNWidgets(2));
    expect(find.byType(ListView), findsOneWidget);

    testWidgets('Check components within ExpansionTile',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          home:
              StopwatchPage())); // Replace `YourWidget` with the actual name of your widget

      // Check for LineChart
      expect(find.byType(LineChart), findsOneWidget);

      // Check for Text labels
      expect(find.text('Training duration'), findsOneWidget);
      expect(find.text('Average Speed'), findsOneWidget);
      expect(find.text('Max Speed'), findsOneWidget);

      // Check for image asset (used for "View Position")
      expect(find.byIcon(Icons.maps_home_work),
          findsOneWidget); // Replace with the correct IconData if it's different

      // If you want, you can also test the interaction. E.g., tapping the 'View Position' image asset and checking if the desired function is called.
    });
  });
}
