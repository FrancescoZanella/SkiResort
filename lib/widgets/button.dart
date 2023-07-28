import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/statistics/main_stats.dart';

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
          MaterialPageRoute(builder: (context) => const MainStats()),
        );
      },
      child: InkWell(
        child: Icon(icon),
      ),
    );
  }
}
