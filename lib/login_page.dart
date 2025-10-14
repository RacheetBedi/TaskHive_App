import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/forgot.dart';
import 'package:flutter_app/signup.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signIn()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(0, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/Oval Logo.png", height: 200,),
                ),
              ),
              const SizedBox(height: 30,),
              TextField(
                controller: email,
                decoration: const InputDecoration(hintText: 'Enter email'),
              ),
              const SizedBox(height: 30,),
              TextField(
                controller: password,
                decoration: const InputDecoration(hintText: 'Enter password'),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (()=> signIn()),
                child: Text("Login")
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (()=> Get.to(Signup())),
                child: Text("Sign Up")
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (()=> Get.to(Forgot())),
                child: Text("Forgot Password"),
              ),     
            ]
          ),
        ),
      )
    );
  }
}