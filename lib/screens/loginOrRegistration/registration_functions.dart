import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

// this functions checks if the user exists in the database, if not, it registers the user if the user exists, it returns the user's data
// this function is used just for google and facebook sign in
Future<Map<String, dynamic>?> registerUser(String name, String surname,
    String email, String password, String phoneNumber, String avatar,
    {http.Client? client}) async {
  client ??= http.Client();

  final getResponse = await http.get(url);

  if (getResponse.statusCode != 200) {
    throw Exception('Failed to retrieve users: ${getResponse.body}');
  }

  final users = Map<String, dynamic>.from(json.decode(getResponse.body));
  bool userExists = false;
  Map<String, dynamic>? user;

  for (final entry in users.entries) {
    if (entry.value['email'] == email) {
      userExists = true;
      user = {
        'userId': entry.key,
        'name': entry.value['name'],
        'surname': entry.value['surname'],
        'phoneNumber': entry.value['phoneNumber'],
        'avatar': entry.value['avatar'],
      };
      break;
    }
  }

  if (!userExists) {
    final postResponse = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'surname': surname,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'avatar': avatar,
      }),
    );

    if (postResponse.statusCode != 200) {
      throw Exception('Failed to register user: ${postResponse.body}');
    }

    user = {
      'userId': jsonDecode(postResponse.body)['name'],
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
    };
  }

  if (kDebugMode) {
    print('User registered successfully');
  }

  return user;
}
