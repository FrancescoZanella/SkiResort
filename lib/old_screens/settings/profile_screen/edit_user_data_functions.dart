import 'package:flutter/material.dart';
import 'package:ski_resorts_app/screens/user_data_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final firebaseUrl = Uri.https(
  'dimaproject2023-default-rtdb.europe-west1.firebasedatabase.app',
  '/user-table.json',
);

Future<void> updateUserInFirebase(
    String userId, Map<String, dynamic> updates) async {
  final url =
      Uri.parse(firebaseUrl.toString().replaceFirst('.json', '/$userId.json'));
  final response = await http.patch(url, body: jsonEncode(updates));

  if (response.statusCode != 200) {
    throw Exception('Failed to update user in Firebase: ${response.body}');
  }
}

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
              // now update firebase
              await updateUserInFirebase(userId, {field: newValue});
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
