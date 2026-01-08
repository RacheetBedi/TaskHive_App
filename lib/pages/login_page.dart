import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/pages/Forgot_Pages/forgot.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/role.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:developer' as developer;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController googlePassword = TextEditingController();

  Future<void> _signInWithEmail() async {
    final authNotifier = ref.read(authProvider.notifier);

    await ref.read(authProvider.notifier).signInWithEmail(
          email.text,
          password.text,
        );

    if(!mounted) return;

    final authState = ref.watch(authProvider);
    final signedInUser = authState.asData?.value;
    
    if(signedInUser != null){
      final user = await UserRepository(ref).initializeAppUserObject();
      Get.snackbar('Initializing user data', 'Please wait...');
      if(user==null){
        Get.snackbar("Error", "User doc either absent or timeout reached.");
      }
      else{
        ref.read(authProvider.notifier).updateUser(user);
      }
    }

    if(authState == AsyncValue.data(null)){
      Get.snackbar(
        "SIGN IN ERROR:",
        "Invalid Email/Password. Please try again or sign up if you don't have an account.",
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try{
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.signInWithGoogle();
    
    if(!mounted) return;

    final authState = ref.watch(authProvider);
    final signedInUer = authState.asData?.value;
    
    if(signedInUer != null){
      final user = await UserRepository(ref).initializeAppUserObject();
      Get.snackbar('Initializing user data', 'Please wait...');
      if(user==null){
        Get.snackbar("Error", "User doc either absent or timeout reached.");
      }
      else{
        ref.read(authProvider.notifier).updateUser(user);
      }
    }

    } catch(e){
        Get.snackbar(
          "Error",
          "Unexpected Google Sign-In Error: ${e.toString()}",
          duration: const Duration(seconds: 10),
        );
        rethrow;
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return authState.when(
      data: (user) {
        if (user != null) {
          if(user.hasCompletedSetup == false){
            return const Role();
          }
          return const Home(fromSignIn: true,);
        }

        return _buildLoginScreen();
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) {
        return _buildLoginScreen();
      },
    );
  }

  Widget _buildLoginScreen() {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Hive Background.png"),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.none,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(height: 30),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(0, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/Oval Logo.png",
                    height: 200,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Login to your Account",
                textAlign: TextAlign.center,
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: true,
                  applyHeightToLastDescent: true,
                ),
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Jomhuria',
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const Text(
                "Enter your Email and Password",
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: true,
                  applyHeightToLastDescent: true,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Jomhuria',
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: email,
                decoration: const InputDecoration(hintText: 'email@domain.com'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'password'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _signInWithEmail,
                child: const Text("Login"),
              ),
              const SizedBox(height: 10),
              const Text(
                "------------------- or -------------------",
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: true,
                  applyHeightToLastDescent: true,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jomhuria',
                  fontSize: 30,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE69900),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFFFE100), width: 4),
                  ),
                ),
                onPressed: _signInWithGoogle,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/Google Logo.png"),
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Sign In with Google",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Get.to(() => const Forgot()),
                child: const Text("Forgot Password?"),
              ),
              const SizedBox(height: 15),
              const Text(
                "Don't have an Account?",
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: true,
                  applyHeightToLastDescent: true,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Jomhuria',
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Get.to(() => const Role()),
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}