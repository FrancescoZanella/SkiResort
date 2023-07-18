import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/skiResort/resort_list.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final url = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/resorts-table.json',
);

final url2 = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/favorites-resort-table.json',
);

class MostPopularResortPage extends StatefulWidget {
  const MostPopularResortPage({Key? key}) : super(key: key);

  @override
  State<MostPopularResortPage> createState() => _MostPopularResortPageState();
}

class _MostPopularResortPageState extends State<MostPopularResortPage> {
  List<Resort> resorts = [];

  Future<void> fetchResorts() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      data.forEach((key, value) {
        resorts.add(Resort.fromJson(value));
      });
      setState(() {}); // Update the UI
    } else {
      throw Exception('Failed to load resorts');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchResorts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ResortList(
          resorts: resorts,
          onFavouriteButtonPressed: () async {
            //SharedPreferences prefs = await SharedPreferences.getInstance();
            //String userId = prefs.getString('userId') ?? '';
            //String userName = prefs.getString('name') ?? '';
            //String userSurname = prefs.getString('surname') ?? '';
            //TODo: BUILD THE BODY OF THE POST REQUEST
          },
        ),
      ),
    );
  }
}
