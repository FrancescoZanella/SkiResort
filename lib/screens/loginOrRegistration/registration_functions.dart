import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

Future<String?> registerUser(String name, String surname, String email,
    String password, String phoneNumber, String avatar,
    {http.Client? client}) async {
  client ??= http.Client();

  final getResponse = await http.get(url);

  if (getResponse.statusCode != 200) {
    throw Exception('Failed to retrieve users: ${getResponse.body}');
  }

  final users = Map<String, dynamic>.from(json.decode(getResponse.body));
  bool userExists = false;
  String? userId;

  for (final entry in users.entries) {
    if (entry.value['email'] == email) {
      userExists = true;
      userId = entry.key; // save the Firebase ID
      name = entry.value['name'];
      surname = entry.value['surname'];
      phoneNumber = entry.value['phoneNumber'];
      avatar = entry.value['avatar'];
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

    userId =
        jsonDecode(postResponse.body)['name']; // use the returned Firebase ID
  }

  if (kDebugMode) {
    print('User registered successfully');
  }

  return userId;
}
