import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

//FUNZIONI CHE SERVONO PER ACCEDERE AL DB.

class DataLogin {
//url to use to in order to have a connection with the db.
  final url = Uri.https(
    'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
    '/user-table.json',
  );

  final http.Client client;
  DataLogin(this.client);

//given a user and an id set the preferences to this user
  static Future<void> setPreferences(
      String id, Map<String, String> user) async {
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

  static Future<bool> login(
      BuildContext context, String email, String password) async {
    final url = Uri.https(
      'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
      '/user-table.json',
    );
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

  Future<UserModel> fetchUser() async {
    final response = await client.get(Uri.https(
      'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
      '/user-table.json',
    ));

    UserModel myuser = UserModel();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      final decodedResponse =
          json.decode(response.body) as Map<String, dynamic>;

      for (var entry in decodedResponse.entries) {
        var user = entry.value;

        if (user['email'] == "franco@gmail.it" && user['password'] == "prova") {
          // Save the user's data to shared preferences
          myuser.updateUser(
              userId: "-NdLHBijRYLHWqt_mFhA",
              name: "franco",
              surname: "battiato",
              email: "franco@prova.it",
              phoneNumber: "3345674564",
              avatarPath: "lib/assets/images/avatar9.jpg");

          return myuser;
        }
      }

      return myuser;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
