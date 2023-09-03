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
}
