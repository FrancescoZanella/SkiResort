import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/smartwatch/watchstast.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:wear/wear.dart';

// ignore: must_be_immutable
class QrPage extends StatefulWidget {
  String? androidId;
  bool ispaired;

  QrPage({super.key, required this.androidId, required this.ispaired});
  @override
  State<StatefulWidget> createState() => QrPageState();
}

class QrPageState extends State<QrPage> {
  Future<void> checkIfPaired() async {
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
            setState(() {
              widget.ispaired = true;
            });
            return;
          }
        }
        setState(() {
          widget.ispaired = false;
        });
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: WatchShape(builder: (context, shape, child) {
        var screenSize = MediaQuery.of(context).size;
        final shape = WatchShape.of(context);
        if (shape == WearShape.round) {
          // boxInsetLength requires radius, so divide by 2
          screenSize = Size(
              1.4142 * screenSize.width / 2, 1.4142 * screenSize.height / 2);
        }
        var screenHeight = screenSize.height;
        var screenWidth = screenSize.width;

        return Center(
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("Scan the qr with the smartphone",
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                const Center(
                  child: Text(
                    "app to pair the device",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                    child: QrImageView(
                  data: widget.androidId!,
                  size: 100,
                )),
                SizedBox(
                  height: screenHeight * 0.05,
                  width: 0.00001,
                ),
                SizedBox(
                  height: screenHeight * 0.16,
                  width: screenWidth * 0.35,
                  child: ElevatedButton(
                      child: const Text(
                        "Done",
                        style: TextStyle(fontSize: 10),
                      ),
                      onPressed: () async {
                        await checkIfPaired();
                        //se è collegato dopo che ho schiacciato done
                        if (widget.ispaired) {
                          //recupero userid
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? s = prefs.getString('userId');
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Prova(
                                    userId: s!,
                                    height: screenHeight,
                                    width: screenWidth),
                              ));
                        }
                        // se ha schiacciato done ma in realtà non era collegato
                        else {
                          //snackbar visualized
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(child: Text("Retry!")),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
