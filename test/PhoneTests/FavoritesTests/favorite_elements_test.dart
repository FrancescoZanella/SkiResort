//tests ok
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/favorites/favorite_elements.dart';

class MockClient extends Mock implements http.Client {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('fetchFavorites', () {
    final client = MockClient();
    final mockPrefs = MockSharedPreferences();

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    // Sample Favorite data
    final Map<String, dynamic> sampleFavoriteData = {
      'skiResortLink': 'sampleLink',
      'skiResortName': 'sampleName',
      'skiResortDescription': 'sampleDescription',
      'imageLink': 'sampleImageLink',
      'skiResortRating': 4.5,
      'totalSkiSlopes': '50',
      'blueSkiSlopes': '20',
      'redSkiSlopes': '20',
      'blackSkiSlopes': '10',
      'skiPassCost': '100',
      'skiResortElevation': '2000',
      'skiLiftsNumber': '5',
      'userId': 'testUser'
    };

    // Mocking SharedPreferences
    SharedPreferences.setMockInitialValues({});
    when(() => mockPrefs.getString('userId')).thenReturn('testUser');

    test('throws an exception if http call completes with an error', () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchFavorites(), isA<Future<List<Favorite>>>());
    });

    test('returns a Future<List<Favorite>> when no data is received', () {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(json.encode({}), 200));

      expect(fetchFavorites(), isA<Future<List<Favorite>>>());
    });

    test('returns empty list when no favorites match userId', () async {
      final nonMatchingData = {
        ...sampleFavoriteData,
        'userId': 'anotherUser',
      };

      final jsonMap = {
        'id1': nonMatchingData,
      };

      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(json.encode(jsonMap), 200));

      final result = await fetchFavorites();
      expect(result, isEmpty);
    });
  });
}
