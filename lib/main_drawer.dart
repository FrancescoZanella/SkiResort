import 'package:flutter/material.dart';
import 'screens/navigation_drawer_menu.dart';

// flutter read my files from top to bottom and executes what it finds

// every widget in flutter needs to extend the stateless widget or stateful widget
void main() {
  runApp(// takes the core widget as an argument and displays it on the screen
      const MyApp()); // runApp is a function that takes the core widget as an argument(the widget is my app) and displays it on the screen
}

// we don't have to worry about pixel disposition, flutter does it for us
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override // we are overriding the build method of the stateless widget with our own implementation DELIBERATELY,
  // i insert the @override to make clear that we are not using the build method of the stateless widget by mistake but we are using our own implementation
  // infact when we write a custom build method the build method of the stateless widget is not called
  Widget build(BuildContext context) {
    // everything is a widget, so every class must have a build method
    return MaterialApp(
        // material app creates a base setup for the app and displays all the widget in the screen
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //darkTheme: darkTheme,
        //themeMode: ThemeMode.system,
        home: const Scaffold(
          // core widget -> is the one that is displayed on the screen
          body: NavigationDrawerMenu(),
        ));
  }
}
