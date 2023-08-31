import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      body: */
        Column(
      children: <Widget>[
        Expanded(flex: 4, child: _buildQrView(context)),
      ],
    );
    //);
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Future<bool> saveAssociation(String? result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    // Controlla se la coppia userId e result esiste già nel database
    final url = Uri.https(
      'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
      '/pairs-table.json',
    );

    final response = await http.get(url);
    if (response.statusCode != 200) {
      return false;
    }
    bool existingEntry = false;
    final data = json.decode(response.body);
    for (var entry in data.entries) {
      var val = entry.value;
      if (val['mac'] == result && val['userid'] == userId) {
        existingEntry = true;
        break;
      }
    }

    if (existingEntry) {
      // La coppia userId e result esiste già nel database
      return false;
    }

    // La coppia non esiste ancora nel database, quindi esegui il post
    final postResponse = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'mac': result,
          'userid': userId,
        }));

    if (postResponse.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        //add a function to save the association result!.code and sharedprefs.userid in firebase,
        // se la funzione ritorna true allora pusho la pagina resultpage
        if (await saveAssociation(result!.code)) {
          // ignore: use_build_context_synchronously
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('paired', true);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pop(context);
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
