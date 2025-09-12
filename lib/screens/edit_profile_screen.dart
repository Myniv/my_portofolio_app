import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_portofolio_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isInitialized = false;
  String? _currentUid;
  String? _originalUid;
  bool _isEditingProfile2 = false;

  @override
  void initState() {
    super.initState();
    _loadUid();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      final String? uid = args?['uid'];

      if (uid != null) {
        _currentUid = uid;
        _isEditingProfile2 = true;

        profileProvider.setEditingState(true);

        print("EditProfileScreen: Editing profile2 for UID: $uid");

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _loadProfileData(profileProvider, uid);
        });
      } else {
        _isEditingProfile2 = false;

        profileProvider.setEditingState(false);

        print("EditProfileScreen: Editing current user profile");
        _populateFormFields(profileProvider.profile, profileProvider);
      }

      _isInitialized = true;
    }
  }

  void _loadProfileData(ProfileProvider profileProvider, String uid) {
    var targetProfile = profileProvider.profile2;

    if (targetProfile == null || targetProfile.uid != uid) {
      try {
        targetProfile = profileProvider.allProfiles.firstWhere(
          (profile) => profile.uid == uid,
        );
        profileProvider.setProfile2(targetProfile);
      } catch (e) {
        print("Profile not found in allProfiles for UID: $uid");
        return;
      }
    }
    _populateFormFields(targetProfile, profileProvider);
  }

  void _populateFormFields(dynamic profile, ProfileProvider profileProvider) {
    if (profile != null) {
      profileProvider.nameController.text = profile.name ?? '';
      profileProvider.professionController.text = profile.profession ?? '';
      profileProvider.phoneController.text = profile.phone ?? '';
      profileProvider.addressController.text = profile.address ?? '';
      profileProvider.bioController.text = profile.bio ?? '';
    }
  }

  void _loadUid() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final uid = await authProvider.loadUserUID();
    if (uid != null) {
      setState(() {
        _originalUid = uid;
      });
    }
  }

  dynamic _getCurrentProfile(ProfileProvider profileProvider) {
    return _isEditingProfile2
        ? profileProvider.profile2
        : profileProvider.profile;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final currentProfile = _getCurrentProfile(provider);

    if (provider.isLoading && currentProfile == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _isEditingProfile2
                ? "Edit ${currentProfile?.name ?? 'Profile'}"
                : "Edit Profile",
          ),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(color: Colors.blueAccent),
        ),
      );
    }

    if (currentProfile == null) {
      return const Scaffold(
        body: Center(child: Text("No profile data found.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditingProfile2
              ? "Edit ${currentProfile.name ?? 'Profile'}"
              : "Edit Profile",
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (provider.errorMessage != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    border: Border.all(color: Colors.red[200]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          provider.errorMessage!,
                          style: TextStyle(color: Colors.red[800]),
                        ),
                      ),
                    ],
                  ),
                ),

              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueAccent, width: 3),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: provider.selectedImageFile != null
                            ? FileImage(provider.selectedImageFile!)
                            : currentProfile.profilePicturePath != null
                            ? NetworkImage(currentProfile.profilePicturePath!)
                            : null,
                        child: currentProfile.profilePicturePath == null
                            ? const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.blueGrey,
                              )
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: provider.isUploadingPhoto
                                ? null
                                : () async {
                                    try {
                                      await provider.pickImage();
                                    } catch (e) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Failed to upload photo: $e',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: provider.isUploadingPhoto
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _buildTextField(
                controller: provider.nameController,
                label: "Full Name",
                icon: Icons.person,
                validator: (val) =>
                    val == null || val.isEmpty ? "Name is required" : null,
              ),

              const SizedBox(height: 16),

              _buildTextField(
                controller: provider.professionController,
                label: "Profession",
                icon: Icons.work,
              ),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async => provider.pickDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.cake, color: Colors.blueAccent),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Birthday",
                                  style: TextStyle(
                                    color: Colors.blueGrey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currentProfile.birthday != null
                                      ? DateFormat(
                                          'dd MMMM yyyy',
                                        ).format(currentProfile.birthday!)
                                      : "Select your birthday",
                                  style: TextStyle(
                                    color: currentProfile.birthday != null
                                        ? Colors.black87
                                        : Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: Colors.blueGrey[400],
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              _buildTextField(
                controller: provider.phoneController,
                label: "Phone Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 16),

              _buildTextField(
                controller: provider.addressController,
                label: "Address",
                icon: Icons.location_on,
                maxLines: 2,
              ),

              const SizedBox(height: 16),

              _buildTextField(
                controller: provider.bioController,
                label: "About Me",
                icon: Icons.info,
                maxLines: 4,
                hint: "Your bio...",
              ),

              const SizedBox(height: 30),

              provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blueAccent, Colors.blue],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (provider.formKey.currentState!.validate()) {
                            try {
                              // Use appropriate update method based on editing state
                              if (_isEditingProfile2) {
                                await provider.updateProfile2();
                              } else {
                                await provider.updateProfile();
                              }

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Profile updated successfully!',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                // Handle navigation and state updates
                                if (_currentUid != null &&
                                    _originalUid != null &&
                                    _currentUid != _originalUid) {
                                  // If editing someone else's profile, reload all profiles
                                  await provider.loadAllProfiles();
                                  // Set back to original user's profile
                                  provider.setProfile(
                                    provider.allProfiles.firstWhere(
                                      (profile) => profile.uid == _originalUid,
                                    ),
                                  );
                                  await provider.loadProfile(_originalUid!);
                                } else if (_isEditingProfile2) {
                                  // If editing profile2, reload all profiles
                                  await provider.loadAllProfiles();
                                } else {
                                  // If editing own profile, reload current profile
                                  final currentUid = provider.profile?.uid;
                                  if (currentUid != null) {
                                    await provider.loadProfile(currentUid);
                                  }
                                }

                                Navigator.pop(context);
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Failed to update profile: $e',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              print("Failed to update profile: $e");
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? hint,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueGrey[300]!),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }
}
