import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/profile_screen.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Test Profile Page', (WidgetTester tester) async {
    // Create a UserModel with dummy data
    final userModel = UserModel();
    userModel.updateUser(
      userId: "abcde",
      name: 'John',
      surname: 'Doe',
      email: 'john@example.com',
      phoneNumber: '123-456-7890',
      avatarPath: 'lib/assets/images/avatar9.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => userModel,
          child: const ProfilePageScreen(),
        ),
      ),
    );

    // Verify that the page content is displayed correctly
    expect(find.text('Profile'), findsOneWidget);
    expect(find.byType(ProfilePageScreen), findsOneWidget);

    // Add additional widget checks as needed
    expect(find.text('Name: John'), findsOneWidget);
    expect(find.text('Surname: Doe'), findsOneWidget);
    expect(find.text('Email: john@example.com'), findsOneWidget);
    expect(find.text('Phone Number: 123-456-7890'), findsOneWidget);
  });
}
