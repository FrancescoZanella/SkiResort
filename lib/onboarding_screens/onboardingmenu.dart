import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ski_resorts_app/onboarding_screens/onboardingpage.dart';
import 'package:ski_resorts_app/navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:ski_resorts_app/constants/text_constants.dart';
import 'package:ski_resorts_app/constants/path_constants.dart';

class OnboardingMenu extends StatefulWidget {
  const OnboardingMenu({super.key});

  @override
  _OnboardingMenuState createState() => _OnboardingMenuState();
}

class _OnboardingMenuState extends State<OnboardingMenu> {
  bool _buttonPressed = false;
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 2.0, top: 8.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          animationDuration: Duration(milliseconds: 200),
                          minimumSize: Size(150, 50),
                          foregroundColor: Colors.blue,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationDrawerMenu()),
                        );
                      },
                      child: Text('Skip',
                          style:
                              TextStyle(decoration: TextDecoration.underline))))
            ],
          ),
          SizedBox(
            height: 600,
            child: PageView(
              controller: controller,
              children: <Widget>[
                OnboardingPage(
                  title: TextConstants.onboarding1Title,
                  mainText: TextConstants.onboarding1Description,
                  imagePath: PathConstants.onboarding1,
                ),
                OnboardingPage(
                  title: TextConstants.onboarding2Title,
                  mainText: TextConstants.onboarding2Description,
                  imagePath: PathConstants.onboarding2,
                ),
                OnboardingPage(
                  title: TextConstants.onboarding3Title,
                  mainText: TextConstants.onboarding3Description,
                  imagePath: PathConstants.onboarding3,
                  endButton: true,
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
                dotHeight: 25,
                dotWidth: 25),
          ),
        ],
      ),
    );
  }
}
