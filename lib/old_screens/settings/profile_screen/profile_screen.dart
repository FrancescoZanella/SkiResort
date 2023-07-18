// ignore_for_file: unnecessary_cast
import 'package:ski_resorts_app/screens/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/old_screens/settings/profile_screen/edit_user_data_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/old_screens/settings/profile_screen/image_profile_handler_function.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  //here i take the user id from shared preferences so i can use it to update the user data on firebase

  String? userId;
  String? avatarPath;

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
                      onTap: () async {
                        showImageDialog(context, userModel);
                        // TODO: Update the user avatarpath on firebase
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
