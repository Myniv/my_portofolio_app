import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String uid;
  String name;
  String? profession;
  String email;
  String? phone;
  String? address;
  String? bio;
  String? profilePicturePath;
  String role;
  DateTime? birthday;

  Profile({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.profession,
    this.phone,
    this.address,
    this.bio,
    this.profilePicturePath,
    this.birthday,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profession': profession,
      'email': email,
      'phone': phone,
      'address': address,
      'bio': bio,
      'profilePicturePath': profilePicturePath,
      'birthday': birthday != null ? Timestamp.fromDate(birthday!) : null,
      'role': role,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      uid: map['uid'],
      name: map['name'],
      profession: map['profession'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      bio: map['bio'],
      profilePicturePath: map['profilePicturePath'],
      birthday: map['birthday'] != null ? (map['birthday'] as Timestamp).toDate() : null,
      role: map['role'] ?? 'member',
    );
  }
}
