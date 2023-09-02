import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/phone/screens/builder.dart';
import 'package:ski_resorts_app/phone/screens/homepage/home.dart';
import 'package:ski_resorts_app/phone/screens/statistics/main_stats.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

void main() {
  final testUserModel = UserModel();

  // Mock the Provider to avoid database calls (assuming UserModel makes such calls)
  Widget createMainPageScreen() {
    return ChangeNotifierProvider<UserModel>.value(
      value: testUserModel,
      child: const MaterialApp(
        home: MainPage(
          userId: "testUserId",
          name: "John",
          surname: "Doe",
          email: "john.doe@test.com",
          phoneNumber: "123456789",
          avatarPath: "path/to/avatar.jpg",
        ),
      ),
    );
  }

  testWidgets('MainPage navigation bar interactions', (tester) async {
    await tester.pumpWidget(createMainPageScreen());

    await tester.tap(find.byIcon(Icons.add_chart));

    expect(find.byType(MainStats), findsNWidgets(0));

    await tester.tap(find.byIcon(Icons.home_outlined));

    expect(find.byType(HomeScreen), findsNWidgets(0));
  });

  Color? getColorFromIcon(WidgetTester tester, IconData icon) {
    final iconFinder = find.byIcon(icon);
    if (tester.any(iconFinder)) {
      final iconWidget = tester.widget<Icon>(iconFinder);
      return iconWidget.color;
    }
    return null;
  }

  testWidgets('MainPage navigation bar icon color changes', (tester) async {
    await tester.pumpWidget(createMainPageScreen());

    // Check initial colors
    expect(getColorFromIcon(tester, Icons.map_outlined),
        Colors.white); // Assuming it's the first selected
    expect(getColorFromIcon(tester, Icons.add_chart),
        Colors.black); // Replace with correct color

    // Tap on the MainStats icon
    await tester.tap(find.byIcon(Icons.add_chart));
    await tester.pumpAndSettle();

    // Check icon colors after tapping
    expect(getColorFromIcon(tester, Icons.map_outlined),
        Colors.black); // Replace with correct color
    expect(getColorFromIcon(tester, Icons.add_chart), Colors.white);
  });
}
