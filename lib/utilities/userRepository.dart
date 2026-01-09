import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class UserRepository {

  final WidgetRef ref;

  UserRepository(this.ref);

  AppUser? get currentAppUser {
    final authState = ref.read(authProvider);
    return authState.asData?.value;
  }

  DocumentReference<Map<String, dynamic>> get currentUserDocument => _firestore.collection('users').doc(currentAppUser?.uid);

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  Future<AppUser?> initializeAppUserObject() async{
    try{
    final user = currentAppUser;
    if(user == null) return null;
    Get.snackbar('Initializing the App User', 'Please help me');

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if(!doc.exists) return null;
    final data = doc.data();

    final updatedUser = AppUser(
      dark_mode: data?['dark_mode'] ?? false,
      hasCompletedSetup: data?['hasCompletedSetup'] ?? false,
      isEmailVerified: user.isEmailVerified,
      is_teacher: data?['is_teacher'] ?? false,
      lang: data?['lang'] ?? '',
      logoPref: data?['logo_preference'] ?? 1,
      password: data?['password'] ?? '',
      country_code: data?['public profile']?['contact_info']?['country_code'] ?? 1,
      email: user.email,
      phoneNumber: data?['public profile']?['contact_info']?['phone_number'] ?? 000000000,
      description: data?['public profile']?['description'] ?? '',
      displayFirstName: data?['public profile']?['firstName'] ?? '',
      displayLastName: data?['public profile']?['lastName'] ?? '',
      photoURL: data?['public profile']?['photo_URL'] ?? '',
      school: data?['school'] ?? " ",
      uid: user.uid,
      userName: data?['username'] ?? '',
    );

    //Get.snackbar('The following is the user data in the doc:', '${updatedUser.displayFirstName}, ${updatedUser.displayLastName}, ${updatedUser.email}, ${updatedUser.uid}');

    return updatedUser;
    } catch (e){
      Get.snackbar("Error", "Failed to initialize in user repository: $e");
      return null;
    }
  }
  

  Future<void> updateDocumentData({
    String? uid,
    String? displayFirstName,
    String? displayLastName,
    String? email, 
    String? photoURL,
    bool? isEmailVerified,
    String? phoneNumber,
    bool? hasCompletedSetup,
    String? description,
    bool? dark_mode,
    bool? is_teacher,
    String? lang,
    int? logoPref,
    int? country_code,
    String? userName,
    String? password,
    String? school,
    }) async{

    final user = currentAppUser;
    if(user == null) return null;

    final docRef = _firestore.collection('users').doc(user.uid);
    final doc = await docRef.get();

    if(doc.exists){
      final updateData = <String, dynamic>{
        if(dark_mode != null) 'dark_mode': dark_mode,
        if(isEmailVerified != null) 'isEmailVerified': isEmailVerified,
        if (hasCompletedSetup != null) "hasCompletedSetup": hasCompletedSetup,
        if(is_teacher != null) "is_teacher": is_teacher,
        if(lang != null) "lang": lang,
        if(logoPref != null) "logo_preference": logoPref,
        if(password != null) "password": password,
        "public profile": {
          "contact_info": {
            if(country_code != null) "country_code": country_code,
            if(email != null) "email_address": email,
            if(phoneNumber != null) "phone_number": phoneNumber,
          },
          if(description != null) "description": description,
          if(displayFirstName != null) "firstName": displayFirstName,
          if(displayLastName != null) "lastName": displayLastName,
          if(photoURL != null) "photo_URL": user.photoURL,
        },
        'uid': user.uid,
        if(userName != null) 'username': userName,
        if(school != null) 'school': school,
      };

      await docRef.set(updateData, SetOptions(merge: true));
    }
  }

  Future<void> createUserDocIfNeeded(String email, String userName, String firstName, String lastName, String password, {bool isNewUser = true}) async {
    try{
    final user = currentAppUser;
    if(user == null){
      Get.snackbar("User Error:", "The User is null");
      return;
    }

    user.email = email;
    user.userName = userName;
    user.displayFirstName = firstName;
    user.displayLastName = lastName;
    user.password = password;


    final docRef = _firestore.collection('users').doc(user?.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        "dark_mode": user.dark_mode ?? false,
        "isEmailVerified": user?.isEmailVerified ?? false,
        "hasCompletedSetup": user.hasCompletedSetup ?? false,
        "is_teacher": user.is_teacher ?? false,
        "lang": user.lang ?? 'EN',
        "logo_preference": user.logoPref ?? 1,
        "password": user.password ?? '',
        "public profile": {
          "contact_info": {
            "country_code": user.country_code ?? 1,
            "email_address": user.email ?? '',
            "phone_number": user?.phoneNumber ?? 0000000000,
          },
          "description": user.description ?? '',
          "firstName": user.displayFirstName ?? '',
          "lastName": user.displayLastName ?? '',
          "photo_URL": user?.photoURL ?? '',
        },
        'uid': user?.uid ?? '',
        'username': user.userName ?? '',
        'school': user.school ?? '',
      });
    }
    } catch(err, st){
        Get.snackbar(
          "Error",
          "Unexpected Firestore Document Creation Error: ${err.toString()}",
          duration: const Duration(seconds: 10),
        );
    }
  }

    Future<void> createTeacherUserDocIfNeeded(String email, String userName, String firstName, String lastName, String password, bool isTeacher, String school, {bool isNewUser = true}) async {
    try{
    final user = currentAppUser;
    if(user == null){
      Get.snackbar("User Error:", "The User is null");
      return;
    }

    user!.email = email;
    user!.userName = userName;
    user!.displayFirstName = firstName;
    user!.displayLastName = lastName;
    user!.password = password;
    user!.is_teacher = isTeacher;
    user!.school = school;


    final docRef = _firestore.collection('teacher_users').doc(user?.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        "dark_mode": user.dark_mode ?? false,
        "isEmailVerified": user?.isEmailVerified ?? false,
        "hasCompletedSetup": user.hasCompletedSetup ?? false,
        "is_teacher": user.is_teacher ?? false,
        "lang": user.lang ?? 'EN',
        "logo_preference": user.logoPref ?? 1,
        "password": user.password ?? '',
        "public profile": {
          "contact_info": {
            "country_code": user.country_code ?? 1,
            "email_address": user.email ?? '',
            "phone_number": user?.phoneNumber ?? 0000000000,
          },
          "description": user.description ?? '',
          "firstName": user.displayFirstName ?? '',
          "lastName": user.displayLastName ?? '',
          "photo_URL": user?.photoURL ?? '',
        },
        'uid': user?.uid ?? '',
        'username': user.userName ?? '',
        'school': user.school ?? '',
      });
      // Change hasCompletedSetup based on google sign in (if not google, it is false here since the email still has to be verified, but if google, it is true...)
    }
    } catch(err, st){
        Get.snackbar(
          "Error",
          "Unexpected Firestore Document Creation Error: ${err.toString()}",
          duration: const Duration(seconds: 10),
        );
    }
  }

  Future<bool> hasCompletedSetup() async {
    final user = currentAppUser;
    if(user == null) return false;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.exists && (doc.data()?['hasCompletedSetup'] == true);
  }
}
