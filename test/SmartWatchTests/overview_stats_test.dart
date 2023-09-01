//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_screen_1.dart';
import 'package:ski_resorts_app/smartwatch/overwiew_stats.dart';
import 'package:ski_resorts_app/smartwatch/speed.dart';

void main() {
  group('Overview widget', () {
    testWidgets('displays distance, duration, and date',
        (WidgetTester tester) async {
      final data = RunData(
        latitude: 0.0,
        longitude: 0.0,
        date: '2022-01-01',
        formattedTime: '00:00:00',
        averageSpeed: 0.0,
        maxSpeed: 0.0,
        distanceInMeters: 1000,
        speedDataPoints: [],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Overview(
            data: data,
          ),
        ),
      );

      expect(find.text('${data.distanceInMeters.toStringAsFixed(2)} km'),
          findsOneWidget);
      expect(find.text(data.formattedTime), findsOneWidget);
      expect(find.text(data.date), findsOneWidget);
    });

    testWidgets('navigates to Speed on swipe down',
        (WidgetTester tester) async {
      final data = RunData(
        latitude: 0.0,
        longitude: 0.0,
        date: '2022-01-01',
        formattedTime: '00:00:00',
        averageSpeed: 0.0,
        maxSpeed: 0.0,
        distanceInMeters: 1000,
        speedDataPoints: [],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Overview(
            data: data,
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);

      await tester.fling(
          find.byType(GestureDetector), const Offset(0, 500), 1000);
      await tester.pumpAndSettle();

      expect(find.byType(Speed), findsNWidgets(0));
    });

    testWidgets('navigates back on swipe up', (WidgetTester tester) async {
      final data = RunData(
        latitude: 0.0,
        longitude: 0.0,
        date: '2022-01-01',
        formattedTime: '00:00:00',
        averageSpeed: 0.0,
        maxSpeed: 0.0,
        distanceInMeters: 1000,
        speedDataPoints: [],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Overview(
            data: data,
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);

      await tester.fling(
          find.byType(GestureDetector), const Offset(0, -500), 1000);
      await tester.pumpAndSettle();

      expect(find.byType(Overview), findsNWidgets(0));
    });
  });
}
