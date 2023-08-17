// profile_on_tap_functions.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/functions_for_firebase.dart';
import 'dart:io';

Future<String?> getImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return pickedFile.path;
  } else {
    return null;
  }
}

ImageProvider<Object> getTypeOfImageProvider(String path) {
  if (path.startsWith('http')) {
    return NetworkImage(path);
  } else if (path.startsWith('/')) {
    return FileImage(File(path));
  } else {
    return AssetImage(path);
  }
}

void showImageDialog(BuildContext context, UserModel userModel, String userId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: getTypeOfImageProvider(userModel.avatarPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  child: const Text('Upload an image from gallery'),
                  onPressed: () async {
                    final newPathImage = await getImage();
                    updateDataOnFirebase(
                      userModel,
                      userId,
                      'avatar',
                      newPathImage,
                    );
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
