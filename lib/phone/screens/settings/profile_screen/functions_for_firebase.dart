import 'package:firebase_database/firebase_database.dart';

Future<void> updateDataOnFirebase(
    userModel, String userId, field, newValue) async {
  //update the user model and the share preferences
  if (field == 'avatar') {
    // there are different names for the avatar field in the user model and in the firebase realtime database
    userModel.updateField('avatarPath', newValue);
  } else {
    userModel.updateField(field, newValue);
  }

  // Create a reference to the specific user entry
  final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child('user-table').child(userId);

  // update the user entries in the firebase realtime database
  await userRef.update({field: newValue});
}
