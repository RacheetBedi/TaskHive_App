import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/pages/signupTeacher.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color(0xFFFFC95C),
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/Circle Logo.png',
                        height: 52,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(104, 255, 255, 255),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.history_outlined, color: Colors.red),
                              iconSize: 26,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.analytics_outlined, color: Colors.red),
                              iconSize: 26,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings_outlined, color: Colors.red),
                              iconSize: 26,

                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Title Below
                const Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jomhuria',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: 
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              const Text("In Progress"),
            ]
          ),
        ),
      )
    );
  }
}