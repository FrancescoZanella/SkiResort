import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../phone/screens/statistics/statistics_screen_1.dart';

class StatsItem extends StatelessWidget {
  const StatsItem({required this.data});

  final RunData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  "${data.distanceInMeters.toStringAsFixed(2)} km",
                  style: TextStyle(color: Colors.white),
                ),
                Text(data.date, style: TextStyle(color: Colors.white)),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
