import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> logoutUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  prefs.setBool('isLoggedIn', false);
}

Future<void> logoutGoogleUser() async {
  final googleSignIn = GoogleSignIn();
  if (await googleSignIn.isSignedIn()) {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
  await logoutUser();
}
