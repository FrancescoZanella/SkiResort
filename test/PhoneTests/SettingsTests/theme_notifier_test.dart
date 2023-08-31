//test ok
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/settings/theme_notifier.dart';

// Define the Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {});

  group('ThemeNotifier', () {
    late ThemeNotifier themeNotifier;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      themeNotifier = ThemeNotifier()..prefs = mockSharedPreferences;

      // Mock the SharedPreferences setBool method to return true using Mocktail's way
      when(() => mockSharedPreferences.setBool(themeNotifier.key, false))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.setBool(themeNotifier.key, true))
          .thenAnswer((_) async => true);
    });

    test('should toggle dark theme', () {
      themeNotifier.toggleTheme();
      expect(themeNotifier.darkTheme, false);
      themeNotifier.toggleTheme();
      expect(themeNotifier.darkTheme, true);
    });
  });
}
