import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_portofolio_app/models/profile.dart';

enum ProfileField { nameProfession, email, phone, address, bio }

class ProfileProvider extends ChangeNotifier {
  final profileKey = GlobalKey<FormState>();
  final value = TextEditingController();
  final value2 = TextEditingController();
  Profile profile = Profile();

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profile.profilePicturePath = pickedFile.path;
      notifyListeners();
    }
  }

  void addEditProfileField(ProfileField field) {
    switch (field) {
      case ProfileField.nameProfession:
        profile.name = value.text;
        profile.profession = value2.text;
        notifyListeners();
        break;
      case ProfileField.email:
        profile.email = value.text;
        notifyListeners();
        break;
      case ProfileField.phone:
        profile.phone = int.parse(value.text);
        notifyListeners();
        break;
      case ProfileField.address:
        profile.address = value.text;
        notifyListeners();
        break;
      case ProfileField.bio:
        profile.bio = value.text;
        notifyListeners();
        break;
      default:
    }
  }

  void getProfileData(ProfileField field) {
    switch (field) {
      case ProfileField.nameProfession:
        value.text = profile.name ?? '';
        value2.text = profile.profession ?? '';
        notifyListeners();
        break;
      case ProfileField.email:
        value.text = profile.email ?? '';
        notifyListeners();
        break;
      case ProfileField.phone:
        value.text = profile.phone?.toString() ?? '';
        notifyListeners();
        break;
      case ProfileField.address:
        value.text = profile.address ?? '';
        notifyListeners();
        break;
      case ProfileField.bio:
        value.text = profile.bio ?? '';
        notifyListeners();
        break;
      default:
    }
  }

  void deleteProfileField(ProfileField field) {
    switch (field) {
      case ProfileField.nameProfession:
        profile.name = '';
        profile.profession = '';
        profile.profilePicturePath = null;
        notifyListeners();
        break;
      case ProfileField.email:
        profile.email = '';
        notifyListeners();
        break;
      case ProfileField.phone:
        profile.phone = 0;
        notifyListeners();
        break;
      case ProfileField.address:
        profile.address = '';
        notifyListeners();

        break;
      case ProfileField.bio:
        profile.bio = '';
        notifyListeners();
        break;
      default:
    }
  }
}
