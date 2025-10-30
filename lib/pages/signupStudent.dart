import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignupStudent extends StatefulWidget {
  const SignupStudent({super.key});

  @override
  State<SignupStudent> createState() => _SignupStudentState();
}

class _SignupStudentState extends State<SignupStudent> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signup()async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
    Get.offAll(Wrapper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up as Student"),),
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
              TextField(
                controller: password,
                decoration: InputDecoration(hintText: 'Enter password'),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (()=> signup()),
                child: Text("Sign Up")
              ),
            ]
          ),
        ),
      )
    );
  }
}