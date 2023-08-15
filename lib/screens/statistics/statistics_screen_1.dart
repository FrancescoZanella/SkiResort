import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/screens/statistics/statistics_data.dart';

class RunData {
  final double? latitude;
  final double? longitude;
  final String date;
  final String formattedTime;
  final double averageSpeed;
  final double maxSpeed;
  final double distanceInMeters;
  final List<double> speedDataPoints;

  RunData({
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.formattedTime,
    required this.averageSpeed,
    required this.maxSpeed,
    required this.distanceInMeters,
    required this.speedDataPoints,
  });
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  bool _isRunning = false;
  double _distanceInMeters = 0;
  Location location = Location();
  LocationData? _lastLocation;
  List<RunData> _runDataList = [];
  double _averageSpeed = 0;
  double _maxSpeed = 0;
  final List<double> _speedDataPoints = [];
  GeolocatorPlatform geolocator = GeolocatorPlatform.instance;

  @override
  void initState() {
    super.initState();
    _initializeRunDataList();
  }

  Future<void> _initializeRunDataList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _runDataList = await getStats(prefs.getString('userId')!);
    } catch (e) {
      // Handle any errors that might occur during initialization
      print("Error getting stats list: $e");
    }
  }

  void _startStopwatch() async {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
      _distanceInMeters = 0; // Reset the distance when starting a new run
      _speedDataPoints.clear(); // Clear the previous speed data points

      double currentSpeedSum = 0;
      double currentMaxSpeed = 0;
      int numSpeedUpdates = 0;

      _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
        if (_lastLocation != null) {
          LocationData currentLocation = await location.getLocation();
          double distanceInMeters =
              await _calculateDistance(_lastLocation!, currentLocation);

          // Calculate current speed
          double elapsedTimeInSeconds = _stopwatch.elapsed.inSeconds.toDouble();
          double currentSpeed = distanceInMeters / elapsedTimeInSeconds;

          // Update current average speed
          currentSpeedSum += currentSpeed;
          numSpeedUpdates++;

          // Update current max speed
          if (currentSpeed > currentMaxSpeed) {
            currentMaxSpeed = currentSpeed;
          }

          // Update speed data points for the chart
          _speedDataPoints.add(currentSpeed);

          // Update UI with current average and max speed
          double averageSpeed = currentSpeedSum / numSpeedUpdates;
          setState(() {
            _averageSpeed = averageSpeed;
            _maxSpeed = currentMaxSpeed;
            _distanceInMeters += distanceInMeters;
          });
        }
        _lastLocation = await location.getLocation();
      });
    });
  }

  void _stopStopwatch() {
    if (_isRunning) {
      setState(() {
        _isRunning = false;
        _stopwatch.stop();
        _timer?.cancel();
        RunData r = RunData(
          latitude: _lastLocation!.latitude,
          longitude: _lastLocation!.longitude,
          date: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
          formattedTime: TimerUtil.formatTime(_stopwatch.elapsed),
          averageSpeed: _averageSpeed,
          maxSpeed: _maxSpeed,
          distanceInMeters: _distanceInMeters,
          speedDataPoints:
              List.from(_speedDataPoints), // Copy the speed data points
        );
        _runDataList.add(r);
        //aggiungo al db
        saveStat(r);
      });
    } else {
      _resetStopwatch();
    }
  }

  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.reset();
      _timer?.cancel();
      _distanceInMeters = 0;
      _averageSpeed = 0;
      _maxSpeed = 0;
      _speedDataPoints.clear();
    });
  }

  Future<double> _calculateDistance(
      LocationData start, LocationData end) async {
    double distanceInMeters = Geolocator.distanceBetween(
      start.latitude!,
      start.longitude!,
      end.latitude!,
      end.longitude!,
    );
    return distanceInMeters;
  }

  double calculateSpeed(double distanceInMeters, double elapsedTimeInSeconds) {
    double distanceInKm = distanceInMeters / 1000;
    double elapsedTimeInHours = elapsedTimeInSeconds / (60 * 60);
    return distanceInKm / elapsedTimeInHours;
  }

  Future<void> _openInGoogleMaps(double? latitude, double? longitude) async {
    final availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
      coords: Coords(latitude!, longitude!),
      title: "Location",
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future:
            _initializeRunDataList(), // Wait for the statistics to be loaded
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          // Once the statistics are loaded, build the actual UI
          String formattedTime = TimerUtil.formatTime(_stopwatch.elapsed);
          double elapsedTimeInSeconds = _stopwatch.elapsed.inSeconds.toDouble();
          double speedKmPerHour =
              calculateSpeed(_distanceInMeters, elapsedTimeInSeconds);

          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedTime,
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Speed: ${speedKmPerHour.toStringAsFixed(2)} km/h',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  'Distance: ${(_distanceInMeters.toStringAsFixed(2))} m', // Modified line
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _isRunning ? null : _startStopwatch,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child:
                          const Text('Start', style: TextStyle(fontSize: 18)),
                    ),
                    ElevatedButton(
                      onPressed: _stopStopwatch,
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(_isRunning ? 'Stop' : 'Reset',
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                if (_runDataList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _runDataList.length,
                      itemBuilder: (context, index) {
                        var data = _runDataList[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ExpansionTile(
                            title: Text(
                                'Time: ${data.formattedTime}, Average Speed: ${data.averageSpeed.toStringAsFixed(2)} km/h'),
                            children: [
                              ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Distance: ${data.distanceInMeters.toStringAsFixed(2)} m'),
                                    Text(
                                        'Average Speed: ${data.averageSpeed.toStringAsFixed(2)} km/h'),
                                    Text(
                                        'Max Speed: ${data.maxSpeed.toStringAsFixed(2)} km/h'),
                                    Text('Date: ${data.date}'),
                                    const Text("View Position on: "),
                                    GestureDetector(
                                      onTap: () {
                                        _openInGoogleMaps(
                                            data.latitude, data.longitude);
                                      },
                                      child: const Text('Google Maps',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline)),
                                    )
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 120,
                                  height: 180,
                                  child: LineChart(
                                    LineChartData(
                                      gridData: const FlGridData(show: false),
                                      titlesData:
                                          const FlTitlesData(show: false),
                                      borderData: FlBorderData(show: true),
                                      minX: 0,
                                      maxX: data.speedDataPoints.length
                                              .toDouble() -
                                          1,
                                      minY: -0.01,
                                      maxY: data.maxSpeed * 1.2,
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: data.speedDataPoints
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            int index = entry.key;
                                            double speed = entry.value;
                                            return FlSpot(
                                                index.toDouble(), speed);
                                          }).toList(),
                                          isCurved: true,
                                          color: Colors.blue,
                                          dotData: const FlDotData(show: false),
                                          belowBarData:
                                              BarAreaData(show: false),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class TimerUtil {
  static String formatTime(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }
}
