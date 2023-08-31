import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ski_resorts_app/constants/text_constants.dart';
import 'package:ski_resorts_app/phone/screens/loginAndRegistration/login/login_screen.dart';
import 'package:ski_resorts_app/phone/screens/onboarding/onboardingmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final mockNavigatorObserver = MockNavigatorObserver();

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('OnboardingMenu Tests', () {
    testWidgets('renders OnboardingMenu', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const SizedBox(
          width: 400,
          height: 800,
          child: OnboardingMenu(),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ));
      await tester.pumpAndSettle();

      // Verify if the first image and title are displayed
      expect(find.byType(Image), findsOneWidget);
      expect(find.text(TextConstants.onboarding1Title), findsOneWidget);
    });

    testWidgets('navigates to LoginPage on pressing Skip', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const OnboardingMenu(),
        navigatorObservers: [mockNavigatorObserver],
      ));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsNothing);
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
