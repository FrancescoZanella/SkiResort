import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ResortContainer extends StatelessWidget {
  final String title;
  final String location;
  final String description;
  final double averageMarks; // Change from String to double
  final String skiSlopesLenght;
  final String skiPassCost;
  final String elevation;
  final String skiLifts;
  final VoidCallback onFavouriteButtonPressed;

  const ResortContainer({
    Key? key,
    required this.title,
    required this.location,
    required this.description,
    required this.averageMarks, // Change from String to double
    required this.skiSlopesLenght,
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
                leading: const Icon(Icons.analytics_outlined),
                title: RatingBarIndicator(
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
              ListTile(
                leading: const Icon(Icons.height),
                title: Text('Elevation: $elevation'),
              ),
              ListTile(
                leading: const Icon(Icons.downhill_skiing),
                title: Text('Ski slopes: $skiSlopesLenght'),
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
