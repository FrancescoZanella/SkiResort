import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/smartwatch/watchstast.dart';

void main() {
  const String mockUserId = "12345";

  testWidgets('Graphical components of Prova widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Prova(
            height: 600,
            width: 400,
            userId: mockUserId))); // Adjust sizes if necessary

    await tester.pumpAndSettle(); // To finish any animations or futures.

    // Check for "Welcome to SkiSage" text
    expect(find.text('Welcome to SkiSage'), findsOneWidget);

    // Check if the two buttons are present.
    expect(find.byIcon(Icons.calendar_month), findsOneWidget);
    expect(find.byIcon(Icons.logout_outlined), findsOneWidget);

    // Check for logo image
    expect(find.byType(Image), findsOneWidget);

    // Check button navigation
    // Here we are just checking the first button for demonstration purposes
    await tester.tap(find.byIcon(Icons.calendar_month));
    await tester.pumpAndSettle();

    expect(find.text('Stats Page'), findsOneWidget);
  });
}
