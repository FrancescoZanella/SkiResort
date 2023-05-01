import 'package:flutter/material.dart';

class CustomTopNavigationBar extends StatefulWidget {
  const CustomTopNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomTopNavigationBar> createState() => _CustomTopNavigationBarState();
}

class _CustomTopNavigationBarState extends State<CustomTopNavigationBar> {
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35, // set the desired height for the navigation bar
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildNavigationItem(
                context, "Today", "/TodayStatisticSection", 0),
          ),
          const SizedBox(width: 0),
          Expanded(
            child: _buildNavigationItem(
                context, "Season", "/SeasonStatisticSection", 1),
          ),
          const SizedBox(width: 0),
          Expanded(
            child: _buildNavigationItem(
                context, "Lifetime", "/LifetimeStatisticSection", 2),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(
      BuildContext context, String label, String route, int index) {
    final isSelected = index == _selectedIndex;
    return InkWell(
      onTap: () {
        _onItemSelected(index);
        Navigator.pushNamed(context, route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
