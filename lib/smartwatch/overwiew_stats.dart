import 'package:flutter/material.dart';

import '../phone/screens/statistics/statistics_screen_1.dart';
import 'speed.dart';

// ignore: must_be_immutable
class Overview extends StatelessWidget {
  RunData data;

  Overview({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 10) {
          Navigator.pop(
            context,
          );
        } else if (details.primaryVelocity! < -10) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Speed(
                      avgspeed: data.averageSpeed.toStringAsFixed(2),
                      maxspeed: data.maxSpeed.toStringAsFixed(2),
                    )),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 11,
              ),
              const Text("General",
                  style: TextStyle(color: Colors.white, fontSize: 19)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 57,
                  ),
                  const Icon(Icons.route, color: Colors.green),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      const Text("Distance",
                          style:
                              TextStyle(color: Colors.white54, fontSize: 15)),
                      Text("${data.distanceInMeters.toStringAsFixed(2)} km",
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
                  const Icon(Icons.watch_later_outlined, color: Colors.blue),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      const Text("Duration",
                          style:
                              TextStyle(color: Colors.white54, fontSize: 15)),
                      Text(data.formattedTime,
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
                    width: 20,
                  ),
                  const Icon(Icons.date_range, color: Colors.red),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Date",
                          style:
                              TextStyle(color: Colors.white54, fontSize: 15)),
                      Text(data.date,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
