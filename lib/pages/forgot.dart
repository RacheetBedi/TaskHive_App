import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  TextEditingController email = TextEditingController();

  reset()async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text,);
    Get.offAll(Wrapper());
  }

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
                    onPressed: () => Get.to(() => const LoginPage()),
                  ),
                  ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(hintText: 'Enter email'),
                    ),
                    const SizedBox(height: 30,),
                    ElevatedButton(
                      onPressed: (()=> reset()),
                      child: Text("Send link")
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}