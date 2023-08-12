import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/skiResort/resort_list.dart';
import 'package:ski_resorts_app/screens/skiResort/resort_table_db_functions.dart';

class MostPopularResortPage extends StatefulWidget {
  const MostPopularResortPage({Key? key}) : super(key: key);

  @override
  State<MostPopularResortPage> createState() => _MostPopularResortPageState();
}

class _MostPopularResortPageState extends State<MostPopularResortPage> {
  List<Resort> resorts = [];
  final resortService = GetResorts();

  Future<void> fetchResorts() async {
    try {
      resorts = await resortService.fetchResorts();
      setState(() {}); // Update the UI
    } catch (e) {
      if (kDebugMode) {
        // Handle error here
        print(e.toString());
      }
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
            //TODo: BUILD THE BODY OF THE POST REQUEST
          },
        ),
      ),
    );
  }
}
