import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_portofolio_app/widgets/custom_appbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _initialized = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      final title = args?['title'] as String;
      final value = args?['value'] as String;
      final value2 = args?['value2'] as String?;
      final profileField = args?['profileField'] as ProfileField;

      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      profileProvider.getProfileData(profileField);
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final title = args?['title'] as String;
    final value = args?['value'] as String;
    final value2 = args?['value2'] as String?;
    final profileField = args?['profileField'] as ProfileField;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppbar(
        title: "Edit $title",
        icon: Icons.arrow_back,
        onIconPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: profileProvider.profileKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update your $title",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please enter the new details below.",
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),

              if (profileField == ProfileField.nameProfession) ...[
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            profileProvider.profile.profilePicturePath != null
                            ? FileImage(
                                File(
                                  profileProvider.profile.profilePicturePath!,
                                ),
                              )
                            : const AssetImage(
                                    'assets/images/profile.png',
                                  )
                                  as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => profileProvider.pickImage(),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),

              TextFormField(
                controller: profileProvider.value,
                decoration: InputDecoration(
                  labelText: value2 != null ? 'Name' : title,
                  hintText: value2 != null
                      ? 'Enter your name'
                      : 'Enter your $title',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: profileField == ProfileField.phone
                    ? TextInputType.number
                    : profileField == ProfileField.email
                    ? TextInputType.emailAddress
                    : TextInputType.text,
                inputFormatters: profileField == ProfileField.phone
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [],
              ),
              const SizedBox(height: 20),

              if (value2 != null) ...[
                TextFormField(
                  controller: profileProvider.value2,
                  decoration: InputDecoration(
                    labelText: 'Profession',
                    hintText: 'Enter your profession',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save, size: 20),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    final newValue = profileProvider.value.text.trim();
                    final newValue2 = profileProvider.value2.text.trim();

                    if (newValue.isNotEmpty) {
                      context.read<ProfileProvider>().addEditProfileField(
                        profileField,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$title edited successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  label: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
