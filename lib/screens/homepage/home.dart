import 'package:flutter/material.dart';

import 'package:ski_resorts_app/screens/homepage/best_time.dart';
import 'package:ski_resorts_app/screens/homepage/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAppBar(),
        BestTime(),
      ],
    );
  }
}
