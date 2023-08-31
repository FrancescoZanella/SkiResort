import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

final resortTableUrl = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/resorts-table.json',
);

final resortReviewsUrl = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/resorts-reviews.json',
);

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/favorites-resort-table.json',
);

class SummaryResort {
  String? skiResortId;
  final String skiResortLink;
  final String skiResortName;
  final String skiResortDescription;
  final String imageLink;
  double skiResortRating;
  final String totalSkiSlopes;
  final String blueSkiSlopes;
  final String redSkiSlopes;
  final String blackSkiSlopes;
  final String skiLiftsNumber;
  final String skiPassCost;
  final String skiResortElevation;
  final double skiResortLatitude;
  final double skiResortLongitude;
  int numberOfReviews;

  SummaryResort({
    required this.skiResortId,
    required this.skiResortLink,
    required this.skiResortName,
    required this.skiResortDescription,
    required this.imageLink,
    required this.skiResortRating,
    required this.totalSkiSlopes,
    required this.blueSkiSlopes,
    required this.redSkiSlopes,
    required this.blackSkiSlopes,
    required this.skiPassCost,
    required this.skiResortElevation,
    required this.skiLiftsNumber,
    required this.skiResortLatitude,
    required this.skiResortLongitude,
    required this.numberOfReviews,
  });

  factory SummaryResort.fromJson(Map<String, dynamic> json, String id) {
    try {
      return SummaryResort(
        skiResortId: id,
        skiResortLink: json['skiResortLink'],
        skiResortName: json['skiResortName'],
        skiResortDescription: json['skiResortDescription'],
        imageLink: json['imageLink'],
        skiResortRating: double.parse(json['skiResortRating']),
        totalSkiSlopes: json['totalSkiSlopes'],
        blueSkiSlopes: json['blueSkiSlopes'],
        redSkiSlopes: json['redSkiSlopes'],
        blackSkiSlopes: json['blackSkiSlopes'],
        skiPassCost: json['skiPassCost'],
        skiResortElevation: json['skiResortElevation'],
        skiLiftsNumber: json['skiLiftsNumber'],
        skiResortLatitude: double.parse(json['skiResortLatitude']),
        skiResortLongitude: double.parse(json['skiResortLongitude']),
        numberOfReviews: json['numberOfReviews'],
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error creating Resort from JSON: $e');
        print('JSON object was: $json');
      }
      rethrow;
    }
  }
}

class SkiResortMapPage extends StatefulWidget {
  const SkiResortMapPage({Key? key}) : super(key: key);

  @override
  State<SkiResortMapPage> createState() => _SkiResortMapPageState();
}

class _SkiResortMapPageState extends State<SkiResortMapPage> {
  bool _showInfoCard = false;
  SummaryResort? _selectedResort;
  List<SummaryResort>? skiResorts;
  String? userId;
  bool isFavorite = false;

