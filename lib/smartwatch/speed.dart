import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Speed extends StatelessWidget {
  String maxspeed;
  String avgspeed;
  Speed({super.key, required this.avgspeed, required this.maxspeed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 11,
                ),
                const Text("Speed",
                    style: TextStyle(color: Colors.white, fontSize: 19)),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Icon(Icons.speed, color: Colors.green),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        const Text("Max Speed",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 15)),
                        Text("$maxspeed km/h",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 19,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Icon(Icons.speed_rounded, color: Colors.red),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        const Text("Avg Speed",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 15)),
                        Text("$avgspeed km/h",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 10) {
            Navigator.pop(
              context,
            );
          }
        });
  }
}
