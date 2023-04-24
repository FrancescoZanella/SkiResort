import 'package:flutter/material.dart';
import 'user_statistic_screen.dart'; //package:DimaProject/screens/user_statistic_screen.dart';
import '../settings_page_screen.dart';
import 'home_app_screen.dart';
import 'favorites_screen.dart';

enum Menu { itemOne, itemTwo, itemThree }

class NavigationDrawerMenu extends StatefulWidget {
  const NavigationDrawerMenu({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerMenu> createState() => _NavigationDrawerMenuState();
}

class _NavigationDrawerMenuState extends State<NavigationDrawerMenu> {
  int _selectedNavigationDrawerMenuIndex = 0;

  final List<Map<String, Object>> _pages = [
    {
      'page': const HomeScreen(),
      'title': 'Home',
    },
    {
      'page': const FavoritesScreen(),
      'title': 'Favorites',
    },
    {
      'page': const StatisticsScreen(),
      'title': 'Statistics',
    },
    {
      'page': const SettingsPage(),
      'title': 'Settings',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onItemTappedDrawer(int index) {
    setState(() {
      // force flutter to rebuild the user interface, not the whole app; without this function the user interface is not updated
      _selectedNavigationDrawerMenuIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //is the function that builds the widget -> this function is always called by flutter for us, so we don't have to call it
    return Scaffold(
      // scaffold creates a base page design for us, a structure for our app and a color scheme
      // we have to return the widget that we want to build for the build method
      appBar: AppBar(
        // as title we insert the title of the page that we are currently on
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'account',
                child: Text('Account'),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'signOut',
                child: Text('Sign out'),
              ),
            ],
            onSelected: (value) {
              // Handle menu item selection
              switch (value) {
                case 'account':
                  // Do something
                  break;
                case 'settings':
                  // Navigate to settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                  break;
                case 'signOut':
                  // Do something
                  break;
              }
            },
            icon: const Icon(Icons.downhill_skiing_sharp),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              selected: _selectedNavigationDrawerMenuIndex == 0,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              selected: _selectedNavigationDrawerMenuIndex == 1,
              onTap: () {
                _onItemTappedDrawer(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              selected: _selectedNavigationDrawerMenuIndex == 2,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: null,
            ),
            const Divider(),
            ListTile(
              title: const Text('Close'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
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
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.blue,
        onTap: _selectPage,
      ),
    );
  }
}
