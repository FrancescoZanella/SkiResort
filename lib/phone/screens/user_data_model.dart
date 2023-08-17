import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {
  String name = '';
  String surname = '';
  String email = '';
  String phoneNumber = '';
  String avatarPath = '';
  String userId = '';

  void updateUser(
      {required String userId,
      required String name,
      required String surname,
      required String email,
      required String phoneNumber,
      required String avatarPath}) {
    this.userId = userId;
    this.name = name;
    this.surname = surname;
    this.email = email;
    this.phoneNumber = phoneNumber;
    this.avatarPath = avatarPath;
  }

  void updateField(String field, String newValue) async {
    switch (field) {
      case 'name':
        name = newValue;
        await _updateSharedPrefs('name', newValue);
        break;
      case 'surname':
        surname = newValue;
        await _updateSharedPrefs('surname', newValue);
        break;
      case 'email':
        email = newValue;
        await _updateSharedPrefs('email', newValue);
        break;
      case 'phoneNumber':
        phoneNumber = newValue;
        await _updateSharedPrefs('phoneNumber', newValue);
        break;
      case 'avatarPath':
        avatarPath = newValue;
        await _updateSharedPrefs('avatarPath', newValue);
        break;
    }
    notifyListeners();
  }

  Future<void> _updateSharedPrefs(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
