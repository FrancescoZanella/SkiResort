import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/smartwatch/qr_page.dart';
import 'package:ski_resorts_app/smartwatch/watchstast.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SmartWatch extends StatefulWidget {
  const SmartWatch({Key? key}) : super(key: key);

  @override
  SmartWatchState createState() => SmartWatchState();
}

//lo smartwatch retrieva il suo imei e controlla se presente in db
class SmartWatchState extends State<SmartWatch> {
  late Future<bool> ispaired;
  late Future<String?> androidId;
  late Future<String?> userid;

  @override
  void initState() {
    super.initState();
    ispaired = checkIfPaired(); // false -- true
    androidId = initializeId(); // id -- id // null -- francesco
    userid = initializeUserId();
  }

  // userid is null if not yet paired
  Future<String?> initializeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<String?> initializeId() async {
    return await UniqueIdentifier.serial;
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([ispaired, androidId, userid]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Scaffold(body: Center(child: Text("error")));
            } else {
              if (snapshot.hasData) {
                //if it's paired
                if (snapshot.data![0] != null && snapshot.data![0] == true) {
                  var screenSize = MediaQuery.of(context).size;
                  screenSize = Size(1.4142 * screenSize.width / 2,
                      1.4142 * screenSize.height / 2);
                  var screenHeight = screenSize.height;
                  var screenWidth = screenSize.width;
                  return Prova(
                    userId: snapshot.data![2] as String,
                    width: screenWidth,
                    height: screenHeight,
                  );
                } else {
                  return QrPage(
                      androidId: snapshot.data![1] as String,
                      ispaired: snapshot.data![0] as bool);
                }
              } else {
                return const Scaffold(
                    body: Center(child: Text("no data loaded")));
              }
            }
          }
        });
  }
}
