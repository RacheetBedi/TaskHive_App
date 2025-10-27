import 'package:firebase_auth/firebase_auth.dart';

class AppUser{
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final bool isEmailVerified;
  final String? phoneNumber;
  final bool? isNewUser;

  const AppUser({
    required this.uid,
    this.displayName,
    this.email,
    this.photoURL,
    this.isEmailVerified = false,
    this.phoneNumber,
    this.isNewUser,
  });

  factory AppUser.fromFirebaseUser(User user, {bool isNewUser = false}){
    return AppUser(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
      isEmailVerified: user.emailVerified,
      isNewUser: isNewUser,
    );
  }

  AppUser copyWith({
    String? displayName,
    String? email,
    String? photoURL,
    bool? isEmailVerified,
    bool? isNewUser,
  }) {
    return AppUser(
      uid: this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }
}