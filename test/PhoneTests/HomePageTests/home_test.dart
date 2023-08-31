import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ski_resorts_app/phone/screens/homepage/best_time.dart';
import 'package:ski_resorts_app/phone/screens/homepage/custom_app_bar.dart';
import 'package:ski_resorts_app/phone/screens/homepage/home.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('HomeScreen', () {
    late Function callback;
    late MockBuildContext mockBuildContext;

    setUp(() {
      callback = () {};
      mockBuildContext = MockBuildContext();
    });

    testWidgets('renders HomeScreen widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(callback: callback),
        ),
      );

      expect(find.byType(CustomAppBar), findsOneWidget);
      expect(find.byType(BestTime), findsOneWidget);
    });

    testWidgets('taps on BestTime', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(callback: callback),
        ),
      );

      await tester.tap(find.byType(BestTime));
      await tester.pumpAndSettle();

      verify(callback).called(1);
    });
  });
}
