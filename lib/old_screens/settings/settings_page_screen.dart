// main page for settings page; this file represents the whole settings page screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './list_tiles_setting.dart';
import './single_section_setting.dart';
import 'package:ski_resorts_app/old_screens/settings/theme_notifier.dart';

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
                ],
              ),
              const Divider(),
              const SingleSection(
                title: "Organization",
                children: [
                  CustomListTile(
                    title: "Profile",
                    icon: Icons.person_outline_rounded,
                    pageName: 'ProfilePageScreen',
                  ),
                  CustomListTile(
                    title: "Messaging",
                    icon: Icons.message_outlined,
                  ),
                  CustomListTile(
                    title: "Calling",
                    icon: Icons.phone_outlined,
                  ),
                  CustomListTile(
                    title: "People",
                    icon: Icons.contacts_outlined,
                  ),
                  CustomListTile(
                    title: "Calendar",
                    icon: Icons.calendar_today_rounded,
                  ),
                ],
              ),
              const Divider(),
              const SingleSection(
                children: [
                  CustomListTile(
                    title: "Help & Feedback",
                    icon: Icons.help_outline_rounded,
                    pageName: 'HelpAndFeedbackPage',
                  ),
                  CustomListTile(
                    title: "About",
                    icon: Icons.info_outline_rounded,
                    pageName: 'AboutUsPage',
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
