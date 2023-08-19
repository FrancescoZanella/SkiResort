import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/settings/connect_smartwatch/barcode_page.dart';

class ConnectSmartwatchScreen extends StatefulWidget {
  const ConnectSmartwatchScreen({Key? key}) : super(key: key);

  @override
  State<ConnectSmartwatchScreen> createState() =>
      _ConnectSmartwatchScreenState();
}

class _ConnectSmartwatchScreenState extends State<ConnectSmartwatchScreen> {
  late Future<bool> _isConnected;

  Future<bool> _initializePaired() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('paired')!;
  }

  void _connectSmartwatch() async {
    //mi apre la pagina del qr code
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const QRViewExample(),
    ));
  }

  void _disconnectSmartwatch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('paired', false);
    setState(() {
      _isConnected = _initializePaired();
    });
  }

  @override
  void initState() {
    super.initState();
    _isConnected = _initializePaired();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _isConnected,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Text("Error knowing if connected");
          }
          //se è gia paired
          if (snapshot.data!) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Smartwatch is connected'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Align children to the start of the column's main axis
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 50.0), // Add padding to move the image higher up
                      child: Image.asset(
                        'lib/assets/images/smartWatchImage.png', // Replace with your image url
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                        height:
                            50.0), // Increase space between the image and the button
                    ElevatedButton(
                      onPressed: () {
                        // Implement the logic to disconnect to the selected device.
                        _disconnectSmartwatch();
                      },
                      child: const Text('Disconnect the smartwatch'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Connect a Smartwatch'),
              ),
              body: Center(
                  child: TextButton(
                child: const Text("pair using qr code"),
                onPressed: () {
                  _connectSmartwatch();
                },
              )),
            );
          }
        });
  }
}

/*return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Smartwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .start, // Align children to the start of the column's main axis
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 50.0), // Add padding to move the image higher up
              child: Image.asset(
                'lib/assets/images/smartWatchImage.png', // Replace with your image url
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
                height:
                    50.0), // Increase space between the image and the button
            ElevatedButton(
              onPressed: () {
                // Implement the logic to connect to the selected device.
              },
              child: const Text('Device Connected'),
            ),
          ],
        ),
      ),
    );*/
