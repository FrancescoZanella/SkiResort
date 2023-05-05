import 'package:flutter/material.dart';

import '../navigation_drawer_menu/navigation_drawer_menu.dart';

// ignore: must_be_immutable
class OnboardingPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title, imagePath, mainText;
  bool endButton;

  OnboardingPage({
    super.key,
    required this.imagePath,
    required this.mainText,
    required this.title,
    this.endButton = false,

    //required this.changepage
  });
  // con widget padding ho un widget orizzontale simmetrico, largo 24
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              scale: 0.60,
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                //spaziatura del secondo paragrafo
                horizontal: screenWidth / 100,
              ),
              child: Text(
                mainText,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // only for the last page insert the button to Login/Register
            endButton
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(310, 55),
                            backgroundColor: Colors.blue,
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationDrawerMenu()),
                          );
                        },
                        child: const InkWell(
                          child: Text(
                            'Explore now',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )
                : const SizedBox(height: 0)
          ],
        ),
      ),
    ]);
  }
}
