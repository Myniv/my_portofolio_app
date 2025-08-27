import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:my_portofolio_app/widgets/delete_button.dart';
import 'package:my_portofolio_app/widgets/edit_button.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  // const _ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildProfileHeader(context),
                buildProfileInfo(context),
                buildProfileBio(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;
    return Container(
      padding: const EdgeInsets.all(10.0),
      // width: 500,
      height: 230,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blueAccent, Colors.blueGrey]),
        // color: const Color.fromARGB(255, 157, 121, 108),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black26,
          //   blurRadius: 10,
          //   offset: Offset(0, 5),
          // ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profile.profilePicturePath != null
                        ? FileImage(File(profile.profilePicturePath!))
                        : const AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    profile.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    profile.profession,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: [
                EditButton(
                  color: Colors.white,
                  onTab: () {
                    Navigator.pushNamed(
                      context,
                      '/editProfile',
                      arguments: {
                        'title': "Name and Profession",
                        'value': profile.name,
                        'value2': profile.profession,
                        'profileField': ProfileField.nameProfession,
                      },
                    );
                  },
                ),
                DeleteButton(
                  color: const Color.fromARGB(255, 250, 129, 121),
                  onTab: () {
                    Navigator.of(context).pop(true);
                    context.read<ProfileProvider>().deleteProfileField(
                      ProfileField.nameProfession,
                    );
                  },
                  name: "Name and Profession",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileInfo(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
      child: Column(
        children: [
          buildInfoBox(
            Icons.email,
            profile.email,
            "Email",
            () {
              Navigator.pushNamed(
                context,
                '/editProfile',
                arguments: {
                  'title': "Email",
                  'value': profile.email,
                  'profileField': ProfileField.email,
                },
              );
            },
            () {
              Navigator.of(context).pop(true);
              context.read<ProfileProvider>().deleteProfileField(
                ProfileField.email,
              );
            },
          ),
          buildInfoBox(
            Icons.phone,
            profile.phone.toString(),
            "Phone Number",
            () {
              Navigator.pushNamed(
                context,
                '/editProfile',
                arguments: {
                  'title': "Phone Number",
                  'value': profile.phone.toString(),
                  'profileField': ProfileField.phone,
                },
              );
            },
            () {
              Navigator.of(context).pop(true);
              context.read<ProfileProvider>().deleteProfileField(
                ProfileField.phone,
              );
            },
          ),
          buildInfoBox(
            Icons.location_on,
            profile.address,
            "Address",
            () {
              Navigator.pushNamed(
                context,
                '/editProfile',
                arguments: {
                  'title': "Address",
                  'value': profile.address,
                  'profileField': ProfileField.address,
                },
              );
            },
            () {
              Navigator.of(context).pop(true);
              context.read<ProfileProvider>().deleteProfileField(
                ProfileField.address,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildInfoBox(
    final IconData? leadingIcon,
    final String text,
    final String title,
    final VoidCallback onEdit,
    final VoidCallback onDelete,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leadingIcon != null) ...[
            Container(
              alignment: Alignment.center,
              child: Icon(leadingIcon, color: Colors.blueGrey),
            ),
          ],
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(text, style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
          ),
          EditButton(onTab: onEdit),
          DeleteButton(onTab: onDelete, name: title),
        ],
      ),
    );
  }

  Widget buildProfileBio(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "About Me",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        profile.bio,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                EditButton(
                  onTab: () {
                    Navigator.pushNamed(
                      context,
                      '/editProfile',
                      arguments: {
                        'title': "Biography",
                        'value': profile.bio,
                        'profileField': ProfileField.bio,
                      },
                    );
                  },
                ),
                DeleteButton(
                  onTab: () {
                    Navigator.of(context).pop(true);
                    context.read<ProfileProvider>().deleteProfileField(
                      ProfileField.bio,
                    );
                  },
                  name: "About Me",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
