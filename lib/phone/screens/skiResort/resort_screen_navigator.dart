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
      height: 45, // set the desired height for the navigation bar
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
          backgroundColor: Colors.blue[100],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          elevation: 0,
        ),
      ),
    );
  }
}
