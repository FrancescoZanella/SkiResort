import 'package:flutter/material.dart';

class LocationSettingScreen extends StatefulWidget {
  const LocationSettingScreen({Key? key}) : super(key: key);

  @override
  State<LocationSettingScreen> createState() => _LocationSettingScreenState();
}

class _LocationSettingScreenState extends State<LocationSettingScreen> {
  bool _isLocationEnabled = false;

  void _toggleLocationEnabled(bool value) {
    setState(() {
      _isLocationEnabled = value;
    });

    // TODO: Implement logic to enable or disable location services.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enable location services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Location'),
              subtitle: const Text('Allow the app to access your location'),
              value: _isLocationEnabled,
              onChanged: _toggleLocationEnabled,
            ),
            const SizedBox(height: 16),
            const Text(
              'Location accuracy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Higher accuracy means better location results, but also consumes more battery and data.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            RadioListTile<int>(
              title: const Text('High accuracy'),
              subtitle: const Text('Use GPS, Wi-Fi, and mobile networks'),
              value: 0,
              groupValue: 0, // TODO: Replace with current value
              onChanged: (value) {
                // TODO: Implement logic to set location accuracy
              },
            ),
            RadioListTile<int>(
              title: const Text('Medium accuracy'),
              subtitle: const Text('Use Wi-Fi and mobile networks'),
              value: 1,
              groupValue: 0, // TODO: Replace with current value
              onChanged: (value) {
                // TODO: Implement logic to set location accuracy
              },
            ),
            RadioListTile<int>(
              title: const Text('Low accuracy'),
              subtitle: const Text('Use mobile networks'),
              value: 2,
              groupValue: 0, // TODO: Replace with current value
              onChanged: (value) {
                // TODO: Implement logic to set location accuracy
              },
            ),
          ],
        ),
      ),
    );
  }
}
