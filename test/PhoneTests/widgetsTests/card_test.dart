//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/widgets/card.dart';

void main() {
  testWidgets('MyCard should display the correct image and title',
      (WidgetTester tester) async {
    const image = 'lib/assets/images/smartwatch.jpg';
    const title = 'My Card Title';
    const height = 200.0;
    const width = 150.0;
    const index = 0;

    await tester.pumpWidget(MaterialApp(
      home: MyCard(
        image: image,
        title: title,
        height: height,
        width: width,
        index: index,
        callback: (int index) {},
      ),
    ));

    final imageFinder = find.descendant(
      of: find.byType(MyCard),
      matching: find.byType(Image),
    );
    expect(imageFinder, findsOneWidget);
    expect((imageFinder.evaluate().first.widget as Image).image,
        const AssetImage(image));

    final titleFinder = find.descendant(
      of: find.byType(MyCard),
      matching: find.text(title),
    );
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('MyCard should call the callback when tapped',
      (WidgetTester tester) async {
    var index = -1;
    const height = 200.0;
    const width = 150.0;
    const image = 'lib/assets/images/smartwatch.jpg';
    const title = 'My Card Title';

    await tester.pumpWidget(MaterialApp(
      home: MyCard(
        image: image,
        title: title,
        height: height,
        width: width,
        index: 0,
        callback: (int i) {
          index = i;
        },
      ),
    ));

    await tester.tap(find.byType(MyCard));
    expect(index, 0);
  });
}
