import '../settings/settings_page_screen.dart';
import 'package:ski_resorts_app/screens/favourites/favorites_screen.dart';
import 'package:ski_resorts_app/screens/statistics/user_statistic_screen.dart';
import 'package:ski_resorts_app/home_app_screen.dart';

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
