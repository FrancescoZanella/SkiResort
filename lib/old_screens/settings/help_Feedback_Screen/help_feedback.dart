import 'package:flutter/material.dart';

class HelpAndFeedbackPage extends StatelessWidget {
  const HelpAndFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Feedback'),
      ),
      body: const Center(
        child: Text(
          'This is the Help and Feedback page',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
