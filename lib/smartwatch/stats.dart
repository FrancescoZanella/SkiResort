import 'package:flutter/material.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_screen_1.dart';
import 'package:ski_resorts_app/smartwatch/stats_item.dart';

import '../phone/screens/statistics/statistics_data.dart';

// ignore: must_be_immutable
class Stats extends StatefulWidget {
  String userId;
  Stats({super.key, required this.userId});

  @override
  StatsState createState() => StatsState();
}

//lo Stats retrieva il suo imei e controlla se presente in db
class StatsState extends State<Stats> {
  late Future<List<RunData>> stats;

  @override
  void initState() {
    super.initState();
    //load the stats
    stats = getStats(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: stats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Text("not found");
          }
          if (snapshot.data!.isNotEmpty) {}
          return GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 10) {
                Navigator.pop(
                  context,
                );
              }
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  // ignore: prefer_const_constructors
                  Text("Training logs",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var data = (snapshot.data!)[index];
                          return StatsItem(data: data);
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
