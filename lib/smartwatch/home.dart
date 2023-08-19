import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

class SmartWatch extends StatefulWidget {
  const SmartWatch({Key? key}) : super(key: key);

  @override
  SmartWatchState createState() => SmartWatchState();
}

//lo smartwatch retrieva il suo imei e controlla se presente in db
class SmartWatchState extends State<SmartWatch> {
  late Future<bool?> ispaired;
  late Future<String?> androidId;

  @override
  void initState() {
    super.initState();
    ispaired = checkIfPaired();
    androidId = initializeId();
  }

  Future<String> initializeId() async {
    String? identifier = await UniqueIdentifier.serial;
    return identifier!;
  }

  Future<bool> checkIfPaired() async {
    try {
      /*mi collego a firebase e vedo se c'è associazione*/

      final url = Uri.https(
        'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
        '/pairs-table.json',
      );
      final response = await http.get(url);
      String? identifier = await UniqueIdentifier.serial;

      if (response.statusCode == 200) {
        Map<String, dynamic> stats = jsonDecode(response.body);

        for (var entry in stats.entries) {
          var pair = entry.value;
          // if the stat is one of the user
          if (pair['mac'] == identifier) {
            //add the stats to the list
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('userId', pair['userid']);
            return true;
          }
        }

        return false;
      } else {
        // If the server returns an error, handle i
        throw Exception("error");
      }
    } catch (e) {
      // Handle any errors that might occur during initialization
      throw Exception("unable to connect to firebase");
    }
  }

  Widget buildqrcode(String? androidId) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Center(
                child: Text(
                    "Scan this qr with the smartphone app to pair the device"),
              )),
          Center(
            child: QrImageView(data: androidId!, size: 100),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ElevatedButton(child: const Text("Fatto"), onPressed: () {}),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([ispaired, androidId]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Scaffold(body: Center(child: Text("not found")));
          }
          //if it's paired
          if (snapshot.data != null) {
            //se
            if (snapshot.data![0] as bool) {
              return const Scaffold(
                  body: Center(
                child: Text("Hello World"),
              ));
            } else {
              return buildqrcode(snapshot.data?[1] as String);
            }
          } else {
            return const Scaffold(body: Center(child: Text("not found")));
          }
        });
  }
}
