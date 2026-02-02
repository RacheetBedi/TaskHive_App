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
  }

  Future<bool> hasCompletedHiveSetup() async {
    final hive = hiveDocuments;
    if(hive == null) return false;

    final doc = await _firestore.collection('groups').doc(uid).get();
    return doc.exists && (doc.data()?['hasCompletedHiveSetup'] == true);
  }

  
}