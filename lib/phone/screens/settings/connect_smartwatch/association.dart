import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connect_smartwatch_screen.dart';

class ResultPage extends StatelessWidget {
  final String? scanResult;

  const ResultPage({required this.scanResult, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smartwatch paired correctly')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                child: Text('Smartwatch ${scanResult!} paired correctly'),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('paired', true);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ConnectSmartwatchScreen(),
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
