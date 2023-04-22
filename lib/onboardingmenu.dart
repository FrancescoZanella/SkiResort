import 'package:flutter/material.dart';
import 'package:ski_resorts_app/onboardingpage.dart';
import 'package:ski_resorts_app/constants/data_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ski_resorts_app/onboardingpageend.dart';

class OnboardingMenu extends StatelessWidget {
  OnboardingMenu({super.key});
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            height: 600,
            child: PageView(
              controller: controller,
              children: <Widget>[
                OnboardingPage(
                  imagePath: DataConstants.onboardingTiles[0].imagePath,
                  mainText: DataConstants.onboardingTiles[0].mainText,
                  title: DataConstants.onboardingTiles[0].title,
                ),
                OnboardingPage(
                  imagePath: DataConstants.onboardingTiles[1].imagePath,
                  mainText: DataConstants.onboardingTiles[1].mainText,
                  title: DataConstants.onboardingTiles[1].title,
                ),
                OnboardingPageEnd(
                  imagePath: DataConstants.onboardingTiles[2].imagePath,
                  mainText: DataConstants.onboardingTiles[2].mainText,
                  title: DataConstants.onboardingTiles[2].title,
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: JumpingDotEffect(
                activeDotColor: Colors.lightBlueAccent,
                dotColor: Colors.lightBlueAccent.withOpacity(0.5),
                dotHeight: 30,
                dotWidth: 30),
          )
        ]));
  }
}
