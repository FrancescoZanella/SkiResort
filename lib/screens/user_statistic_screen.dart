import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CaloriesData {
  final String day;
  final int caloriesBurned;

  CaloriesData(this.day, this.caloriesBurned);
}

class DurationData {
  final String day;
  final int totalDuration;

  DurationData(this.day, this.totalDuration);
}

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final List<CaloriesData> _caloriesData = [
    CaloriesData('Mon', 600),
    CaloriesData('Tue', 800),
    CaloriesData('Wed', 1000),
    CaloriesData('Thu', 1200),
    CaloriesData('Fri', 900),
    CaloriesData('Sat', 1100),
    CaloriesData('Sun', 700),
  ];

  final List<DurationData> _durationData = [
    DurationData('Mon', 45),
    DurationData('Tue', 60),
    DurationData('Wed', 75),
    DurationData('Thu', 90),
    DurationData('Fri', 60),
    DurationData('Sat', 75),
    DurationData('Sun', 50),
  ];

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<CaloriesData, String>> caloriesSeries = [
      charts.Series(
        id: 'Calories Burned',
        data: _caloriesData,
        domainFn: (CaloriesData data, _) => data.day,
        measureFn: (CaloriesData data, _) => data.caloriesBurned,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];

    final List<charts.Series<DurationData, String>> durationSeries = [
      charts.Series(
        id: 'Total Workout Duration',
        data: _durationData,
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
