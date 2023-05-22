import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/home/widgets/bestresult.dart';
import 'package:ski_resorts_app/screens/home/widgets/services.dart';

class BestTime extends StatelessWidget {
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
              height: 110,
              color: const Color.fromRGBO(12, 56, 177, 1),
            ),
            Services(),
          ],
        ),
        Positioned(top: 50, left: 15, right: 15, child: BestResult())
      ],
    );
  }
}
