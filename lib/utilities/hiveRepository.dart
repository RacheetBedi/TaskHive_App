import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/group_models/hive.dart';
import 'package:flutter_app/models/user_models/app_user.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/providers/hive_service_provider.dart';
import 'package:flutter_app/providers/hive_service_provider.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class HiveRepository{
  final WidgetRef ref;
  String? uid; 
  //This is the uid of the hive, automatically assigned by Firestore.

  HiveRepository (this.ref);

  Hive? get currentHive{
    final hiveState = ref.read(hiveServiceProvider);
    uid = hiveState.asData?.value?.hive_uid;
    return hiveState.asData?.value;
  }

  DocumentReference<Map<String, dynamic>> get hiveDocument => _firestore.collection('groups').doc(uid); //Add a way to properly get the uid, using riverpod, later.

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  Future<Hive?> initializeHive() async{
    try{
    final hive = hiveDocument;
    if(hiveDocument == null) return null;
    Get.snackbar('Initializing the Hive', 'Please help me');

    final doc = await _firestore.collection('groups').doc(uid).get(); //Fix the reading of the data (make it proper, distinguishing between a snippet and all of the data)
    //In this case, we want to only read a snippet
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

      final mainHiveRef = _firestore.collection('groups').doc(); 
      
      //If the hive hasn't been made yet, that means that
        //the hive uid is null; so to prevent a firestore error, we use this dummy uid which will
        //certainly fail to produce a docRef and thus proceed to the creation step below.
      final mainHiveDoc = await mainHiveRef.get();

      await mainHiveRef.set({
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

      hive.hive_uid = mainHiveRef.id;

      final recentUpdatesDocRef = _firestore.collection('groups').doc(mainHiveRef.id).collection('Recent Updates').doc('set_1');
      //Change set_1 to set_# based on the number of days elapsed since the creation of the hive, divided by 3.
      //We will automatically start deleting sets of recent updates when reaching around 50 sets (150 days).

      final hiveUsersDocRef = _firestore.collection('groups').doc(mainHiveRef.id).collection('group_users').doc('user_data');
      final assignedTasksDocRef = _firestore.collection('groups').doc(mainHiveRef.id).collection('tasks').doc('assigned_task_properties').collection('Assigned Tasks List').doc('tasks_set_1');
      final completedTasksDocRef = _firestore.collection('groups').doc(mainHiveRef.id).collection('tasks').doc('completed_task_properties').collection('Completed Tasks List').doc('completedTasks_set_1');

      await recentUpdatesDocRef.set({
        'recent_updates': hive.recent_updates ?? [],
      });

      await hiveUsersDocRef.set({
        'hive_users': hive.hive_users ?? [],
      });

      await assignedTasksDocRef.set({
        'assigned_tasks': hive.assigned_tasks ?? [],
      });

      await completedTasksDocRef.set({
        'completed_tasks': hive.completed_tasks ?? [],
      });
    } catch(err, st){
      Get.snackbar('Error', 'Failed to create Hive document: $err');
    }
  }

  Future<void> updateHiveDocData({
    required Hive hive,
    String? hive_name,
    String? hive_description,
    String? hive_subject,
    String? hive_code,
    String? points_description,
    String? icon_description,
    Map<String, bool>? default_settings, //This will be changed
    bool? teacher_led,
    bool? ai_summary,
    String? theme_color,
    String? hiveImage,
    //Snippets can't be changed, they are set directly through firestore. When a task or something
    //else hive related is added, the hive document is updated, and the appreciation/task snippets are automatically triggered to update as well.
    List<List<Map<String, String>>>? recent_updates,
    List<Map<dynamic, dynamic>>? hive_users,
    List<Map<String, dynamic>>? assigned_tasks,
    List<Map<String, dynamic>>? completed_tasks,
    }) async {

      final hive = currentHive;

      bool mainHiveElementsChanged = false;

      final mainHiveRef = _firestore.collection('groups').doc(hive?.hive_uid); 
      final mainDoc = mainHiveRef.get();

      final recentUpdatesDocRef = _firestore.collection('groups').doc(hive?.hive_uid).collection('Recent Updates').doc('set_1');
      final recentUpdatesDoc = recentUpdatesDocRef.get();

      final hiveUsersDocRef = _firestore.collection('groups').doc(hive?.hive_uid).collection('group_users').doc('user_data');
      final hiveUsersDoc = hiveUsersDocRef.get();

      final assignedTasksDocRef = _firestore.collection('groups').doc(hive?.hive_uid).collection('tasks').doc('assigned_task_properties').collection('Assigned Tasks List').doc('tasks_set_1');
      final assignedTasksDoc = assignedTasksDocRef.get();
      final completedTasksDocRef = _firestore.collection('groups').doc(hive?.hive_uid).collection('tasks').doc('completed_task_properties').collection('Completed Tasks List').doc('completedTasks_set_1');

      if(hive_name != null){
        hive?.hive_name = hive_name;
        mainHiveElementsChanged = true;
      }

      if(hive_description != null){
        hive?.hive_description = hive_description;
        mainHiveElementsChanged = true;
      }

      if(hive_subject != null){
        hive?.hive_subject = hive_subject;
        mainHiveElementsChanged = true;
      }

      if(hive_code != null){
        hive?.hive_code = hive_code;
        mainHiveElementsChanged = true;
      }

      if(points_description != null){
        hive?.points_description = points_description;
        mainHiveElementsChanged = true;
      }

      if(icon_description != null){
        hive?.icon_description = icon_description;
        mainHiveElementsChanged = true;
      }

      if(default_settings != null){
        hive?.default_settings = default_settings;
        mainHiveElementsChanged = true;
      }

      if(teacher_led != null){
        hive?.teacher_led = teacher_led;
        mainHiveElementsChanged = true;
      }

      if(ai_summary != null){
        hive?.ai_summary = ai_summary;
        mainHiveElementsChanged = true;
      }

      if(theme_color != null){
        hive?.theme_color = theme_color;
        mainHiveElementsChanged = true;
      }

      if(hiveImage != null){
        hive?.hiveImage = hiveImage;
        mainHiveElementsChanged = true;
      }

      if(mainDoc !=null && mainHiveElementsChanged){
        final updateData = <String, dynamic>{
          if(hive_name != null) 'hive_name': hive_name,
          if(hive_description != null) 'hive_description': hive_description,
          if(hive_subject != null) 'hive_subject': hive_subject,
          if(hive_code != null) 'hive_code': hive_code,
          if(points_description != null) 'points_description': points_description,
          if(icon_description != null) 'icon_description': icon_description,
          if(default_settings != null) 'default_settings': default_settings,
          if(teacher_led != null) 'teacher_led': teacher_led,
          if(ai_summary != null) 'ai_summary': ai_summary,
          if(theme_color != null) 'theme_color': theme_color,
          if(hiveImage != null) 'hiveImage': hiveImage,
        };
        await mainHiveRef.update(updateData);
      }

      if(recentUpdatesDoc != null && recent_updates != null){
        await recentUpdatesDocRef.update({
          'recent_updates': recent_updates,
        });
      }

      if(hiveUsersDoc != null && hive_users != null){
        await hiveUsersDocRef.update({
          'hive_users': hive_users,
        });
      }

      if(assignedTasksDoc != null && assigned_tasks != null){
        await assignedTasksDocRef.update({
          'assigned_tasks': assigned_tasks,
        });
      }

      if(completedTasksDocRef != null && completed_tasks != null){
        await completedTasksDocRef.update({
          'completed_tasks': completed_tasks,
        });
      }
      //These are placeholder update statements; each of these will require a 
      //separate method to update, which needs to be coded later.
  }

  // Future<bool> hasCompletedHiveSetup() async {
  //   final hive = hiveDocuments;
  //   if(hive == null) return false;

  //   final doc = await _firestore.collection('groups').doc(uid).get();
  //   return doc.exists && (doc.data()?['hasCompletedHiveSetup'] == true);
  // }

  //Implement later when hasCompletedSetup bugs have been resolved.

}