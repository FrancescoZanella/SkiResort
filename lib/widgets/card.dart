// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:flutter/material.dart';
import 'dart:async';

// ignore: must_be_immutable
class MyCard extends StatefulWidget {
  var image;
  var height;
  var width;
  var title;
  var route;

  MyCard({
    Key? key,
    required this.height,
    required this.width,
    required this.image,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
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

          Navigator.pushNamed(context, widget.route);
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
              SizedBox(
                width: widget.width,
                height: widget.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: widget.height * 0.8,
                left: widget.width * 0.10,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              // Effetto splash when is pressed
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
      ),
    );
  }
}
