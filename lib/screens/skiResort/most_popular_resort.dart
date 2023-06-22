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
              weather: 'Sunny',
              snowConditions: 'Fresh Powder',
              elevation: '2000m',
              trails: '50',
            ),
            Resort(
              title: 'Another Ski Resort',
              location: 'Location, Another',
              description:
                  'Description of another ski resort. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              weather: 'Cloudy',
              snowConditions: 'Moderate Snow',
              elevation: '1500m',
              trails: '30',
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
