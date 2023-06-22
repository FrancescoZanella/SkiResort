import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class SkiResortMapPage extends StatelessWidget {
  const SkiResortMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          zoom: 5.0, // Set the initial zoom level (0-18)
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png?lang=en', // OpenStreetMap tile provider URL
            subdomains: ['a', 'b', 'c'], // Tile server subdomains
          ),
        ],
      ),
    );
  }
}
