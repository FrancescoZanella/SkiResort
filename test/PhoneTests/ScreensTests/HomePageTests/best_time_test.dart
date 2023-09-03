import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/homepage/bestresult.dart';
import 'package:ski_resorts_app/phone/screens/homepage/services.dart';
import 'package:ski_resorts_app/phone/screens/homepage/best_time.dart';

void main() {
  group('BestTime', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BestTime(callback: () {}),
        ),
      );

      expect(find.byType(Stack), findsNWidgets(7));
      expect(find.byType(Column), findsNWidgets(2));
      expect(find.byType(Container), findsNWidgets(8));
      expect(find.byType(Services), findsOneWidget);
      expect(find.byType(Positioned), findsNWidgets(11));
      expect(find.byType(BestResult), findsOneWidget);
    });

    testWidgets('calls callback when Services is tapped',
        (WidgetTester tester) async {
      bool callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: BestTime(callback: () {
            callbackCalled = true;
          }),
        ),
      );

      expect(find.byType(Services), findsOneWidget);

      await tester.tap(find.byType(Services));
      await tester.pumpAndSettle();

      expect(callbackCalled, isTrue);
    });
  });
}
