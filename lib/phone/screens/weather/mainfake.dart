/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/hourlyWeatherScreen.dart';
import './provider/weatherProvider.dart';
import 'screens/weeklyWeatherScreen.dart';
import 'screens/WeatherScreen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: 'Flutter Weather',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        home: const WeatherScreen(),
        routes: {
          WeeklyScreen.routeName: (myCtx) => const WeeklyScreen(),
          HourlyScreen.routeName: (myCtx) => const HourlyScreen(),
        },
      ),
    );
  }
}
*/