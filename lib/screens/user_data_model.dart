import 'package:flutter/foundation.dart';

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
    notifyListeners();
  }

  void updateField(String field, String newValue) {
    switch (field) {
      case 'Name':
        name = newValue;
        break;
      case 'Surname':
        surname = newValue;
        break;
      case 'Email':
        email = newValue;
        break;
      case 'Phone Number':
        phoneNumber = newValue;
        break;
    }
    notifyListeners();
  }
}
