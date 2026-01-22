import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  int? phoneNumber;
  bool hasCompletedSetup;
  String? description;
  String? school;
  List<Map<String, dynamic>>? possessions;

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
    this.school,
    this.possessions
  });

  factory AppUser.fromFirebaseUser(User user,{
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
    String school = "",
    List<Map<String, dynamic>>? possessions,
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
      school: school,
      possessions: possessions,
    );
  }

  AppUser copyWith({
    String? displayName,
    String? email,
    String? photoURL,
    bool? isEmailVerified,
    bool? isNewUser,
    String? description,
    String? school,
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
      school: school ?? this.school,
    );
  }
}