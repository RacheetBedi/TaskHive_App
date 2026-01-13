import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/pages/Forgot_Pages/forgot.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/pages/Setup_Pages/signupStudent.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

//enum Origin{forgot, setup} (use this if routing stops working)

class VerifyPhone extends ConsumerStatefulWidget {
  //final Origin from;
  final String number;
  VerifyPhone(this.number, {super.key});

  @override
  ConsumerState<VerifyPhone> createState() => _VerifyPhoneState(number);
}

class _VerifyPhoneState extends ConsumerState<VerifyPhone> {

  int _countdown = 60;
  Timer? _timer;
  bool _isResendEnabled = false;
  final String number;
  ConfirmationResult? _confirmationResult;
  bool _hasSent = false;

  TextEditingController phoneCode = TextEditingController();
  bool isCodeEnabled = false;

  _VerifyPhoneState(this.number);
  

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

  Future<void> verifyNumber(String phoneNumber) async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        if(userCredential.user != null){
          AppUser appUser = AppUser.fromFirebaseUser(userCredential.user! , hasCompletedSetup: true);
          final authState = ref.read(authProvider);
          // Add a set appUser to the current user for riverpod method in authProvider.
          Get.offAll(() => const Home());
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar(
          "ERROR",
          "Phone number verification failed: ${e.message}",
          duration: const Duration(seconds: 10),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        // Code sent, prompt user to enter the code
        Get.snackbar('Message Sent', 'If you possess an account, a message has been sent to your provided number. It may take up to 5 minutes.');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout
      },
    );
  }

  timeandSend() {
    verifyNumber(widget.number);
    _startTimer();
  }

  /*sendverifyMessage() async{
    //FIX FOR MOBILE( USE KISWEB!!!)!!!
    final appUser = UserRepository(ref).currentAppUser;

    //Going from forgot password flow
    if(appUser == null){

    }

    _confirmationResult = await FirebaseAuth.instance.signInWithPhoneNumber(number);
    
    return Get.snackbar('Message Sent', 'If you possess an account, a message has been sent to your provided number. It may take up to 5 minutes.');
  }
  checkCode(String code) async{
    try{
    final userCredential = await(_confirmationResult)?.confirm(code);
    if(userCredential?.user != null){
      AppUser appUser = AppUser.fromFirebaseUser(userCredential!.user! , hasCompletedSetup: true);
      final authState = ref.read(authProvider);
      // Add a set appUser to the current user for riverpod method in authProvider.
      Get.offAll(() => const Home());
    }
    else{
      Get.snackbar(
        "ERROR",
        "The code you entered is invalid. Please try again.",
        duration: const Duration(seconds: 10),
      );
    }
    } catch(e){
      Get.snackbar(
        "ERROR",
        "User code verification error: ${e.toString()}",
        duration: const Duration(seconds: 10),
      );
    }
  }
  checkConfirmation(String code) async{
    //FIX FOR MOBILE!!!
    if(_confirmationResult == null){
      Get.snackbar(
        "ATTENTION",
        "You failed to validate the request. Please try again.",
        duration: const Duration(seconds: 10),
      );
      return;
    }
    else{
      await checkCode(code);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(authProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!_hasSent){
        verifyNumber(widget.number);
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
                    const SizedBox(height: 15),
                    const Text(
                      'Verify Your Phone',
                      style: TextStyle(
                        fontSize: 50, 
                        fontFamily: 'Jomhuria'
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 20),
                    TextField(
                      controller: phoneCode,
                      decoration: const InputDecoration(
                        hintText: 'Enter verification code',
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: (){
                        
                      },//checkConfirmation(phoneCode.text.trim()),
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
                    const SizedBox(height: 15),
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
    );
  }
}