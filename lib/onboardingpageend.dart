import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageEnd extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title, imagePath, mainText;

  const OnboardingPageEnd({
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              scale: 0.60,
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
              ),
            ),
            SizedBox(
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
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 60),
            Container(
              height: 80,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.lightBlueAccent,
              ),
              child: Center(
                child: Text(
                  "Let's Start",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
