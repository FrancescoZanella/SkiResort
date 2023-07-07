import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/loginOrSub/registration_screen_2.dart';
import 'package:ski_resorts_app/screens/builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import com.facebook.FacebookSdk;
//import com.facebook.appevents.AppEventsLogger;

class RegistrationScreen1 extends StatefulWidget {
  const RegistrationScreen1({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen1> createState() => _RegistrationScreen1State();
}

class _RegistrationScreen1State extends State<RegistrationScreen1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Firebase URL
  final url = Uri.https(
    'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
    '/user-table.json',
  );

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

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

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': userCredential.user!.displayName ??
              'Signed up with Google account',
          'surname': '',
          'email':
              userCredential.user!.email ?? 'Signed up with Google account',
          'phoneNumber': 'Signed up with Google account',
          'password': 'Signed up with Google account',
          'avatar': userCredential.user!.photoURL ?? '',
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to register user: ${response.body}');
      }

      if (kDebugMode) {
        print('User registered successfully');
      }

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
              userId: jsonDecode(response.body)['name'],
              name: userCredential.user!.displayName ??
                  'Signed up with Google account',
              surname: '',
              email:
                  userCredential.user!.email ?? 'Signed up with Google account',
              phoneNumber: 'Signed up with Google account',
              avatarPath: userCredential.user!.photoURL ?? '',
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

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents resizing when the keyboard appears
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid Name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _surnameController,
                  decoration: const InputDecoration(
                    labelText: 'Surname',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid Surname.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid Phone number.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // When validation is successful
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 50,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen2(
                            name: _nameController.text,
                            surname: _surnameController.text,
                            phoneNumber: _phoneNumberController.text,
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // Google Sign-In button
                ElevatedButton(
                  onPressed: _signInWithGoogle,
                  child: const Text('Sign Up with Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
