import 'package:flutter/material.dart';

class Favorite {
  final String name;
  final String image;
  final String location;
  final int rating;

  Favorite(this.name, this.image, this.location, this.rating);
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Favorite> _favorites = [
    Favorite(
        'Aspen Mountain',
        'https://www.aspensnowmass.com/-/media/aspen-snowmass/images/hero/hero-image/winter/2021-22/safety-announcements-hero-08192021.jpg?mw=1506&mh=930&hash=DB1E48A3CC94E5ED795D2BA9B140E6B5',
        'Colorado, USA',
        4),
    Favorite(
        'Whistler Blackcomb',
        'https://afar.brightspotcdn.com/dims4/default/906b260/2147483647/strip/true/crop/728x500+36+0/resize/660x453!/format/webp/quality/90/?url=https%3A%2F%2Fafar-media-production-web.s3.amazonaws.com%2Fbrightspot%2F86%2F19%2F3bd86d690576defafe014166957f%2Foriginal-5b4a18aedca298cb23631f4dd6e54e37.jpg',
        'British Columbia, Canada',
        5),
    Favorite(
        'Courchevel',
        'http://www.alpineworld.com.au/wp-content/uploads/2014/12/snow-1024x667.jpg',
        'Savoie, France',
        3),
    Favorite(
        'Niseko',
        'https://www.agoda.com/wp-content/uploads/2019/12/Grand-Hirafu-Niseko-Village-ski-resort-things-to-do-in-Niseko-Japan.jpg',
        'Hokkaido, Japan',
        4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          final favorite = _favorites[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  favorite.image,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    favorite.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    favorite.location,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        '${favorite.rating}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
