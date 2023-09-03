//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/statistics/main_stats.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_screen_1.dart';

void main() {
  group('MainStats', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MainStats(),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(StopwatchPage), findsOneWidget);
    });
  });
}
