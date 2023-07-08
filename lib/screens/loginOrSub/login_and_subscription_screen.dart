import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ski_resorts_app/screens/loginOrSub/login_screen.dart';
import 'package:ski_resorts_app/screens/loginOrSub/registration_screen_1.dart';
import 'package:ski_resorts_app/screens/builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Firebase URL
final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

class LoginAndSubscriptionPage extends StatelessWidget {
  const LoginAndSubscriptionPage({super.key});

  void _onFacebookLoginButtonPressed() {
    // implement Facebook login functionality here
  }

  void _onGithubLoginButtonPressed() {
    // implement Github login functionality here
  }

  @override
  Widget build(BuildContext context) {
    // Google Sign-In instance
    final GoogleSignIn googleSignIn = GoogleSignIn();

    Future<void> signInWithGoogle() async {
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
        final email =
            userCredential.user!.email ?? 'Signed up with Google account';
        final avatar =
            userCredential.user!.photoURL ?? 'lib/assets/images/avatar9.jpg';

        final getResponse = await http.get(
          Uri.https(
            'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
            '/user-table.json',
          ),
        );

        if (getResponse.statusCode != 200) {
          throw Exception('Failed to retrieve users: ${getResponse.body}');
        }

        final users = Map<String, dynamic>.from(json.decode(getResponse.body));
        bool userExists = false;
        String? userId;

        for (final entry in users.entries) {
          if (entry.value['name'] + entry.value['surname'] == name &&
              entry.value['email'] == email) {
            userExists = true;
            userId = entry.key; // save the Firebase ID
            break;
          }
        }

        if (!userExists) {
          final postResponse = await http.post(
            Uri.https(
              'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
              '/user-table.json',
            ),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'name': name,
              'surname': '',
              'phoneNumber': 'Signed up with Google account',
              'password': 'Signed up with Google account',
              'avatar': avatar,
            }),
          );

          if (postResponse.statusCode != 200) {
            throw Exception('Failed to register user: ${postResponse.body}');
          }

          userId = jsonDecode(
              postResponse.body)['name']; // use the returned Firebase ID
        }

        if (kDebugMode) {
          print('User registered successfully');
        }

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.network(
                'https://thumbs.dreamstime.com/z/plantilla-gr%C3%A1fica-blanco-y-negro-del-logotipo-de-las-gafas-del-esqu%C3%AD-de-la-monta%C3%B1a-82893493.jpg',
                height: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationScreen1(),
                    ),
                  );
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 1,
                    ),
                  ),
                  Text(
                    ' or continue with ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2008px-Google_%22G%22_Logo.svg.png'),
                    iconSize: 50,
                    onPressed: signInWithGoogle,
                  ),
                  IconButton(
                    icon: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png'),
                    iconSize: 50,
                    onPressed: _onFacebookLoginButtonPressed,
                  ),
                  IconButton(
                    icon: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/25/25231.png'),
                    iconSize: 50,
                    onPressed: _onGithubLoginButtonPressed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
