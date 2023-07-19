import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:ski_resorts_app/screens/builder.dart';
import 'package:ski_resorts_app/screens/loginOrRegistration/registration/registration_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

// Google Sign-In instance
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('Google Sign In was aborted');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final name =
        userCredential.user!.displayName ?? 'Signed up with Google account';
    final email = userCredential.user!.email ?? 'Signed up with Google account';
    final avatar =
        userCredential.user!.photoURL ?? 'lib/assets/images/avatar9.jpg';
    const surname = '';
    const password = 'Signed up with Google account';
    const phoneNumber = 'Signed up with Google account';

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
  } catch (e) {
    if (kDebugMode) {
      print('Google Sign In error: $e');
    } // Log the error
  }
}
