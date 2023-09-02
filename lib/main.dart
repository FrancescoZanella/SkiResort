import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/phone/screens/onboarding/onboardingmenu.dart';
import 'package:flutter/services.dart';
import 'package:ski_resorts_app/phone/screens/settings/theme_notifier.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';
import 'package:ski_resorts_app/phone/app_routes.dart';
import 'package:ski_resorts_app/phone/screens/builder.dart';
import 'package:ski_resorts_app/phone/screens/check_user_login_status.dart';
import 'package:ski_resorts_app/smartwatch/home.dart';

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
    WidgetsFlutterBinding.ensureInitialized();
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
              ? ThemeData(
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(color: Color(0xFF1F2022))),
                  fontFamily: 'NotoSansKR',
                  primarySwatch: Colors.blue,
                  scaffoldBackgroundColor: Colors.white,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                )
              : ThemeData.dark(),
          home: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              debugPrint('Host device screen width: ${constraints.maxWidth}');

              // Watch-sized device
              if (constraints.maxWidth < 300) {
                return const SmartWatch();
              }
              // Phone-sized device
              else {
                return FutureBuilder<UserModel>(
                  future: checkUserLoginStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('No internet connection: ${snapshot.error}');
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
                );
              }
            },
          ),
        );
      }),
    );
  }
}
