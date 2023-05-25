// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ski_resorts_app/constants/path_constants.dart';

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

  void _submitCity(BuildContext context) {
    final enteredCity = _cityController.text;
    // TODO: Implement weather data fetching based on the entered city
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
                      opacity: 0.7,
                      child: Container(
                        height: 40,
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitCity(context),
                child: const Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
