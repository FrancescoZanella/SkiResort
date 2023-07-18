import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//FUNZIONI CHE SERVONO PER ACCEDERE AL DB.

//url to use to in order to have a connection with the db.
final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

// funzione che dato una mail e una password ritorna vero o falso
Future<bool> checkCredentials(Uri url, String email, String password) async {
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

//preferences non dovrebbero essere usate per storare grandi dati,
//solo per esempio se è loggato o no o roba del genere

//given a user set the preferences to this user
Future<void> setPreferences(String id, Map<String, String> user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('userId', id); // Save the unique Firebase ID
  await prefs.setString('email', user['email']!);
  await prefs.setString('name', user['name']!);
  await prefs.setString('surname', user['surname']!);
  await prefs.setString('phoneNumber', user['phoneNumber']!);
  await prefs.setString('avatar', user['avatar']!);
  return;
}

//dato un id mi retrieva l'User



