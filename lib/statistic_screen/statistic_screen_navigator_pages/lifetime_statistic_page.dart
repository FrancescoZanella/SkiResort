import 'package:flutter/material.dart';

class LifetimePage extends StatelessWidget {
  const LifetimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatisticTile(
            context,
            label: 'Total distance',
            value: '250km',
          ),
          const SizedBox(height: 16),
          _buildStatisticTile(
            context,
            label: 'Total time',
            value: '25 hours',
          ),
          const SizedBox(height: 16),
          _buildStatisticTile(
            context,
            label: 'Number of sessions',
            value: '10',
          ),
          const SizedBox(height: 16),
          _buildStatisticTile(
            context,
            label: 'Number of resorts visited',
            value: '3',
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticTile(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
