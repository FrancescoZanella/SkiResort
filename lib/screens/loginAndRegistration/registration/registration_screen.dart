import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/screens/builder.dart';
import 'package:ski_resorts_app/screens/loginAndRegistration/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
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
    _nameController.dispose();
    _surnameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: buildCard(
            context,
            size,
            _emailController,
            _passwordController,
            _nameController,
            _surnameController,
            _phoneNumberController,
            isPressed,
            _viewPassword,
            obscure),
      ),
    );
  }
}

Widget buildCard(
    BuildContext context,
    Size size,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController nameController,
    TextEditingController surnameController,
    TextEditingController phoneNumberController,
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
            height: size.height * 0.03,
          ),

          //welcome text
          Text(
            'Create an Account!',
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
            'Let’s create an account to have fun skiing',
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
          richText(22),
          SizedBox(
            height: size.height * 0.01,
          ),
          //name textField
          Text(
            'Name',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          nameTextField(size, nameController),
          SizedBox(
            height: size.height * 0.02,
          ),
          //surname textField
          Text(
            'Surname',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          surnameTextField(size, surnameController),
          SizedBox(
            height: size.height * 0.02,
          ),
          //phone textField
          Text(
            'Phone number',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          phoneTextField(size, phoneNumberController),
          SizedBox(
            height: size.height * 0.02,
          ),
          //email textField
          Text(
            'Email',
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
            height: size.height * 0.02,
          ),

          //sign in button
          signUpButton(
              context,
              size,
              isPressed,
              callback,
              emailController.text,
              passwordController.text,
              nameController.text,
              surnameController.text,
              phoneNumberController.text),
          SizedBox(
            height: size.height * 0.02,
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
          text: 'SIGN-UP',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

Widget nameTextField(Size size, TextEditingController nameController) {
  return SizedBox(
    height: size.height / 15,
    child: TextField(
      controller: nameController,
      style: GoogleFonts.inter(
        fontSize: 18.0,
        color: const Color(0xFF151624),
      ),
      maxLines: 1,
      keyboardType: TextInputType.name,
      cursorColor: const Color(0xFF151624),
      decoration: InputDecoration(
        hintText: 'Enter your name',
        hintStyle: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624).withOpacity(0.5),
        ),
        filled: true,
        fillColor: nameController.text.isEmpty
            ? const Color.fromRGBO(248, 247, 251, 1)
            : Colors.transparent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: nameController.text.isEmpty
                  ? Colors.transparent
                  : const Color.fromRGBO(44, 185, 176, 1),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color.fromRGBO(44, 185, 176, 1),
            )),
        prefixIcon: Icon(
          Icons.assignment_ind,
          color: nameController.text.isEmpty
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
          child: nameController.text.isEmpty
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

Widget surnameTextField(Size size, TextEditingController surnameController) {
  return SizedBox(
    height: size.height / 15,
    child: TextField(
      controller: surnameController,
      style: GoogleFonts.inter(
        fontSize: 18.0,
        color: const Color(0xFF151624),
      ),
      maxLines: 1,
      keyboardType: TextInputType.name,
      cursorColor: const Color(0xFF151624),
      decoration: InputDecoration(
        hintText: 'Enter your surname',
        hintStyle: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624).withOpacity(0.5),
        ),
        filled: true,
        fillColor: surnameController.text.isEmpty
            ? const Color.fromRGBO(248, 247, 251, 1)
            : Colors.transparent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: surnameController.text.isEmpty
                  ? Colors.transparent
                  : const Color.fromRGBO(44, 185, 176, 1),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color.fromRGBO(44, 185, 176, 1),
            )),
        prefixIcon: Icon(
          Icons.assignment_ind,
          color: surnameController.text.isEmpty
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
          child: surnameController.text.isEmpty
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

Widget phoneTextField(Size size, TextEditingController phoneNumberController) {
  return SizedBox(
    height: size.height / 15,
    child: TextField(
      controller: phoneNumberController,
      style: GoogleFonts.inter(
        fontSize: 18.0,
        color: const Color(0xFF151624),
      ),
      maxLines: 1,
      keyboardType: TextInputType.name,
      cursorColor: const Color(0xFF151624),
      decoration: InputDecoration(
        hintText: 'Enter your phone number',
        hintStyle: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624).withOpacity(0.5),
        ),
        filled: true,
        fillColor: phoneNumberController.text.isEmpty
            ? const Color.fromRGBO(248, 247, 251, 1)
            : Colors.transparent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: phoneNumberController.text.isEmpty
                  ? Colors.transparent
                  : const Color.fromRGBO(44, 185, 176, 1),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color.fromRGBO(44, 185, 176, 1),
            )),
        prefixIcon: Icon(
          Icons.phone_android,
          color: phoneNumberController.text.isEmpty
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
          child: phoneNumberController.text.isEmpty
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

Widget emailTextField(Size size, TextEditingController emailController) {
  return SizedBox(
    height: size.height / 15,
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
    height: size.height / 15,
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

Widget signUpButton(BuildContext context, size, bool isPressed, var callback,
    String email, String password, String name, String surname, String phone) {
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
                // Before posting a new user, check if the user already exists
                final getResponse = await http.get(url);

                final decodedResponse =
                    json.decode(getResponse.body) as Map<String, dynamic>;

                // Flag to check if the user already exists
                bool userExists = false;

                for (var entry in decodedResponse.entries) {
                  var user = entry.value;

                  if (user['email'] == email || user['phoneNumber'] == phone) {
                    userExists = true;
                    break; // Exit the loop once a match is found
                  }
                }

                if (userExists) {
                  if (context.mounted) {
                    // If the user already exists, show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'User already exists',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else {
                  // if the user doesn't exist, post the user's data to the database

                  final response = await http.post(
                    url,
                    headers: {'Content-Type': 'application/json'},
                    body: json.encode(
                      {
                        'name': name,
                        'surname': surname,
                        'email': email,
                        'phoneNumber': phone,
                        'password': password,
                        'avatar': 'lib/assets/images/avatar9.jpg',
                      },
                    ),
                  );

                  if (response.statusCode == 200) {
                    if (kDebugMode) {
                      print('User registered successfully');
                    }

                    // Save the user's data to shared preferences
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', true);
                    await prefs.setString(
                        'userId', jsonDecode(response.body)['name']);
                    await prefs.setString('name', name);
                    await prefs.setString('surname', surname);
                    await prefs.setString('email', email);
                    await prefs.setString('phoneNumber', phone);
                    await prefs.setString(
                        'avatarPath', 'lib/assets/images/avatar9.jpg');

                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(
                            userId: jsonDecode(response.body)['name'],
                            name: name,
                            surname: surname,
                            email: email,
                            phoneNumber: phone,
                            avatarPath: 'lib/assets/images/avatar9.jpg',
                          ),
                        ),
                      ); // Redirect to home page
                    }
                  } else {
                    throw Exception('Failed to register user');
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: size.height / 15,
                child: Text(
                  'Sign up',
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
        //footer text 'sign up' text here
        Text.rich(
          TextSpan(
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: Colors.black,
            ),
            children: [
              const TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                  text: 'Sign in here',
                  style: const TextStyle(
                    color: Color(0xFFFF7248),
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ), // Redirect to home page
                      );
                    }),
            ],
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
