/*
import 'package:flutter/material.dart';
import './models/statistic_lists.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticItem extends StatelessWidget {
  const StatisticItem({super.key});

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
    return Container();
  }
}*/
