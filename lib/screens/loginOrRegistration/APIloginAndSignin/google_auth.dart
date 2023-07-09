import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:ski_resorts_app/screens/builder.dart';
import 'package:ski_resorts_app/screens/loginOrRegistration/registration_functions.dart';

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
    const phone = 'Signed up with Google account';

    final userId =
        await registerUser(name, surname, email, password, phone, avatar);

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            userId: userId ?? '',
            name: name,
            surname: '',
            email: email,
            phoneNumber: 'Signed up with Google account',
            avatarPath: avatar,
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
