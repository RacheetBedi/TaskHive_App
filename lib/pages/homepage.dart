import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/pages/Forgot_Pages/forgot.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(authProvider).asData?.value;

    if (appUser == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Homepage")),
      body: Center(
        child: Text("${appUser.email}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(authProvider.notifier).signOut();
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}

    // return authState.when(
    //   data: (appUser){
    //     if(appUser == null){
    //       return const LoginPage();
    //     }
    //     else{
    //       return Scaffold(
    //         appBar: AppBar(title: Text("Homepage"),),
    //         body: Center(
    //           child: Text("${appUser!.email}"),
    //         ),
    //         floatingActionButton: FloatingActionButton(
    //           onPressed: (() async{
    //             final authNotifier = ref.read(authProvider.notifier);
    //             await authNotifier.signOut();
    //           }),
    //           child: Icon(Icons.login_rounded),
    //         ),
    //       );
    //     }
    //   },
    //   loading: ()=>Center(child: CircularProgressIndicator()),
    //   error: (error, stackTrace){
    //     Get.snackbar(
    //       "Error",
    //       "Unexpected Google Sign-In Error: ${error.toString()}",
    //       duration: const Duration(seconds: 10),
    //     );

    //     return LoginPage();
    //   }
    // );

