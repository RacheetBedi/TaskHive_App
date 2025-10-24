import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/verifyemail.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            if(snapshot.data!.emailVerified){
              return Homepage();
            }
            else{
              return  Verify();
            }
          }
          else{
            return LoginPage();
          }
        },
      ),
    ); 
  }
}