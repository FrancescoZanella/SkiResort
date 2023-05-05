import 'package:flutter/material.dart';

class FitnessButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final Function() onTap;
  final height;
  final width;

  FitnessButton(
      {required this.width,
      required this.height,
      required this.title,
      this.isEnabled = true,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isEnabled ? Color(0xFF6358E1) : Color(0xFFE1E1E5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
