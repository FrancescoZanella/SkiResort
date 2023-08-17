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
      height: 55, // set the desired height for the navigation bar
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Resort Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Most Popular',
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
