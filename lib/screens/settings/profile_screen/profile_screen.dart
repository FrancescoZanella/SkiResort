import 'package:flutter/material.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  final String _name = 'John Doe';
  final String _email = 'johndoe@example.com';
  final String _phoneNumber = '+1 555-555-5555';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: Text('Name: $_name'),
              onTap: () {
                // TODO: Implement name editing
              },
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: Text('Email: $_email'),
              onTap: () {
                // TODO: Implement email editing
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: Text('Phone Number: $_phoneNumber'),
              onTap: () {
                // TODO: Implement phone number editing
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
