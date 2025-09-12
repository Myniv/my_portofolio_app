import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:my_portofolio_app/screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final String? uid = args?['uid'];

      if (uid != null) {
        print("Loading profile for UID: $uid");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final profileProvider = context.read<ProfileProvider>();
          try {
            final selectedProfile = profileProvider.allProfiles.firstWhere(
              (profile) => profile.uid == uid,
            );
            profileProvider.setProfile2(selectedProfile);
            print("Profile loaded: ${selectedProfile.name}");
          } catch (e) {
            print("Profile not found for UID: $uid");
          }
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final profileProvider = context.read<ProfileProvider>();
          try {
            profileProvider.setProfile(profileProvider.profile!);
            print("Profile loaded: ${profileProvider.profile?.name}");
          } catch (e) {
            print("Profile not found for UID: $uid");
          }
        });
      }
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? uid = args?['uid'];

    print("Profile 2: ${provider.profile2?.name}");
    print("Profile 1: ${provider.profile?.name}");

    var profile = uid != null ? provider.profile2 : provider.profile;

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (profile == null) {
      return const Scaffold(
        body: Center(child: Text("No profile data found.")),
      );
    }

    return Scaffold(
      appBar: uid == null
          ? null
          : AppBar(
              title: Text(
                "${profile.name}'s Profile",
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blueAccent,
              leading: backButton(),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildProfileHeader(profile),
              buildProfileInfo(profile),
              buildProfileBio(profile),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "profile_fab",
        onPressed: () async {
          if (uid != null) {
            await Navigator.pushNamed(
              context,
              '/editProfile',
              arguments: {'uid': uid},
            );
          } else {
            await Navigator.pushNamed(context, '/editProfile');
          }

          // Reload the profile data after editing
          if (mounted) {
            final profileProvider = context.read<ProfileProvider>();
            if (uid != null) {
              await profileProvider.loadAllProfiles();
              try {
                final updatedProfile = profileProvider.allProfiles.firstWhere(
                  (profile) => profile.uid == uid,
                );
                profileProvider.setProfile2(updatedProfile);
              } catch (e) {
                print("Error finding updated profile: $e");
              }
            } else {
              final currentUid = profileProvider.profile?.uid;
              if (currentUid != null) {
                await profileProvider.loadProfile(currentUid);
              }
            }
          }
        },
        child: const Icon(Icons.edit, color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget buildProfileHeader(profile) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 230,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.blueGrey],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  (profile.profilePicturePath != null &&
                      profile.profilePicturePath!.isNotEmpty)
                  ? NetworkImage(profile.profilePicturePath!)
                  : null,
              child:
                  (profile.profilePicturePath == null ||
                      profile.profilePicturePath!.isEmpty)
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 10),
            Text(
              (profile.name?.isNotEmpty ?? false) ? profile.name! : "No Data",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: (profile.name?.isEmpty ?? true)
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              (profile.profession?.isNotEmpty ?? false)
                  ? profile.profession!
                  : "No Data",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontStyle: (profile.profession?.isEmpty ?? true)
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileInfo(profile) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
      child: Column(
        children: [
          buildInfoBox(Icons.email, profile?.email ?? "No Data", "Email"),
          buildInfoBox(
            Icons.phone,
            profile?.phone ?? "No Data",
            "Phone Number",
          ),
          buildInfoBox(
            Icons.location_on,
            profile?.address ?? "No Data",
            "Address",
          ),
          buildInfoBox(
            Icons.cake,
            profile?.birthday != null
                ? DateFormat('dd MMMM yyyy').format(profile!.birthday!)
                : "No Data",
            "Birthday",
          ),
        ],
      ),
    );
  }

  Widget buildInfoBox(IconData? leadingIcon, String? text, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leadingIcon != null) Icon(leadingIcon, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (text != null && text.isNotEmpty) ? text : "No Data",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontStyle: (text == null || text.isEmpty)
                        ? FontStyle.italic
                        : FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileBio(profile) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: const EdgeInsets.only(bottom: 10),
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
                      const Text(
                        "About Me",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (profile.bio?.isNotEmpty ?? false)
                            ? profile.bio!
                            : "No Data",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontStyle: (profile.bio?.isEmpty ?? true)
                              ? FontStyle.italic
                              : FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget backButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
