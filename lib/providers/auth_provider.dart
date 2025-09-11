import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:my_portofolio_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  String? _errorMessage;
  bool _isLoading = false;

  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> signInWithEmail(
    String email,
    String password,
    ProfileProvider profileProvider,
  ) async {
    _setLoading(true);
    try {
      _user = await _authService.signInWithEmail(email, password);

      if (_user != null) {
        saveUserUID(_user!.uid);
        await profileProvider.loadProfile(_user!.uid);
        _user = user;
        print("User in auth provider: $_user");
      }
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> registerWithEmail(
    String email,
    String password,
    ProfileProvider profileProvider,
  ) async {
    _setLoading(true);
    try {
      _user = await _authService.registerWithEmail(email, password);
      _errorMessage = null;

      await profileProvider.loadProfile(user!.uid);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signInWithGoogle(ProfileProvider profileProvider) async {
    _setLoading(true);
    try {
      _user = await _authService.signInWithGoogle();
      print("User in auth provider: $_user");

      if (_user != null) {
        saveUserUID(_user!.uid);
        await profileProvider.loadProfile(_user!.uid);
        _user = user;
        print("User in auth provider: $_user");
      }
      _errorMessage = null;
      notifyListeners();
      return _user != null;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    clearAllPreferences();
    notifyListeners();
  }

  Future<void> saveUserUID(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', uid);
    } catch (e) {
      throw Exception('Failed to save user UID: $e');
    }
  }

  Future<String?> loadUserUID() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('uid');
    } catch (e) {
      throw Exception('Failed to get user UID: $e');
    }
  }

  clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
