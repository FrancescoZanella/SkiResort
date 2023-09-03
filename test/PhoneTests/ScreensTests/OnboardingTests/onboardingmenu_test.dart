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
        home: const OnboardingMenu(),
        navigatorObservers: [mockNavigatorObserver],
      ));
      expect(find.byType(OnboardingMenu), findsOneWidget);
    });

    testWidgets('navigates to LoginPage on pressing Skip', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const OnboardingMenu(),
        navigatorObservers: [mockNavigatorObserver],
      ));
      expect(find.byType(LoginPage), findsNothing);
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('Swipe through PageView and verify content changes',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: OnboardingMenu(),
      ));
      final pageView = find.byType(PageView);
      expect(find.text(TextConstants.onboarding1Title), findsOneWidget);
      await tester.drag(pageView, const Offset(-500, 0)); // Swipe to the left
      await tester.pumpAndSettle();
      expect(find.text(TextConstants.onboarding2Title), findsOneWidget);
      await tester.drag(pageView, const Offset(-500, 0)); // Swipe again
      await tester.pumpAndSettle();
      expect(find.text(TextConstants.onboarding3Title), findsOneWidget);
    });

    testWidgets('Navigate to LoginPage on pressing Explore now',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: OnboardingMenu(),
      ));
      final pageView = find.byType(PageView);
      await tester.drag(
          pageView, const Offset(-500, 0)); // Swipe to the last page
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore now'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
