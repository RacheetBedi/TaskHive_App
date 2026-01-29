import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/models/user_models/app_user.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/providers/google_auth_service_provider.dart';
import 'package:flutter_app/utilities/theme.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class TaskModel {
  String task_name;
  String tradeable;
  DateTime date_assigned;
  DateTime date_due;
  String task_description;
  DateTime? date_completed;
  Map<String, String> users_tasked; //Instead of the first string, something indicating the users should be included; uid is a good option.
  String hive_ID;
  String difficulty;
  bool help_flagged;
  bool gc_task;
  String task_progress;
  Map<dynamic, String>? images;


  TaskModel({
    required this.task_name,
    required this.tradeable,
    required this.date_assigned,
    required this.date_due,
    required this.task_description,
    this.date_completed,
    required this.users_tasked,
    required this.hive_ID,
    required this.difficulty,
    this.help_flagged = false,
    required this.gc_task,
    this.task_progress = 'unstarted',
    this.images,
  });

  List<dynamic> taskSnippet(){
    return [
      task_name,
      date_assigned,
      date_due,
      users_tasked,
      difficulty,
      help_flagged,
      gc_task,
      task_progress,
    ];
  }
}