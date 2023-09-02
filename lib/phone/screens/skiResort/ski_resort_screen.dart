import 'package:flutter/material.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_screen_navigator.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/ski_resort_pages.dart';

class SkiResortScreen extends StatefulWidget {
  const SkiResortScreen({Key? key}) : super(key: key);

  @override
  State<SkiResortScreen> createState() => _SkiResortScreenState();
}

class _SkiResortScreenState extends State<SkiResortScreen> {
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
          const SizedBox(
            height: 15,
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
