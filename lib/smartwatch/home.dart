import 'package:flutter/material.dart';

class SmartWatch extends StatefulWidget {
  const SmartWatch({Key? key}) : super(key: key);

  @override
  SmartWatchState createState() => SmartWatchState();
}

class SmartWatchState extends State<SmartWatch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
