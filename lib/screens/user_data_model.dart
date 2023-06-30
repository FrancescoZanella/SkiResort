import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String name = '';
  String surname = '';
  String email = '';
  String phoneNumber = '';

  void updateUser(
      {required String name,
      required String surname,
      required String email,
      required String phoneNumber}) {
    this.name = name;
    this.surname = surname;
    this.email = email;
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }
}
