import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/most_popular_resort.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_list.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_table_db_functions.dart';

class MockGetResorts extends Mock implements GetResorts {}

void main() {
  group('MostPopularResortPage', () {
    late MockGetResorts mockGetResorts;

    setUp(() {
      mockGetResorts = MockGetResorts();
      when(() => mockGetResorts.fetchResorts()).thenAnswer((_) async => []);
    });

    testWidgets('renders MostPopularResortPage', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MostPopularResortPage()));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(ResortList), findsOneWidget);
    });

    /* testWidgets('displays resorts if available', (WidgetTester tester) async {
      final fakeResorts = [Resort(name: 'Test Resort')];
      when(() => mockGetResorts.fetchResorts())
          .thenAnswer((_) async => fakeResorts);

      // Inject the mock into MostPopularResortPage
      // Ideally, you'd refactor MostPopularResortPage to accept the service via a constructor or a provider

      await tester.pumpWidget(const MaterialApp(home: MostPopularResortPage()));
      await tester.pumpAndSettle();

      expect(find.text('Test Resort'), findsOneWidget);
    });*/
  });
}
