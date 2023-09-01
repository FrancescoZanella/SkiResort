import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ski_resorts_app/smartwatch/qr_page.dart';
import 'package:ski_resorts_app/smartwatch/stats.dart';
import 'package:unique_identifier/unique_identifier.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

// ignore: must_be_immutable
class Prova extends StatefulWidget {
  String userId;
  double height;
  double width;

  Prova(
      {super.key,
      required this.height,
      required this.width,
      required this.userId});

  @override
  State<Prova> createState() => ProvaState();
}

class ProvaState extends State<Prova> {
  late Future<String?> name;

  @override
  void initState() {
    super.initState();
    name = getName(widget.userId);
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

  Future<String?> getName(String userId) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> stats = jsonDecode(response.body);
      String? name;
      for (var key in stats.keys) {
        if (key == userId) {
          name = stats[key]['name'];
        }
      }
      return name;
    } else {
      // If the server returns an error, handle i
      throw Exception("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 10) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Scaffold(
                        body:
                            Center(child: Text('Contenuto della su pagina')))));
          } else if (details.primaryVelocity! < -10) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Stats(userId: widget.userId)),
            );
          }
        },
        child: FutureBuilder(
            future: name,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Text("not found");
              }
              if (snapshot.data!.isNotEmpty) {
                return Scaffold(
                    backgroundColor: Colors.black,
                    body: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 22,
                          ),
                          const Text("Welcome to SkiSage",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text("${snapshot.data!}!",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Stats(
                                                  userId: snapshot.data!,
                                                )),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        fixedSize: const Size(40, 40),
                                        backgroundColor: Colors.orange[400]),
                                    child: const Icon(Icons.calendar_month)),
                              ),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      String? id =
                                          await UniqueIdentifier.serial;
                                      deletepair(widget.userId);
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QrPage(
                                                  androidId: id,
                                                  ispaired: false,
                                                )),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        fixedSize: const Size(40, 40),
                                        backgroundColor: Colors.blue[400]),
                                    child: const Icon(Icons.logout_outlined)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Image.asset(
                            'lib/assets/logo/logo.png',
                            height: 40,
                            width: 60,
                          )
                        ],
                      ),
                    ));
              }
              return const Text("not found");
            }));
  }
}
