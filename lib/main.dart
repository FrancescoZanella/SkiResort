import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/screens/onboarding/onboardingmenu.dart';
import 'package:flutter/services.dart';
import 'package:ski_resorts_app/screens/builder.dart';
import 'package:ski_resorts_app/old_screens/settings/theme_notifier.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'old_screens/app_routes.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const isLoggedIn = false;

  void _loadUserData() async {}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SkiResorts',
            routes: routes,
            theme: notifier.darkTheme
                ? ThemeData.dark()
                : ThemeData(
                    textTheme: const TextTheme(
                        bodyLarge: TextStyle(color: Color(0xFF1F2022))),
                    fontFamily: 'NotoSansKR',
                    primarySwatch: Colors.blue,
                    scaffoldBackgroundColor: Colors.white,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
            home: isLoggedIn
                ? const Scaffold(
                    body: MainPage(),
                  )
                : const OnboardingMenu(),
          );
        },
      ),
    );
  }
}
