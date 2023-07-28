import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/screens/onboarding/onboardingmenu.dart';
import 'package:flutter/services.dart';
import 'package:ski_resorts_app/old_screens/settings/theme_notifier.dart';
import 'package:ski_resorts_app/screens/user_data_model.dart';
import 'old_screens/app_routes.dart';
import 'package:ski_resorts_app/screens/builder.dart';
import 'package:ski_resorts_app/screens/check_user_login_status.dart';
import 'package:ski_resorts_app/screens/weather/provider/weatherProvider.dart';
import 'package:ski_resorts_app/screens/weather/Screens/hourlyWeatherScreen.dart';
import 'package:ski_resorts_app/screens/weather/Screens/weeklyWeatherScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
      ],
      child: Consumer3<ThemeNotifier, UserModel, WeatherProvider>(
        builder: (context, themeNotifier, userModel, weatherProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SkiResorts',
            routes: {
              ...routes,
              WeeklyScreen.routeName: (myCtx) => const WeeklyScreen(),
              HourlyScreen.routeName: (myCtx) => const HourlyScreen(),
            },
            theme: themeNotifier.darkTheme
                ? ThemeData(
                    textTheme: const TextTheme(
                        bodyLarge: TextStyle(color: Color(0xFF1F2022))),
                    fontFamily: 'NotoSansKR',
                    primarySwatch: Colors.blue,
                    scaffoldBackgroundColor: Colors.white,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  )
                : ThemeData.dark(),
            home: FutureBuilder<UserModel>(
              future: checkUserLoginStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  UserModel userModel = snapshot.data!;
                  return userModel.name.isEmpty
                      ? const OnboardingMenu()
                      : MainPage(
                          userId: userModel.userId,
                          name: userModel.name,
                          surname: userModel.surname,
                          email: userModel.email,
                          phoneNumber: userModel.phoneNumber,
                          avatarPath: userModel.avatarPath,
                        );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
