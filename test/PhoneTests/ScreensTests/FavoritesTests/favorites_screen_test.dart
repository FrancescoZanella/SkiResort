import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/favorites/favorite_widget.dart';
import 'package:ski_resorts_app/phone/screens/favorites/favorites_screen.dart';

void main() {
  testWidgets('Displays loading indicator', (WidgetTester tester) async {
    // Mock the fetchFavorites function to delay
    await tester
        .pumpWidget(MaterialApp(home: FavoritesScreen(callback: (int val) {})));

    // Expect the CircularProgressIndicator to be showing
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays error when there\'s a fetch error',
      (WidgetTester tester) async {
    // Mock the fetchFavorites function to return an error

    await tester
        .pumpWidget(MaterialApp(home: FavoritesScreen(callback: (int val) {})));
    await tester.pumpAndSettle(); // Let the Future complete

    // Expect the error text widget to be showing
    expect(find.text('Error loading favorites'), findsOneWidget);
  });

  testWidgets('Displays message when there are no favorites',
      (WidgetTester tester) async {
    // Mock the fetchFavorites function to return an empty list

    await tester
        .pumpWidget(MaterialApp(home: FavoritesScreen(callback: (int val) {})));
    await tester.pumpAndSettle(Duration.zero); // Let the Future complete

    // Expect the "You haven't added favorites yet" text to be showing
    expect(find.text('You haven\'t added favorites yet'), findsOneWidget);
    // Expect the "Add favorites" button to be showing
    expect(find.text('Add favorites'), findsOneWidget);
  });

  testWidgets('Displays favorites when present', (WidgetTester tester) async {
    // Mock the fetchFavorites function to return a list of favorites

    await tester
        .pumpWidget(MaterialApp(home: FavoritesScreen(callback: (int val) {})));
    await tester.pumpAndSettle(); // Let the Future complete

    // Expect the FavoriteWidget to be showing for each favorite
    expect(find.byType(FavoriteWidget),
        findsNWidgets(2)); // assuming you mocked 2 favorites
  });
}
