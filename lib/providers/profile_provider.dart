import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_portofolio_app/models/profile.dart';
import '../services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  Profile? _profile;
  Profile? get profile => _profile;

  // Added profile2 logic
  Profile? _profile2;
  Profile? get profile2 => _profile2;

  bool _isEditingProfile2 = false;
  bool get isEditingProfile2 => _isEditingProfile2;

  List<Profile> _allProfiles = [];
  List<Profile> get allProfiles => _allProfiles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isUploadingPhoto = false;
  bool get isUploadingPhoto => _isUploadingPhoto;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  File? _selectedImageFile;
  File? get selectedImageFile => _selectedImageFile;

  final _picker = ImagePicker();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final bioController = TextEditingController();

  Future<void> loadAllProfiles() async {
    _setLoading(true);
    try {
      _allProfiles = await _profileService.getAllUserProfiles();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      print("Error fetching all profiles: $e");
      _errorMessage = "Failed to fetch all profiles: $e";
    } finally {
      _setLoading(false);
    }
  }

  void setProfile(Profile profile) {
    _profile = profile;
    _selectedImageFile = null;
    notifyListeners();
  }

  // Added profile2 methods
  void setProfile2(Profile profile) {
    _profile2 = profile;
    _selectedImageFile = null;
    notifyListeners();
  }

  void setEditingState(bool editingProfile2) {
    _isEditingProfile2 = editingProfile2;
    notifyListeners();
  }

  Future<void> loadProfile(String uid) async {
    _setLoading(true);
    try {
      _profile = await _profileService.getUserProfile(uid);
      print("Profile loaded: $_profile");

      if (_profile != null) {
        nameController.text = _profile!.name;
        professionController.text = _profile!.profession ?? '';
        phoneController.text = _profile!.phone ?? '';
        addressController.text = _profile!.address ?? '';
        bioController.text = _profile!.bio ?? '';
      }
      _errorMessage = null;
      _selectedImageFile = null;
      notifyListeners();
    } catch (e) {
      print("Error fetching profile: $e");
      _errorMessage = "Failed to fetch profile: $e";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateProfile() async {
    if (_profile == null) return;
    if (!formKey.currentState!.validate()) return;

    _setLoading(true);
    try {
      if (_selectedImageFile != null) {
        await uploadProfilePhoto(_selectedImageFile!);
      }

      final updated = Profile(
        uid: _profile!.uid,
        email: _profile!.email,
        name: nameController.text,
        profession: professionController.text,
        phone: phoneController.text,
        address: addressController.text,
        bio: bioController.text,
        profilePicturePath: _profile!.profilePicturePath,
        birthday: _profile!.birthday,
        role: _profile!.role,
      );

      await _profileService.updateUserProfile(updated);
      _profile = updated;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      print("Error updating profile: $e");
      _errorMessage = "Failed to update profile: $e";
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Added updateProfile2 method
  Future<void> updateProfile2() async {
    if (_profile2 == null) {
      _errorMessage = "No profile2 loaded for editing";
      notifyListeners();
      return;
    }

    if (!formKey.currentState!.validate()) return;

    _setLoading(true);
    try {
      String? updatedPhotoPath = _profile2!.profilePicturePath;
      if (_selectedImageFile != null) {
        updatedPhotoPath = await _profileService.uploadProfilePhoto(
          _profile2!.uid,
          _selectedImageFile!,
          _profile2!.profilePicturePath ?? '',
        );
      }

      final updated = Profile(
        uid: _profile2!.uid,
        name: nameController.text,
        email: _profile2!.email,
        role: _profile2!.role,
        profession: professionController.text,
        phone: phoneController.text,
        address: addressController.text,
        bio: bioController.text,
        profilePicturePath: updatedPhotoPath,
        birthday: _profile2!.birthday,
      );

      await _profileService.updateUserProfile(updated);

      _profile2 = updated;

      // Update in allProfiles list
      final index = _allProfiles.indexWhere((p) => p.uid == updated.uid);
      if (index != -1) {
        _allProfiles[index] = updated;
      }

      _errorMessage = null;
      _selectedImageFile = null;
      notifyListeners();

      print("Profile2 updated successfully: ${updated.name}");
    } catch (e) {
      print("Error updating profile2: $e");
      _errorMessage = "Failed to update profile: $e";
      notifyListeners();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  void clearProfile() {
    _profile = null;
    _errorMessage = null;
    _selectedImageFile = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setUploadingPhoto(bool value) {
    _isUploadingPhoto = value;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    professionController.dispose();
    phoneController.dispose();
    addressController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> uploadProfilePhoto(File file) async {
    if (_profile == null) {
      _errorMessage = "No profile loaded";
      notifyListeners();
      return;
    }
    _setUploadingPhoto(true);
    _errorMessage = null;
    notifyListeners();
    try {
      final url = await _profileService.uploadProfilePhoto(
        _profile!.uid,
        file,
        _profile!.profilePicturePath ?? '',
      );

      final updatedProfile = _profile!.copyWith(profilePicturePath: url);
      _profile = updatedProfile;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to upload photo: $e";
      _selectedImageFile = null;
      notifyListeners();
      rethrow;
    } finally {
      _setUploadingPhoto(false);
      _setLoading(false);
    }
  }

  void setBirthDay(DateTime? value) {
    if (value != null) {
      if (_isEditingProfile2 && _profile2 != null) {
        _profile2 = _profile2!.copyWith(birthday: value);
      } else if (_profile != null) {
        _profile = _profile!.copyWith(birthday: value);
      }
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        print("Image picked: ${pickedFile.path}");
        _setSelectedImageFile(File(pickedFile.path));
      }
    } catch (e) {
      print("Error picking image: $e");
      _errorMessage = "Failed to pick image: $e";
      _selectedImageFile = null;
      notifyListeners();
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final initialDate = _isEditingProfile2
        ? (_profile2?.birthday ?? DateTime.now().subtract(Duration(days: 6570)))
        : (profile?.birthday ?? DateTime.now().subtract(Duration(days: 6570)));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setBirthDay(picked);
    }
  }

  void _setSelectedImageFile(File? file) {
    _selectedImageFile = file;
    notifyListeners();
  }
}
