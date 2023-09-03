//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/settings/single_section_setting.dart';

void main() {
  group('SingleSection', () {
    testWidgets('renders correctly with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleSection(
              title: 'Test Title',
              children: [
                Container(),
                Container(),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('renders correctly without title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleSection(
              children: [
                Container(),
                Container(),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Text), findsNothing);
      expect(find.byType(Container), findsNWidgets(2));
    });
  });
}
