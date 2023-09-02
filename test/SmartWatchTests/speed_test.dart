//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/smartwatch/speed.dart';

void main() {
  group('Speed widget', () {
    testWidgets('displays max speed and avg speed',
        (WidgetTester tester) async {
      const maxSpeed = '100';
      const avgSpeed = '50';
      await tester.pumpWidget(
        MaterialApp(
          home: Speed(
            avgspeed: avgSpeed,
            maxspeed: maxSpeed,
          ),
        ),
      );

      expect(find.text('Max Speed'), findsOneWidget);
      expect(find.text('$maxSpeed km/h'), findsOneWidget);
      expect(find.text('Avg Speed'), findsOneWidget);
      expect(find.text('$avgSpeed km/h'), findsOneWidget);
    });

    testWidgets('pops when dragged down', (WidgetTester tester) async {
      const maxSpeed = '100';
      const avgSpeed = '50';
      await tester.pumpWidget(
        MaterialApp(
          home: Speed(
            avgspeed: avgSpeed,
            maxspeed: maxSpeed,
          ),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);

      await tester.fling(
          find.byType(GestureDetector), const Offset(0, 200), 1000);
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsNothing);
    });
  });
}
