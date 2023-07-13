import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/screens/user_data_model.dart';
import 'package:ski_resorts_app/old_screens/settings/profile_screen/edit_user_data_functions.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
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
                    child: Transform.scale(
                      scale: 2.5,
                      child: CircleAvatar(
                        backgroundImage: userModel.avatarPath.startsWith('http')
                            ? NetworkImage(userModel.avatarPath)
                                as ImageProvider<Object>?
                            : AssetImage(userModel.avatarPath)
                                as ImageProvider<Object>?,
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
                  editInformation(context, 'Name', userModel.name, userModel);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline_rounded),
                title: Text('Surname: ${userModel.surname}'),
                onTap: () {
                  editInformation(
                      context, 'Surname', userModel.surname, userModel);
                },
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: Text('Email: ${userModel.email}'),
                onTap: () {
                  editInformation(context, 'Email', userModel.email, userModel);
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: Text('Phone Number: ${userModel.phoneNumber}'),
                onTap: () {
                  editInformation(context, 'Phone Number',
                      userModel.phoneNumber, userModel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
