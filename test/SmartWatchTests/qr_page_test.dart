import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/smartwatch/qr_page.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('QrPage', () {
    testWidgets('displays the QR code and Done button',
        (WidgetTester tester) async {
      // arrange
      const androidId = 'mock_androidId';
      const isPaired = false;
      final qrPage = QrPage(androidId: androidId, ispaired: isPaired);
      await tester.pumpWidget(MaterialApp(home: qrPage));

      // assert
      expect(find.text('Scan the qr with the smartphone'), findsOneWidget);
      expect(find.text('app to pair the device'), findsOneWidget);
      expect(find.byType(QrImageView), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);
    });
  });
}
