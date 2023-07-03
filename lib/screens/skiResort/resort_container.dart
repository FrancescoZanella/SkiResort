import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ResortContainer extends StatelessWidget {
  final String title;
  final String location;
  final String description;
  final double averageMarks;
  final String skiSlopesLenght;
  final String blueSkiSlopesLenght;
  final String redSkiSlopesLenght;
  final String blackSkiSlopesLenght;
  final String skiPassCost;
  final String elevation;
  final String skiLifts;
  final VoidCallback onFavouriteButtonPressed;

  const ResortContainer({
    Key? key,
    required this.title,
    required this.location,
    required this.description,
    required this.averageMarks,
    required this.skiSlopesLenght,
    required this.blueSkiSlopesLenght,
    required this.redSkiSlopesLenght,
    required this.blackSkiSlopesLenght,
    required this.skiPassCost,
    required this.elevation,
    required this.skiLifts,
    required this.onFavouriteButtonPressed,
  }) : super(key: key);

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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/skiResortImage.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).textTheme.bodyLarge?.color
                        : Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                // Padding for RatingBarIndicator
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RatingBarIndicator(
                  rating: averageMarks,
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
                  description,
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
                title: Text('Elevation: $elevation'),
              ),
              ListTile(
                leading: const Icon(Icons.downhill_skiing),
                title: Row(
                  children: [
                    Expanded(
                      child: Text('Ski slopes: $skiSlopesLenght'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blue,
                      child: Text(
                        '$blueSkiSlopesLenght km',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.red,
                      child: Text(
                        '$redSkiSlopesLenght km',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black,
                      child: Text(
                        '$blackSkiSlopesLenght km',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.arrow_upward),
                title: Text('Ski lifts: $skiLifts'),
              ),
              ListTile(
                leading: const Icon(Icons.euro_symbol_sharp),
                title: Text('Ski Pass Cost: $skiPassCost'),
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
                  onPressed: onFavouriteButtonPressed,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  child: const Text('Add to Favourites'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
