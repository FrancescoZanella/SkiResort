import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ski_resorts_app/screens/skiResort/resort_list.dart';

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/resorts-table.json',
);

class GetResorts {
  Future<List<Resort>> fetchResorts() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<Resort> resorts = [];
      data.forEach((key, value) {
        Resort resort = Resort.fromJson(value);
        resort.skiResortId = key;
        resorts.add(resort);
      });

      // Sort resorts based on skiResortRating in descending order
      resorts.sort((a, b) => b.skiResortRating.compareTo(a.skiResortRating));

      // If there are more than 10 resorts, take the top 10. Otherwise, return all resorts.
      return resorts.length > 10 ? resorts.sublist(0, 10) : resorts;
    } else {
      throw Exception('Failed to load resorts');
    }
  }
}
