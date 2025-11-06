import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/role.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignupTeacher extends ConsumerStatefulWidget {
  const SignupTeacher({super.key});

  @override
  ConsumerState<SignupTeacher> createState() => _SignupTeacherState();
}

class _SignupTeacherState extends ConsumerState<SignupTeacher> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController school = TextEditingController();

  signup()async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
    Get.offAll(Wrapper());
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
                    onPressed: () {
                      Get.to(() => const Role());
                    },
                  ),
                  ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/Oval Logo.png",
                          height: 125,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      'Create your teacher account', 
                      style: TextStyle(
                        fontSize: 16, 
                        fontFamily: 'inter_18pt'
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(hintText: 'email@domain.com'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: username,
                      decoration: const InputDecoration(hintText: 'username'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: first_name,
                      decoration: const InputDecoration(hintText: 'first name'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: last_name,
                      decoration: const InputDecoration(hintText: 'last name'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: school,
                      decoration: const InputDecoration(hintText: 'school name'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: password,
                      decoration: const InputDecoration(hintText: 'password'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: password2,
                      decoration: const InputDecoration(hintText: 're-enter password'),
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: (()=> signup()),
                      child: const Text("Sign Up")
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 100, 149, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 6),
                        ),
                        maximumSize: const Size(300, 100),
                        minimumSize: const Size(300, 100),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("assets/images/Teacher.png"),
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Teacher",
                              style: TextStyle(
                                color: Color.fromARGB(255, 245, 255, 101), 
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}