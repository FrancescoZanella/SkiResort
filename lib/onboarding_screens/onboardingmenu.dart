import 'package:flutter/material.dart';
import 'package:ski_resorts_app/onboarding_screens/onboardingpageend.dart';
import 'package:ski_resorts_app/constants/data_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ski_resorts_app/onboarding_screens/onboardingpage.dart';
import 'package:ski_resorts_app/navigation_drawer_menu/navigation_drawer_menu.dart';

class OnboardingMenu extends StatefulWidget {
  @override
  _OnboardingMenuState createState() => _OnboardingMenuState();
}

class _OnboardingMenuState extends State<OnboardingMenu> {
  bool _buttonPressed = false;
  final PageController controller = PageController();

  void _skipToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigationDrawerMenu()),
    );
  }

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
              GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    _buttonPressed = true;
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    _buttonPressed = false;
                  });
                  _skipToLogin();
                },
                onTapCancel: () {
                  setState(() {
                    _buttonPressed = false;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(right: 20.0, top: 15.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: _buttonPressed ? 80.0 : 100.0,
                  height: 50.0,
                  child: const Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          ),
        ],
      ),
    );
  }
}
