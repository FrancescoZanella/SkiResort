import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/user_data_model.dart';
import 'package:ski_resorts_app/old_screens/settings/profile_screen/functions_for_firebase.dart';

void editInformation(BuildContext context, String field, String currentValue,
    UserModel userModel, String userId) {
  showDialog(
    context: context,
    builder: (context) {
      String newValue = currentValue;
      return AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          onChanged: (value) => newValue = value,
          controller: TextEditingController(text: currentValue),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              updateDataOnFirebase(userModel, userId, field, newValue)
                  .then((_) {
                // update was successful
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Information updated successfully!'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              }).catchError((error) {
                // update failed
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Failed to update information. Please try again.'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              });
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
