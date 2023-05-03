import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title, imagePath, mainText;

  const OnboardingPage({
    super.key,
    this.imagePath,
    this.mainText,
    this.title,
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
          ],
        ),
      ),
    ]);
  }
}
