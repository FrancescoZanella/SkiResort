import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_list.dart';

void main() {
  group('ResortList', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      final resorts = [
        Resort(
          skiResortId: '1',
          skiResortLink: '',
          skiResortName: 'Resort 1',
          skiResortDescription: 'Description 1',
          imageLink: '',
          skiResortRating: 4.5,
          totalSkiSlopes: '100',
          blueSkiSlopes: '30',
          redSkiSlopes: '50',
          blackSkiSlopes: '20',
          skiPassCost: '50',
          skiResortElevation: '1000',
          skiLiftsNumber: '10',
          skiResortLatitude: 45.0,
          skiResortLongitude: 10.0,
        ),
        Resort(
          skiResortId: '2',
          skiResortLink: '',
          skiResortName: 'Resort 2',
          skiResortDescription: 'Description 2',
          imageLink: '',
          skiResortRating: 4.0,
          totalSkiSlopes: '80',
          blueSkiSlopes: '20',
          redSkiSlopes: '40',
          blackSkiSlopes: '20',
          skiPassCost: '40',
          skiResortElevation: '800',
          skiLiftsNumber: '8',
          skiResortLatitude: 46.0,
          skiResortLongitude: 11.0,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResortList(
              resorts: resorts,
              onFavouriteButtonPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
