import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/homepage/card.dart';
import 'package:ski_resorts_app/screens/homepage/weathercard.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // scritta services
            Text(
              '    Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              height: 400,
              color: Colors.white,
            ),
            Positioned(
                top: 20,
                left: 20,
                child: MyCard(
                  title: 'Ski Resorts',
                  width: 165.0,
                  height: 180.0,
                  image: 'lib/assets/images/Statistics.jpg',
                  route: '',
                )),
            Positioned(
                top: 20,
                right: 20,
                child: MyCard(
                  title: 'Favourites',
                  width: 165.0,
                  height: 210.0,
                  image: 'lib/assets/images/favourites.jpg',
                  route: '/FavoritesScreen',
                )),
            Positioned(
                top: 210,
                left: 20,
                child: MyCard(
                  title: 'Statistics',
                  width: 165.0,
                  height: 170.0,
                  image: 'lib/assets/images/ski_resorts.jpg',
                  route: '/StatisticsScreen',
                )),
            Positioned(
                top: 244,
                right: 20,
                child: Weather(
                  title: 'Weather',
                  width: 165.0,
                  height: 140.0,
                  route: '/MeteoPage',
                )),
          ],
        )
      ],
    );
  }
}
