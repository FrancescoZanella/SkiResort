import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/user_data_model.dart';

void editInformation(BuildContext context, String field, String currentValue,
    UserModel userModel) {
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
            onPressed: () {
              userModel.updateField(field, newValue);
              // now update firebase
              //TODO: update firebase and check if the logic is correct
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
