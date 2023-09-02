//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_screen_navigator.dart';

void main() {
  group('CustomTopNavigationBar', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      var selectedIndex = 0;
      void onItemTapped(int index) {
        selectedIndex = index;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: CustomTopNavigationBar(
              selectedIndex: selectedIndex,
              onItemTapped: onItemTapped,
            ),
          ),
        ),
      );

      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      expect(find.text('Resort Map'), findsOneWidget);
      expect(find.byIcon(Icons.timeline), findsOneWidget);
      expect(find.text('Most Popular'), findsOneWidget);
    });

    testWidgets('calls onItemTapped when an item is tapped',
        (WidgetTester tester) async {
      var selectedIndex = 0;
      void onItemTapped(int index) {
        selectedIndex = index;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: CustomTopNavigationBar(
              selectedIndex: selectedIndex,
              onItemTapped: onItemTapped,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.timeline));
      expect(selectedIndex, equals(1));
    });
  });
}
