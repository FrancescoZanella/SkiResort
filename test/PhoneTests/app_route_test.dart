import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/app_routes.dart';
import 'package:ski_resorts_app/phone/screens/settings/about_us_screen/about_us_screen.dart';

void main() {
  group("routeTests", () {
    testWidgets('Route test', (WidgetTester tester) async {
      // Wrap the app with a MaterialApp widget to enable navigation
      await tester.pumpWidget(MaterialApp(
        routes: routes,
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/AboutUsPage'); // Change this for each test
              },
              child: const Text('Test'),
            );
          },
        ),
      ));

      await tester.tap(find.text('Test')); // Simulate a button tap
      await tester.pumpAndSettle();

      // Change this for each route to check the correct widget
      expect(find.byType(AboutUsPage), findsOneWidget);
    });
  });
}
