import 'package:flutter/material.dart';
import 'package:ski_resorts_app/onboardingmenu.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLoggedIn = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkiResorts',
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isLoggedIn ? Scaffold() : OnboardingMenu(),
    );
  }
}
