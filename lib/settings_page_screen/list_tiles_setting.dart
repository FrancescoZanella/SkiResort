import 'package:flutter/material.dart';
import 'package:ski_resorts_app/settings_page_screen/about_us_screen/about_us_screen.dart';
import 'package:ski_resorts_app/settings_page_screen/help_Feedback_Screen/help_feedback.dart';
import 'package:ski_resorts_app/settings_page_screen/notification_handler_screen/notification_handler_screem.dart';
import 'package:ski_resorts_app/settings_page_screen/position_handler_screen/position_handler_screen.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final String? pageName;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
    this.pageName,
  }) : super(key: key);

  static final Map<String, Widget> _pageWidgets = {
    'NotificationSettingScreen': const NotificationSettingScreen(),
    'AboutUsPage': const AboutUsPage(),
    'HelpAndFeedbackPage': const HelpAndFeedbackPage(),
    'LocationSettingScreen': const LocationSettingScreen(),
    // add more pages here
  };

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing:
          trailing, //see for example the one at the right of dark mode text
      onTap: () {
        if (title == 'Sign out') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirm Log Out'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: handle log out logic
                    Navigator.pop(context);
                  },
                  child: const Text('Log Out'),
                ),
              ],
            ),
          );
        } else {
          Widget pageWidget = _pageWidgets[pageName]!;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageWidget),
          );
        }
      },
    );
  }
}
