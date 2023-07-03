import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/skiResort/resort_container.dart';

class Resort {
  final String title;
  final String location;
  final String description;
  final double averageMarks;
  final String blueSkiSlopesLenght;
  final String redSkiSlopesLenght;
  final String blackSkiSlopesLenght;
  final String skiSlopesLenght;
  final String skiPassCost;
  final String elevation;
  final String skiLifts;

  Resort({
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
  });
}

class ResortList extends StatelessWidget {
  final List<Resort> resorts;
  final VoidCallback onFavouriteButtonPressed;

  const ResortList({
    Key? key,
    required this.resorts,
    required this.onFavouriteButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resorts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ResortContainer(
            title: resorts[index].title,
            location: resorts[index].location,
            description: resorts[index].description,
            averageMarks: resorts[index].averageMarks,
            skiSlopesLenght: resorts[index].skiSlopesLenght,
            blueSkiSlopesLenght: resorts[index].blueSkiSlopesLenght,
            redSkiSlopesLenght: resorts[index].redSkiSlopesLenght,
            blackSkiSlopesLenght: resorts[index].blackSkiSlopesLenght,
            skiPassCost: resorts[index].skiPassCost,
            elevation: resorts[index].elevation,
            skiLifts: resorts[index].skiLifts,
            onFavouriteButtonPressed: onFavouriteButtonPressed,
          ),
        );
      },
    );
  }
}
