/*import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_container.dart'; // <- Replace with your actual file location

void main() {
  testWidgets('Checks if all important child widgets are present',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: ResortContainer(
          skiResortLink: 'test',
          skiResortName: 'Test Resort',
          skiResortDescription: 'Test Description',
          imageLink: 'https://example.com/image.jpg',
          skiResortRating: 4.0,
          totalSkiSlopes: '15',
          blueSkiSlopes: '5',
          redSkiSlopes: '5',
          blackSkiSlopes: '5',
          skiPassCost: '50',
          skiResortElevation: '1000',
          skiLiftsNumber: '10',
          onFavouriteButtonPressed: () {},
        ),
      ));

      expect(find.text('Test Resort'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsWidgets);
      expect(find.byIcon(Icons.height), findsOneWidget);
      expect(find.byIcon(Icons.downhill_skiing), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
      expect(find.byIcon(Icons.euro_symbol_sharp), findsOneWidget);
      expect(find.text('Add to favorites'), findsOneWidget);
    });
  });

  testWidgets('Clicking on the favorite button changes the button text',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: ResortContainer(
          skiResortLink: 'test',
          skiResortName: 'Test Resort',
          skiResortDescription: 'Test Description',
          imageLink: 'https://example.com/image.jpg',
          skiResortRating: 4.0,
          totalSkiSlopes: '15',
          blueSkiSlopes: '5',
          redSkiSlopes: '5',
          blackSkiSlopes: '5',
          skiPassCost: '50',
          skiResortElevation: '1000',
          skiLiftsNumber: '10',
          onFavouriteButtonPressed: () {},
        ),
      ));

      expect(find.text('Add to favorites'), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text('Added to favorites ✅'), findsOneWidget);
    });
  });

  // Continue with the rest of your tests, wrapping them inside mockNetworkImagesFor.
  // ...
}
*/