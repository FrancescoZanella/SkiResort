import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ski_resorts_app/old_screens/settings/settings_page_screen.dart';
import 'package:ski_resorts_app/old_screens/statistics/user_statistic_screen.dart';
import 'package:ski_resorts_app/screens/weather/weather_screen.dart';
import 'package:ski_resorts_app/screens/homepage/home.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/screens/user_data_model.dart';

import '../old_screens/favourites/favorites_screen.dart';

class MainPage extends StatefulWidget {
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final String avatarPath;
  final String userId;

  const MainPage(
      {Key? key,
      required this.userId,
      required this.name,
      required this.surname,
      required this.email,
      required this.phoneNumber,
      required this.avatarPath})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIconIndex = 2;

  List<Widget> pages = [
    const StatisticsScreen(),
    const MeteoPageScreen(),
    const HomeScreen(),
    const FavoritesScreen(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    final userModel = Provider.of<UserModel>(context, listen: false);
    userModel.updateUser(
      userId: widget.userId,
      name: widget.name,
      surname: widget.surname,
      email: widget.email,
      phoneNumber: widget.phoneNumber,
      avatarPath: widget.avatarPath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: pages[selectedIconIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selectedIconIndex,
        buttonBackgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.lightBlueAccent
            : Colors.blue, // consider choosing a different color in light mode
        height: 60.0,
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).cardColor
            : Colors.lightBlue[50]!, // change this to a lighter shade of blue
        onTap: (index) {
          setState(() {
            selectedIconIndex = index;
          });
        },
        animationDuration: const Duration(
          milliseconds: 200,
        ),
        items: <Widget>[
          Icon(
            Icons.map_outlined,
            size: 30,
            color: selectedIconIndex == 0
                ? Colors.white
                : Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
          ),
          Icon(
            Icons.sunny,
            size: 30,
            color: selectedIconIndex == 1
                ? Colors.white
                : Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
          ),
          Icon(
            Icons.home_outlined,
            size: 30,
            color: selectedIconIndex == 2
                ? Colors.white
                : Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
          ),
          Icon(
            Icons.favorite_border_outlined,
            size: 30,
            color: selectedIconIndex == 3
                ? Colors.white
                : Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: selectedIconIndex == 4
                ? Colors.white
                : Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
          ),
        ],
      ),
    );
  }
}
