import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/pages/Forgot_Pages/forgot.dart';
import 'package:flutter_app/pages/Setup_Pages/enterPhoneNumber.dart';
import 'package:flutter_app/pages/Setup_Pages/verifyPhone.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/pages/Setup_Pages/signupStudent.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class FinalStepsQuestion extends ConsumerStatefulWidget {
  FinalStepsQuestion({super.key});

  @override
  ConsumerState<FinalStepsQuestion> createState() => _FinalStepsQuestionState();
}

class _FinalStepsQuestionState extends ConsumerState<FinalStepsQuestion> {

  @override
  Widget build(BuildContext context) {
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
                      //Login warning here
                      onPressed: () => Get.back(),
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
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB743),
                    borderRadius: BorderRadius.circular(32.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black26,
                      ),
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const SizedBox(height: 15),
                      const Text(
                        'Setup Intstructions',
                        style: TextStyle(
                          fontSize: 50, 
                          fontFamily: 'Jomhuria'
                        ),
                      ),
                        const Text(
                          'Would you like to complete additional setup steps now?',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => const Enterphonenumber());
                              },
                              child: const Text('Yes'),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => Home(fromSignIn: true,));
                              },
                              child: const Text('No'),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
                    ]
                  )
        )
        ]
      ),
        
        
        
        
        
        
        /* Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black26,
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Would you like to complete additional setup steps now?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => VerifyPhone(''));
                    },
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => Home(fromSignIn: true,));
                    },
                    child: const Text('No'),
                  ),
                ],
              ),
            ],
          ),
        )*/
      ),
    ),
    );
  }
}
      
      
  

/* return Scaffold(
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
                    onPressed: () => Get.to(() => const Forgot()),
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
                      'Verify Your Phone',
                      style: TextStyle(
                        fontSize: 50, 
                        fontFamily: 'Jomhuria'
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'You have been sent a verification message. Please enter your received code.\nNOTE: Standard SMS rates apply.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0, 
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneCode,
                      decoration: const InputDecoration(
                        hintText: 'Enter verification code',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => checkConfirmation(phoneCode.text.trim()),
                      child: const Text("Check Code"),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Didn\'t get the message?', 
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
                      child: Text(_isResendEnabled ? "Resend Message" : '$_countdown s'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );*/