import 'package:flutter/material.dart';
import './favorite_widget.dart';
import 'favorite_elements.dart';

class FavoritesScreen extends StatefulWidget {
  Function callback;
  FavoritesScreen({required this.callback});

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
            return Center(
                child: Column(
              children: [
                const SizedBox(
                  height: 350,
                ),
                const Text(
                  'You haven\'t added favorites yet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.callback(0);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    "Add favorites",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ));
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
