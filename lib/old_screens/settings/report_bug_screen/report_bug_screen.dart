import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReportBugScreen extends StatefulWidget {
  const ReportBugScreen({super.key});

  @override
  State<ReportBugScreen> createState() => _ReportBugScreenState();
}

class _ReportBugScreenState extends State<ReportBugScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report a Bug'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Describe the bug here',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  } else if (value.length > 500) {
                    return 'Description is too long';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                child: const Text(
                  'Send Report',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Here we're just printing the bug report to the console.
                    // In your app, you'd probably want to send it somewhere more useful!
                    if (kDebugMode) {
                      print('Bug Report: ${_controller.text}');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
