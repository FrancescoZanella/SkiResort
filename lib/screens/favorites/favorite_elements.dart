import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final favoriteUrl = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/favorites-resort-table.json',
);

class Favorite {
  String skiResortFavoriteId;
  final String skiResortUrl;
  final String skiResortName;
  final String skiResortDescription;
  final String imageLink;
  final double skiResortRating;
  final String totalSkiSlopes;
  final String blueSkiSlopes;
  final String redSkiSlopes;
  final String blackSkiSlopes;
  final String skiPassCost;
  final String skiResortElevation;
  final String skiLiftsNumber;

  Favorite({
    required this.skiResortFavoriteId,
    required this.skiResortUrl,
    required this.skiResortName,
    required this.skiResortDescription,
    required this.imageLink,
    required this.skiResortRating,
    required this.totalSkiSlopes,
    required this.blueSkiSlopes,
    required this.redSkiSlopes,
    required this.blackSkiSlopes,
    required this.skiPassCost,
    required this.skiResortElevation,
    required this.skiLiftsNumber,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      skiResortFavoriteId: json['skiResortFavoriteId'],
      skiResortUrl: json['skiResortUrl'],
      skiResortName: json['skiResortName'],
      skiResortDescription: json['skiResortDescription'],
      imageLink: json['imageLink'],
      skiResortRating: double.parse(json['skiResortRating']),
      totalSkiSlopes: json['totalSkiSlopes'],
      blueSkiSlopes: json['blueSkiSlopes'],
      redSkiSlopes: json['redSkiSlopes'],
      blackSkiSlopes: json['blackSkiSlopes'],
      skiPassCost: json['skiPassCost'],
      skiResortElevation: json['skiResortElevation'],
      skiLiftsNumber: json['skiLiftsNumber'],
    );
  }
}

Future<List<Favorite>> fetchFavorites() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('userId') ?? '';
  //print: the user is: $userId
  final response = await http.get(favoriteUrl);
  if (response.statusCode == 200) {
    Map<String, dynamic>? data = json.decode(response.body);
    if (data == null) {
      return [];
    }
    List<Favorite> favorites = [];

    data.forEach((key, value) {
      if (value['userId'] == userId) {
        Favorite favorite = Favorite.fromJson(value);
        favorite.skiResortFavoriteId = key;
        favorites.add(favorite);
      }
    });

    return favorites;
  } else {
    throw Exception('Failed to load favorites');
  }
}
