import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/edit_user_data_functions.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/functions_for_firebase.dart';
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

    testWidgets('taps on Save button', (tester) async {
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

      const newValue = 'Jane';
      final textField = find.byType(TextField);
      await tester.enterText(textField, newValue);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      verify(
        updateDataOnFirebase(userModel, userId, field, newValue),
      ).called(1);
      expect(find.text('Information updated successfully!'), findsOneWidget);
    });

    testWidgets('taps on Cancel button', (tester) async {
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

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(
        updateDataOnFirebase(userModel, userId, field, any),
      );
    });
  });
}
