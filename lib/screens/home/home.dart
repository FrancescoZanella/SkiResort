import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:ski_resorts_app/screens/home/widgets/best_time.dart';
import 'package:ski_resorts_app/screens/home/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIconIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.only(top: 0.0 * 2),
        child: Column(
          children: [
            CustomAppBar(),
            BestTime(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selectedIconIndex,
        buttonBackgroundColor: Colors.lightBlueAccent, //(0xFF4FC3F7),
        height: 60.0,
        color: Colors.white,
        onTap: (index) {
          setState(() {
            selectedIconIndex = index;
          });
        },
        animationDuration: Duration(
          milliseconds: 200,
        ),
        items: <Widget>[
          Icon(
            Icons.map_outlined,
            size: 30,
            color: selectedIconIndex == 0 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.sunny,
            size: 30,
            color: selectedIconIndex == 1 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.home_outlined,
            size: 30,
            color: selectedIconIndex == 2 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.favorite_border_outlined,
            size: 30,
            color: selectedIconIndex == 3 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.person_outline,
            size: 30,
            color: selectedIconIndex == 4 ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
