import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/skiResort/resort_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/favorites-resort-table.json',
);

class MostPopularResortPage extends StatelessWidget {
  const MostPopularResortPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ResortList(
          resorts: [
            Resort(
              title: 'Rozzano Ski Resort',
              location: 'Location, Rozzano',
              description:
                  'Description of the ski resort. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              averageMarks: 4.2, // Here's the average marks value
              skiSlopesLenght: '10km',
              blueSkiSlopesLenght: '6',
              redSkiSlopesLenght: '3',
              blackSkiSlopesLenght: '1',
              skiPassCost: '100€',
              elevation: '2000m',
              skiLifts: '50',
            ),
            Resort(
              title: 'Another Ski Resort',
              location: 'Location, Another',
              description:
                  'Description of another ski resort. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              averageMarks: 3.8, // And here
              skiSlopesLenght: '8km',
              blueSkiSlopesLenght: '5',
              redSkiSlopesLenght: '2',
              blackSkiSlopesLenght: '1',
              skiPassCost: '80€',
              elevation: '1500m',
              skiLifts: '30',
            ),
          ],
          onFavouriteButtonPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String userId = prefs.getString('userId') ?? '';
            String userName = prefs.getString('name') ?? '';
            String userSurname = prefs.getString('surname') ?? '';
            //TODO: BUILD THE BODY OF THE POST REQUEST
          },
        ),
      ),
    );
  }
}
