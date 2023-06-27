// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:ski_resorts_app/constants/path_constants.dart';
import 'package:ski_resorts_app/screens/weather/weather_container.dart';
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

  String temperature = '';
  String weatherCondition = '';
  String windSpeed = '';
  String humidity = '';
  String skiResortName = '';
  String skiResortElevation = '';
  String skiResortTrailCount = '';

  // City list for autocomplete
  final List<String> _cities = <String>[
    'Miami',
    'Milan',
    'Minneapolis',
    'Minsk',
    'Mumbai',
    'Munich',
    'Moscow'
  ];

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
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Autocomplete<String>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable<String>.empty();
                                }
                                return _cities.where((String option) {
                                  return option.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (String selection) {
                                _cityController.text = selection;
                              },
                              optionsViewBuilder: (BuildContext context,
                                  AutocompleteOnSelected<String> onSelected,
                                  Iterable<String> options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4.0,
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          maxHeight: 200.0),
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        children: options
                                            .map((String option) =>
                                                GestureDetector(
                                                  onTap: () =>
                                                      onSelected(option),
                                                  child: ListTile(
                                                    title: Text(option),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController
                                      fieldTextEditingController,
                                  FocusNode fieldFocusNode,
                                  VoidCallback onFieldSubmitted) {
                                return TextField(
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    hintText: _cityController.text.isEmpty
                                        ? 'Enter a location'
                                        : '',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                );
                              },
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
                      child: const WeatherContainer(
                        temperature: '25',
                        windSpeed: '10',
                        humidity: '80',
                        rainfall: '5',
                        elevation: '1880',
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
