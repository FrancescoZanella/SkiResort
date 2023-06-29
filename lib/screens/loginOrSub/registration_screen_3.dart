//TODO -> THE POST REQUEST FOR REGISTRATION WORKS-> IMPLEMENT THE LOGIC AFTER THE CLICK ON THE BUTTON
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrationScreen3 extends StatefulWidget {
  final String name;
  final String surname;
  final String phoneNumber;
  final String email;
  final String password;

  const RegistrationScreen3({
    Key? key,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  State<RegistrationScreen3> createState() => _RegistrationScreen3State();
}

class _RegistrationScreen3State extends State<RegistrationScreen3> {
  final url = Uri.https(
    'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
    '/user-table.json',
  );

  Future<void> _registerUser() async {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': widget.name,
          'surname': widget.surname,
          'email': widget.email,
          'phoneNumber': widget.phoneNumber,
          'password': widget.password,
        },
      ),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('User registered successfully');
      }
    } else {
      throw Exception('Failed to register user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your UI for the final screen, can have a review of the details entered...
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${widget.name}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Surname: ${widget.surname}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Email: ${widget.email}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Phone Number: ${widget.phoneNumber}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Password: ${widget.password}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _registerUser();
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
