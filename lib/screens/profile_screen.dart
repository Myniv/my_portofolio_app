import 'package:flutter/material.dart';
import 'package:my_portofolio_app/models/profile.dart';
import 'package:my_portofolio_app/screens/edit_profile_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  // width: 500,
                  height: 230,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.blueGrey],
                    ),
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
                        child: buildProfileHeader(),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                buildProfileInfo(),
                buildProfileBio(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(name: "Budi",),
                      ),
                    );
                  },
                  child: Text("Edit Profile Screen"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileHeader() {
    final profile = Profile();
    return Padding(
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
    );
  }

  Widget buildProfileInfo() {
    final profile = Profile();

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
      child: Column(
        children: [
          buildInfoBox(Icons.email, profile.email, "Email", () {}),
          buildInfoBox(Icons.phone, profile.phone, "Phone Number", () {}),
          buildInfoBox(Icons.location_on, profile.address, "Address", () {}),
          // buildInfoBox(Icons.info, profile.bio, () {}),
        ],
      ),
    );
  }

  Widget buildInfoBox(
    IconData leadingIcon,
    String text,
    String title,
    VoidCallback onEdit,
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
          Container(
            alignment: Alignment.center,
            child: Icon(leadingIcon, color: Colors.blueGrey),
          ),
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
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blueAccent),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }

  Widget buildProfileBio() {
    final profile = Profile();
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
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
