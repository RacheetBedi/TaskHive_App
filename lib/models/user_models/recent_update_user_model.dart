import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/enums/achievements_enum.dart';
import 'package:flutter_app/models/group_models/hive.dart';
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

class RecentUpdateUserModel{
  DateTime? updateTime;
  String? briefDescription;
  Hive? hiveOccurred;
  AppUser? userResponsible;
  String? longerDescription;
  Achievements? achievementUnlocked; //Null if no achievement was unlocked, otherwise contains the achievement that was unlocked
  bool? helpedOthers;

  RecentUpdateUserModel({
    this.updateTime,
    this.briefDescription,
    this.hiveOccurred,
    this.userResponsible,
    this.longerDescription,
    this.achievementUnlocked,
    this.helpedOthers
  });

  Map<String, dynamic> toMap() {
    return {
      'updateTime': updateTime != null ? Timestamp.fromDate(updateTime!) : Timestamp.fromDate(DateTime.now()),
      'briefDescription': briefDescription ?? '',
      'longerDescription': longerDescription ?? '',
      'helpedOthers': helpedOthers ?? false,
      'achievementUnlocked': achievementUnlocked?.name ?? 'none',
      'user' : {
        'uid': userResponsible?.uid ?? '',
        'name': '${userResponsible?.displayFirstName ?? ''} ${userResponsible?.displayLastName ?? ''}',
      },
      'hive': {
        'hive_uid': hiveOccurred?.hive_uid ?? '',
        'hive_name': hiveOccurred?.hive_name ?? '',
      },
    };
  }
}