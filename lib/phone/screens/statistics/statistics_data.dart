import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_screen_1.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/statistics-table.json',
);

//method to save the stat in the db
void saveStat(RunData r, {http.Client? client}) async {
  client ??= http.Client();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final postResponse = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'latitude': r.latitude,
      'longitude': r.longitude,
      'date': r.date,
      'duration': r.formattedTime,
      'averageSpeed': r.averageSpeed,
      'maxSpeed': r.maxSpeed,
      'distance': r.distanceInMeters,
      'speedPoints': r.speedDataPoints,
      'userid': prefs.getString('userId'),
    }),
  );

  if (postResponse.statusCode != 200) {
    throw Exception('Failed to save stat: ${postResponse.body}');
  }
}

Future<List<RunData>> getStats(String useriD) async {
  final response = await http.get(url);
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (response.statusCode == 200) {
    Map<String, dynamic> stats = jsonDecode(response.body);
    List<RunData> list = [];
    for (var entry in stats.entries) {
      var stat = entry.value;
      // if the stat is one of the user
      if (stat['userid'] == prefs.getString('userId')) {
        //add the stats to the list
        var points = stat['speedPoints'];
        RunData r = RunData(
          latitude: stat['latitude'],
          longitude: stat['longitude'],
          date: stat['date'],
          formattedTime: stat['duration'],
          averageSpeed: stat['averageSpeed'],
          maxSpeed: stat['maxSpeed'],
          distanceInMeters: stat['distance'],
          speedDataPoints: List<double>.from(points),
        );
        list.add(r);
      }
    }
    return list;
  } else {
    // If the server returns an error, handle i
    throw Exception("error");
  }
}

Future<RunData> getBestStat(String useriD) async {
  final response = await http.get(url);
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (response.statusCode == 200) {
    Map<String, dynamic> stats = jsonDecode(response.body);
    double maxspeed = 0;
    RunData r = RunData(
        latitude: 0,
        longitude: 0,
        date: "0",
        formattedTime: "0",
        averageSpeed: 0,
        maxSpeed: 0,
        distanceInMeters: 0,
        speedDataPoints: []);
    for (var entry in stats.entries) {
      var stat = entry.value;
      // if the stat is one of the user
      if (stat['userid'] == prefs.getString('userId') &&
          stat['maxSpeed'] > maxspeed) {
        //add the stats to the list
        var points = stat['speedPoints'];
        r = RunData(
          latitude: stat['latitude'],
          longitude: stat['longitude'],
          date: stat['date'],
          formattedTime: stat['duration'],
          averageSpeed: stat['averageSpeed'],
          maxSpeed: stat['maxSpeed'],
          distanceInMeters: stat['distance'],
          speedDataPoints: List<double>.from(points),
        );
        maxspeed = stat['maxSpeed'];
      }
    }
    return r;
  } else {
    // If the server returns an error, handle it
    throw Exception('Failed to load user credentials');
  }
}
