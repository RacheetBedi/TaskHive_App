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
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/Circle Logo.png',
          fit: BoxFit.contain,
        ),
        title: Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined),
            onPressed: () {}, //Get.to(() => const Recent_Changes()),
          ),
          IconButton(
            icon: const Icon(Icons.summarize_outlined),
            onPressed: () {}, //Get.to(() => const Summary()),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {}, //Get.to(() => const Settings()),
          ),
        ],
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