import 'package:flutter/material.dart';
import 'package:ski_resorts_app/smartwatch/overwiew_stats.dart';

import '../phone/screens/statistics/statistics_screen_1.dart';

class StatsItem extends StatelessWidget {
  const StatsItem({super.key, required this.data});

  final RunData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Card(
          color: Colors.black,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'lib/assets/icons/output.png',
                  height: 22, // Adjust the image size as needed
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    "${data.distanceInMeters.toStringAsFixed(2)} m",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(data.date, style: const TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Overview(
                      data: data,
                    )),
          );
        },
      ),
    );
  }
}
