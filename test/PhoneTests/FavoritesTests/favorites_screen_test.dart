import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ski_resorts_app/phone/screens/favorites/favorite_elements.dart';
import 'package:ski_resorts_app/phone/screens/favorites/favorite_widget.dart';
import 'package:ski_resorts_app/phone/screens/favorites/favorites_screen.dart';

class MockFavorite extends Mock implements Favorite {}

void main() {
  setUpAll(() {
    registerFallbackValue(Future.value([]));
  });

  testWidgets('Displays CircularProgressIndicator when waiting',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: FavoritesScreen(),
    ));

    // Initial pump is always ConnectionState.none
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays error text when future completes with error',
      (WidgetTester tester) async {
    when(fetchFavorites).thenAnswer((_) async => throw Exception('An error'));

    await tester.pumpWidget(const MaterialApp(
      home: FavoritesScreen(),
    ));

    await tester.pumpAndSettle();
    expect(find.text('Error loading favorites'), findsOneWidget);
  });

  testWidgets('Displays "There are no favorites" when the list is empty',
      (WidgetTester tester) async {
    when(fetchFavorites).thenAnswer((_) async => []);

    await tester.pumpWidget(const MaterialApp(
      home: FavoritesScreen(),
    ));

    await tester.pumpAndSettle();
    expect(find.text('There are no favorites'), findsOneWidget);
  });

  testWidgets('Displays list of favorites when there are favorites',
      (WidgetTester tester) async {
    final favorites = [MockFavorite(), MockFavorite(), MockFavorite()];
    when(fetchFavorites).thenAnswer((_) async => favorites);

    await tester.pumpWidget(const MaterialApp(
      home: FavoritesScreen(),
    ));

    await tester.pumpAndSettle();
    expect(find.byType(FavoriteWidget), findsNWidgets(3));
  });

  testWidgets('Removes favorite from the list when tapped',
      (WidgetTester tester) async {
    final favorites = [MockFavorite(), MockFavorite(), MockFavorite()];
    when(fetchFavorites).thenAnswer((_) async => favorites);

    await tester.pumpWidget(const MaterialApp(
      home: FavoritesScreen(),
    ));

    await tester.pumpAndSettle();
    await tester.tap(find.byType(FavoriteWidget).first);
    await tester.pumpAndSettle();

    expect(find.byType(FavoriteWidget), findsNWidgets(2));
  });
}
