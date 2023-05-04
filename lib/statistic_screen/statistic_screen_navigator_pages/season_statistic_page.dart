import 'package:flutter/material.dart';

class SeasonPage extends StatelessWidget {
  const SeasonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Season Statistics',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          _StatisticCard(
            label: 'Total distance skied',
            value: '154 km',
          ),
          SizedBox(height: 16),
          _StatisticCard(
            label: 'Number of runs',
            value: '12',
          ),
          SizedBox(height: 16),
          _StatisticCard(
            label: 'Total time on slopes',
            value: '12 hours',
          ),
        ],
      ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatisticCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
