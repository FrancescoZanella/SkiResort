import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'barcode_page.dart';

class ConnectSmartwatchScreen extends StatefulWidget {
  const ConnectSmartwatchScreen({super.key});

  @override
  State<ConnectSmartwatchScreen> createState() =>
      _ConnectSmartwatchScreenState();
}

class _ConnectSmartwatchScreenState extends State<ConnectSmartwatchScreen> {
  int _backendValue = 0;

  Future<int> _isPaired() async {
    //leggo da firebase in tabella se c'è association

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    // Controlla se la coppia userId e result esiste già nel database
    final url = Uri.https(
      'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
      '/pairs-table.json',
    );

    final response = await http.get(url);
    if (response.statusCode != 200) {
      return 2;
    }
    final data = json.decode(response.body);
    for (var entry in data.entries) {
      var val = entry.value;
      if (val['userid'] == userId) {
        return 0;
      }
    }

    return 2;
  }

  void changepage(int index) {
    setState(() {
      _backendValue = index;
    });
  }

  void _connectSmartwatch() async {
    //mi apre la pagina del qr code
    setState(() {
      _backendValue = 1;
    });
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
    String? userId = prefs.getString('userId');
    await deletepair(userId);
    setState(() {
      _backendValue = 2;
    });
  }

  @override
  void initState() {
    super.initState();
    _isPaired().then((value) {
      setState(() {
        _backendValue = value;
      });
    });
  }

  // 0 se è gia connesso
  // 2 se non è connesso
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _isPaired(),
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
          if (_backendValue == 0) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Disconnect the smartwatch"),
              ),
              body: Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Align children to the start of the column's main axis
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top:
                                50.0), // Add padding to move the image higher up
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
              ),
            );
          }
          if (_backendValue == 1) {
            return QRViewExample(
              callback: changepage,
            );
          } else {
            return Scaffold(
              appBar: AppBar(title: const Text("Connect your smartphone !")),
              body: Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top:
                                50.0), // Add padding to move the image higher up
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
                        child:
                            const Text('Connect the smartwatch with Qr Code'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
