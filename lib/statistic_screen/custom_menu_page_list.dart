import 'package:ski_resorts_app/statistic_screen/statistic_screen_navigator_pages/lifetime_statistic_page.dart';
import 'package:ski_resorts_app/statistic_screen/statistic_screen_navigator_pages/season_statistic_page.dart';
import 'package:ski_resorts_app/statistic_screen/statistic_screen_navigator_pages/today_statistic_page.dart';

final List<Map<String, Object>> pages = [
  {
    'page': TodayPage(),
  },
  {
    'page': const SeasonPage(),
  },
  {
    'page': const LifetimePage(),
  },
];
