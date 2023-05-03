import 'package:flutter/material.dart';

class CustomTopNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomTopNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35, // set the desired height for the navigation bar
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Season',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Lifetime',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        iconSize: 0,
        showSelectedLabels: true,
      ),
    );
  }
}
