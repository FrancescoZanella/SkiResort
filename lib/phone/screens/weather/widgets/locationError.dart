// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/weatherProvider.dart';

class LocationError extends StatefulWidget {
  const LocationError({super.key});

  @override
  State<LocationError> createState() => _LocationErrorState();
}

class _LocationErrorState extends State<LocationError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_off,
            color: Colors.black,
            size: 75,
          ),
          const SizedBox(height: 10),
          const Text(
            'Your Location is Disabled',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 75, vertical: 10),
            child: Text(
              "Please turn on your location service and refresh the app",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              textStyle: const TextStyle(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 50),
            ),
            child: const Text('Enable Location'),
            onPressed: () async {
              await Provider.of<WeatherProvider>(context, listen: false)
                  .getWeatherData(context);
            },
          ),
        ],
      ),
    );
  }
}
