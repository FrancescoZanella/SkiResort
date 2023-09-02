//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/widgets/button.dart';

void main() {
  testWidgets('Button displays correct color, shape, icon, and calls callback',
      (tester) async {
    // Track if callback has been triggered
    bool callbackTriggered = false;
    void buttonCallback(int value) {
      callbackTriggered = true;
      expect(value, 1);
    }

    // Create the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Button(
          color: Colors.blue,
          icon: Icons.add,
          callback: buttonCallback,
        ),
      ),
    ));

    // Find button by type
    final buttonFinder = find.byType(ElevatedButton);
    final button = tester.widget<ElevatedButton>(buttonFinder);

    // Verify button's attributes
    expect((button.style as ButtonStyle).backgroundColor?.resolve({}),
        Colors.blue);
    expect((button.style as ButtonStyle).elevation?.resolve({}), 5);
    expect(button.child, isA<InkWell>());

    // Verify icon inside the button
    expect(find.descendant(of: buttonFinder, matching: find.byIcon(Icons.add)),
        findsOneWidget);

    // Tap on the button
    await tester.tap(buttonFinder);

    // Verify that the callback has been triggered
    expect(callbackTriggered, true);
  });
}
