import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/skiResort/resort_list.dart';

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
              skiPassCost: '80€',
              elevation: '1500m',
              skiLifts: '30',
            ),
            // Add more resorts here...
          ],
          onFavouriteButtonPressed: () {
            // TODO: Handle button press
          },
        ),
      ),
    );
  }
}
