import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/models/group_models/hive.dart';
import 'package:flutter_app/models/user_models/app_user.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/providers/google_auth_service_provider.dart';
import 'package:flutter_app/utilities/hiveRepository.dart';
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

final hiveServiceProvider =
    StateNotifierProvider<HiveServiceProvider, AsyncValue<Hive?>>(
  (ref) => HiveServiceProvider(ref),
);

class HiveServiceProvider extends StateNotifier<AsyncValue<Hive?>>{
  final Ref ref;

  HiveServiceProvider(this.ref) : super(const AsyncValue.loading()){
    //_loadHives();
    //Must code _loadHives first; should this be listenToHiveChanges instead?
  }

  void updateHive(Hive hive){
    state = AsyncValue.data(hive);
  }

  Future<void> addNewFirestoreHive(Hive hive) async{
    try{
      final myCurrentHive = state.asData?.value;
      state = AsyncValue.data(hive);

      //await HiveRepository(ref).createHiveDocIfNeeded(hive); Hive will be created in the page classes; needs WidgetRef

    } catch(e, st){
      state = AsyncValue.error(e, st);
      Get.snackbar('Firestore Hive Creation Error', '$e');
    }
  }

}