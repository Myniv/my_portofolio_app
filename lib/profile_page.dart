import 'package:flutter/material.dart';
import 'package:my_portofolio_app/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildProfileHeader(),
            buildProfileInfo(),
            buildProfileBio(),
          ],
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            profile.profession,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buildProfileInfo() {
    final profile = Profile();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.email, color: Colors.grey),
              SizedBox(width: 10),
              Text(profile.email, style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.grey),
              SizedBox(width: 10),
              Text(profile.phone, style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey),
              SizedBox(width: 10),
              Text(profile.address, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProfileBio() {
    final profile = Profile();

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Padding(padding: EdgeInsets.all(8.0)),
          Text(
            "About Me",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(profile.bio, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
