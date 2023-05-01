import 'package:flutter/material.dart';

class LifetimePage extends StatelessWidget {
  const LifetimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifetime'),
      ),
      body: const Center(
        child: Text('Lifetime Page'),
      ),
    );
  }
}
