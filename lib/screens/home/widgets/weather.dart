// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Weather extends StatelessWidget {
  var height;
  var width;
  var title;
  Weather(
      {super.key,
      required this.height,
      required this.width,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(7, 22, 66, 1), //Color(0x001e59),
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 30.0,
                    offset: const Offset(10, 15),
                  ),
                ],
              ),
            ),
            Positioned(
                top: height * 0.7,
                left: width * 0.10,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                )),
            Positioned(
                top: height * 0.15,
                left: width * 0.10,
                child: const Text(
                  'Milano',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                )),
            Positioned(
                top: height * 0.35,
                left: width * 0.10,
                child: const Text(
                  '-10°',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 35),
                )),
            Positioned(
                top: height * 0.15,
                right: width * 0.15,
                child: const Icon(
                  Icons.cloud,
                  color: Colors.white,
                )),
          ],
        )
      ],
    );
  }
}
