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

class Hive {
  String hive_name;
  String hive_description;
  String hive_subject;
  String? hive_code;
  String? points_description;
  String? icon_description;
  //Map of tasks can only be coded when the task model object is coded
  Map<String, bool> default_settings;
  bool teacher_led;
  bool ai_summary;
  String theme_color;
  String? hiveImage;

  Hive({
    required this.hive_name,
    required this.hive_description,
    required this.hive_subject,
    this.hive_code,
    this.points_description,
    this.icon_description,
    required this.default_settings,
    required this.teacher_led,
    required this.ai_summary,
    required this.theme_color,
    this.hiveImage,
  });


}