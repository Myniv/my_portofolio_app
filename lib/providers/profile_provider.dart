import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_portofolio_app/models/profile.dart';
import '../services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  Profile? _profile;
  Profile? get profile => _profile;

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

  Future<void> loadProfile(String uid) async {
    _setLoading(true);
    try {
      _profile = await _profileService.getUserProfile(uid);

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
    if (_selectedImageFile != null) ;

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
      final url = await _profileService.uploadProfilePhoto(_profile!.uid, file, _profile!.profilePicturePath ?? '');
      
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
    if (value != null && _profile != null) {
      _profile = _profile!.copyWith(birthday: value);
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        print("Image picked: ${pickedFile.path}");
        // await uploadProfilePhoto(File(pickedFile.path));
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
    final initialDate =
        profile?.birthday ?? DateTime.now().subtract(Duration(days: 6570));

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
