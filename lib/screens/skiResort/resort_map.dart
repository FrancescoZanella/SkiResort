import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/resorts-table.json',
);

class SummaryResort {
  final String skiResortName;
  double skiResortRating;
  final String totalSkiSlopes;
  final String skiPassCost;
  final String skiResortElevation;
  final double skiResortLatitude;
  final double skiResortLongitude;
  int numberOfReviews;

  SummaryResort({
    required this.skiResortName,
    required this.skiResortRating,
    required this.totalSkiSlopes,
    required this.skiPassCost,
    required this.skiResortElevation,
    required this.skiResortLatitude,
    required this.skiResortLongitude,
    required this.numberOfReviews,
  });

  factory SummaryResort.fromJson(Map<String, dynamic> json) {
    return SummaryResort(
      skiResortName: json['skiResortName'],
      skiResortRating: double.parse(json['skiResortRating']),
      totalSkiSlopes: json['totalSkiSlopes'],
      skiPassCost: json['skiPassCost'],
      skiResortElevation: json['skiResortElevation'],
      skiResortLatitude: double.parse(json['skiResortLatitude']),
      skiResortLongitude: double.parse(json['skiResortLongitude']),
      numberOfReviews: json['numberOfReviews'],
    );
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

  @override
  void initState() {
    super.initState();
    getResorts().then((resorts) => setState(() {
          skiResorts = resorts;
        }));
  }

  Future<List<SummaryResort>> getResorts() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<SummaryResort> resorts = [];
      jsonResponse.forEach((key, value) {
        resorts.add(SummaryResort.fromJson(value));
      });
      return resorts;
    } else {
      throw Exception('Failed to load resorts');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<double?> showRatingDialog(BuildContext context) async {
      double? rating = 0.0;
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
                rating = r;
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
                onPressed: () {
                  Navigator.of(context).pop(rating);
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
                            /*favorites.contains(_selectedResort)
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border),*/
                            onPressed: () {
                              //favorites.contains(_selectedResort)
                              //? removeFromFavorites(_selectedResort!)
                              //: addToFavorites(_selectedResort!);
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
