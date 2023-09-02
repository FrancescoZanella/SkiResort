import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

import '../../builder.dart';

//FUNZIONI CHE SERVONO PER ACCEDERE AL DB.

//url to use to in order to have a connection with the db.
final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);
/* QUESTA FUNZIONA MA VA MODIFICATA*/
Future<void> checkCredentials(
    BuildContext context, String email, String password) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    for (var entry in data.entries) {
      var id = entry.key; // The unique Firebase ID
      var user = entry.value;
      if (user['email'] == email && user['password'] == password) {
        // If credentials are found in the database, save them to the device
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userId', id); // Save the unique Firebase ID
        await prefs.setString('email', user['email']);
        await prefs.setString('name', user['name']);
        await prefs.setString('surname', user['surname']);
        await prefs.setString('phoneNumber', user['phoneNumber']);
        await prefs.setString('avatarPath', user['avatar']);

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
              userId: id, // Pass the unique Firebase ID
              name: user['name'],
              surname: user['surname'],
              email: user['email'],
              phoneNumber: user['phoneNumber'],
              avatarPath: user['avatar'],
            ),
          ), // Redirect to home page
        );
        return;
      }
    }
  } else {
    // If the server returns an error, handle it
    throw Exception('Failed to load user credentials');
  }
}

// funzione che dato una mail e una password ritorna vero o falso se l'utente esiste e ha pw corretta
// ignore: non_constant_identifier_names
Future<bool> checkCredentials_TODO(String email, String password) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    for (var entry in data.entries) {
      var user = entry.value;
      if (user['email'] == email && user['password'] == password) {
        return true;
      }
    }
    return false;
  } else {
    throw Exception('Failed to load user credentials');
  }
}

//given an email and password return the user
Future<UserModel> returnUser(String email, String password) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    for (var entry in data.entries) {
      var user = entry.value;
      if (user['email'] == email && user['password'] == password) {
        return user;
      } else {
        continue;
      }
    }
    UserModel user = UserModel();
    return user;
  } else {
    throw Exception('Failed to load user credentials');
  }
}

//given a user and an id set the preferences to this user
Future<void> setPreferences(String id, Map<String, String> user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('userId', id); // Save the unique Firebase ID
  await prefs.setString('email', user['email']!);
  await prefs.setString('name', user['name']!);
  await prefs.setString('surname', user['surname']!);
  await prefs.setString('phoneNumber', user['phoneNumber']!);
  await prefs.setString('avatarPath', user['avatar']!);

  return;
}

Future<bool> login(BuildContext context, String email, String password) async {
  final getResponse = await http.get(url);

  //now  i check if there is a user with the same email and password
  if (getResponse.statusCode == 200) {
    final decodedResponse =
        json.decode(getResponse.body) as Map<String, dynamic>;
    for (var entry in decodedResponse.entries) {
      var user = entry.value;

      if (user['email'] == email && user['password'] == password) {
        // Save the user's data to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userId', entry.key);
        await prefs.setString('name', user['name']);
        await prefs.setString('surname', user['surname']);
        await prefs.setString('email', user['email']);
        await prefs.setString('phoneNumber', user['phoneNumber']);
        await prefs.setString('avatarPath', user['avatar']);

        return true;
      }
    }
  }
  return false;
}
