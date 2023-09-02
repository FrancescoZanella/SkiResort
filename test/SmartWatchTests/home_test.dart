import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/smartwatch/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void setUpAll() {
  registerFallbackValue(null);
}

void main() {
  group('SmartWatch', () {
    late SharedPreferences sharedPreferences;

    setUp(() {
      sharedPreferences = MockSharedPreferences();
    });

    testWidgets('Shows CircularProgressIndicator while loading',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SmartWatch()));

      // This will show the CircularProgressIndicator since the Future is still running.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Shows error if FutureBuilder encounters an error',
        (tester) async {
      when(() => sharedPreferences.getString('userId'))
          .thenThrow(Exception('Mocked error'));

      await tester.pumpWidget(const MaterialApp(home: SmartWatch()));

      // Let the FutureBuilder finish.
      await tester.pump(Duration.zero); // Skips the animation

      expect(find.text('error'), findsNWidgets(0));
    });

    testWidgets('Shows no data loaded if snapshot has no data', (tester) async {
      when(() => sharedPreferences.getString('userId')).thenReturn(null);

      await tester.pumpWidget(const MaterialApp(home: SmartWatch()));

      // Let the FutureBuilder finish.
      await tester.pump(Duration.zero); // Skips the animation

      expect(find.text('no data loaded'), findsNWidgets(0));
    });
  });
}
