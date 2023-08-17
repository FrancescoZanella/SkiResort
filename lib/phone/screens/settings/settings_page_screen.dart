// main page for settings page; this file represents the whole settings page screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logout_logic/list_tiles_setting.dart';
import './single_section_setting.dart';
import 'package:ski_resorts_app/phone/screens/settings/theme_notifier.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              SingleSection(
                title: "General",
                children: [
                  CustomListTile(
                    title: "Dark Mode",
                    icon: Icons.dark_mode_outlined,
                    trailing: Switch(
                      value: themeNotifier.darkTheme,
                      onChanged: (value) {
                        themeNotifier.toggleTheme();
                      },
                    ),
                  ),
                  const CustomListTile(
                    title: 'Notifications',
                    icon: Icons.notifications,
                    pageName: 'NotificationSettingScreen',
                  ),
                  const CustomListTile(
                    title: "Position",
                    icon: Icons.location_on_outlined,
                    pageName: 'LocationSettingScreen',
                  ),
                  const CustomListTile(
                    title: "Profile",
                    icon: Icons.person_outline_rounded,
                    pageName: 'ProfilePageScreen',
                  ),
                ],
              ),
              const SingleSection(
                title: "Devices",
                children: [
                  CustomListTile(
                    title: "Connect Smartwatch",
                    icon: Icons.watch,
                    pageName: 'ConnectSmartwatchScreen',
                  ),
                ],
              ),
              const Divider(),
              const SingleSection(
                title: "Support",
                children: [
                  CustomListTile(
                    title: "About Us",
                    icon: Icons.info_outline_rounded,
                    pageName: 'AboutUsPage',
                  ),
                  CustomListTile(
                    title: "Rate Our App",
                    icon: Icons.star_rate_rounded,
                    pageName:
                        'RateOurAppScreen', // Remember to link this to your actual rate app page
                  ),
                  CustomListTile(
                    title: "Report Bug",
                    icon: Icons.bug_report_rounded,
                    pageName:
                        'ReportBugScreen', // Remember to link this to your actual report bug page
                  ),
                  CustomListTile(
                    title: "Sign out",
                    icon: Icons.exit_to_app_rounded,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
