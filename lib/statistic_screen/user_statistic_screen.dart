import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import './duration_and_calories.dart';
import './statistic_widgets.dart';
import './statistic_screen_navigator.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<charts.Series<CaloriesData, String>> caloriesSeries =
        getCaloriesSeries();

    final List<charts.Series<DurationData, String>> durationSeries =
        getDurationSeries();

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const CustomTopNavigationBar(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Calories Burned:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Expanded(
                    child: charts.BarChart(caloriesSeries, animate: true),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Total Workout Duration:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Expanded(
                    child: charts.BarChart(durationSeries, animate: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
