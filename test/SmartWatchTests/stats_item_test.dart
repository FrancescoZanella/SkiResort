//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_screen_1.dart';
import 'package:ski_resorts_app/smartwatch/overwiew_stats.dart';
import 'package:ski_resorts_app/smartwatch/stats_item.dart';

void main() {
  group('StatsItem widget', () {
    testWidgets('displays distance and date', (WidgetTester tester) async {
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
          home: StatsItem(
            data: data,
          ),
        ),
      );

      expect(find.text('${data.distanceInMeters.toStringAsFixed(2)} m'),
          findsOneWidget);
      expect(find.text(data.date), findsOneWidget);
    });

    testWidgets('navigates to Overview on tap', (WidgetTester tester) async {
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
          home: StatsItem(
            data: data,
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.byType(Overview), findsOneWidget);
    });
  });
}
