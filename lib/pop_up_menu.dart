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
          child: Text('Start session'),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: Text('Settings'),
        ),
        const PopupMenuItem(
          value: 'my goals',
          child: Text('My goals'),
        ),
      ],
      onSelected: onSelected,
      icon: const Icon(Icons.downhill_skiing_sharp),
    );
  }
}
