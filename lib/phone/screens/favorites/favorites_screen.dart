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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading favorites'));
          }
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('There are no favorites'));
          }
          List<Favorite> favorites = snapshot.data!;
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return FavoriteWidget.favoriteWidget(favorite, context, () {
                setState(() {
                  favorites.removeAt(
                      index); // Remove the favorite from the list and update the state
                });
              });
            },
          );
        },
      ),
    );
  }
}
