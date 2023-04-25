import './statistic_dummy_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import './duration_and_calories.dart';

List<charts.Series<CaloriesData, String>> getCaloriesSeries() {
  return [
    charts.Series(
      id: 'Calories Burned',
      data: caloriesData,
      domainFn: (CaloriesData data, _) => data.day,
      measureFn: (CaloriesData data, _) => data.caloriesBurned,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
    )
  ];
}

List<charts.Series<DurationData, String>> getDurationSeries() {
  return [
    charts.Series(
      id: 'Total Workout Duration',
      data: durationData,
      domainFn: (DurationData data, _) => data.day,
      measureFn: (DurationData data, _) => data.totalDuration,
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
    )
  ];
}
