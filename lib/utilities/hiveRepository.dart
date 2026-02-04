import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/group_models/hive.dart';
import 'package:flutter_app/models/user_models/app_user.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class HiveRepository{
  final WidgetRef ref;
  String uid; 
  //This is the uid of the hive, automatically assigned by Firestore.

  HiveRepository (this.ref, this.uid);

  //currentHive riverpod placerholder

  DocumentReference<Map<String, dynamic>> get hiveDocuments => _firestore.collection('groups').doc(uid);

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  Future<AppUser?> initializeHive() async{
    try{
    final hive = hiveDocuments;
    if(hiveDocuments == null) return null;
    Get.snackbar('Initializing the App User', 'Please help me');

    final doc = await _firestore.collection('groups').doc(uid).get();
    if(!doc.exists) return null;
    final data = doc.data();

    } catch (e){
      Get.snackbar("Error", "Failed to initialize in user repository: $e");
      return null;
    }
  }


  Future<void> createHiveDoc(Hive hive) async {
    try{
      final curUser = UserRepository(ref).currentAppUser;
      if(curUser == null) throw Exception("No current user found");

      curUser.hives_joined?.add(hive);

      final docRef = _firestore.collection('groups').doc(); //If the hive hasn't been made yet, that means that
        //the hive uid is null; so to prevent a firestore error, we use this dummy uid which will
        //certainly fail to produce a docRef and thus proceed to the creation step below.
      final doc = await docRef.get();

      await docRef.set({
          'hive_name': hive.hive_name,
          'hive_description': hive.hive_description,
          'hive_points_description': hive.points_description,
          'appreciation_snippet': hive.appreciation_snippet, //this will change
          'default_settings': hive.default_settings,
          'hive_icons_description': hive.icon_description,
          //'hive_join_code': hive.hive_code, do this when you code the join code auto generation
          'hive_tasks_snippet': hive.tasks_snippet,//this will change
          'teacher_led': hive.teacher_led,
          'theme_color': hive.theme_color,
          'ai_summary': hive.ai_summary,
          'hiveImage': hive.hiveImage,

      });

      hive.hive_uid = docRef.id;
    } catch(err, st){
      Get.snackbar('Error', 'Failed to create Hive document: $err');
    }
  }

  // Future<bool> hasCompletedHiveSetup() async {
  //   final hive = hiveDocuments;
  //   if(hive == null) return false;

  //   final doc = await _firestore.collection('groups').doc(uid).get();
  //   return doc.exists && (doc.data()?['hasCompletedHiveSetup'] == true);
  // }

  //Implement later when hasCompletedSetup bugs have been resolved.

}