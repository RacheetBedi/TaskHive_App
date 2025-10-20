import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/forgot.dart';
import 'package:flutter_app/signup.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  loginApple() async{
    
  }

  login() async {
    try {
      developer.log('Starting Google Sign In process', name: 'login');
      
      // Start the sign-in process with specific configuration
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: '180420637512-6edngactqt1ghqgrs6ivp3b3hthq4cqk.apps.googleusercontent.com',
        scopes: ['email', 'profile'],
      );
      
      developer.log('GoogleSignIn initialized', name: 'login');
      
      developer.log('Attempting to sign in...', name: 'login');
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      
      // Check if user canceled the sign-in flow
      if (googleUser == null) {
        developer.log('User cancelled sign in', name: 'login');
        Get.snackbar("Sign In Cancelled", "User cancelled Google Sign In");
        return;
      }
      
      developer.log('Successfully got GoogleSignInAccount', name: 'login');

      // Get auth details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // Ensure we have the required tokens
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        Get.snackbar("Error", "Could not get authentication tokens");
        return;
      }

      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken!,
        idToken: googleAuth.idToken!,
      );

      // Sign in to Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);
      
    } catch (e) {
      print("Google Sign In Error: $e"); // For debugging
      Get.snackbar(
        "Error", 
        "Could not sign in with Google: ${e.toString()}",
        duration: Duration(seconds: 5),
      );
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  signIn()async{
    setState((){
      isLoading = true;
    });
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
  
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
                child: const Text("Login"),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (()=> Get.to(Signup())),
                child: const Text("Sign Up"),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (()=> Get.to(Forgot())),
                child: const Text("Forgot Password"),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE69900),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFFFE100), width: 4),
                  ),
                ),
                onPressed: (()=> login()),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/images/Google Logo.png"), height: 30,),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Sign In with Google",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],
                ),
              ),  
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (()=> loginApple()),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Sign In with Apple"),
                  ),
              ), 
            ]
          ),
        ),
      )
    );
  }
}