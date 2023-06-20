import 'package:flutter/material.dart';

class LightDarkMode with ChangeNotifier {
  var currentMode = false;

  void switchMode(bool mode) {
    currentMode = mode;
    notifyListeners();
  }

  final light = const ColorScheme(
    /*Light Color OF Icons*/ primary: Color.fromARGB(255, 126, 12, 12),
    /*Dark Color OF Icon/Buttons*/ secondary:
        Color.fromARGB(255, 219, 203, 217),
    onPrimary: Color.fromARGB(255, 163, 163, 163),
    onSecondary: Colors.amber,
    /*BACKGROUND OF APP*/ background: Color.fromARGB(255, 211, 204, 198),
    /*Appbar,Big Widgets etc*/ onBackground: Color.fromARGB(255, 0, 0, 0),
    surface: Color.fromARGB(255, 165, 158, 158),
    onSurface: Color.fromARGB(255, 0, 0, 0),
    error: Color.fromARGB(255, 233, 56, 44),
    onError: Color.fromARGB(255, 124, 8, 0),
    brightness: Brightness.light,
  );

  final dark = const ColorScheme(
    /*Light Color OF Icons*/ primary: Color.fromARGB(255, 9, 75, 9),
    /*Dark Color OF Icon/Buttons*/ secondary: Color.fromARGB(255, 23, 159, 168),
    onPrimary: Colors.white,
    onSecondary: Colors.amber,
    /*BACKGROUND OF APP*/ background: Color.fromARGB(255, 0, 0, 0),
    /*Appbar,Big Widgets etc*/ onBackground: Color.fromARGB(255, 255, 255, 255),
    surface: Color.fromARGB(255, 231, 214, 199),
    onSurface: Color.fromARGB(255, 0, 0, 0),
    error: Color.fromARGB(255, 233, 56, 44),
    onError: Color.fromARGB(255, 124, 8, 0),
    brightness: Brightness.dark,
  );
}
