import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/Forgot_Pages/forgot.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/providers/current_user_provider.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Verify extends ConsumerStatefulWidget {
  const Verify({super.key});

  @override
  ConsumerState<Verify> createState() => _VerifyState();
}

class _VerifyState extends ConsumerState<Verify> {

  int _countdown = 60;
  Timer? _timer;
  bool _isResendEnabled = false;
  bool _hasSent = false;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer()
  {
    setState((){
      _isResendEnabled = false;
      _countdown = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState((){
        if(_countdown > 0)
        {
          _countdown--;
        }
        else
        {
          _timer?.cancel();
          _isResendEnabled = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  sendverifylink() async{
    final appUser = FirebaseAuth.instance.currentUser;
    await appUser?.sendEmailVerification().then((value)=>{
      Get.snackbar('Link sent', 'A link has been sent to your email.', margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM)
    });
  }

  timeandSend() {
    sendverifylink();
    _startTimer();
  }
  

  reload() async{
    await FirebaseAuth.instance.currentUser?.reload();
    if (FirebaseAuth.instance.currentUser?.emailVerified == false){
      Get.snackbar(
        "ATTENTION:",
        "You have not verified, or verification was unsuccessful. A new link has been sent to your email. Please try again."
      );
      return;
    }

    Get.offAll(() => const Home());
  }

  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(authProvider);

    return appUser.when(
      data: (user){
        if (user == null){
          return const SizedBox();
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if(!_hasSent){
            sendverifylink();
            _hasSent = true;
          }
       });

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
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      iconSize: 40,
                      onPressed: () => Get.to(() => const LoginPage()),
                    ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 15,),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 255, 255, 255),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/Oval Logo.png",
                            height: 125,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Verify Your Email',
                        style: TextStyle(
                          fontSize: 50, 
                          fontFamily: 'Jomhuria'
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'You have been sent a verification email. Please check and verify the email.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0, 
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0)
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => reload(),
                        child: const Text("I Have Verified"),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Didn\'t get the email?', 
                        style: TextStyle(
                          fontSize: 20.0, 
                          fontFamily: 'Inter', 
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 73, 73, 73)
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _isResendEnabled ? timeandSend : null,
                        child: Text(_isResendEnabled ? "Resend Email" : '$_countdown s'),
                      ),
                      const SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: () => Get.offAll(() => const Home()),
                        child: const Text("Temp Access Bypass"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
       );
      }, 
      error:(err, stack){
        Get.snackbar(
          "Error",
          "Unexpected Email Verification Error: ${err.toString()}",
          duration: const Duration(seconds: 10),
        );

        return const LoginPage();
      }, 
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}