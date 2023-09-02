import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/widgets/card.dart';

void main() {
  testWidgets('MyCard displays correct details and handles interactions',
      (tester) async {
    bool callbackCalled = false;
    int? callbackIndex;

    void cardCallback(int index) {
      callbackCalled = true;
      callbackIndex = index;
    }

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MyCard(
          height: 200,
          width: 150,
          image:
              'assets/test_image.jpg', // Replace with a valid asset image in your app
          title: 'TestTitle',
          index: 5,
          callback: cardCallback,
        ),
      ),
    ));

    // Verify image and title display
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('TestTitle'), findsOneWidget);

    // Simulate pressing down on the card
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    // Check if the callback was triggered with the correct index
    expect(callbackCalled, true);
    expect(callbackIndex, 5);
  });
}
