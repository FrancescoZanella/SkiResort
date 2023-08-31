import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ski_resorts_app/smartwatch/stats.dart';
import 'package:ski_resorts_app/smartwatch/trainings.dart';

// ignore: must_be_immutable
class Prova extends StatefulWidget {
  String userId;
  double height;
  double width;

  Prova(
      {super.key,
      required this.height,
      required this.width,
      required this.userId});

  @override
  State<Prova> createState() => ProvaState();
}

class ProvaState extends State<Prova> {
  final Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  bool _isRunning = false;

  void _startStopwatch() async {
    setState(() {
      _isRunning = true;
      stopwatch.start();

      _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
        setState(() {});
      });
    });
  }

  void nothing() {}

  void _stopStopwatch() {
    if (_isRunning) {
      setState(() {
        _isRunning = false;
        stopwatch.stop();
        _timer?.cancel();
      });
    } else {
      _resetStopWatch();
    }
  }

  void _resetStopWatch() {
    setState(() {
      _isRunning = false;
      stopwatch.reset();
      _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 10) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Scaffold(
                      body: Center(child: Text('Contenuto della su pagina')))));
        } else if (details.primaryVelocity! < -10) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Stats(userId: widget.userId)),
          );
        }
      },
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < -10) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Training()),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("lib/assets/images/photo_5992241769431022582_y.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              heightFactor: widget.height,
              widthFactor: widget.height,
              child: Column(
                children: [
                  SizedBox(height: widget.height * 0.05),
                  const Center(
                    child: Text(
                      "0,00",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                  const Text("Average Speed (km/h)",
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                  const SizedBox(
                    height: 5,
                  ),
                  IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Column(
                            children: [
                              Center(
                                child: Text(
                                  "0,00",
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white),
                                ),
                              ),
                              Text("Max speed (km/h)",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.white,
                            thickness: 0.7,
                          ),
                          SizedBox(
                            width: widget.width * 0.05,
                          ),
                          const Column(
                            children: [
                              Center(
                                child: Text(
                                  "0,00",
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white),
                                ),
                              ),
                              Text("  Distance (m)",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "boh",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                  const Text("Time",
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                  Row(
                    children: [
                      SizedBox(
                        width: widget.width * 0.33,
                      ),
                      ElevatedButton(
                        onPressed: _isRunning ? nothing : _startStopwatch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const CircleBorder(),
                          minimumSize: const Size(35, 35),
                        ),
                        child: const Icon(Icons.play_arrow,
                            size: 20), // Use the play icon
                      ),
                      SizedBox(
                        width: widget.width * 0.05,
                      ),
                      ElevatedButton(
                        onPressed: _stopStopwatch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const CircleBorder(),
                          minimumSize: const Size(35, 35),
                        ),
                        child: _isRunning
                            ? const Icon(Icons.pause, size: 20)
                            : const Icon(Icons.stop, size: 20),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
