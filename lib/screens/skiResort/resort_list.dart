import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/skiResort/resort_container.dart';

class Resort {
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

  Resort({
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
  });

  // Here's the fromJson method:
  factory Resort.fromJson(Map<String, dynamic> json) {
    return Resort(
      skiResortName: json['skiResortName'],
      skiResortDescription: json['skiResortDescription'],
      imageLink: json['imageLink'],
      skiResortRating: json['rating_title'].toDouble(),
      totalSkiSlopes: json['totalSkiSlopes'],
      blueSkiSlopes: json['blueSkiSlopes'],
      redSkiSlopes: json['redSkiSlopes'],
      blackSkiSlopes: json['blackSkiSlopes'],
      skiPassCost: json['skiPassCost'],
      skiResortElevation: json['skiResortElevation'],
      skiLiftsNumber: json['skiLiftsNumber'],
    );
  }
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
            skiResortName: resorts[index].skiResortName,
            skiResortDescription: resorts[index].skiResortDescription,
            imageLink: resorts[index].imageLink,
            skiResortRating: resorts[index].skiResortRating,
            totalSkiSlopes: resorts[index].totalSkiSlopes,
            blueSkiSlopes: resorts[index].blueSkiSlopes,
            redSkiSlopes: resorts[index].redSkiSlopes,
            blackSkiSlopes: resorts[index].blackSkiSlopes,
            skiPassCost: resorts[index].skiPassCost,
            skiResortElevation: resorts[index].skiResortElevation,
            skiLiftsNumber: resorts[index].skiLiftsNumber,
            onFavouriteButtonPressed: onFavouriteButtonPressed,
          ),
        );
      },
    );
  }
}
