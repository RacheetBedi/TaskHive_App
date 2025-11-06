import 'package:firebase_auth/firebase_auth.dart';

class AppUser{
  final String uid;
  final bool? dark_mode;
  final bool? is_teacher;
  final String? lang;
  final int? logoPref;
  final String? password;
  final int? country_code;
  final String? displayFirstName;
  final String? displayLastName;
  final String? userName;
  final String? email;
  final String? photoURL;
  final bool isEmailVerified;
  final String? phoneNumber;
  final bool hasCompletedSetup;
  final String? description;

  const AppUser({
    required this.uid,
    this.displayFirstName,
    this.displayLastName,
    this.email,
    this.photoURL,
    this.isEmailVerified = false,
    this.phoneNumber,
    required this.hasCompletedSetup,
    this.description,
    this.dark_mode,
    this.is_teacher,
    this.lang,
    this.logoPref,
    this.password,
    this.country_code,
    this.userName,
  });

  factory AppUser.fromFirebaseUser(User user, {
    bool hasCompletedSetup = false,
    bool dark_mode = false,
    bool is_teacher = false,
    String lang = "EN",
    int logoPref = 1,
    String password = "placeholder",
    int country_code = 1,
    String userName = "placeholder2",
    String description = "",
    String firstName = "",
    String lastName = "",
    }){
    return AppUser(
      uid: user.uid,
      displayFirstName: firstName,
      displayLastName: lastName,
      email: user.email,
      photoURL: user.photoURL,
      isEmailVerified: user.emailVerified,
      hasCompletedSetup: hasCompletedSetup,
      dark_mode: dark_mode,
      is_teacher: is_teacher,
      lang: lang,
      logoPref: logoPref,
      password: password,
      country_code: country_code,
      userName: userName,
      description: description,
    );
  }

  AppUser copyWith({
    String? displayName,
    String? email,
    String? photoURL,
    bool? isEmailVerified,
    bool? isNewUser,
    String? description,
    //ADD OTHER PROPERTIES LATER HERE!
  }) {
    return AppUser(
      uid: this.uid,
      displayFirstName: displayFirstName ?? this.displayFirstName,
      displayLastName: displayLastName ?? this.displayLastName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      hasCompletedSetup: isNewUser ?? this.hasCompletedSetup,
      description: description ?? this.description,
    );
  }
}