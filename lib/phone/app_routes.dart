// this filedefines all the routes in the app; when i click on a button, i want to go to a specific page.
// The route of the page is defined here; so in every file i can call the route of the page i want to go to
import 'package:flutter/material.dart';
import 'package:ski_resorts_app/phone/screens/settings/settings_page_screen.dart';
import 'package:ski_resorts_app/phone/screens/settings/about_us_screen/about_us_screen.dart';
import 'package:ski_resorts_app/phone/screens/settings/position_handler_screen/position_handler_screen.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/profile_screen.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/ski_resort_screen.dart';
import 'package:ski_resorts_app/phone/screens/loginAndRegistration/login/login_screen.dart';
import 'package:ski_resorts_app/phone/screens/onboarding/onboardingmenu.dart';
import 'package:ski_resorts_app/phone/screens/settings/report_bug_screen/report_bug_screen.dart';
import 'package:ski_resorts_app/phone/screens/settings/rate_our_app_screen/rate_our_app_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/AboutUsPage': (BuildContext context) => const AboutUsPage(),
  '/LocationSettingScreen': (BuildContext context) =>
      const LocationSettingScreen(),
  '/ProfilePageScreen': (BuildContext context) => const ProfilePageScreen(),
  '/SettingsPage': (BuildContext context) => const SettingsPage(),
  '/SkiResortScreen': (BuildContext context) => const SkiResortScreen(),
  '/LoginPage': (BuildContext context) => const LoginPage(),
  '/OnboardingMenu': (BuildContext context) => const OnboardingMenu(),
  '/ReportBugScreen': (BuildContext context) => const ReportBugScreen(),
  '/RateOurAppScreen': (BuildContext context) => const RateOurAppScreen(),
};
