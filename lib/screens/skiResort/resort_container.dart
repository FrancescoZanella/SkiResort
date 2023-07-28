import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResortContainer extends StatefulWidget {
  final String skiResortId;
  final String skiResortLink;
  final String skiResortName;
  final String skiResortDescription;
  final String imageLink;
  final double skiResortRating;
  final String totalSkiSlopes;
  final String blueSkiSlopes;
  final String redSkiSlopes;
  final String blackSkiSlopes;
  final String skiPassCost;
  final String skiResortElevation;
  final String skiLiftsNumber;
  final double skiResortLatitude;
  final double skiResortLongitude;
  final VoidCallback onFavouriteButtonPressed;

  const ResortContainer({
    Key? key,
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
    required this.onFavouriteButtonPressed,
  }) : super(key: key);

  @override
  State<ResortContainer> createState() => _ResortContainerState();
}

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/favorites-resort-table.json',
);

class _ResortContainerState extends State<ResortContainer>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  String? userId;

  void getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 1, end: 1.4).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.background
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.imageLink,
                    ), // Use NetworkImage to load image from URL
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.skiResortName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).textTheme.bodyLarge?.color
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                // Padding for RatingBarIndicator
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RatingBarIndicator(
                  rating: widget.skiResortRating,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.skiResortDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).textTheme.bodyLarge?.color
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.height),
                title: Text('Elevation: ${widget.skiResortElevation}'),
              ),
              ListTile(
                leading: const Icon(Icons.downhill_skiing),
                title: Row(
                  children: [
                    Expanded(
                      child: Text('Ski slopes: ${widget.totalSkiSlopes}'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blue,
                      child: Text(
                        widget.blueSkiSlopes,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.red,
                      child: Text(
                        widget.redSkiSlopes,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black,
                      child: Text(
                        widget.blackSkiSlopes,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.arrow_upward),
                title: Text('Ski lifts: ${widget.skiLiftsNumber}'),
              ),
              ListTile(
                leading: const Icon(Icons.euro_symbol_sharp),
                title: Text('Ski Pass Cost: ${widget.skiPassCost}'),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    widget.onFavouriteButtonPressed;
                    _controller.forward();
                    // post request to insert the resort into the favorites table
                    final postResponse = await http.post(
                      url,
                      body: json.encode({
                        'userId': userId,
                        'skiResortId': widget.skiResortId,
                        'skiResortLink': widget.skiResortLink,
                        'skiResortName': widget.skiResortName,
                        'skiResortDescription': widget.skiResortDescription,
                        'imageLink': widget.imageLink,
                        'skiResortRating': widget.skiResortRating,
                        'totalSkiSlopes': widget.totalSkiSlopes,
                        'blueSkiSlopes': widget.blueSkiSlopes,
                        'redSkiSlopes': widget.redSkiSlopes,
                        'blackSkiSlopes': widget.blackSkiSlopes,
                        'skiPassCost': widget.skiPassCost,
                        'skiResortElevation': widget.skiResortElevation,
                        'skiLiftsNumber': widget.skiLiftsNumber,
                        'skiResortLatitude': widget.skiResortLatitude,
                        'skiResortLongitude': widget.skiResortLongitude,
                      }),
                    );
                    if (postResponse.statusCode != 200) {
                      throw Exception(
                          'Failed to register user: ${postResponse.body}');
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  child: Text(
                    isFavorite ? 'Added to favorites ✅' : 'Add to favorites',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _animation.value * 18,
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
