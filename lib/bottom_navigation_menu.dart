import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Favorites',
    ),
    Text(
      'Index 2: Statistics',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_sharp),
            label: 'Statistics',
          ),
        ],
        currentIndex:
            _selectedIndex, // we manage the selection of the page manually so we need to tell flutter what is the current index
        selectedItemColor: Colors.blue,
        onTap:
            _onItemTapped, // we have to manually control what the user taps on -> so onTap is a listener. OnTap is a function developed by flutter that returns automatically the index of the item that the user tapped on
      ),
    );
  }
}
