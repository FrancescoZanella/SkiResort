import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/builder.dart';
// ignore: unused_import
import 'package:ski_resorts_app/phone/screens/loginAndRegistration/login/data_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ski_resorts_app/phone/screens/loginAndRegistration/registration/registration_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../APIloginAndSignin/facebook_auth.dart';
import '../APIloginAndSignin/google_auth.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscure = true;
  void _viewPassword() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: buildCard(context, size, _emailController, _passwordController,
          isPressed, _viewPassword, obscure),
    );
  }
}

Widget buildCard(
    BuildContext context,
    Size size,
    TextEditingController emailController,
    TextEditingController passwordController,
    bool isPressed,
    var callback,
    bool obscure) {
  return Container(
    alignment: Alignment.center,
    height: MediaQuery.sizeOf(context).height,
    width: MediaQuery.sizeOf(context).width,
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: size.height * 0.1,
          ),
          //welcome text
          Text(
            'Welcome Back!',
            style: GoogleFonts.inter(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            'Let’s login for explore your skiing progress',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: const Color(0xFF969AA8),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),

          //logo section
          logo(size.height / 12, size.height / 12),
          SizedBox(
            height: size.height * 0.02,
          ),
          richText(24),
          SizedBox(
            height: size.height * 0.03,
          ),

          //email textField
          Text(
            'Email or Phone Number',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          emailTextField(size, emailController),
          SizedBox(
            height: size.height * 0.02,
          ),

          //password textField
          Text(
            'Password',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          passwordTextField(size, passwordController, callback, obscure),
          SizedBox(
            height: size.height * 0.03,
          ),

          //sign in button
          signInButton(context, size, isPressed, callback, emailController.text,
              passwordController.text),
          SizedBox(
            height: size.height * 0.03,
          ),

          //we can connect text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: Divider()),
              const SizedBox(
                width: 16,
              ),
              Text(
                'We can Connect with',
                style: GoogleFonts.inter(
                  fontSize: 12.0,
                  color: const Color(0xFF969AA8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 16,
              ),
              const Expanded(child: Divider()),
            ],
          ),

          //footer section
          buildFooter(size, context),
        ],
      ),
    ),
  );
}

Widget logo(double height_, double width_) {
  return Image.asset(
    'lib/assets/logo/logo.png',
    height: height_,
    width: width_,
  );
}

Widget richText(double fontSize) {
  return Text.rich(
    TextSpan(
      style: GoogleFonts.inter(
        fontSize: fontSize,
        color: Colors.black, //const Color(0xFF21899C),
        letterSpacing: 2.0,
      ),
      children: const [
        TextSpan(
          text: 'SIGN-IN',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

Widget emailTextField(Size size, TextEditingController emailController) {
  return SizedBox(
    height: size.height / 13,
    child: TextField(
      controller: emailController,
      style: GoogleFonts.inter(
        fontSize: 18.0,
        color: const Color(0xFF151624),
      ),
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      cursorColor: const Color(0xFF151624),
      decoration: InputDecoration(
        hintText: 'Enter your email',
        hintStyle: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624).withOpacity(0.5),
        ),
        filled: true,
        fillColor: emailController.text.isEmpty
            ? const Color.fromRGBO(248, 247, 251, 1)
            : Colors.transparent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: emailController.text.isEmpty
                  ? Colors.transparent
                  : const Color.fromRGBO(44, 185, 176, 1),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color.fromRGBO(44, 185, 176, 1),
            )),
        prefixIcon: Icon(
          Icons.mail_outline_rounded,
          color: emailController.text.isEmpty
              ? const Color(0xFF151624).withOpacity(0.5)
              : const Color.fromRGBO(44, 185, 176, 1),
          size: 16,
        ),
        suffix: Container(
          alignment: Alignment.center,
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: const Color.fromRGBO(44, 185, 176, 1),
          ),
          child: emailController.text.isEmpty
              ? const Center()
              : const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 13,
                ),
        ),
      ),
    ),
  );
}

Widget passwordTextField(Size size, TextEditingController passController,
    var callback, bool obscure) {
  return Container(
    height: size.height / 13,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color.fromRGBO(248, 247, 251, 1),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            size: 16,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              controller: passController,
              style: GoogleFonts.inter(
                fontSize: 16.0,
                color: const Color(0xFF151624),
              ),
              cursorColor: const Color(0xFF151624),
              obscureText: obscure,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: const Color(0xFF151624).withOpacity(0.5),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          passController.text.isEmpty
              ? const Center()
              : Container(
                  color: const Color.fromRGBO(249, 225, 224, 1),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        callback();
                      },
                      child: Container(
                        height: 30,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color.fromRGBO(254, 152, 121, 1),
                            )),
                        child: Text(
                          'View',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 12.0,
                            color: const Color(0xFFFE9879),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    ),
  );
}

Widget signInButton(BuildContext context, size, bool isPressed, var callback,
    String email, String password) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C2E84).withOpacity(0.2),
            offset: const Offset(0, 15.0),
            blurRadius: 60.0,
          ),
        ],
      ),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () async {
                final getResponse = await http.get(url);
                // Flag to check if the user already exists
                bool userExists = false;

                //now  i check if there is a user with the same email and password
                if (getResponse.statusCode == 200) {
                  final decodedResponse =
                      json.decode(getResponse.body) as Map<String, dynamic>;
                  for (var entry in decodedResponse.entries) {
                    var user = entry.value;

                    if (user['email'] == email &&
                        user['password'] == password) {
                      userExists = true;
                      // Save the user's data to shared preferences
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                      await prefs.setString('userId', entry.key);
                      await prefs.setString('name', user['name']);
                      await prefs.setString('surname', user['surname']);
                      await prefs.setString('email', user['email']);
                      await prefs.setString('phoneNumber', user['phoneNumber']);
                      await prefs.setString('avatarPath', user['avatar']);
                      await prefs.setBool('paired', false);

                      break;
                    }
                  }
                }

                // get the user's data from shared preferences
                final prefs = await SharedPreferences.getInstance();
                if (userExists) {
                  // Navigate to the home page
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(
                          userId: prefs.getString('userId')!,
                          name: prefs.getString('name')!,
                          surname: prefs.getString('surname')!,
                          email: prefs.getString('email')!,
                          phoneNumber: prefs.getString('phoneNumber')!,
                          avatarPath: prefs.getString('avatarPath')!,
                        ),
                      ),
                    );
                  }
                } else {
                  if (context.mounted) {
                    // Show an error message with a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Incorrect email or password',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: size.height / 13,
                child: Text(
                  'Sign in',
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ))));
}

Widget buildFooter(Size size, BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        //social logo: facebook, google
        SizedBox(
          height: size.height * 0.05,
        ),
        SizedBox(
          width: size.width * 0.6,
          height: 44.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //google logo here
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: const Color.fromRGBO(246, 246, 246, 1)),
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 44.0,
                        height: 44.0,
                        child: IconButton(
                          icon: Image.asset(
                            'lib/assets/logo/google_logo.svg.png',
                          ),
                          iconSize: 23,
                          onPressed: () => {signInWithGoogle(context)},
                        ),
                      ),
                    )),
              ),
              //facebook logo here
            ],
          ),
        ),

        //footer text 'sign up' text here
        SizedBox(
          height: size.height * 0.03,
        ),
        Text.rich(
          TextSpan(
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: Colors.black,
            ),
            children: [
              const TextSpan(
                text: 'Don’t have an account? ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                  text: 'Sign Up here',
                  style: const TextStyle(
                    color: Color(0xFFFF7248),
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationPage(),
                          ));
                    }),
            ],
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
