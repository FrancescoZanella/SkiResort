import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConnectSmartwatchScreen extends StatefulWidget {
  const ConnectSmartwatchScreen({Key? key}) : super(key: key);

  @override
  State<ConnectSmartwatchScreen> createState() =>
      _ConnectSmartwatchScreenState();
}

class _ConnectSmartwatchScreenState extends State<ConnectSmartwatchScreen> {
  late Future<bool> _isConnected;

  Future<bool> _initializePaired() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('paired')!;
  }

  void _connectSmartwatch() async {
    //mi apre la pagina del qr code
    Navigator.of(context).pushNamed('/QrPage').then((value) => setState(() {
          _isConnected = _initializePaired();
        }));
  }

  Future<void> deletepair(String? userid) async {
    // Controlla se la coppia userId e result esiste già nel database
    final url = Uri.https(
      'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
      '/pairs-table.json',
    );

    final response = await http.get(url);
    String? key;

    final data = json.decode(response.body);
    for (var entry in data.entries) {
      var val = entry.value;
      if (val['userid'] == userid) {
        key = entry.key;
        FirebaseDatabase.instance
            .ref()
            .child('pairs-table')
            .child(key!)
            .remove();
      }
    }
  }

  void _disconnectSmartwatch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('paired', false);
    String? userId = prefs.getString('userId');
    setState(() {
      _isConnected = _initializePaired();
    });
    await deletepair(userId);
  }

  @override
  void initState() {
    super.initState();
    _isConnected = _initializePaired();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _isConnected,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Text("Error knowing if connected");
          }
          //se è gia paired
          if (snapshot.data!) {
            return Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Colors.white,
              child: Center(
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
                        // Implement the logic to disconnect to the selected device.
                        _disconnectSmartwatch();
                      },
                      child: const Text('Disconnect the smartwatch'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Align children to the start of the column's main axis
                  children: [
                    SizedBox(
                      width: 200,
                    ),
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
                        _connectSmartwatch();
                      },
                      child: const Text('Connect the smartwatch with Qr Code'),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

/*return Scaffold(
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
              child: const Text('Device Connected'),
            ),
          ],
        ),
      ),
    );*/
