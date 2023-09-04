//tests ok
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/image_profile_handler_function.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

// Mocked function for getTypeOfImageProvider
ImageProvider<Object> getTypeOfImageProvider(String path) {
  return const AssetImage('test_asset_image.png');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('showImageDialog displays dialog with image and button',
      (WidgetTester tester) async {
    // Mocked user model with dummy avatar path
    final user = UserModel();
    user.updateField('avatarPath', 'lib/assets/images/avatar1.jpg');

    // Build the widget tree for testing
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => showImageDialog(context, user, 'testUserId'),
            child: const Text('Show Dialog'),
          );
        },
      ),
    ));

    // Tap to trigger showImageDialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle(); // Let the animations finish and dialog appear

    // Check for the presence of dialog
    expect(find.byType(Dialog), findsOneWidget);

    // Check for the ElevatedButton with the expected text
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Upload an image from gallery'), findsOneWidget);
  });
}
