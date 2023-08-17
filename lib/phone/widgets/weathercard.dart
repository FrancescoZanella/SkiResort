// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'dart:async';

// ignore: must_be_immutable
class Weather extends StatefulWidget {
  var height;
  var width;
  var title;
  var index;
  var callback;
  Weather(
      {super.key,
      required this.height,
      required this.width,
      required this.title,
      required this.index,
      required this.callback});
  @override
  // ignore: library_private_types_in_public_api
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  bool isPressed = false;
  late Timer splashTimeout = Timer(const Duration(milliseconds: 5000), () {});
  @override
  void dispose() {
    splashTimeout.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTapDown: (details) {
            // Funzione chiamata quando si tiene premuto il widget
            setState(() {
              isPressed = true;
            });

            // Avvia il timer per mostrare l'effetto "splash" per un certo periodo di tempo
            splashTimeout = Timer(const Duration(milliseconds: 5000), () {
              setState(() {
                isPressed = false;
              });
            });
          },
          onTapUp: (details) {
            // Funzione chiamata quando si smette di tenere premuto il widget
            setState(() {
              isPressed = false;
            });

            // Apri una nuova pagina
            widget.callback(widget.index);
          },
          onTapCancel: () {
            // Funzione chiamata se l'utente annulla la pressione (ad esempio, scorrendo il dito via dal widget)
            setState(() {
              isPressed = false;
            });
          },
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              border: Border.all(width: 5.0, color: Colors.black),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 30.0,
                  offset: const Offset(10, 15),
                )
              ],
            ),
            child: Stack(
              children: [
                Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color:
                        const Color.fromRGBO(7, 22, 66, 1), //Color(0x001e59),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 30.0,
                        offset: const Offset(10, 15),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: widget.height * 0.7,
                    left: widget.width * 0.10,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    )),
                Positioned(
                    top: widget.height * 0.15,
                    left: widget.width * 0.10,
                    child: const Text(
                      'Milano',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 17),
                    )),
                Positioned(
                    top: widget.height * 0.35,
                    left: widget.width * 0.10,
                    child: const Text(
                      '-10°',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 35),
                    )),
                Positioned(
                    top: widget.height * 0.15,
                    right: widget.width * 0.15,
                    child: const Icon(
                      Icons.cloud,
                      color: Colors.white,
                    )),
                if (isPressed)
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.grey.withOpacity(0.3)),
                  ),
              ],
            ),
          ),
        ));
  }
}
