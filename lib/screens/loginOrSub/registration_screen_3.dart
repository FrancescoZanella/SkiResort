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
  int selectedAvatar = 0;

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
          'avatar': 'lib/assets/images/avatar${selectedAvatar + 1}.jpg',
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

  void _avatarClicked(int index) {
    setState(() {
      selectedAvatar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(9, (index) {
                return GestureDetector(
                  onTap: () => _avatarClicked(index),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedAvatar == index
                            ? Colors.red
                            : Colors.transparent,
                        width: 2.0,
                      ),
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            'lib/assets/images/avatar${index + 1}.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Register'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
