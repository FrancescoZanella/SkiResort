import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/loginAndRegistration/login/login_screen.dart'
    as login_screen;
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('emailTextField', () {
    testWidgets('displays hint text and prefix icon',
        (WidgetTester tester) async {
      const size = Size(200, 200);
      final emailController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: login_screen.emailTextField(size, emailController),
          ),
        ),
      );

      final hintTextFinder = find.text('Enter your email');
      expect(hintTextFinder, findsOneWidget);

      final prefixIconFinder = find.byIcon(Icons.mail_outline_rounded);
      expect(prefixIconFinder, findsOneWidget);
    });

    testWidgets('displays suffix icon when email is not empty',
        (WidgetTester tester) async {
      const size = Size(200, 200);
      final emailController = TextEditingController(text: 'test@example.com');

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: login_screen.emailTextField(size, emailController),
          ),
        ),
      );

      final suffixIconFinder = find.byIcon(Icons.check);
      expect(suffixIconFinder, findsOneWidget);
    });

    testWidgets('does not display suffix icon when email is empty',
        (WidgetTester tester) async {
      const size = Size(200, 200);
      final emailController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: login_screen.emailTextField(size, emailController),
          ),
        ),
      );

      final suffixIconFinder = find.byIcon(Icons.check);
      expect(suffixIconFinder, findsNothing);
    });
  });

  group('passwordTextField', () {
    late TextEditingController passController;
    late Function callback;

    setUp(() {
      passController = TextEditingController();
      callback = () {};
    });

    testWidgets('displays hint text', (WidgetTester tester) async {
      const size = Size(200, 200);
      const obscure = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: login_screen.passwordTextField(
                size, passController, callback, obscure),
          ),
        ),
      );

      final hintTextFinder = find.text('Enter your password');
      expect(hintTextFinder, findsOneWidget);
    });

    testWidgets('displays view button when password is not empty',
        (WidgetTester tester) async {
      const size = Size(200, 200);
      const obscure = true;
      passController.text = 'password';

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: login_screen.passwordTextField(
                size, passController, callback, obscure),
          ),
        ),
      );

      final viewButtonFinder = find.text('View');
      expect(viewButtonFinder, findsOneWidget);
    });

    testWidgets('hides view button when password is empty',
        (WidgetTester tester) async {
      const size = Size(200, 200);
      const obscure = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: login_screen.passwordTextField(
                size, passController, callback, obscure),
          ),
        ),
      );

      final viewButtonFinder = find.text('View');
      expect(viewButtonFinder, findsNothing);
    });
  });

  testWidgets('logo widget renders correctly', (WidgetTester tester) async {
    const height = 100.0;
    const width = 100.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: login_screen.logo(height, width),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('richText widget renders correctly', (WidgetTester tester) async {
    const fontSize = 24.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: login_screen.richText(fontSize),
        ),
      ),
    );

    expect(find.text('SIGN-IN'), findsOneWidget);
  });

  group('buildFooter', () {
    testWidgets('displays Google and Facebook logos', (tester) async {
      const size = Size(400, 800);
      final context = MockBuildContext();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: login_screen.buildFooter(size, context),
        ),
      ));

      expect(find.byWidgetPredicate((widget) {
        if (widget is Image) {
          final AssetImage assetImage = widget.image as AssetImage;
          return assetImage.assetName ==
                  'lib/assets/logo/google_logo.svg.png' ||
              assetImage.assetName == 'lib/assets/logo/facebook_logo.png';
        }
        return false;
      }), findsNWidgets(2));
    });
  });
}
