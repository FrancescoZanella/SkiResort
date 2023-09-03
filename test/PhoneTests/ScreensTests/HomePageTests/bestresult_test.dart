import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/homepage/bestresult.dart';

class StatisticsData {
  final String distance;
  final String time;
  final String maxSpeed;

  StatisticsData({
    required this.distance,
    required this.time,
    required this.maxSpeed,
  });
}

Future<void> setBestStat(String userId, StatisticsData data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('$userId-distance', data.distance);
  await prefs.setString('$userId-time', data.time);
  await prefs.setString('$userId-maxSpeed', data.maxSpeed);
}

void main() {
  group('BestResult', () {
    testWidgets('renders CircularProgressIndicator while waiting for data',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BestResult(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders "not found" if there is an error',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'userId': 'testUserId',
      });
      await tester.pumpWidget(
        const MaterialApp(
          home: BestResult(),
        ),
      );

      expect(find.text('not found'), findsOneWidget);
    });

    testWidgets('renders data correctly', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'userId': 'testUserId',
      });
      setBestStat('testUserId',
          StatisticsData(distance: '10.0', time: '01:00:00', maxSpeed: '50.0'));

      await tester.pumpWidget(
        const MaterialApp(
          home: BestResult(),
        ),
      );

      expect(find.text('10.00 Km'), findsOneWidget);
      expect(find.text('01:00:00'), findsOneWidget);
      expect(find.text('50.00 KM/h'), findsOneWidget);
    });
  });
}
