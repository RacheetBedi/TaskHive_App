import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {

  final Ref ref;

  UserRepository(this.ref);

  AppUser? get currentAppUser {
    final authState = ref.read(authProvider);
    return authState.when(
      data: (user) => user,
      loading: () => null,
      error: (_, __) => null,
    );
  }

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  //USE COPYWITH

  Future<AppUser?> getAppuser() async{
    final user = currentAppUser;
    if(user == null) return null;


    final doc = await _firestore.collection('users').doc(user.uid).get();

    return AppUser(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
      isEmailVerified: user.isEmailVerified,
      phoneNumber: user.phoneNumber,
      hasCompletedSetup: doc.data()?['hasCompletedSetup'] ?? false,
      description: doc.data()?['description'] ?? false,
      dark_mode: doc.data()?['dark_mode'] ?? false,
      is_teacher: doc.data()?['is_teacher'] ?? false,
      lang: doc.data()?['lang'] ?? false,
      logoPref: doc.data()?['password'] ?? false,
      country_code: doc.data()?['country_code'] ?? false,
      userName: doc.data()?['userName'] ?? false,
    );
  }

  Future<void> createUserDocIfNeeded({bool isNewUser = false}) async {
    final user = currentAppUser;
    if(user == null) return null;

    final docRef = _firestore.collection('users').doc(user.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        "dark_mode": false,
        "isEmailVerified": user.isEmailVerified,
        "hasCompletedSetup": null,
        "is_teacher": false,
        "lang": "EN",
        "logo_preference": 1,
        "password": "22222222",
        "public profile": {
          "contact_info": {
            "country_code": 1,
            "email_address": user.email,
            "phone_number": user.phoneNumber,
          },
          "description": null,
          "name": user.displayName,
          "photo_URL": user.photoURL,
        },
        'uid': user.uid,
        'username': null,
      });
    }
  }

  //CODE UPDATE USER DATA!

  Future<bool> hasCompletedSetup() async {
    final user = currentAppUser;
    if(user == null) return false;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.exists && (doc.data()?['hasCompletedSetup'] == true);
  }

  Future<void> completeSetup(String username) async {
    final user = currentAppUser;
    if(user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'username': username,
      'hasCompletedSetup': true,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
