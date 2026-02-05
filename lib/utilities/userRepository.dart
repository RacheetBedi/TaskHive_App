import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/group_models/hive.dart';
import 'package:flutter_app/models/user_models/app_user.dart';
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
    final activityLogDoc = await _firestore.collection('users').doc(user.uid).collection('possessions').doc('activity_log').get();
    final appreciationPointsDoc = await _firestore.collection('users').doc(user.uid).collection('possessions').doc('appreciation_points').get();
    final hivesJoinedDoc = await _firestore.collection('users').doc(user.uid).collection('possessions').doc('hives_joined').get();
    if(!doc.exists) return null;
    final mainUserData = doc.data();
    final activityLogData = activityLogDoc.data();
    final appreciationPointsData = appreciationPointsDoc.data();
    final hivesJoinedData = hivesJoinedDoc.data();

    final updatedUser = AppUser(
      dark_mode: mainUserData?['dark_mode'] ?? false,
      hasCompletedSetup: mainUserData?['hasCompletedSetup'] ?? false,
      isEmailVerified: user.isEmailVerified,
      is_teacher: mainUserData?['is_teacher'] ?? false,
      lang: mainUserData?['lang'] ?? '',
      logoPref: mainUserData?['logo_preference'] ?? 1,
      password: mainUserData?['password'] ?? '',
      country_code: mainUserData?['public profile']?['contact_info']?['country_code'] ?? 1,
      email: user.email,
      phoneNumber: mainUserData?['public profile']?['contact_info']?['phone_number'] ?? 000000000,
      description: mainUserData?['public profile']?['description'] ?? '',
      displayFirstName: mainUserData?['public profile']?['firstName'] ?? '',
      displayLastName: mainUserData?['public profile']?['lastName'] ?? '',
      photoURL: mainUserData?['public profile']?['photo_URL'] ?? '',
      school: mainUserData?['school'] ?? " ",
      uid: user.uid,
      userName: mainUserData?['username'] ?? '',
      activity_log: List<Map<String, dynamic>>.from(activityLogData?.values ?? []),
      appreciation_points: List<Map<int, String>>.from(appreciationPointsData?.values ?? []),
      hives_joined: List<Hive>.from(hivesJoinedData?.values ?? []),
    );

    //Get.snackbar('The following is the user data in the doc:', '${updatedUser.displayFirstName}, ${updatedUser.displayLastName}, ${updatedUser.email}, ${updatedUser.uid}');

    return updatedUser;
    } catch (e){
      Get.snackbar("Error", "Failed to initialize in user repository: $e");
      return null;
    }
  }
  
  //add possessions to this
  Future<void> updateDocumentData({
    String? uid,
    String? displayFirstName,
    String? displayLastName,
    String? email, 
    String? photoURL,
    bool? isEmailVerified,
    int? phoneNumber,
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
    List<Map<String, dynamic>>? activity_log,
    List<Map<int, String>>? appreciation_points,
    List<Hive>? hives_joined,
    }) async{

    final user = currentAppUser;
    if(user == null) return null;

    bool mainUserDocUpdated = false;

    final mainDocRef = _firestore.collection('users').doc(user.uid);
    final mainDoc = await mainDocRef.get();

    final activityLogDocRef = _firestore.collection('users').doc(user.uid).collection('possessions').doc('activity_log');
    final activityLogDoc = await activityLogDocRef.get();

    final appreciationPointsDocRef = _firestore.collection('users').doc(user.uid).collection('possessions').doc('appreciation_points');
    final appreciationPointsDoc = await appreciationPointsDocRef.get();

    final hivesJoinedDocRef = _firestore.collection('users').doc(user.uid).collection('possessions').doc('hives_joined');
    final hivesJoinedDoc = await hivesJoinedDocRef.get();

    if(displayFirstName != null){
      user.displayFirstName = displayFirstName;
      mainUserDocUpdated = true;
    }
    if(displayLastName != null){
      user.displayLastName = displayLastName;
      mainUserDocUpdated = true;
    }
    if(email != null){
      user.email = email;
      mainUserDocUpdated = true;
    }
    if(photoURL != null){
      user.photoURL = photoURL;
      mainUserDocUpdated = true;
    }
    if(isEmailVerified != null){
      user.isEmailVerified = isEmailVerified;
      mainUserDocUpdated = true;
    }
    if(phoneNumber != null){
      user.phoneNumber = phoneNumber;
      mainUserDocUpdated = true;
    }
    if(hasCompletedSetup != null){
      user.hasCompletedSetup = hasCompletedSetup;
      mainUserDocUpdated = true;
    }
    if(description != null){
      user.description = description;
      mainUserDocUpdated = true;
    }
    if(dark_mode != null){
      user.dark_mode = dark_mode;
      mainUserDocUpdated = true;
    }
    if(is_teacher != null){
      user.is_teacher = is_teacher;
      mainUserDocUpdated = true;
    }
    if(lang != null){ 
      user.lang = lang;
      mainUserDocUpdated = true;
    }
    if(logoPref != null){
      user.logoPref = logoPref;
      mainUserDocUpdated = true;
    }
    if(country_code != null){
      user.country_code = country_code;
      mainUserDocUpdated = true;
    }
    if(userName != null){
      user.userName = userName;
      mainUserDocUpdated = true;
    }
    if(password != null){
      user.password = password;
      mainUserDocUpdated = true;
    }
    if(school != null){ 
      user.school = school;
      mainUserDocUpdated = true;
    }
    if(activity_log != null){
      user.activity_log = activity_log;
      mainUserDocUpdated = true;
    }
    if(appreciation_points != null){
      user.appreciation_points = appreciation_points;
      mainUserDocUpdated = true;
    }
    if(hives_joined != null){
      user.hives_joined = hives_joined;
      mainUserDocUpdated = true;
    }

    if(mainDoc.exists && mainUserDocUpdated){
      final updateData = <String, dynamic>{
        if(dark_mode != null) 'dark_mode': dark_mode,
        if(isEmailVerified != null) 'isEmailVerified': isEmailVerified,
        if (hasCompletedSetup != null) "hasCompletedSetup": hasCompletedSetup,
        if(is_teacher != null) "is_teacher": is_teacher,
        if(lang != null) "lang": lang,
        if(logoPref != null) "logo_preference": logoPref,
        if(password != null) "password": password,
        if(country_code != null) "public profile.contact_info.country_code": country_code,
        if(email != null) "public profile.contact_info.email_address": email,
        if(phoneNumber != null) "public profile.contact_info.phone_number": phoneNumber,
        if(description != null) "public profile.description": description,
        if(displayFirstName != null) "public profile.firstName": displayFirstName,
        if(displayLastName != null) "public profile.lastName": displayLastName,
        if(photoURL != null) "public profile.photo_URL": user.photoURL,
        if(uid != null) 'uid': user.uid,
        if(userName != null) 'username': userName,
        if(school != null) 'school': school,
      };
      await mainDocRef.update(updateData);
    }
    
    if(activity_log != null){
      await activityLogDocRef.update({
        'activity_log': activity_log,
      });
    }
    
    if(appreciation_points != null){
      await appreciationPointsDocRef.update({
        'appreciation_points': appreciation_points,
      });
    }
    if(hives_joined != null){
      await hivesJoinedDocRef.update({
        'hives_joined': hives_joined,
      });
    }
  }

  Future<void> createUserDocIfNeeded(
    String email, 
    String userName, 
    String firstName, 
    String lastName, 
    String password, 
    {bool isNewUser = true}) async {
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
