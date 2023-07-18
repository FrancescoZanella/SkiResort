import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/user_data_model.dart';
import 'package:firebase_database/firebase_database.dart';

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
              // update the userModel and the shared preferences
              userModel.updateField(field, newValue);
              // update the user entries in the firebase realtime database

              // Create a reference to the specific user entry
              final DatabaseReference userRef = FirebaseDatabase.instance
                  .ref()
                  .child('user-table')
                  .child(userId);

              // update the user entries in the firebase realtime database
              await userRef.update({field: newValue}).then((_) {
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
