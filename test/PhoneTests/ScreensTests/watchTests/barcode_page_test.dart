import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ski_resorts_app/phone/screens/watch/barcode_page.dart';

class MockQRViewController extends Mock implements QRViewController {}

void main() {
  testWidgets('QRViewExample UI test', (WidgetTester tester) async {
    // Mock the QRViewController
    final mockController = MockQRViewController();

    when(mockController.scannedDataStream).thenAnswer((_) =>
        Stream<Barcode>.value(
            Barcode('QRCodeResult', BarcodeFormat.qrcode, [])));

    final widget = MaterialApp(
      home: QRViewExample(callback: (index) {}),
    );

    await tester.pumpWidget(widget);

    // Let's see if the QRView was rendered
    expect(find.byType(QRView), findsOneWidget);

    // Mocking scanning of a QR code. This would simulate as if a QR code is scanned.
    await tester.pump();

    // Check if QRView was created
    expect(find.byType(QRView), findsOneWidget);
  });
}
