import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/forgot.dart';
import 'package:flutter_app/signup.dart';
import 'package:flutter_app/wrapper.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

  @override
  void initState() {
    super.initState();
  }

  sendverifylink() async{
    final user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification().then((value)=>{
      Get.snackbar('Link sent', 'A link has been sent to your email.', margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM)
    });
  }

  reload() async{
    await FirebaseAuth.instance.currentUser!.reload().then((value)=> {
      Get.offAll(Wrapper()),
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}