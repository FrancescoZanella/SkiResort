import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/loginOrRegistration/login_screen.dart';
import 'package:ski_resorts_app/screens/loginOrRegistration/registrationScreens/registration_screen_1.dart';
import 'package:ski_resorts_app/screens/loginOrRegistration/APIloginAndSignin/google_auth.dart'; // this is my class
import 'package:ski_resorts_app/screens/loginOrRegistration/APIloginAndSignin/facebook_auth.dart'; // this is my class

// Firebase URL
final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

class LoginAndSubscriptionPage extends StatelessWidget {
  const LoginAndSubscriptionPage({super.key});

  void _onGithubLoginButtonPressed() {
    // implement Github login functionality here
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () => signInWithGoogle(context),
                  ),
                  IconButton(
                    icon: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png'),
                    iconSize: 50,
                    onPressed: () => onFacebookLoginButtonPressed(context),
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
