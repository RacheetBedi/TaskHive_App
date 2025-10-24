import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AppBar(title: Text("Forgot Password"),),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Hive Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
      )
    );
  }
}