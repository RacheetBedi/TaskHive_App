import 'package:firebase_auth/firebase_auth.dart';

class AppUser{
  String uid;
  bool? dark_mode;
  bool? is_teacher;
  String? lang;
  int? logoPref;
  String? password;
  int? country_code;
  String? displayFirstName;
  String? displayLastName;
  String? userName;
  String? email;
  String? photoURL;
  bool isEmailVerified;
  String? phoneNumber;
  bool hasCompletedSetup;
  String? description;

  AppUser({
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
    String password = "",
    int country_code = 1,
    String userName = "",
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