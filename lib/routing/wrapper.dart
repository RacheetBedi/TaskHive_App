import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/verifyemail.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({super.key});

  @override
  ConsumerState<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper> {

  @override
  Widget build(BuildContext context) {
  final authState = ref.watch(authProvider);

    return authState.when(
      data: (appUser){
        if(appUser == null){
          return const LoginPage();
        } else if(!appUser.isEmailVerified){
          return const Verify();
        } else{
          return const Homepage();
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace){
        Get.snackbar(
          "Error",
          "Unexpected Google Sign-In Error: ${error.toString()}",
          duration: const Duration(seconds: 10),
        );

        return LoginPage();
      }
    );

    // return Scaffold(
    //   body: StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot){
    //       if (snapshot.hasData){
    //         if(snapshot.data!.emailVerified){
    //           return Homepage();
    //         }
    //         else{
    //           return  Verify();
    //         }
    //       }
    //       else{
    //         return LoginPage();
    //       }
    //     },
    //   ),
    // ); 
  }
}