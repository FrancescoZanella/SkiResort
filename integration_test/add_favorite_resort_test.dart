// integration_test/favorite_resort_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ski_resorts_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Add Resort to Favorites Integration Test', () {
    testWidgets('Find resort and add to favorites',
        (WidgetTester tester) async {
      // Start your app
      runApp(
          const MyApp()); // MyApp should be the name of your app's main widget

      // Find the resort by its name or identifier
      final resortFinder = find.byKey(const Key(
          'resortNameKey')); // replace 'resortNameKey' with the actual Key of the resort item

      // Tap on the resort to view its details
      await tester.tap(resortFinder);
      await tester.pumpAndSettle();

      // Find the favorite button on the resort details page and tap it
      final favoriteButtonFinder = find.byKey(const Key('favoriteButton'));
      await tester.tap(favoriteButtonFinder);
      await tester.pumpAndSettle();

      // Verify if the resort was added to favorites successfully
      final favoriteIconFinder = find.byIcon(Icons
          .favorite); // Assuming you're using `Icons.favorite` for favorited resorts
      expect(favoriteIconFinder, findsOneWidget);
    });

    testWidgets('Add another resort to Favorites', (WidgetTester tester) async {
      // Start your app
      runApp(const MyApp());

      // Assuming there's a list of resorts and you can tap on any resort to see its details
      final resortFinder = find.byKey(const Key(
          'resortItem0')); // This assumes the first resort in the list has a key 'resortItem0'

      // Tap on the first resort to view its details
      await tester.tap(resortFinder);
      await tester.pumpAndSettle();

      // In the resort details, there should be a button to add the resort to favorites
      final addToFavoritesButtonFinder =
          find.byKey(const Key('addToFavoritesButton'));

      // Tap on the "add to favorites" button
      await tester.tap(addToFavoritesButtonFinder);
      await tester.pumpAndSettle();

      // After tapping, there should be a message or indicator showing the resort has been added to favorites
      final favoriteAddedIndicatorFinder = find.text('Added to Favorites');
      expect(favoriteAddedIndicatorFinder, findsOneWidget);
    });
  });
}
