import 'package:flutter/material.dart';

class SkiResortMapPage extends StatelessWidget {
  final List<ResortMarker> resortMarkers = [
    ResortMarker(
      name: 'Resort 1',
      latitude: 40.7128,
      longitude: -74.0060,
    ),
    ResortMarker(
      name: 'Resort 2',
      latitude: 47.6062,
      longitude: -122.3321,
    ),
    ResortMarker(
      name: 'Resort 3',
      latitude: 51.5074,
      longitude: -0.1278,
    ),
    ResortMarker(
      name: 'Resort 4',
      latitude: 45.4215,
      longitude: -75.6999,
    ),
    ResortMarker(
      name: 'Resort 5',
      latitude: 48.8566,
      longitude: 2.3522,
    ),
  ];

  SkiResortMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Image.asset(
          //  'assets/images/map_background.jpg', // Replace with your map image
          //  fit: BoxFit.cover,
          //  width: double.infinity,
          //  height: double.infinity,
          //),
          ListView.builder(
            itemCount: resortMarkers.length,
            itemBuilder: (context, index) {
              return ResortMarkerWidget(resortMarker: resortMarkers[index]);
            },
          ),
        ],
      ),
    );
  }
}

class ResortMarker {
  final String name;
  final double latitude;
  final double longitude;

  ResortMarker({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class ResortMarkerWidget extends StatelessWidget {
  final ResortMarker resortMarker;

  const ResortMarkerWidget({super.key, required this.resortMarker});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _calculateLeftPosition(context),
      top: _calculateTopPosition(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          resortMarker.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  double _calculateLeftPosition(BuildContext context) {
    // Calculate the left position based on the longitude and container width
    double containerWidth = MediaQuery.of(context).size.width;
    double longitudePercentage = (resortMarker.longitude + 180) / 360;
    return containerWidth * longitudePercentage;
  }

  double _calculateTopPosition(BuildContext context) {
    // Calculate the top position based on the latitude and container height
    double containerHeight = MediaQuery.of(context).size.height;
    double latitudePercentage = (90 - resortMarker.latitude) / 180;
    return containerHeight * latitudePercentage;
  }
}
