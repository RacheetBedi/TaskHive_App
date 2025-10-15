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

  bool isLoading = false;

  signIn()async{
    setState((){
      isLoading = true;
    });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
    } on FirebaseAuthException catch(e){
        Get.snackbar("Error Message", e.code);
    } catch(e){
        Get.snackbar("Error Message", e.toString());
      }
    setState((){
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return isLoading?Center(child: CircularProgressIndicator(),): Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'Enter email'),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(hintText: 'Enter password'),
            ),

            ElevatedButton(
              onPressed: (()=> signIn()),
              child: Text("Login")
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (()=> Get.to(Signup())),
              child: Text("Sign Up")
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (()=> Get.to(Forgot())),
              child: Text("Forgot Password"),
            ),     
          ]
        ),
      )
    );
  }
}