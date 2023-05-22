import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromRGBO(12, 56, 177, 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 15.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(80.0 / 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(80.0 / 20),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(80.0 / 8),
                            child: Center(
                                child: Transform.scale(
                              scale: 1.5,
                              child: const CircleAvatar(
                                backgroundImage: AssetImage(
                                  'lib/assets/images/profile.jpg',
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Francesco Zanella',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            '5',
                            style: TextStyle(color: Colors.black, fontSize: 8),
                          ),
                        ),
                      )
                    ],
                  ),
                  Transform(
                    transform: Matrix4.rotationY(math.pi),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.sort_rounded,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
