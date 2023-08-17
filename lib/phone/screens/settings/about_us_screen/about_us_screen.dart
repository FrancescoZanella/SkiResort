import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Who We Are',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              "We are Stefano Chiodini and Francesco Zanella, two ambitious students from the Politecnico di Milano. Our passion for innovation, problem-solving and technology drives us to continuously challenge ourselves in our academic and personal projects.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Project',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              "This application is a result of our dedication and hard work as part of a university project. Our main objective was to design and develop an app that provides real value to its users. This application aims to bridge the gap between skiing enthusiasts and the resources they need to enhance their skiing experience. Whether you're looking for the perfect ski resort, tracking your performance, or just want to stay updated on skiing conditions, we've got you covered!",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
