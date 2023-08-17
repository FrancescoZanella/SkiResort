import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:ski_resorts_app/phone/screens/builder.dart';
import 'package:ski_resorts_app/phone/screens/loginAndRegistration/registration/data_registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

void onFacebookLoginButtonPressed(BuildContext context) async {
  final LoginResult result = await FacebookAuth.instance.login(
    permissions: const ['email', 'public_profile'],
  );

  final AccessToken accessToken = result.accessToken!;
  final OAuthCredential credential =
      FacebookAuthProvider.credential(accessToken.token);
  final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

  final userData = await FacebookAuth.instance.getUserData();

  final name =
      userCredential.user!.displayName ?? 'Signed up with Facebook account';
  final email = userData["email"] ?? 'Signed up with Facebook account';
  final avatar =
      userCredential.user!.photoURL ?? 'lib/assets/images/avatar9.jpg';
  const surname = '';
  const password = 'Signed up with Facebook account';
  const phoneNumber = 'Signed up with Facebook account';

  final user =
      await registerUser(name, surname, email, password, phoneNumber, avatar);

  // Save the user's data to shared preferences
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', true);
  await prefs.setString('userId', user?['userId'] ?? '');
  await prefs.setString('name', user?['name'] ?? '');
  await prefs.setString('surname', user?['surname'] ?? '');
  await prefs.setString('email', user?['email'] ?? '');
  await prefs.setString('phoneNumber', user?['phoneNumber'] ?? '');
  await prefs.setString('avatarPath', user?['avatar'] ?? '');

  if (context.mounted) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          userId: user?['userId'] ?? '',
          name: user?['name'] ?? '',
          surname: user?['surname'] ?? '',
          email: user?['email'] ?? '',
          phoneNumber: user?['phoneNumber'] ?? '',
          avatarPath: user?['avatar'] ?? '',
        ),
      ),
    );
  }
}
