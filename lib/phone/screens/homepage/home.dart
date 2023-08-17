import 'package:flutter/material.dart';

import 'package:ski_resorts_app/phone/screens/homepage/best_time.dart';
import 'package:ski_resorts_app/phone/screens/homepage/custom_app_bar.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  Function callback;
  HomeScreen({required this.callback, super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(),
        BestTime(callback: callback),
      ],
    );
  }
}
