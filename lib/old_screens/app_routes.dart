// this filedefines all the routes in the app; when i click on a button, i want to go to a specific page.
// The route of the page is defined here; so in every file i can call the route of the page i want to go to
import 'package:flutter/material.dart';
import 'package:ski_resorts_app/old_screens/statistics/user_statistic_screen.dart';
import 'package:ski_resorts_app/old_screens/settings/settings_page_screen.dart';
import 'package:ski_resorts_app/old_screens/settings/about_us_screen/about_us_screen.dart';
import 'package:ski_resorts_app/old_screens/settings/notification_handler_screen/notification_handler_screem.dart';
import 'package:ski_resorts_app/old_screens/settings/position_handler_screen/position_handler_screen.dart';
import 'package:ski_resorts_app/old_screens/settings/profile_screen/profile_screen.dart';
import 'package:ski_resorts_app/old_screens/favorites/favorites_screen.dart';
import 'package:ski_resorts_app/screens/skiResort/ski_resort_screen.dart';
import 'package:ski_resorts_app/screens/loginAndRegistration/login/login_screen.dart';
import 'package:ski_resorts_app/screens/onboarding/onboardingmenu.dart';
import 'package:ski_resorts_app/old_screens/settings/report_bug_screen/report_bug_screen.dart';
import 'package:ski_resorts_app/old_screens/settings/rate_our_app_screen/rate_our_app_screen.dart';
import 'package:ski_resorts_app/old_screens/settings/connect_smartwatch/connect_smartwatch_screen.dart';
import 'package:ski_resorts_app/screens/weather/Screens/weatherScreen.dart';
import 'package:ski_resorts_app/screens/weather/Screens/hourlyWeatherScreen.dart';
import 'package:ski_resorts_app/screens/weather/Screens/weeklyWeatherScreen.dart';

final Map<String, WidgetBuilder> routes = {
  '/NotificationSettingScreen': (BuildContext context) =>
      const NotificationSettingScreen(),
  '/AboutUsPage': (BuildContext context) => const AboutUsPage(),
  '/LocationSettingScreen': (BuildContext context) =>
      const LocationSettingScreen(),
  '/ProfilePageScreen': (BuildContext context) => const ProfilePageScreen(),
  '/StatisticsScreen': (BuildContext context) => const StatisticsScreen(),
  '/SettingsPage': (BuildContext context) => const SettingsPage(),
  '/FavoritesScreen': (BuildContext context) => const FavoritesScreen(),
  '/SkiResortScreen': (BuildContext context) => const SkiResortScreen(),
  '/LoginPage': (BuildContext context) => const LoginPage(),
  '/OnboardingMenu': (BuildContext context) => const OnboardingMenu(),
  '/ReportBugScreen': (BuildContext context) => const ReportBugScreen(),
  '/RateOurAppScreen': (BuildContext context) => const RateOurAppScreen(),
  '/ConnectSmartwatchScreen': (BuildContext context) =>
      const ConnectSmartwatchScreen(),
  '/WeatherScreen': (BuildContext context) => const WeatherScreen(),
  '/WeeklyScreen': (BuildContext context) => const WeeklyScreen(),
  '/HourlyScreen': (BuildContext context) => const HourlyScreen(),
};
