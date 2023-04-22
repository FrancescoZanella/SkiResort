import 'package:flutter/material.dart';
import 'package:ski_resorts_app/onboardingmenu.dart';
import 'package:flutter/services.dart';
import 'package:ski_resorts_app/screens/navigation_drawer_menu.dart';

//edit
void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const isLoggedIn = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkiResorts',
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // ignore: dead_code
      home: isLoggedIn
          ? const Scaffold(
              body: NavigationDrawerMenu(),
            )
          : OnboardingMenu(),
    );
  }
}
