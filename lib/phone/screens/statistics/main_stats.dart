import 'package:flutter/material.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_screen_1.dart';

class MainStats extends StatefulWidget {
  const MainStats({Key? key}) : super(key: key);

  @override
  MainStatsState createState() => MainStatsState();
}

class MainStatsState extends State<MainStats> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StopwatchPage(),
    );
  }
}
