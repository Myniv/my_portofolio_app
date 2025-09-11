import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_portofolio_app/models/profile.dart';
import 'package:my_portofolio_app/services/profile_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ProfileService _profileService = ProfileService();

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User in auth service: ${credential.user}");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message) ?? "Login failed";
    }
  }

  Future<User?> registerWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        final profile = Profile(
          uid: user.uid,
          name: user.email!.split('@')[0],
          email: user.email!,
          role: "member",
        );
        await _profileService.createUserProfile(profile);

        await _auth.signOut();
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message) ?? "Registration failed";
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      User? user = userCredential.user;

      final exists = await _profileService.checkUserExists(user!.uid);

      if (!exists) {
        final profile = Profile(
          uid: user.uid,
          name: user.displayName ?? "No Name",
          email: user.email!,
          role: "member",
          profilePicturePath: user.photoURL,
        );
        await _profileService.createUserProfile(profile);
      }

      print("User in auth service: $exists");

      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
