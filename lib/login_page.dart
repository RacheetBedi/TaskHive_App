import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/forgot.dart';
import 'package:flutter_app/signup.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  login() async{

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final dynamic googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);


  }

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
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (()=> login),
              )    
            ]
          ),
        ),
      )
    );
  }
}