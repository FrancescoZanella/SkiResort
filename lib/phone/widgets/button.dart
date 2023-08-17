import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Color color;
  IconData icon;
  Function callback;

  Button({
    Key? key,
    required this.color,
    required this.icon,
    required this.callback,
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
        callback(1);
      },
      child: InkWell(
        child: Icon(icon),
      ),
    );
  }
}
