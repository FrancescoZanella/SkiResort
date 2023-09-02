//test ok
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ski_resorts_app/phone/screens/settings/report_bug_screen/report_bug_screen.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockUrlLauncher extends Mock {
  Future<bool> launch(String urlString);
}

void main() {
  group('ReportBugScreen', () {
    late MockBuildContext mockBuildContext;
    late MockUrlLauncher mockUrlLauncher;

    setUp(() {
      mockBuildContext = MockBuildContext();
      mockUrlLauncher = MockUrlLauncher();
      // Override the default launch function with our mock function
      final Function launchUrl = mockUrlLauncher.launch;
      // When our mock launch function is called, always return true for simplicity
      when(() => mockUrlLauncher.launch(any())).thenAnswer((_) async => true);
    });

    testWidgets('renders ReportBugScreen widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ReportBugScreen(),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
    });
  });
}
