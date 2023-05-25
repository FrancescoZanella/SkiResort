import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/homepage/bestresult.dart';
import 'package:ski_resorts_app/screens/homepage/services.dart';

class BestTime extends StatelessWidget {
  const BestTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                color: Color.fromRGBO(12, 56, 177, 1),
              ),
            ),
            const Services(),
          ],
        ),
        const Positioned(top: 30, left: 15, right: 15, child: BestResult())
      ],
    );
  }
}
