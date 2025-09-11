import 'package:flutter/material.dart';
import 'package:my_portofolio_app/models/project.dart';
import 'package:my_portofolio_app/models/certification.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileListScreen extends StatefulWidget {
  @override
  State<ProfileListScreen> createState() => _ProfileListScreenState();
}

class _ProfileListScreenState extends State<ProfileListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().loadAllProfiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final profiles = provider.allProfiles;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: ListView.builder(
            itemCount: profiles.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final cert = profiles[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _listProfileView(
                  cert.profilePicturePath ?? "assets/images/profile.png",
                  cert.name,
                  cert.email,
                  cert.uid,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _listProfileView(
    String imagePath,
    String name,
    String email,
    String uid,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
      ),
      title: Text(name),
      subtitle: Text(email),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.pushNamed(context, '/profile', arguments: {'uid': uid});
      },
    );
  }
}
