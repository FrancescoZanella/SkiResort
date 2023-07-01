import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ski_resorts_app/screens/onboarding/onboardingpage.dart';
import 'package:ski_resorts_app/constants/text_constants.dart';
import 'package:ski_resorts_app/constants/path_constants.dart';
import 'package:ski_resorts_app/screens/builder.dart';
import 'package:ski_resorts_app/screens/loginOrSub/login_and_subscription_screen.dart';

class OnboardingMenu extends StatefulWidget {
  const OnboardingMenu({super.key});

  @override
  State<OnboardingMenu> createState() => _OnboardingMenuState();
}

class _OnboardingMenuState extends State<OnboardingMenu> {
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
                      animationDuration: const Duration(milliseconds: 200),
                      minimumSize: const Size(150, 50),
                      foregroundColor: Colors.blue,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      )),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginAndSubscriptionPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2.0, top: 8.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                      animationDuration: const Duration(milliseconds: 200),
                      minimumSize: const Size(150, 50),
                      foregroundColor: Colors.blue,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      )),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(
                            name: 'pippo',
                            surname: 'lacoca',
                            email: 'pippo@lacoca.com',
                            phoneNumber: '3203229036',
                            avatarPath: 'lib/assets/images/avatar9.jpg',
                          ), // Replace with the actual page
                        ),
                      );
                    },
                    child: const Text(
                      'Skip Login Screen',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ),
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
