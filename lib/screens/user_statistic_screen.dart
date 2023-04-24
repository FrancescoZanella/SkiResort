import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../dummy_data.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<charts.Series<CaloriesData, String>> caloriesSeries = [
      charts.Series(
        id: 'Calories Burned',
        data: caloriesData,
        domainFn: (CaloriesData data, _) => data.day,
        measureFn: (CaloriesData data, _) => data.caloriesBurned,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];

    final List<charts.Series<DurationData, String>> durationSeries = [
      charts.Series(
        id: 'Total Workout Duration',
        data: durationData,
        domainFn: (DurationData data, _) => data.day,
        measureFn: (DurationData data, _) => data.totalDuration,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      )
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calories Burned:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: charts.BarChart(caloriesSeries, animate: true),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Total Workout Duration:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: charts.BarChart(durationSeries, animate: true),
            ),
          ],
        ),
      ),
    );
  }
}
