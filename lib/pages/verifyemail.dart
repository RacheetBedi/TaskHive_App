import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/forgot.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/providers/auth_provider.dart';
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

  @override
  void initState() {
    super.initState();
  }

  sendverifylink() async{
    final appUser = FirebaseAuth.instance.currentUser;
    await appUser?.sendEmailVerification().then((value)=>{
      Get.snackbar('Link sent', 'A link has been sent to your email.', margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM)
    });
  }

  reload() async{
    await FirebaseAuth.instance.currentUser!.reload().then((value)=> {
      Get.offAll(() => const Homepage()),
    });
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
          sendverifylink();
       });

       return Scaffold(
        body: Column(
          children: [
            const Center(
              child:  Text('A verficiation email has been sent to your inbox.'),
            ),
            ElevatedButton(
              onPressed: () => reload(), 
              child: const Text("Email Verified."),
              )
          ],
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