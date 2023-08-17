import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

Future<UserModel> checkUserLoginStatus() async {
  UserModel userModel = UserModel();

  User? firebaseUser = FirebaseAuth.instance.currentUser;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  if (firebaseUser != null || isLoggedIn) {
    // User logged in with firebase (Google or Email/Password)
    userModel.updateUser(
      userId: prefs.getString('userId') ?? '',
      name: prefs.getString('name') ?? '',
      surname: prefs.getString('surname') ?? '',
      email: prefs.getString('email') ?? '',
      phoneNumber: prefs.getString('phoneNumber') ?? '',
      avatarPath: prefs.getString('avatarPath') ?? '',
    );
  }
  return userModel;
}
