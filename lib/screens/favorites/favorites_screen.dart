import 'package:flutter/material.dart';
import './favorite_widget.dart';
import 'favorite_elements.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Favorite>>(
        future: fetchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Favorite> favorites = snapshot.data!;
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return FavoriteWidget.favoriteWidget(favorite, context);
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              // Added Center widget here
              child: Text('There are no favorites yet!'),
            );
          }

          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
