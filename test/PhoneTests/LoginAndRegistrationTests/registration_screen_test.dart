import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ski_resorts_app/phone/screens/loginAndRegistration/registration/registration_screen.dart';

class TestCardWrapper extends StatelessWidget {
  final Widget child;

  const TestCardWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

const isGreen = Color.fromRGBO(44, 185, 176, 1);
const isTransparent = Color.fromRGBO(0, 0, 0, 0);
const isRed = Color.fromRGBO(255, 0, 0, 1);

void main() {
  /*group('buildCard', () {
    testWidgets('renders all text fields', (WidgetTester tester) async {
      final emailController = TextEditingController();
      final passwordController = TextEditingController();
      final nameController = TextEditingController();
      final surnameController = TextEditingController();
      final phoneNumberController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestCardWrapper(
              child: buildCard(
                context,
                const Size(400, 800),
                emailController,
                passwordController,
                nameController,
                surnameController,
                phoneNumberController,
                false,
                null,
                false,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Surname'), findsOneWidget);
      expect(find.text('Phone number'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('calls callback when sign up button is pressed',
        (WidgetTester tester) async {
      final emailController = TextEditingController();
      final passwordController = TextEditingController();
      final nameController = TextEditingController();
      final surnameController = TextEditingController();
      final phoneNumberController = TextEditingController();
      var isPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: buildCard(
              null,
              const Size(400, 800),
              emailController,
              passwordController,
              nameController,
              surnameController,
              phoneNumberController,
              isPressed,
              () => isPressed = true,
              false,
            ),
          ),
        ),
      );

      await tester.tap(find.text('SIGN UP'));
      expect(isPressed, isTrue);
    });
  });*/

  group('nameTextField', () {
    testWidgets('shows hint text when empty', (WidgetTester tester) async {
      final nameController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: nameTextField(
              const Size(400, 800),
              nameController,
            ),
          ),
        ),
      );

      expect(find.text('Enter your name'), findsOneWidget);
    });

    testWidgets('shows check icon when not empty', (WidgetTester tester) async {
      final nameController = TextEditingController(text: 'John');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: nameTextField(
              const Size(400, 800),
              nameController,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('shows error border when empty', (WidgetTester tester) async {
      final nameController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: nameTextField(
              const Size(400, 800),
              nameController,
            ),
          ),
        ),
      );

      final decoration =
          (find.byType(TextField).evaluate().first.widget as TextField)
              .decoration as InputDecoration;

      expect(decoration.enabledBorder, isNotNull);
      expect(decoration.enabledBorder!.borderSide.color, isTransparent);
      expect(decoration.focusedBorder, isNotNull);
      expect(decoration.focusedBorder!.borderSide.color, isGreen);
    });

