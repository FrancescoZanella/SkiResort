import 'package:flutter/material.dart';

class MyPopupMenu extends StatelessWidget {
  final Function(String) onSelected;

  const MyPopupMenu({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'start session',
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Start session'),
                Icon(Icons.play_arrow),
              ],
            ),
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Settings'),
                Icon(Icons.settings),
              ],
            ),
          ),
        ),
        const PopupMenuItem(
          value: 'my goals',
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('My goals'),
                Icon(Icons.flag),
              ],
            ),
          ),
        ),
      ],
      onSelected: onSelected,
      icon: const Icon(Icons.downhill_skiing_sharp),
    );
  }
}
