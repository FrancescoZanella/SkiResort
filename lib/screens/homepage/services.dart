import 'package:flutter/material.dart';
import 'package:ski_resorts_app/constants/color_constants.dart';
import 'package:ski_resorts_app/widgets/button.dart';
import 'package:ski_resorts_app/widgets/card.dart';
import 'package:ski_resorts_app/widgets/weathercard.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
        ),
        Stack(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 50,
              width: MediaQuery.of(context).size.width,
            ),
            const Positioned(
              top: 25,
              left: 15,
              child: Text(
                '    Services',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Positioned(
              right: 35,
              bottom: 2,
              child: Button(
                  color: ColorConstants.orange,
                  icon: Icons.play_arrow,
                  key: key),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              height: 400,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Colors.white,
            ),
            Positioned(
                top: 20,
                left: 20,
                child: MyCard(
                  title: 'Ski Resorts',
                  width: 165.0,
                  height: 180.0,
                  image: 'lib/assets/images/Statistics.jpg',
                  route: '/SkiResortScreen',
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
                  image:
                      'lib/assets/images/22702455-statistica-icona-con-colorato-piatto-stile-isolato-su-bianca-sfondo-vettoriale.jpg',
                  route: '/StatisticsScreen',
                )),
            Positioned(
                top: 244,
                right: 20,
                child: Weather(
                  title: 'Weather',
                  width: 165.0,
                  height: 140.0,
                  route: '/WeatherScreen',
                )),
          ],
        )
      ],
    );
  }
}
