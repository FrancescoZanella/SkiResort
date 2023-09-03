import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/watch/connect_smartwatch_screen.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('ConnectSmartwatchScreen UI Tests', () {
    testWidgets('Shows CircularProgressIndicator while loading',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: ConnectSmartwatchScreen()));
      await tester.pump(); // Trigger a frame

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
