import 'package:flutter/material.dart';

class FavoriteWidget {
  static Widget favoriteWidget(favorite, context) {
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
  }
}
