import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_container.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_list.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('Resort Tests', () {
    test('fromJson should create Resort from valid JSON', () {
      final jsonData = {
        'skiResortId': '1',
        'skiResortLink': 'link',
        'skiResortName': 'Test Resort',
        'skiResortDescription': 'Test Description',
        'imageLink': 'image.png',
        'skiResortRating': '4.5',
        'totalSkiSlopes': '50',
        'blueSkiSlopes': '20',
        'redSkiSlopes': '20',
        'blackSkiSlopes': '10',
        'skiPassCost': '100',
        'skiResortElevation': '2000',
        'skiLiftsNumber': '5',
        'skiResortLatitude': '20.0',
        'skiResortLongitude': '20.0',
      };

      final resort = Resort.fromJson(jsonData);
      expect(resort.skiResortName, 'Test Resort');
    });

    test('fromJson should throw an error with invalid JSON', () {
      final jsonData = {
        'skiResortLink': 'link', // Missing some fields intentionally
        'skiResortName': 'Test Resort',
      };

      expect(() => Resort.fromJson(jsonData), throwsA(isA<Error>()));
    });
  });

  group('ResortList Widget Tests', () {
    final mockResorts = [
      Resort(
          skiResortId: '1',
          skiResortLink: 'link',
          skiResortName: 'Test Resort',
          skiResortDescription: 'Test Description',
          imageLink: 'image.png',
          skiResortRating: 4.5,
          totalSkiSlopes: '50',
          blueSkiSlopes: '20',
          redSkiSlopes: '20',
          blackSkiSlopes: '10',
          skiPassCost: '100',
          skiResortElevation: '2000',
          skiLiftsNumber: '5',
          skiResortLatitude: 20.0,
          skiResortLongitude: 20.0),
      // Add more resorts if needed
    ];

    bool isFavouriteButtonPressed = false;

    testWidgets('renders ResortList with multiple resorts', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ResortList(
            resorts: mockResorts,
            onFavouriteButtonPressed: () {
              isFavouriteButtonPressed = true;
            },
          ),
        ),
      ));
      expect(find.byType(ResortContainer), findsNWidgets(mockResorts.length));
    });

    testWidgets('executes callback on favourite button pressed',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ResortList(
            resorts: mockResorts,
            onFavouriteButtonPressed: () {
              isFavouriteButtonPressed = true;
            },
          ),
        ),
      ));

      // Note: The following assumes a favourite button exists in ResortContainer
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle();
      expect(isFavouriteButtonPressed, true);
    });
  });
}
