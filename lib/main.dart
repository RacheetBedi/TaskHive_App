import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/utilities/theme.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'utilities/firebase_options.dart';
import 'package:riverpod/riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/models/user_models/app_user.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/providers/google_auth_service_provider.dart';
import 'package:flutter_app/utilities/theme.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Wrapper(),
    );
  }
}