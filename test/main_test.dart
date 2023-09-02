//tests ok
// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/main.dart';
import 'package:ski_resorts_app/phone/screens/settings/theme_notifier.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';
import 'package:ski_resorts_app/smartwatch/home.dart';

class MockThemeNotifier extends Mock implements ThemeNotifier {}

class MockUserModel extends Mock implements UserModel {}

void main() {
  late MockThemeNotifier mockThemeNotifier;
  late MockUserModel mockUserModel;

  setUpAll(() {
    registerFallbackValue(MockUserModel());
    registerFallbackValue(MockThemeNotifier());
  });

  setUp(() {
    mockThemeNotifier = MockThemeNotifier();
    mockUserModel = MockUserModel();
  });

  testWidgets('shows dark theme when themeNotifier.darkTheme is true',
      (tester) async {
    when(() => mockThemeNotifier.darkTheme).thenReturn(true);

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => mockThemeNotifier,
        ),
        ChangeNotifierProvider<UserModel>(
          create: (_) => mockUserModel,
        ),
      ],
      child: const MyApp(),
    ));
  });

  testWidgets('displays SmartWatch UI for watch-sized devices', (tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(280, 280);

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => mockThemeNotifier,
        ),
        ChangeNotifierProvider<UserModel>(
          create: (_) => mockUserModel,
        ),
      ],
      child: const MyApp(),
    ));

    expect(find.byType(SmartWatch), findsOneWidget);
  });
}
