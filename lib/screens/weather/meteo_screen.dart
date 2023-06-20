// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ski_resorts_app/constants/path_constants.dart';
import 'dart:ui';

enum SearchMethod {
  manual,
  automatic,
}

class MeteoPageScreen extends StatefulWidget {
  const MeteoPageScreen({Key? key}) : super(key: key);

  @override
  State<MeteoPageScreen> createState() => _MeteoPageScreenState();
}

class _MeteoPageScreenState extends State<MeteoPageScreen> {
  final TextEditingController _cityController = TextEditingController();
  SearchMethod _searchMethod = SearchMethod.manual;
// Track if user is typing

  String temperature = '';
  String weatherCondition = '';
  String windSpeed = '';
  String humidity = '';
  String skiResortName = '';
  String skiResortElevation = '';
  String skiResortTrailCount = '';

  void _submitCity(BuildContext context) {
    final enteredCity = _cityController.text;
    // TODO: Implement weather data fetching based on the entered city
    // Here, you would fetch the weather data based on the entered city
    // and update the weather information variables
    temperature = '25°C';
    weatherCondition = 'Sunny';
    windSpeed = '10 km/h';
    humidity = '70%';
    skiResortName = 'Ski Resort';
    skiResortElevation = '2000m';
    skiResortTrailCount = '15';

    setState(() {});

    print('Submitted city: $enteredCity');
  }

  void _selectSearchMethod(SearchMethod method) {
    setState(() {
      _searchMethod = method;
      if (method == SearchMethod.automatic) {
        // TODO: Implement automatic location detection
        print('Using current location');
      }
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: null,
      resizeToAvoidBottomInset:
          false, // Prevents resizing when the keyboard appears
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(PathConstants.sunnyDay),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Opacity(
                      opacity: _cityController.text.isEmpty ? 0.7 : 0.0,
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Enter a location',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _cityController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        PopupMenuButton<SearchMethod>(
                          initialValue: _searchMethod,
                          onSelected: (SearchMethod method) {
                            _selectSearchMethod(method);
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SearchMethod>>[
                            const PopupMenuItem<SearchMethod>(
                              value: SearchMethod.manual,
                              child: ListTile(
                                leading: Icon(Icons.location_on),
                                title: Text('Enter city manually'),
                              ),
                            ),
                            const PopupMenuItem<SearchMethod>(
                              value: SearchMethod.automatic,
                              child: ListTile(
                                leading: Icon(Icons.my_location),
                                title: Text('Use current location'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () => _submitCity(context),
                child: const Text('Search'),
              ),
              const SizedBox(height: 50),
              Opacity(
                opacity: 0.4,
                child: Container(
                  width: 380,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.white.withOpacity(0.2),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Rozzano',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  temperature,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.thermostat_outlined),
                                      const SizedBox(width: 5),
                                      const Text(
                                        '25°C',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        temperature,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.cloud,
                                    size: 80,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.thermostat_outlined),
                                const SizedBox(width: 5),
                                const Text(
                                  'Perceived temperature: 20°C',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  temperature,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.waves_outlined),
                                const SizedBox(width: 5),
                                const Text(
                                  'Wind Speed: 10 km/h',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  windSpeed,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.opacity_outlined),
                                const SizedBox(width: 5),
                                const Text(
                                  'Humidity: 80%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  humidity,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.terrain_outlined),
                                const SizedBox(width: 5),
                                const Text(
                                  'Rainfall: 5 cm',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  skiResortName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.height_outlined),
                                const SizedBox(width: 5),
                                const Text(
                                  'Elevation: 1880m',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  skiResortElevation,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
