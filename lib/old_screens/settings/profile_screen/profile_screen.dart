// ignore_for_file: unnecessary_cast
import 'package:ski_resorts_app/screens/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/old_screens/settings/profile_screen/edit_user_data_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  //here i take the user id from shared preferences so i can use it to update the user data on firebase

  String? userId;

  void getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  ImageProvider<Object> getImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path) as ImageProvider<Object>;
    } else {
      return AssetImage(path) as ImageProvider<Object>;
    }
  }

  Future<String?> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, userModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(80.0 / 8),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize:
                                      MainAxisSize.min, // Make dialog smaller
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: getImageProvider(
                                              userModel.avatarPath),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ElevatedButton(
                                        child: const Text(
                                            'Upload an image from gallery'),
                                        onPressed: () async {
                                          final newPathImage = await getImage();
                                          if (newPathImage != null) {
                                            userModel.updateField(
                                                'avatar', newPathImage);
                                          }
                                          if (mounted) {
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
                      },
                      child: Transform.scale(
                        scale: 2.5,
                        child: CircleAvatar(
                          backgroundImage:
                              getTypeOfImageProvider(userModel.avatarPath),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.person_outline_rounded),
                title: Text('Name: ${userModel.name}'),
                onTap: () {
                  editInformation(
                      context, 'name', userModel.name, userModel, userId!);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline_rounded),
                title: Text('Surname: ${userModel.surname}'),
                onTap: () {
                  editInformation(context, 'surname', userModel.surname,
                      userModel, userId!);
                },
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: Text('Email: ${userModel.email}'),
                onTap: () {
                  editInformation(
                      context, 'email', userModel.email, userModel, userId!);
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: Text('Phone Number: ${userModel.phoneNumber}'),
                onTap: () {
                  editInformation(context, 'phoneNumber', userModel.phoneNumber,
                      userModel, userId!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