  // Get the user id from the shared preferences
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    return userId;
  }

  @override
  void initState() {
    super.initState();
    getResorts().then((resorts) => setState(() {
          skiResorts = resorts;
        }));
    getUserId().then((id) => setState(() {
          userId = id;
        }));
  }

  Future<List<SummaryResort>> getResorts() async {
    final response = await http.get(resortTableUrl);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<SummaryResort> resorts = [];
      jsonResponse.forEach((key, value) {
        SummaryResort resort = SummaryResort.fromJson(value, key);
        resorts.add(resort);
      });
      return resorts;
    } else {
      throw Exception('Failed to load resorts');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<double?> showRatingDialog(BuildContext context) async {
      double? skiResortRating = 0.0;
      return showDialog<double>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Rate this ski resort'),
            content: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (r) {
                skiResortRating = r;
              },
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Submit'),
                onPressed: () async {
                  int totalReviews = _selectedResort!.numberOfReviews;
                  double currentRating = _selectedResort!.skiResortRating;
                  double newRating = 0.0;
                  String newRatingString = '';
                  String reviewId = '';

                  // Create a reference to the specific resort entry
                  final DatabaseReference resortRefResortTable =
                      FirebaseDatabase.instance
                          .ref()
                          .child('resorts-table')
                          .child(_selectedResort!.skiResortId!);

                  // Create a reference to the specific review user entry
                  final DatabaseReference resortRefResortReviews =
                      FirebaseDatabase.instance
                          .ref()
                          .child('resorts-reviews')
                          .child(reviewId);

                  // control if the user has already reviewed this resort
                  final response = await http.get(resortReviewsUrl);
                  if (response.statusCode == 200) {
                    Map<String, dynamic>? jsonResponse =
                        json.decode(response.body);
                    if (jsonResponse != null) {
                      jsonResponse.forEach((key, value) async {
                        if (value['userId'] == userId) {
                          if (value['skiResortId'] ==
                              _selectedResort!.skiResortId) {
                            reviewId = key;
                            // just modify the rating in the resort table
                            newRating = (currentRating * totalReviews -
                                    value['skiResortRating'] +
                                    skiResortRating!) /
                                totalReviews;

                            // update the rating in the firebase realtime database
                            await resortRefResortReviews.update({
                              'skiResortRating': newRating.toStringAsFixed(2),
                            });
                          }
                        } else {
                          // add a new review made by the user on this resort and modify the rating in the resort table
                          newRating = (currentRating * totalReviews +
                                  skiResortRating!) /
                              (totalReviews + 1);

                          totalReviews++;

                          // create a new review entry in the firebase realtime database with post request
                          await http.post(
                            resortReviewsUrl,
                            headers: {'Content-Type': 'application/json'},
                            body: json.encode(
                              {
                                'userId': userId,
                                'skiResortId': _selectedResort!.skiResortId,
                                'skiResortRating': skiResortRating,
                              },
                            ),
                          );
                        }
                      });
                    } else {
                      // add a new review made by the user on this resort and modify the rating in the resort table
                      newRating =
                          (currentRating * totalReviews + skiResortRating!) /
                              (totalReviews + 1);

                      totalReviews++;

                      // create a new review entry in the firebase realtime database with post request
                      await http.post(
                        resortReviewsUrl,
                        headers: {'Content-Type': 'application/json'},
                        body: json.encode(
                          {
                            'userId': userId,
                            'skiResortId': _selectedResort!.skiResortId,
                            'skiResortRating': skiResortRating,
                          },
                        ),
                      );
                    }
                  } else {
                    throw Exception('Failed to load resort ratings');
                  }

                  newRating = double.parse(newRating.toStringAsFixed(2));

                  // newRating now is a double; must became a string to be stored in the database
                  newRatingString = newRating.toString();

                  // update the resort entries in the firebase realtime database
                  await resortRefResortTable
                      .update({"numberOfReviews": totalReviews});
                  await resortRefResortTable
                      .update({"skiResortRating": newRatingString});

                  if (mounted) {
                    setState(() {
                      _selectedResort!.numberOfReviews = totalReviews;
                      _selectedResort!.skiResortRating = newRating;
                    });
                    Navigator.of(context).pop(newRating);
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return Stack(
      children: [
        skiResorts == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FlutterMap(
                options: MapOptions(
                  center: const LatLng(45.477859, 9.1900),
                  zoom: 5.2,
                ),
                nonRotatedChildren: [
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () => launchUrl(
                            Uri.parse('https://openstreetmap.org/copyright')),
                      ),
                    ],
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: skiResorts!
                        .map((resort) => Marker(
                              width: 80.0 + (resort.skiResortRating * 10),
                              height: 80.0 + (resort.skiResortRating * 10),
                              point: LatLng(resort.skiResortLatitude,
                                  resort.skiResortLongitude),
                              builder: (ctx) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showInfoCard = true;
                                    _selectedResort = resort;
                                  });
                                },
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.blue,
                                  size: 10.0 + (resort.skiResortRating * 10),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
        if (_showInfoCard)
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              margin: const EdgeInsets.all(0.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            _selectedResort?.skiResortName ?? 'Unknown',
                            style: const TextStyle(fontSize: 24),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () =>
                              setState(() => _showInfoCard = false),
                        ),
                      ],
                    ),
                    if (_selectedResort != null) ...[
                      Row(
                        children: [
                          Text(
                            "${_selectedResort!.skiResortRating} ",
                            style: const TextStyle(fontSize: 20),
                          ),
                          RatingBarIndicator(
                            rating: _selectedResort!.skiResortRating,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 24.0,
                            direction: Axis.horizontal,
                          ),
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () async {
                              double? userRating =
                                  await showRatingDialog(context);
                              setState(() {
                                _selectedResort!.skiResortRating = userRating!;
                              });
                            },
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Elevation: ${_selectedResort!.skiResortElevation}',
                            style: const TextStyle(fontSize: 20)),
                      ),
                      const SizedBox(
                          height:
                              12), // This will add space between the elevation and ski slopes lines.

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Ski Slopes: ${_selectedResort!.totalSkiSlopes}',
                            style: const TextStyle(fontSize: 20)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ski Pass Cost: ${_selectedResort!.skiPassCost}',
                              style: const TextStyle(fontSize: 20)),
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            //if the resort is already in favorites, i want to show the filled heart icon: a red heart
                            color: isFavorite ? Colors.red : null,

                            onPressed: () async {
                              setState(() {
                                isFavorite = !isFavorite;
                              });

                              //check if the user already has the resort in favorites, if yes don't add it again
                              final getResponse = await http.get(url);
                              if (getResponse.statusCode == 200) {
                                Map<String, dynamic>? data =
                                    json.decode(getResponse.body);

                                if (data != null) {
                                  List<dynamic> resorts = data.values.toList();

                                  for (var resort in resorts) {
                                    if (resort['userId'] == userId &&
                                        resort['skiResortId'] ==
                                            _selectedResort!.skiResortId) {
                                      setState(() {
                                        isFavorite = true;
                                      });
                                      return; // exit the function early to avoid making the post request
                                    }
                                  }
                                }
                              }

                              // post request to insert the resort into the favorites table
                              final postResponse = await http.post(
                                url,
                                body: json.encode({
                                  'userId': userId,
                                  'skiResortId': _selectedResort!.skiResortId,
                                  'skiResortLink':
                                      _selectedResort!.skiResortLink,
                                  'skiResortName':
                                      _selectedResort!.skiResortName,
                                  'skiResortDescription':
                                      _selectedResort!.skiResortDescription,
                                  'imageLink': _selectedResort!.imageLink,
                                  'skiResortRating':
                                      _selectedResort!.skiResortRating,
                                  'totalSkiSlopes':
                                      _selectedResort!.totalSkiSlopes,
                                  'blueSkiSlopes':
                                      _selectedResort!.blueSkiSlopes,
                                  'redSkiSlopes': _selectedResort!.redSkiSlopes,
                                  'blackSkiSlopes':
                                      _selectedResort!.blackSkiSlopes,
                                  'skiPassCost': _selectedResort!.skiPassCost,
                                  'skiResortElevation':
                                      _selectedResort!.skiResortElevation,
                                  'skiLiftsNumber':
                                      _selectedResort!.skiLiftsNumber,
                                  'skiResortLatitude':
                                      _selectedResort!.skiResortLatitude,
                                  'skiResortLongitude':
                                      _selectedResort!.skiResortLongitude,
                                }),
                              );
                              if (postResponse.statusCode != 200) {
                                throw Exception(
                                    'Failed to register user: ${postResponse.body}');
                              }
                            }, //() => addToFavorites(_selectedResort!),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
