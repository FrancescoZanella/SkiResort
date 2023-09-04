//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/settings/rate_our_app_screen/rate_our_app_screen.dart';

void main() {
  testWidgets('Ratings page UI tests', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: RateOurAppScreen()));

    // Check if AppBar with title 'Rate Our App' is being displayed.
    expect(find.widgetWithText(AppBar, 'Rate Our App'), findsOneWidget);

    // Check if RatingBar is being displayed.
    expect(find.byType(RatingBar), findsOneWidget);

    // Check if TextFormField with the label 'Leave your feedback' is being displayed.
    expect(find.widgetWithText(TextFormField, 'Leave your feedback'),
        findsOneWidget);

    // Check if the ElevatedButton with text 'Submit' is being displayed.
    expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);

    // Check if userRatings list is being displayed.
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Ratings page functional tests', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RateOurAppScreen()));

    // Check RatingBar's functionality.
    await tester.tap(find
        .byType(RatingBar)
        .first); // You can be more specific with the position.
    await tester.pumpAndSettle();
    // Add checks to see if the rating has been updated.

    // Check TextFormField's functionality.
    await tester.enterText(find.byType(TextFormField), 'Sample feedback');
    expect(find.text('Sample feedback'), findsOneWidget);
  });
}
