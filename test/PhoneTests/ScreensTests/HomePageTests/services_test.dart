// ignore_for_file: unused_local_variable
//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // 1. Import the mocktail package.
import 'package:ski_resorts_app/phone/screens/homepage/services.dart';
import 'package:ski_resorts_app/phone/widgets/button.dart';
import 'package:ski_resorts_app/phone/widgets/card.dart';

// 2. Create a Mock class for BuildContext using mocktail.
class MockBuildContext extends Mock implements BuildContext {}

class MockCallback extends Mock {
  void call();
}

void main() {
  group('Services', () {
    late MockCallback mockCallback;
    late MockBuildContext mockBuildContext;

    setUp(() {
      mockCallback = MockCallback();

      mockBuildContext = MockBuildContext();
    });

    testWidgets('renders Services widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Services(callback: mockCallback),
        ),
      );

      expect(find.byType(MyCard), findsNWidgets(4));
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('renders dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Services(callback: mockCallback),
        ),
      );

      final container = find.byType(Container).first;
      final color = (container.evaluate().single.widget as Container).color;

      // mocktail doesn't directly support capturing arguments like mockito, so we have to do a manual check.
      expect(color, equals(null));
    });

    testWidgets('renders light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Services(callback: mockCallback),
        ),
      );

      final container = find.byType(Container).first;
      final color = (container.evaluate().single.widget as Container).color;

      expect(color, equals(null));
    });
  });
}
