import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_data.dart';

class BestResult extends StatefulWidget {
  const BestResult({super.key});

  @override
  State<BestResult> createState() => _BestResultState();
}

class _BestResultState extends State<BestResult> {
  Future<List<String>> getvalues() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> l = [];
      l.add((await getBestStat(prefs.getString('userId')!)).getDistance());
      l.add((await getBestStat(prefs.getString('userId')!)).getTime());
      l.add((await getBestStat(prefs.getString('userId')!)).getmaxSpeed());
      return l;
    } catch (e) {
      // Handle any errors that might occur during initialization
      throw Exception(e);
    }
  }

  //[0] destination
  //[1] time
  //[2] maxspeed
  late Future<List<String>> values;

  @override
  void initState() {
    super.initState();
    values = getvalues();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: values,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Text("not found");
          }
          return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 121, 93, 1),
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 30.0,
                            offset: const Offset(10, 15))
                      ]),
                  // interno di riquadro arancione
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' ✰ BEST RESULT - 2023',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 15, right: 10),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  //DESTINATION
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DESTINATION',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${double.parse(snapshot.data![0]).toStringAsFixed(2)} m",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const VerticalDivider(
                                    color: Colors.white,
                                    width: 20.0,
                                    thickness: 1.0,
                                  ),
                                  // TIME section
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'TIME',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        textAlign: TextAlign.left,
                                        snapshot.data![1],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  const VerticalDivider(
                                    color: Colors.white,
                                    width: 20.0,
                                    thickness: 1.0,
                                  ),
                                  // SPEED SECTION
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'MAX SPEED',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        '${double.parse(snapshot.data![2]).toStringAsFixed(2)} m/s',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  )));
        });
  }
}
