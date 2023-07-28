import 'package:flutter/material.dart';

class ConnectSmartwatchScreen extends StatefulWidget {
  const ConnectSmartwatchScreen({Key? key}) : super(key: key);

  @override
  State<ConnectSmartwatchScreen> createState() =>
      _ConnectSmartwatchScreenState();
}

class _ConnectSmartwatchScreenState extends State<ConnectSmartwatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Smartwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .start, // Align children to the start of the column's main axis
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 50.0), // Add padding to move the image higher up
              child: Image.asset(
                'lib/assets/images/smartWatchImage.png', // Replace with your image url
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
                height:
                    50.0), // Increase space between the image and the button
            ElevatedButton(
              onPressed: () {
                // Implement the logic to connect to the selected device.
              },
              child: const Text('Connect Device'),
            ),
          ],
        ),
      ),
    );
  }
}
