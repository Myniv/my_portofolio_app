import 'package:flutter/material.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:my_portofolio_app/widgets/delete_button.dart';
import 'package:my_portofolio_app/widgets/edit_button.dart';
import 'package:provider/provider.dart';
import 'package:my_portofolio_app/models/profile.dart';
import 'package:my_portofolio_app/screens/edit_profile_screen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: _ProfilePage(),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({super.key});

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
                    backgroundImage: AssetImage('assets/images/profile.png'),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider.value(
                          value: context.read<ProfileProvider>(),
                          child: EditProfileScreen(
                            value: profile.name,
                            value2: profile.profession,
                            profileField: ProfileField.nameProfession,
                            title: "Name and Profession",
                          ),
                        ),
                      ),
                    );
                  },
                ),
                DeleteButton(
                  color: const Color.fromARGB(255, 250, 129, 121),
                  onTab: () {
                    Navigator.of(context).pop(true); // use 'context' from here
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: context.read<ProfileProvider>(),
                    child: EditProfileScreen(
                      value: profile.email,
                      profileField: ProfileField.email,
                      title: "Email",
                    ),
                  ),
                ),
              );
            },
            () {
              Navigator.of(context).pop(true); // use 'context' from here
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: context.read<ProfileProvider>(),
                    child: EditProfileScreen(
                      value: profile.phone.toString(),
                      profileField: ProfileField.phone,
                      title: "Phone Number",
                    ),
                  ),
                ),
              );
            },
            () {
              Navigator.of(context).pop(true); // use 'context' from here
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: context.read<ProfileProvider>(),
                    child: EditProfileScreen(
                      value: profile.address,
                      profileField: ProfileField.address,
                      title: "Address",
                    ),
                  ),
                ),
              );
            },
            () {
              Navigator.of(context).pop(true); // use 'context' from here
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider.value(
                          value: context.read<ProfileProvider>(),
                          child: EditProfileScreen(
                            value: profile.bio,
                            profileField: ProfileField.bio,
                            title: "Biography",
                          ),
                        ),
                      ),
                    );
                  },
                ),
                DeleteButton(
                  onTab: () {
                    Navigator.of(context).pop(true); // use 'context' from here
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
