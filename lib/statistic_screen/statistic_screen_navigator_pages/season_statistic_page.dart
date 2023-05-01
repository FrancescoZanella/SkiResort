import 'package:flutter/material.dart';

class SeasonPage extends StatelessWidget {
  const SeasonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Season'),
      ),
      body: const Center(
        child: Text('Season Page'),
      ),
    );
  }
}
