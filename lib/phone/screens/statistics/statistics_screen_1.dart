import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_data.dart';
import 'package:supercharged/supercharged.dart';

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

  String getmaxSpeed() {
    return maxSpeed.toString();
  }

  String getTime() {
    return formattedTime.toString();
  }

  String getDistance() {
    return distanceInMeters.toString();
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Location location = Location();
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  StreamSubscription<LocationData>? locationSubscription;
  bool isRunning = false;

  LocationData? previousLocation;
  double totalDistance = 0.0;
  List<double> speedData = [];
  String elapsed = '00:00:00';

  void startstopwatch() {
    startLocationTracking();
    stopwatch.start();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer t) {
      // Update the UI
      setState(() {
        // result in hh:mm:ss format
        elapsed =
            '${stopwatch.elapsed.inHours.toString().padLeft(2, '0')}:${(stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
  }

  void startLocationTracking() {
    locationSubscription =
        location.onLocationChanged.listen((LocationData newLocation) {
      handleLocationChange(newLocation);
    });
  }

  void stopLocationTracking() {
    locationSubscription?.cancel();
    timer?.cancel();
    stopwatch.stop();
    stopwatch.reset();
    setState(() {
      isRunning = false;
      RunData r = RunData(
        latitude: previousLocation!.latitude,
        longitude: previousLocation!.longitude,
        date: DateFormat.yMMMMd('en_US').format(DateTime.now()),
        formattedTime: elapsed,
        averageSpeed: speedData.averageBy((n) => n)!,
        maxSpeed: speedData.max()!,
        distanceInMeters: totalDistance,
        speedDataPoints: List.from(speedData), // Copy the speed data points
      );
      _addedList.add(r);
      //aggiungo al db
      saveStat(r);
      totalDistance = 0;
      previousLocation = null;
      elapsed = "00:00:00";
    });
  }

  void handleLocationChange(LocationData newLocation) {
    if (previousLocation != null) {
      double distance = Geolocator.distanceBetween(
        previousLocation!.latitude!,
        previousLocation!.longitude!,
        newLocation.latitude!,
        newLocation.longitude!,
      );
      setState(() {
        isRunning = true;
        totalDistance += distance;
        speedData.add(newLocation.speed!);
      });
    }
    setState(() {
      previousLocation = newLocation;
    });
  }

  //backend caricamento
  late Future<List<RunData>> _runDataList;
  final List<RunData> _addedList = [];

  @override
  void initState() {
    super.initState();
    _runDataList = _initializeRunDataList();
  }

  Future<List<RunData>> _initializeRunDataList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await getStats(prefs.getString('userId')!);
    } catch (e) {
      // Handle any errors that might occur during initialization
      throw Exception(e);
    }
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
    return FutureBuilder(
        future: _runDataList, // Wait for the statistics to be loaded
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Text("not found");
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  color: Colors.blue,
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'lib/assets/icons/output.png',
                          height: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Training",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: "NotoSansKR",
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('lib/assets/icons/clock.png',
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.blueGrey
                          : Colors.blue[50],
                      height: MediaQuery.of(context).size.height *
                          0.33), // Replace with your image path
                  Positioned(
                    top: 60,
                    child: Text(
                      TimerUtil.formatTime(stopwatch.elapsed),
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 115,
                    child: Text(
                      'Speed: ${previousLocation?.speed?.toStringAsFixed(2) ?? "N/A"} m/s',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54,
                      ),
                      /** */
                    ),
                  ),
                  Positioned(
                    top: 155,
                    child: Text(
                      'Distance: ${totalDistance.toStringAsFixed(2)} m', // Modified line
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black54,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: isRunning ? null : startstopwatch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const CircleBorder(),
                      minimumSize: const Size(55, 55),
                    ),
                    child: const Icon(Icons.play_arrow,
                        size: 30), // Use the play icon
                  ),
                  ElevatedButton(
                    onPressed: stopLocationTracking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const CircleBorder(),
                      minimumSize: const Size(55, 55),
                    ),
                    child: const Icon(Icons.stop, size: 30),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: (snapshot.data! + _addedList).length,
                  itemBuilder: (context, index) {
                    var data = (snapshot.data! + _addedList)[index];
                    return Card(
                      elevation: 2,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromRGBO(32, 33, 36, 255)
                          : Colors.white, //.withOpacity(0.7),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'lib/assets/icons/output.png',
                                  height: 24, // Adjust the image size as needed
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    Text("Ski",
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black38,
                                        )),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                    ),
                                    Text(data.date,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black38,
                                            fontSize: 15)),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    Text(
                                      textAlign: TextAlign.left,
                                      data.distanceInMeters.toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black54,
                                      ),
                                    ),
                                    Text("  m",
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black54,
                                        )),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    Text(
                                      textAlign: TextAlign.left,
                                      data.formattedTime,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black54),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.045),
                                    Text(
                                      textAlign: TextAlign.left,
                                      "${data.averageSpeed.toStringAsFixed(2)} m/s",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black54),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 180,
                            child: LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: true),
                                titlesData: const FlTitlesData(
                                    leftTitles: AxisTitles(
                                      axisNameWidget: Text("m/s"),
                                    ),
                                    topTitles:
                                        AxisTitles(axisNameWidget: Text("s"))),
                                borderData: FlBorderData(show: false),
                                minX: 0,
                                maxX: data.speedDataPoints.length.toDouble(),
                                minY: 0,
                                maxY: data.maxSpeed * 1.2,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: data.speedDataPoints
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int index = entry.key;
                                      double speed = entry.value;
                                      return FlSpot(index.toDouble(), speed);
                                    }).toList(),
                                    isCurved: true,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black38,
                                    dotData: const FlDotData(show: false),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Training duration",
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black38,
                                        )),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.003),
                                    Text(data.formattedTime)
                                  ]),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Average Speed",
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black38,
                                        )),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.003),
                                    Text(
                                        '${data.averageSpeed.toStringAsFixed(2)} m/s')
                                  ]),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Max Speed",
                                      style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black38,
                                      )),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.003),
                                  Text(
                                      '${data.maxSpeed.toStringAsFixed(2)} m/s')
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.003),
                          Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1),
                              const Text("View Position on: "),
                              GestureDetector(
                                onTap: () {
                                  _openInGoogleMaps(
                                      data.latitude, data.longitude);
                                },
                                child: Image.asset(
                                  'lib/assets/icons/noun-position-2115343.png',
                                  height: 35,
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
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
