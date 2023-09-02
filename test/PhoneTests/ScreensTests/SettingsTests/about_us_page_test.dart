import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ski_resorts_app/phone/screens/settings/about_us_screen/about_us_screen.dart';

void main() {
  testWidgets('AboutUsPage displays content correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: AboutUsPage()));

    // Check if AppBar with title "About Us" is displayed.
    expect(find.widgetWithText(AppBar, 'About Us'), findsOneWidget);

    // Check if the header "Who We Are" is displayed.
    expect(find.text('Who We Are'), findsOneWidget);

    // Check if the header "Our Project" is displayed.
    expect(find.text('Our Project'), findsOneWidget);

    // Check for text content about "Who We Are".
    expect(
      find.text(
          "We are Stefano Chiodini and Francesco Zanella, two ambitious students from the Politecnico di Milano. Our passion for innovation, problem-solving and technology drives us to continuously challenge ourselves in our academic and personal projects."),
      findsOneWidget,
    );

    // Check for text content about "Our Project".
    expect(
      find.text(
          "This application is a result of our dedication and hard work as part of a university project. Our main objective was to design and develop an app that provides real value to its users. This application aims to bridge the gap between skiing enthusiasts and the resources they need to enhance their skiing experience. Whether you're looking for the perfect ski resort, tracking your performance, or just want to stay updated on skiing conditions, we've got you covered!"),
      findsOneWidget,
    );
  });
}
