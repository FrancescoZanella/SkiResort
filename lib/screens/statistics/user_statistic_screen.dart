import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/statistics/statistic_screen_navigator.dart';
import 'package:ski_resorts_app/screens/statistics/custom_menu_page_list.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
                // used just to leave space between the top of the screen and the top of the app bar
                top: 20),
          ),
          CustomTopNavigationBar(
            selectedIndex: _selectedPageIndex,
            onItemTapped: _selectPage,
          ),
          Container(
            margin: const EdgeInsets.only(
                // used just to leave space between the custom menu and the "body" of the page
                top: 20),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedPageIndex,
              children: pages.map((page) => page['page'] as Widget).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
