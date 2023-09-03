import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/app_routes.dart';
import 'package:ski_resorts_app/phone/screens/settings/about_us_screen/about_us_screen.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/profile_screen.dart';

void main() {
  testWidgets('Test About Us Page', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AboutUsPage()));

    // Verify that the page content is displayed correctly
    expect(find.text('About Us'), findsOneWidget);
    expect(
        find.byType(AboutUsPage), findsOneWidget); // Add specific widget checks
  });
}
