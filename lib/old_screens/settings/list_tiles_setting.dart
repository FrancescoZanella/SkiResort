import 'package:flutter/material.dart';

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
          Navigator.pushNamed(context, '/$pageName');
        }
      },
    );
  }
}
