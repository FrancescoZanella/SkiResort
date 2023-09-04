import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/skiResort/resort_container.dart';

void main() {
  testWidgets('ResortContainer displays correct content',
      (WidgetTester tester) async {
    // Build our widget.
    await tester.pumpWidget(MaterialApp(
      home: ResortContainer(
        skiResortId: '1',
        skiResortLink: 'https://example.com',
        skiResortName: 'Test Resort',
        skiResortDescription: 'This is a test resort.',
        imageLink: 'https://example.com/image.jpg',
        skiResortRating: 4.5,
        totalSkiSlopes: '10',
        blueSkiSlopes: '4',
        redSkiSlopes: '4',
        blackSkiSlopes: '2',
        skiPassCost: '100',
        skiResortElevation: '3000m',
        skiLiftsNumber: '5',
        skiResortLatitude: 50.0,
        skiResortLongitude: 50.0,
        onFavouriteButtonPressed: () {},
      ),
    ));

    // Check if the required elements are displayed.
    expect(find.text('Test Resort'), findsOneWidget);
    expect(find.text('This is a test resort.'), findsOneWidget);
    expect(find.text('Elevation: 3000m'), findsOneWidget);
    expect(find.text('Ski slopes: 10'), findsOneWidget);
    expect(find.text('Ski lifts: 5'), findsOneWidget);
    expect(find.text('Ski Pass Cost: 100'), findsOneWidget);
    expect(find.text('Add to favorites'), findsOneWidget);

    // Check for icons
    expect(find.byIcon(Icons.star),
        findsWidgets); // Since multiple star icons can be displayed
    expect(find.byIcon(Icons.height), findsOneWidget);
    expect(find.byIcon(Icons.downhill_skiing), findsOneWidget);
    expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    expect(find.byIcon(Icons.euro_symbol_sharp), findsOneWidget);

    // Check if the image is loaded from the correct URL
    expect(
        find.byType(Image), findsWidgets); // In case there are multiple images
    final Image imgWidget = tester.firstWidget(find.byType(Image)) as Image;
    final NetworkImage imgProvider = imgWidget.image as NetworkImage;
    expect(imgProvider.url, 'https://example.com/image.jpg');
  });
}
