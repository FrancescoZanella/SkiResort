import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ski_resorts_app/old_screens/settings/logout_logic/logout_functions.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing, //for example the one at the right of darkMode text
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
                  onPressed: () async {
                    User? currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      if (kDebugMode) {
                        print(currentUser.providerData[0].providerId);
                      }
                      switch (currentUser.providerData[0].providerId) {
                        case 'google.com':
                          // The user signed in with Google
                          await logoutGoogleUser();
                          break;
                        case 'facebook.com':
                          // The user signed in with Facebook
                          await logoutFacebookUser();
                          break;
                        default:
                          // The user signed in with email and password
                          await logoutUser();
                      }
                    }
                    if (context.mounted) {
                      // Navigate to the login page
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/OnboardingMenu',
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: const Text('Log Out'),
                ),
              ],
            ),
          );
        } else {
          Navigator.pushNamed(context, '/$pageName');
        }
      },
    );
  }
}
