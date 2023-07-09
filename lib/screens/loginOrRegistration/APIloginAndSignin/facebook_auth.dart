import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:ski_resorts_app/screens/builder.dart';
import 'package:ski_resorts_app/screens/loginOrRegistration/registration_functions.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

void onFacebookLoginButtonPressed(BuildContext context) async {
  final LoginResult result = await FacebookAuth.instance.login();

  if (result.status == LoginStatus.success) {
    // you are logged
    final AccessToken accessToken = result.accessToken!;
    final OAuthCredential credential =
        FacebookAuthProvider.credential(accessToken.token);
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final name =
        userCredential.user!.displayName ?? 'Signed up with Facebook account';
    final email =
        userCredential.user!.email ?? 'Signed up with Facebook account';
    final avatar =
        userCredential.user!.photoURL ?? 'lib/assets/images/avatar9.jpg';
    const surname = '';
    const password = 'Signed up with Facebook account';
    const phone = 'Signed up with Facebook account';

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
            phoneNumber: 'Signed up with Facebook account',
            avatarPath: avatar,
          ),
        ),
      );
    }
  }
}
