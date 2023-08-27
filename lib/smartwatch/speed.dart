import 'package:flutter/material.dart';

class Speed extends StatelessWidget {
  String maxspeed;
  String avgspeed;
  Speed({required this.avgspeed, required this.maxspeed});

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
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 57,
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
                        Text("${maxspeed} km/h",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 55,
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
                        Text("${avgspeed} km/h",
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
