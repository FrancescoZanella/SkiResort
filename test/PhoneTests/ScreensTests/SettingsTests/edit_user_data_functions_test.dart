// ignore_for_file: unused_local_variable
//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/edit_user_data_functions.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockUserModel extends Mock implements UserModel {}

void main() {
  group('editInformation', () {
    late UserModel userModel;
    late MockUserModel mockUserModel;
    late BuildContext context;
    late String field;
    late String currentValue;
    late String userId;

    setUp(() {
      mockUserModel = MockUserModel();
      userModel = UserModel();
      context = MockBuildContext();
      field = 'Name';
      currentValue = 'John';
      userId = '123';
    });

    testWidgets('renders AlertDialog', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => editInformation(
                context,
                field,
                currentValue,
                userModel,
                userId,
              ),
              child: const Text('Edit Information'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Edit Name'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });
  });

  group('editInformation UI tests', () {
    testWidgets('displays the correct UI components', (tester) async {
      // Create a test app and call the `editInformation` function
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () => editInformation(
                      context, 'Name', 'John', UserModel(), '1234'),
                  child: const Text('Show Dialog'),
                ),
              );
            },
          ),
        ),
      );

      // Tap the button to show the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify the dialog's components
      expect(find.text('Edit Name'), findsOneWidget); // Title
      expect(find.byType(TextField), findsOneWidget); // TextField
      expect(find.text('Cancel'), findsOneWidget); // Cancel button
      expect(find.text('Save'), findsOneWidget); // Save button
    });

    testWidgets('TextField contains the correct initial value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () => editInformation(
                      context, 'Name', 'John', UserModel(), '1234'),
                  child: const Text('Show Dialog'),
                ),
              );
            },
          ),
        ),
      );

      // Tap the button to show the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TextField, 'John'), findsOneWidget);
    });
  });
}
