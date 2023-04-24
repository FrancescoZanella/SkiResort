import 'package:flutter/material.dart';
import '../settings_page_screen.dart';
import 'home_app_screen.dart';
import '../bottom_navigation_menu.dart';
import '../pop_up_menu.dart';
import '../dummy_data.dart';

enum Menu { itemOne, itemTwo, itemThree }

class NavigationDrawerMenu extends StatefulWidget {
  const NavigationDrawerMenu({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerMenu> createState() => _NavigationDrawerMenuState();
}

class _NavigationDrawerMenuState extends State<NavigationDrawerMenu> {
  int _selectedNavigationDrawerMenuIndex = 0;

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
        title: Text(pages[_selectedPageIndex]['title'] as String),
        actions: [
          MyPopupMenu(
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
      body: pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBarMenu(
        onItemTapped: _selectPage,
        selectedIndex: _selectedPageIndex,
      ),
    );
  }
}