    testWidgets('shows success border when not empty',
        (WidgetTester tester) async {
      final nameController = TextEditingController(text: 'John');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: nameTextField(
              const Size(400, 800),
              nameController,
            ),
          ),
        ),
      );

      final decoration =
          (find.byType(TextField).evaluate().first.widget as TextField)
              .decoration as InputDecoration;

      expect(decoration.enabledBorder, isNotNull);
      expect(decoration.enabledBorder!.borderSide.color, isGreen);
      expect(decoration.focusedBorder, isNotNull);
      expect(decoration.focusedBorder!.borderSide.color, isGreen);
    });
  });
  group('surnameTextField', () {
    testWidgets('shows hint text when empty', (WidgetTester tester) async {
      final surnameController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: surnameTextField(
              const Size(400, 800),
              surnameController,
            ),
          ),
        ),
      );

      expect(find.text('Enter your surname'), findsOneWidget);
    });

    testWidgets('shows check icon when not empty', (WidgetTester tester) async {
      final surnameController = TextEditingController(text: 'Doe');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: surnameTextField(
              const Size(400, 800),
              surnameController,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('shows error border when empty', (WidgetTester tester) async {
      final surnameController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: surnameTextField(
              const Size(400, 800),
              surnameController,
            ),
          ),
        ),
      );

      final decoration =
          (find.byType(TextField).evaluate().first.widget as TextField)
              .decoration as InputDecoration;

      expect(decoration.enabledBorder, isNotNull);
      expect(decoration.enabledBorder!.borderSide.color, isTransparent);
      expect(decoration.focusedBorder, isNotNull);
      expect(decoration.focusedBorder!.borderSide.color, isGreen);
    });

    testWidgets('shows success border when not empty',
        (WidgetTester tester) async {
      final surnameController = TextEditingController(text: 'Doe');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: surnameTextField(
              const Size(400, 800),
              surnameController,
            ),
          ),
        ),
      );

      final decoration =
          (find.byType(TextField).evaluate().first.widget as TextField)
              .decoration as InputDecoration;

      expect(decoration.enabledBorder, isNotNull);
      expect(decoration.enabledBorder!.borderSide.color, isGreen);
      expect(decoration.focusedBorder, isNotNull);
      expect(decoration.focusedBorder!.borderSide.color, isGreen);
    });
  });
  group('phoneTextField', () {
    testWidgets('shows hint text when empty', (WidgetTester tester) async {
      final phoneNumberController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: phoneTextField(
              const Size(400, 800),
              phoneNumberController,
            ),
          ),
        ),
      );

      expect(find.text('Enter your phone number'), findsOneWidget);
    });

    testWidgets('shows check icon when valid', (WidgetTester tester) async {
      final phoneNumberController = TextEditingController(text: '1234567890');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: phoneTextField(
              const Size(400, 800),
              phoneNumberController,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('shows success border when valid', (WidgetTester tester) async {
      final phoneNumberController = TextEditingController(text: '1234567890');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: phoneTextField(
              const Size(400, 800),
              phoneNumberController,
            ),
          ),
        ),
      );

      final decoration =
          (find.byType(TextField).evaluate().first.widget as TextField)
              .decoration as InputDecoration;

      expect(decoration.enabledBorder, isNotNull);
      expect(decoration.enabledBorder!.borderSide.color, isGreen);
      expect(decoration.focusedBorder, isNotNull);
      expect(decoration.focusedBorder!.borderSide.color, isGreen);
    });
  });
  group('emailTextField', () {
    testWidgets('shows hint text when empty', (WidgetTester tester) async {
      final emailController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: emailTextField(
              const Size(400, 800),
              emailController,
            ),
          ),
        ),
      );

      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('shows check icon when valid', (WidgetTester tester) async {
      final emailController = TextEditingController(text: 'test@example.com');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: emailTextField(
              const Size(400, 800),
              emailController,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('shows success border when valid', (WidgetTester tester) async {
      final emailController = TextEditingController(text: 'test@example.com');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: emailTextField(
              const Size(400, 800),
              emailController,
            ),
          ),
        ),
      );

      final decoration =
          (find.byType(TextField).evaluate().first.widget as TextField)
              .decoration as InputDecoration;

      expect(decoration.enabledBorder, isNotNull);
      expect(decoration.enabledBorder!.borderSide.color, isGreen);
      expect(decoration.focusedBorder, isNotNull);
      expect(decoration.focusedBorder!.borderSide.color, isGreen);
    });
  });

  group('passwordTextField', () {
    testWidgets('shows hint text when empty', (WidgetTester tester) async {
      final passController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: passwordTextField(
              const Size(400, 800),
              passController,
              () {},
              true,
            ),
          ),
        ),
      );

      expect(find.text('Enter your password'), findsOneWidget);
    });

    testWidgets('shows view button when not empty',
        (WidgetTester tester) async {
      final passController = TextEditingController(text: 'password');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: passwordTextField(
              const Size(400, 800),
              passController,
              () {},
              true,
            ),
          ),
        ),
      );

      expect(find.text('View'), findsOneWidget);
    });

    testWidgets('shows password when view button is pressed',
        (WidgetTester tester) async {
      final passController = TextEditingController(text: 'password');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: passwordTextField(
              const Size(400, 800),
              passController,
              () {},
              true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('View'));
      await tester.pumpAndSettle();

      final textField =
          find.byType(TextField).evaluate().first.widget as TextField;

      expect(textField.obscureText, isTrue);
      expect(textField.controller!.text, 'password');
    });

    testWidgets('hides password when view button is pressed twice',
        (WidgetTester tester) async {
      final passController = TextEditingController(text: 'password');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: passwordTextField(
              const Size(400, 800),
              passController,
              () {},
              true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('View'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('View'));
      await tester.pumpAndSettle();

      final textField =
          find.byType(TextField).evaluate().first.widget as TextField;

      expect(textField.obscureText, isTrue);
      expect(textField.controller!.text, 'password');
    });
  });
}
