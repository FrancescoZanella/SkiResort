// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyCard extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var image;
  var height;
  var width;
  var title;
  MyCard(
      {super.key,
      required this.height,
      required this.width,
      required this.image,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 30.0,
                  offset: const Offset(10, 15))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: width,
                    height: height,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: height * 0.8,
                      left: width * 0.10,
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
