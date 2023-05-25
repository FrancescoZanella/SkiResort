// this filedefines all the routes in the app; when i click on a button, i want to go to a specific page.
// The route of the page is defined here; so in every file i can call the route of the page i want to go to
import 'package:flutter/material.dart';
import 'package:ski_resorts_app/old_screens/statistics/user_statistic_screen.dart';
import 'package:ski_resorts_app/screens/weather/meteo_screen.dart';
import 'package:ski_resorts_app/old_screens/settings/settings_page_screen.dart';
// this filedefines all the routes in the app; when i click on a button, i want to go to a specific page.
// The route of the page is defined here; so in every file i can call the route of the page i want to go to
import 'package:ski_resorts_app/old_screens/settings/about_us_screen/about_us_screen.dart';
import 'package:ski_resorts_app/old_screens/settings/help_Feedback_Screen/help_feedback.dart';
import 'package:ski_resorts_app/old_screens/settings/notification_handler_screen/notification_handler_screem.dart';
import 'package:ski_resorts_app/old_screens/settings/position_handler_screen/position_handler_screen.dart';
import 'package:ski_resorts_app/old_screens/settings/profile_screen/profile_screen.dart';
import 'package:ski_resorts_app/old_screens/favourites/favorites_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/NotificationSettingScreen': (BuildContext context) =>
      const NotificationSettingScreen(),
  '/AboutUsPage': (BuildContext context) => const AboutUsPage(),
  '/HelpAndFeedbackPage': (BuildContext context) => const HelpAndFeedbackPage(),
  '/LocationSettingScreen': (BuildContext context) =>
      const LocationSettingScreen(),
  '/ProfilePageScreen': (BuildContext context) => const ProfilePageScreen(),
  '/StatisticsScreen': (BuildContext context) => const StatisticsScreen(),
  '/SettingsPage': (BuildContext context) => const SettingsPage(),
  '/MeteoPage': (BuildContext context) => const MeteoPageScreen(),
  '/FavoritesScreen': (BuildContext context) => const FavoritesScreen(),
};