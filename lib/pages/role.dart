import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/pages/signupTeacher.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Role extends StatefulWidget {
  const Role({super.key});
  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
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
                      Get.to(() => const LoginPage());
                    },
                  ),
                  ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    const Text(
                      "Choose Account Type",
                      textAlign: TextAlign.center,
                      textHeightBehavior: TextHeightBehavior(
                        applyHeightToFirstAscent: true,
                        applyHeightToLastDescent: true,
                      ),
                      style: TextStyle(
                        fontSize: 50,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    ElevatedButton(
                      onPressed: ()=> Get.to(() => const SignupStudent()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 149, 252, 124),
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
                            image: AssetImage("assets/images/Student.png"),
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Student",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 86, 86), 
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: ()=> Get.to(() => const SignupTeacher()),
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
                    const SizedBox(height: 30),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/Oval Logo.png",
                          height: 200,
                        ),
                      ),
                    ),
                    
                    //Remove After we can actually get to the home page by logging in.
                    ElevatedButton(
                      onPressed: ()=> Get.to(() => const Home()), 
                      child: const Text("Temp: To Home"),
                    )
                  ]
                ),
              ),
            ]
          ),
        )
      )
    );
  }
}