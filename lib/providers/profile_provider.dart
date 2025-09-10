import 'package:flutter/material.dart';
import 'package:my_portofolio_app/models/profile.dart';
import '../services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  Profile? _profile;
  Profile? get profile => _profile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // form key
  final formKey = GlobalKey<FormState>();

  // controllers
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final bioController = TextEditingController();

  // load profile from Firestore
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
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // update profile ke Firestore
  Future<void> updateProfile() async {
    if (_profile == null) return;
    if (!formKey.currentState!.validate()) return;

    _setLoading(true);
    try {
      final updated = Profile(
        uid: _profile!.uid,
        email: _profile!.email,
        name: nameController.text,
        profession: professionController.text,
        phone: phoneController.text,
        address: addressController.text,
        bio: bioController.text,
        profilePicturePath: _profile!.profilePicturePath,
        role: _profile!.role,
      );

      await _profileService.updateUserProfile(updated);
      _profile = updated;
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void clearProfile() {
    _profile = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
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
}
