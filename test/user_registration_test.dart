import 'dart:convert';
import 'package:ski_resorts_app/screens/loginOrRegistration/registration/registration_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';

// example test done for the registerUser function
class MockClient extends Mock implements http.Client {}

void main() {
  group('registerUser', () {
    final url = Uri.https(
      'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
      '/user-table.json',
    );

    test('should throw an exception if GET request fails', () async {
      final client = MockClient();

      when(client.get(url)).thenAnswer((_) async => Response('Not Found', 404));

      expect(
          registerUser('John', 'Doe', 'johndoe@example.com', 'password',
              '+123456789', 'avatar.png',
              client: client),
          throwsException);
    });

    test('should throw an exception if POST request fails', () async {
      final client = MockClient();

      when(client.get(url)).thenAnswer((_) async => Response('{}', 200));
      when(client.post(url,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response('Bad Request', 400));

      expect(
          registerUser('John', 'Doe', 'johndoe@example.com', 'password',
              '+123456789', 'avatar.png',
              client: client),
          throwsException);
    });

    test('should return userId when user is already registered', () async {
      final client = MockClient();
      final responseBody = jsonEncode({
        '1': {
          'name': 'John',
          'surname': 'Doe',
          'email': 'johndoe@example.com',
          'phoneNumber': '+123456789',
          'password': 'password',
          'avatar': 'avatar.png',
        },
      });

      when(client.get(url))
          .thenAnswer((_) async => Response(responseBody, 200));

      expect(
          await registerUser('John', 'Doe', 'johndoe@example.com', 'password',
              '+123456789', 'avatar.png',
              client: client),
          '1');
    });

    test('should return userId when new user is registered', () async {
      final client = MockClient();
      final getResponseBody = jsonEncode({});
      final postResponseBody = jsonEncode({
        'name': '1',
      });

      when(client.get(url))
          .thenAnswer((_) async => Response(getResponseBody, 200));
      when(client.post(url,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response(postResponseBody, 200));

      expect(
          await registerUser('John', 'Doe', 'johndoe@example.com', 'password',
              '+123456789', 'avatar.png',
              client: client),
          '1');
    });
  });
}
