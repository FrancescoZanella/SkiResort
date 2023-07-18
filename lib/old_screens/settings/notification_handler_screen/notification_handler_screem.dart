import 'package:flutter/material.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);
  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool _isNotificationOn = true;

  void _saveNotificationStatus(bool value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notifications"),
                Switch(
                  value: _isNotificationOn,
                  onChanged: (value) {
                    setState(() {
                      _isNotificationOn = value;
                    });
                    _saveNotificationStatus(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Receive notifications about new messages, updates, and other activity.",
            ),
          ],
        ),
      ),
    );
  }
}
