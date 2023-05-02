import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Company',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit tincidunt condimentum. Nulla quis tellus metus. In egestas quam vel velit pellentesque tincidunt. Sed finibus, quam eget maximus fermentum, nunc sapien faucibus ex, sit amet gravida lacus mi sed nibh. Donec sem ipsum, tristique quis massa in, consequat laoreet magna. Nam bibendum ultricies velit, nec consectetur neque imperdiet at. Curabitur tincidunt nunc orci, quis euismod metus pretium ac. Fusce eget arcu ut sapien sodales blandit.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit tincidunt condimentum. Nulla quis tellus metus. In egestas quam vel velit pellentesque tincidunt. Sed finibus, quam eget maximus fermentum, nunc sapien faucibus ex, sit amet gravida lacus mi sed nibh. Donec sem ipsum, tristique quis massa in, consequat laoreet magna. Nam bibendum ultricies velit, nec consectetur neque imperdiet at. Curabitur tincidunt nunc orci, quis euismod metus pretium ac. Fusce eget arcu ut sapien sodales blandit.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Team',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit tincidunt condimentum. Nulla quis tellus metus. In egestas quam vel velit pellentesque tincidunt. Sed finibus, quam eget maximus fermentum, nunc sapien faucibus ex, sit amet gravida lacus mi sed nibh. Donec sem ipsum, tristique quis massa in, consequat laoreet magna. Nam bibendum ultricies velit, nec consectetur neque imperdiet at. Curabitur tincidunt nunc orci, quis euismod metus pretium ac. Fusce eget arcu ut sapien sodales blandit.',
            ),
          ],
        ),
      ),
    );
  }
}
