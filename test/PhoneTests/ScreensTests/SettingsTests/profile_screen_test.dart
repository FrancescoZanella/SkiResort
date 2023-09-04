//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/profile_screen.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

void main() {
  // Create a mock UserModel for testing purposes
  UserModel mockUserModel = UserModel()
    ..updateUser(
      userId: 'testUserId',
      name: 'John',
      surname: 'Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1234567890',
      avatarPath:
          'lib/assets/images/avatar1.jpg', // This could be a path to a local test asset or a mock URL.
    );

  testWidgets('Renders ProfilePageScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider<UserModel>.value(
        value: mockUserModel,
        child: const MaterialApp(home: ProfilePageScreen()),
      ),
    );

    // Verify if the app bar title is correct.
    expect(find.text('Profile'), findsOneWidget);

    // Verify if personal information header is displayed.
    expect(find.text('Personal Information'), findsOneWidget);

    // Verify if user details are displayed.
    expect(find.text('Name: John'), findsOneWidget);
    expect(find.text('Surname: Doe'), findsOneWidget);
    expect(find.text('Email: john.doe@example.com'), findsOneWidget);
    expect(find.text('Phone Number: +1234567890'), findsOneWidget);
  });
}
