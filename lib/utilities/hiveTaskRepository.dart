import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_models/app_user.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class HiveTaskRepository{
  final WidgetRef ref;

  HiveTaskRepository (this.ref);
}