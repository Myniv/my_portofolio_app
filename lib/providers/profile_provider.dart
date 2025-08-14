import 'package:flutter/material.dart';
import 'package:my_portofolio_app/models/profile.dart';

enum ProfileField { nameProfession, email, phone, address, bio }

class ProfileProvider extends ChangeNotifier {
  final Profile _profile = Profile();
  Profile get profile => _profile;
  void addEditProfileField(String value, String? value2, ProfileField field) {
    switch (field) {
      case ProfileField.nameProfession:
        _profile.name = value;
        _profile.profession = value2 ?? '';
        notifyListeners();
        break;
      case ProfileField.email:
        _profile.email = value;
        notifyListeners();
        break;
      case ProfileField.phone:
        _profile.phone = int.parse(value);
        notifyListeners();
        break;
      case ProfileField.address:
        _profile.address = value;
        notifyListeners();
        break;
      case ProfileField.bio:
        _profile.bio = value;
        notifyListeners();
        break;
      default:
    }
  }

  void deleteProfileField(ProfileField field) {
    switch (field) {
      case ProfileField.nameProfession:
        _profile.name = '';
        _profile.profession = '';
        notifyListeners();
        break;
      case ProfileField.email:
        _profile.email = '';
        notifyListeners();
        break;
      case ProfileField.phone:
        _profile.phone = 0;
        notifyListeners();
        break;
      case ProfileField.address:
        _profile.address = '';
        notifyListeners();

        break;
      case ProfileField.bio:
        _profile.bio = '';
        notifyListeners();
        break;
      default:
    }
  }
}
