import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/screens/onboarding/onboardingmenu.dart';
import 'package:flutter/services.dart';
import 'package:ski_resorts_app/old_screens/settings/theme_notifier.dart';
import 'package:ski_resorts_app/screens/user_data_model.dart';
import 'old_screens/app_routes.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider<UserModel>(
          create: (_) => UserModel(),
        ),
      ],
      child: Consumer2<ThemeNotifier, UserModel>(
        builder: (context, themeNotifier, userModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SkiResorts',
            routes: routes,
            theme: themeNotifier.darkTheme
                ? ThemeData.dark()
                : ThemeData(
                    textTheme: const TextTheme(
                        bodyLarge: TextStyle(color: Color(0xFF1F2022))),
                    fontFamily: 'NotoSansKR',
                    primarySwatch: Colors.blue,
                    scaffoldBackgroundColor: Colors.white,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
            home: const OnboardingMenu(),
          );
        },
      ),
    );
  }
}
