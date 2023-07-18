import 'package:flutter/material.dart';

import '../old_screens/statistics/user_statistic_screen.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Color color;
  IconData icon;

  Button({
    Key? key,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(45, 45),
        backgroundColor: color,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StatisticsScreen()),
        );
      },
      child: InkWell(
        child: Icon(icon),
      ),
    );
  }
}
