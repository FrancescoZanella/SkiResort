import './models/statistic_lists.dart';
import 'package:flutter/material.dart';
import '../settings_page_screen.dart';
import 'package:ski_resorts_app/screens/favorites_screen.dart';
import 'package:ski_resorts_app/screens/user_statistic_screen.dart';
import 'package:ski_resorts_app/screens/home_app_screen.dart';

class CaloriesData {
  final String day;
  final int caloriesBurned;

  CaloriesData(this.day, this.caloriesBurned);
}

class DurationData {
  final String day;
  final int totalDuration;

  DurationData(this.day, this.totalDuration);
}

final List<CaloriesData> caloriesData = [
  CaloriesData('Mon', 600),
  CaloriesData('Tue', 800),
  CaloriesData('Wed', 1000),
  CaloriesData('Thu', 1200),
  CaloriesData('Fri', 900),
  CaloriesData('Sat', 1100),
  CaloriesData('Sun', 700),
];

final List<DurationData> durationData = [
  DurationData('Mon', 45),
  DurationData('Tue', 60),
  DurationData('Wed', 75),
  DurationData('Thu', 90),
  DurationData('Fri', 60),
  DurationData('Sat', 75),
  DurationData('Sun', 50),
];

final List<Map<String, Object>> pages = [
  {
    'page': const HomeScreen(),
    'title': 'Home',
  },
  {
    'page': const FavoritesScreen(),
    'title': 'Favorites',
  },
  {
    'page': const StatisticsScreen(),
    'title': 'Statistics',
  },
  {
    'page': const SettingsPage(),
    'title': 'Settings',
  },
];
