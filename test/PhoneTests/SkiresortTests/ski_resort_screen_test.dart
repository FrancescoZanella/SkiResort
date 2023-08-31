import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_screen_navigator.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/ski_resort_screen.dart';

void main() {
  group('SkiResortScreen', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SkiResortScreen(),
        ),
      );

      expect(find.byType(CustomTopNavigationBar), findsOneWidget);
      expect(find.byType(IndexedStack), findsOneWidget);
    });

    /*testWidgets('changes page when an item is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SkiResortScreen(),
        ),
      );

      expect(find.byType(ResortScreenNavigator), findsOneWidget);
      expect(find.byType(SkiResortPages), findsOneWidget);

      await tester.tap(find.byIcon(Icons.timeline));
      await tester.pump();

      expect(find.byType(ResortScreenNavigator), findsNothing);
      expect(find.byType(SkiResortPages), findsOneWidget);
    });*/
  });
}
