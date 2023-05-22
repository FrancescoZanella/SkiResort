import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Welcome to the Skiing App!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: [
                _buildFeatureCard(
                  context: context,
                  title: 'Trails',
                  icon: Icons.map,
                  color: Colors.orange,
                  onTap: () {
                    // Handle tap on Trails feature
                  },
                ),
                _buildFeatureCard(
                  context: context,
                  title: 'Weather',
                  icon: Icons.wb_sunny,
                  color: Colors.blue,
                  onTap: () {
                    // goes to MeteoPageScreen
                    Navigator.pushNamed(context, '/MeteoPage');
                  },
                ),
                _buildFeatureCard(
                  context: context,
                  title: 'Resorts',
                  icon: Icons.home,
                  color: Colors.green,
                  onTap: () {
                    // Handle tap on Resorts feature
                  },
                ),
                _buildFeatureCard(
                  context: context,
                  title: 'Equipment',
                  icon: Icons.shopping_cart,
                  color: Colors.purple,
                  onTap: () {
                    // Handle tap on Equipment feature
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48.0,
              color: Colors.white,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
