import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ski_resorts_app/statistic_screen/duration_and_calories.dart';
import 'package:ski_resorts_app/statistic_screen/statistic_widgets.dart';

class TodayPage extends StatelessWidget {
  TodayPage({Key? key}) : super(key: key);

  final List<charts.Series<CaloriesData, String>> caloriesSeries =
      getCaloriesSeries();

  final List<charts.Series<DurationData, String>> durationSeries =
      getDurationSeries();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
