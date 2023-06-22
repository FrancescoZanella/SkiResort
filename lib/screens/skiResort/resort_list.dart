import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/skiResort/resort_container.dart';

class Resort {
  final String title;
  final String location;
  final String description;
  final String weather;
  final String snowConditions;
  final String elevation;
  final String trails;

  Resort({
    required this.title,
    required this.location,
    required this.description,
    required this.weather,
    required this.snowConditions,
    required this.elevation,
    required this.trails,
  });
}

class ResortList extends StatelessWidget {
  final List<Resort> resorts;
  final VoidCallback onFavouriteButtonPressed;

  const ResortList(
      {super.key,
      required this.resorts,
      required this.onFavouriteButtonPressed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resorts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              bottom: 16.0), // Add some space at the bottom of each container
          child: ResortContainer(
            title: resorts[index].title,
            location: resorts[index].location,
            description: resorts[index].description,
            weather: resorts[index].weather,
            snowConditions: resorts[index].snowConditions,
            elevation: resorts[index].elevation,
            trails: resorts[index].trails,
            onFavouriteButtonPressed: onFavouriteButtonPressed,
          ),
        );
      },
    );
  }
}
